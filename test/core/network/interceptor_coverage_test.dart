import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/network/rate_limit_interceptor.dart';
import 'package:sakkoja/core/network/web_proxy_interceptor.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/features/ai/domain/services/open_router_service_impl.dart';
import 'package:sakkoja/features/weather/data/datasources/syke_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Interceptor Coverage Test Suite', () {
    test(
      'dioProvider contains RateLimitInterceptor and conditionally WebProxyInterceptor',
      () async {
        final prefs = await SharedPreferences.getInstance();
        final container = ProviderContainer(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
        );
        addTearDown(container.dispose);

        final dio = container.read(dioProvider);
        final types = dio.interceptors.map((i) => i.runtimeType).toSet();

        expect(types, contains(RateLimitInterceptor));
        if (kIsWeb) {
          expect(types, contains(WebProxyInterceptor));
        }
      },
    );

    test(
      'openRouterDioProvider contains RateLimitInterceptor and conditionally WebProxyInterceptor',
      () async {
        final prefs = await SharedPreferences.getInstance();
        final container = ProviderContainer(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
        );
        addTearDown(container.dispose);

        final dio = container.read(openRouterDioProvider);
        final types = dio.interceptors.map((i) => i.runtimeType).toSet();

        expect(types, contains(RateLimitInterceptor));
        if (kIsWeb) {
          expect(types, contains(WebProxyInterceptor));
        }
      },
    );

    test(
      'SykeDataSource uses injected dioProvider carrying RateLimitInterceptor',
      () async {
        final prefs = await SharedPreferences.getInstance();
        final container = ProviderContainer(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
        );
        addTearDown(container.dispose);

        final sykeDs = container.read(sykeDataSourceProvider);
        final types = sykeDs.dio.interceptors.map((i) => i.runtimeType).toSet();

        expect(types, contains(RateLimitInterceptor));
        if (kIsWeb) {
          expect(types, contains(WebProxyInterceptor));
        }
      },
    );
  });
}
