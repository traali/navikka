import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/ai/domain/services/open_router_service.dart';
import 'package:sakkoja/features/ai/domain/services/open_router_service_impl.dart';

class MockDio extends Mock implements Dio {}

class FakeRequestOptions extends Fake implements RequestOptions {}

void main() {
  late MockDio mockDio;
  late OpenRouterServiceImpl service;

  setUpAll(() {
    registerFallbackValue(FakeRequestOptions());
    registerFallbackValue(Options());
  });

  setUp(() {
    mockDio = MockDio();
    service = OpenRouterServiceImpl(mockDio);
  });

  group('OpenRouterServiceImpl', () {
    test('returns explanation on successful primary model call', () async {
      when(
        () => mockDio.post<Map<String, dynamic>>(
          '/chat/completions',
          options: any(named: 'options'),
          data: any(named: 'data'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: {
            'choices': [
              {
                'message': {
                  'content': 'Wind is picking up to 12 m/s. Consider reefing.',
                },
              },
            ],
          },
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await service.getExplanation(
        apiKey: 'test-key',
        modelId: 'meta-llama/llama-3.3-70b-instruct:free',
        prompt: 'test prompt',
      );

      expect(result.isRight(), true);
      expect(
        result.getOrElse((_) => ''),
        'Wind is picking up to 12 m/s. Consider reefing.',
      );
    });

    test('falls back to second model when primary fails with 503', () async {
      var callCount = 0;
      when(
        () => mockDio.post<Map<String, dynamic>>(
          '/chat/completions',
          options: any(named: 'options'),
          data: any(named: 'data'),
        ),
      ).thenAnswer((_) async {
        callCount++;
        if (callCount == 1) {
          throw DioException(
            requestOptions: RequestOptions(),
            response: Response(
              statusCode: 503,
              requestOptions: RequestOptions(),
            ),
            error: 'Model unavailable',
          );
        }
        return Response(
          data: {
            'choices': [
              {
                'message': {'content': 'Fallback explanation'},
              },
            ],
          },
          statusCode: 200,
          requestOptions: RequestOptions(),
        );
      });

      final result = await service.getExplanation(
        apiKey: 'test-key',
        modelId: 'meta-llama/llama-3.3-70b-instruct:free',
        prompt: 'test prompt',
      );

      expect(result.isRight(), true);
      expect(result.getOrElse((_) => ''), 'Fallback explanation');
      expect(callCount, 2);
    });

    test('returns ServerFailure when all models fail', () async {
      when(
        () => mockDio.post<Map<String, dynamic>>(
          '/chat/completions',
          options: any(named: 'options'),
          data: any(named: 'data'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(),
          error: 'Network error',
        ),
      );

      final result = await service.getExplanation(
        apiKey: 'test-key',
        modelId: 'meta-llama/llama-3.3-70b-instruct:free',
        prompt: 'test prompt',
      );

      expect(result.isLeft(), true);
      final failure = result.fold((f) => f, (_) => null);
      expect(failure, isA<ServerFailure>());
      expect(
        failure!.message,
        contains('fallback chain exhausted'),
      );
    });

    test('returns ServerFailure on 401 (invalid API key)', () async {
      when(
        () => mockDio.post<Map<String, dynamic>>(
          '/chat/completions',
          options: any(named: 'options'),
          data: any(named: 'data'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(),
          ),
          error: 'Unauthorized',
        ),
      );

      final result = await service.getExplanation(
        apiKey: 'bad-key',
        modelId: 'meta-llama/llama-3.3-70b-instruct:free',
        prompt: 'test prompt',
      );

      expect(result.isLeft(), true);
      final failure = result.fold((f) => f, (_) => null);
      expect(failure!.message, contains('Invalid API key'));
    });

    test('returns ServerFailure when response has no choices', () async {
      when(
        () => mockDio.post<Map<String, dynamic>>(
          '/chat/completions',
          options: any(named: 'options'),
          data: any(named: 'data'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: {'choices': []},
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await service.getExplanation(
        apiKey: 'test-key',
        modelId: 'meta-llama/llama-3.3-70b-instruct:free',
        prompt: 'test prompt',
      );

      expect(result.isLeft(), true);
    });

    test('skips duplicate fallback models in chain', () async {
      var callCount = 0;
      when(
        () => mockDio.post<Map<String, dynamic>>(
          '/chat/completions',
          options: any(named: 'options'),
          data: any(named: 'data'),
        ),
      ).thenAnswer((_) async {
        callCount++;
        // First call fails, second should succeed
        if (callCount == 1) {
          throw DioException(
            requestOptions: RequestOptions(),
            response: Response(
              statusCode: 429,
              requestOptions: RequestOptions(),
            ),
          );
        }
        return Response(
          data: {
            'choices': [
              {
                'message': {'content': 'OK'},
              },
            ],
          },
          statusCode: 200,
          requestOptions: RequestOptions(),
        );
      });

      // Use a fallback model as primary — should not duplicate in chain
      await service.getExplanation(
        apiKey: 'test-key',
        modelId: 'meta-llama/llama-3.2-3b-instruct:free',
        prompt: 'test prompt',
      );

      // Should try 3.2-3b first (as primary), then 3.3-70b, then openrouter/free
      // That's 3 unique models, so if first fails, second succeeds
      expect(callCount, 2);
    });
  });
}
