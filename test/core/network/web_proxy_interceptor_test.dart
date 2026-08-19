import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/core/network/web_proxy_interceptor.dart';

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

void main() {
  group('WebProxyInterceptor', () {
    late WebProxyInterceptor interceptor;
    late MockRequestInterceptorHandler handler;

    setUp(() {
      interceptor = WebProxyInterceptor(forceWebForTesting: true);
      handler = MockRequestInterceptorHandler();
    });

    test('should correctly encode URL query parameters when proxying', () {
      // Arrange
      // A complex URL with characters that need encoding and existing query parameters
      const originalPath = '/wfs';
      const originalBase = 'https://opendata.fmi.fi';
      final options = RequestOptions(
        path: originalPath,
        baseUrl: originalBase,
        queryParameters: {
          'id': 'fmi::test', // Colon needs encoding
          'time': '2026-01-05T12:00:00Z', // Colon in time needs encoding
        },
      );

      // Act
      interceptor.onRequest(options, handler);

      // Assert
      // The path should be the proxy URL
      expect(
        options.path,
        startsWith('https://sakkoja-cors-proxy.sakkoja.workers.dev'),
      );

      // The 'url' query param should be present
      final proxyUrl = Uri.parse(options.path);
      final targetUrlEncoded = proxyUrl.queryParameters['url'];
      expect(targetUrlEncoded, isNotNull);

      // Decode the target URL to verify it's what we expect
      final targetUrl = Uri.decodeFull(targetUrlEncoded!);

      // Reconstruct what the full target URL should have been
      // Note: Dio combines baseUrl + path + queryParameters when making the request.
      // The interceptor takes `options.uri` which creates the full URI.
      // verified behavior: 'https://opendata.fmi.fi/wfs?id=fmi%3A%3Atest&time=2026-01-05T12%3A00%3A00Z'

      // Specifically check for the double encoding issue.
      // If we used encodeFull (the bug), '%' would become '%25' inside the 'url' param.
      // So if we decode ONCE, we should get the clean URL.
      // If the bug exists, we might see residuals or broken query params.

      // Actually, the bug is that `&` is NOT encoded by encodeFull.
      // So if the bug is present, the proxyUrl will have multiple query params, not just 'url'.
      if (proxyUrl.queryParameters.length > 1) {
        fail(
          'FAIL: Proxy URL has leaked query parameters (likely due to & not being encoded). Params: ${proxyUrl.queryParameters.keys}',
        );
      }

      // And check if the value itself was correct
      expect(targetUrl, contains('id=fmi::test'));
    });

    test(
      'should clear baseUrl when proxying to prevent relative URL resolution',
      () {
        final options = RequestOptions(
          path: '/v2/sports-places',
          baseUrl: 'https://api.lipas.fi',
          queryParameters: {
            'typeCodes': [5110],
          },
        );

        interceptor.onRequest(options, handler);

        expect(options.baseUrl, equals(''));
        expect(
          options.path,
          startsWith('https://sakkoja-cors-proxy.sakkoja.workers.dev'),
        );
        expect(options.queryParameters, isEmpty);
      },
    );
  });
}
