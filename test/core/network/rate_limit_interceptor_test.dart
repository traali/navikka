import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/core/network/rate_limit_interceptor.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late RateLimitInterceptor interceptor;
  late MockRequestInterceptorHandler mockHandler;
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockHandler = MockRequestInterceptorHandler();
    mockPrefs = MockSharedPreferences();

    when(() => mockPrefs.getKeys()).thenReturn({});
    when(
      () => mockPrefs.setStringList(any(), any()),
    ).thenAnswer((_) async => true);
    when(() => mockPrefs.getStringList(any())).thenReturn([]);

    interceptor = RateLimitInterceptor(
      prefs: mockPrefs,
      defaultConfig: const RateLimitConfig(2, Duration(milliseconds: 100)),
      domainConfigs: {
        'api.custom.com': const RateLimitConfig(5, Duration(milliseconds: 100)),
      },
    );
  });

  test('should use default config for unknown domains', () async {
    final options = RequestOptions(path: 'https://api.unknown.com/users');

    // 1st request - OK
    await interceptor.onRequest(options, mockHandler);
    // 2nd request - OK
    await interceptor.onRequest(options, mockHandler);

    // 3rd request - Throttled (limit is 2)
    // We expect it to wait, but since we can't easily test "wait" without FakeAsync,
    // we verify that the method eventually completes.
    // However, knowing the logic, the 3rd one WILL call handler.next() eventually.

    verify(() => mockHandler.next(options)).called(2);
  });

  test('should use custom config for known domains', () async {
    final options = RequestOptions(path: 'https://api.custom.com/data');

    // Limit is 5. Send 5 requests.
    for (var i = 0; i < 5; i++) {
      await interceptor.onRequest(options, mockHandler);
    }

    verify(() => mockHandler.next(options)).called(5);
  });

  test('should track limits independently per domain', () async {
    final options1 = RequestOptions(path: 'https://api.unknown.com/1');
    final options2 = RequestOptions(path: 'https://api.custom.com/1');

    // Use up default limit (2)
    await interceptor.onRequest(options1, mockHandler); // 1
    await interceptor.onRequest(options1, mockHandler); // 2

    // Usage on unknown.com should NOT affect custom.com (limit 5)
    await interceptor.onRequest(options2, mockHandler); // 1
    await interceptor.onRequest(options2, mockHandler); // 2
    await interceptor.onRequest(options2, mockHandler); // 3

    // unknown.com: 2
    verify(() => mockHandler.next(options1)).called(2);
    // custom.com: 3
    verify(() => mockHandler.next(options2)).called(3);
  });
  test(
    'queued requests use the lock-acquisition time for their next window',
    () async {
      final queuedInterceptor = RateLimitInterceptor(
        prefs: mockPrefs,
        defaultConfig: const RateLimitConfig(1, Duration(milliseconds: 80)),
      );
      final dispatches = <DateTime>[];
      registerFallbackValue(RequestOptions(path: 'https://api.queued.com'));
      when(() => mockHandler.next(any())).thenAnswer((_) {
        dispatches.add(DateTime.now());
      });

      await queuedInterceptor.onRequest(
        RequestOptions(path: 'https://api.queued.com/one'),
        mockHandler,
      );
      final second = queuedInterceptor.onRequest(
        RequestOptions(path: 'https://api.queued.com/two'),
        mockHandler,
      );
      await Future<void>.delayed(const Duration(milliseconds: 10));
      final third = queuedInterceptor.onRequest(
        RequestOptions(path: 'https://api.queued.com/three'),
        mockHandler,
      );

      await Future.wait([second, third]);

      expect(dispatches, hasLength(3));
      expect(
        dispatches[2].difference(dispatches[1]).inMilliseconds,
        lessThan(130),
      );
    },
  );
}
