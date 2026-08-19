import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/core/network/rate_limit_interceptor.dart';
import 'package:sakkoja/core/network/web_proxy_interceptor.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/ai/domain/services/open_router_service.dart';

part 'open_router_service_impl.g.dart';

const bool _kIsWeb = identical(0, 0.0);

/// Default fallback chain for AI models.
///
/// Order matters: primary → fast fallback → last-resort free router.
const List<String> _fallbackChain = [
  'meta-llama/llama-3.3-70b-instruct:free',
  'meta-llama/llama-3.2-3b-instruct:free',
  'openrouter/free',
];

/// Dio provider specifically for OpenRouter (separate base URL, no rate limit conflicts).
@Riverpod(keepAlive: true)
Dio openRouterDio(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://openrouter.ai/api/v1',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        // HTTP-Referer and X-Title are required by OpenRouter
        'HTTP-Referer': 'https://sakkoja.pages.dev',
        'X-Title': 'Sakkoja Marine Safety Navigator',
      },
    ),
  );
  dio.interceptors.add(
    RateLimitInterceptor(
      defaultConfig: const RateLimitConfig(10, Duration(seconds: 60)),
      prefs: prefs,
    ),
  );
  if (_kIsWeb) {
    dio.interceptors.add(WebProxyInterceptor());
  }
  ref.onDispose(dio.close);
  return dio;
}

@Riverpod(keepAlive: true)
OpenRouterService openRouterService(Ref ref) {
  return OpenRouterServiceImpl(ref.watch(openRouterDioProvider));
}

class OpenRouterServiceImpl implements OpenRouterService {
  OpenRouterServiceImpl(this._dio);
  final Dio _dio;

  @override
  Future<ExplanationResult> getExplanation({
    required String apiKey,
    required String modelId,
    required String prompt,
  }) async {
    // Build the fallback chain starting with the user-selected primary model
    final chain = <String>[modelId];
    for (final fallback in _fallbackChain) {
      if (fallback != modelId && !chain.contains(fallback)) {
        chain.add(fallback);
      }
    }

    String? lastError;
    for (final model in chain) {
      try {
        final result = await _tryModel(
          apiKey: apiKey,
          model: model,
          prompt: prompt,
        );
        if (result != null) {
          Log.i('[OpenRouter] Success with model: $model');
          return Right(result);
        }
      } on DioException catch (e) {
        lastError = _formatDioError(e, model);
        Log.w('[OpenRouter] Model $model failed: $lastError');
        continue;
      } catch (e) {
        lastError = 'Model $model error: $e';
        Log.w('[OpenRouter] $lastError');
        continue;
      }
    }

    return Left(
      ServerFailure(
        'OpenRouter fallback chain exhausted. Last error: ${lastError ?? 'Unknown'}',
      ),
    );
  }

  Future<String?> _tryModel({
    required String apiKey,
    required String model,
    required String prompt,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/chat/completions',
      options: Options(
        headers: {'Authorization': 'Bearer $apiKey'},
      ),
      data: {
        'model': model,
        'messages': [
          {'role': 'user', 'content': prompt},
        ],
        'temperature': 0.7,
        'max_tokens': 300,
      },
    );

    if (response.statusCode != 200 || response.data == null) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Non-200 response: ${response.statusCode}',
      );
    }

    final data = response.data!;
    final choices = data['choices'];
    if (choices is! List || choices.isEmpty) {
      throw Exception('No choices in response');
    }

    final firstChoice = choices.first;
    if (firstChoice is! Map) {
      throw Exception('Invalid choice structure in response');
    }

    final message = firstChoice['message'];
    if (message is! Map) {
      throw Exception('Invalid message structure in response');
    }

    final content = message['content'];
    if (content is! String || content.trim().isEmpty) {
      throw Exception('Empty content in response');
    }

    return content.trim();
  }

  String _formatDioError(DioException e, String model) {
    final status = e.response?.statusCode;
    final data = e.response?.data;
    if (status == 401) return 'Model $model: Invalid API key';
    if (status == 429) return 'Model $model: Rate limited';
    if (status == 402) return 'Model $model: Insufficient credits';
    if (status == 503) return 'Model $model: Model unavailable';
    if (data != null && data is Map && data['error'] != null) {
      return 'Model $model: ${data['error']}';
    }
    return 'Model $model: ${e.message}';
  }
}
