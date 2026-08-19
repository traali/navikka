import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/fishing/domain/entities/keyword_config.dart';

/// Abstract interface for fetching remote configuration.
///
/// Current implementation: Cloudflare Worker
/// Future: Firebase Remote Config (swap implementation without changing consumers)
abstract class RemoteConfigService {
  /// Fetches the keyword configuration from the remote source.
  /// Returns the fallback configuration if fetch fails.
  Future<KeywordConfig> fetchKeywordConfig();
}

/// Cloudflare Worker implementation of [RemoteConfigService].
class CloudflareRemoteConfigService implements RemoteConfigService {
  CloudflareRemoteConfigService({Dio? dio, String? baseUrl})
    : _dio = dio ?? Dio(),
      _baseUrl = baseUrl ?? 'https://sakkoja-proxy.traali.workers.dev';
  final Dio _dio;
  final String _baseUrl;

  /// Cached configuration to avoid repeated network calls.
  KeywordConfig? _cachedConfig;

  @override
  Future<KeywordConfig> fetchKeywordConfig() async {
    // Return cached config if available
    if (_cachedConfig != null) {
      return _cachedConfig!;
    }

    try {
      final response = await _dio.get<dynamic>(
        '$_baseUrl/config',
        options: Options(
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        final json = data is String
            ? jsonDecode(data) as Map<String, dynamic>
            : (data is Map<String, dynamic> ? data : null);

        if (json != null) {
          _cachedConfig = KeywordConfig.fromJson(json);
          return _cachedConfig!;
        }
      }
    } on Exception catch (e) {
      Log.e('RemoteConfigService: Failed to fetch config: $e');
    }

    // Return bundled fallback on any error
    return KeywordConfig.fallback;
  }

  /// Clears the cached configuration, forcing a fresh fetch on next call.
  void clearCache() {
    _cachedConfig = null;
  }
}
