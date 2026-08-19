import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/core/network/rate_limit_interceptor.dart';
import 'package:sakkoja/core/network/web_proxy_interceptor.dart';
import 'package:sakkoja/core/utils/dio_transformer.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'core_providers.g.dart';

/// Shared Preferences Provider
/// Must be overridden in `main.dart` with `await SharedPreferences.getInstance()`
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in main.dart',
  );
}

/// App Database Provider (Drift)
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}

/// Dio Client Provider
/// configured with RateLimits, Retry, and WebProxy
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);

  final dio = Dio(
    BaseOptions(
      // Timeout configuration for network resilience
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 15),
    ),
  );
  dio.transformer = FlutterTransformer();
  ref.onDispose(dio.close);

  // Rate Limiting: Prevent self-DoS and respect API quotas
  dio.interceptors.add(
    RateLimitInterceptor(
      // Default: 20 requests per 10 seconds (Burst protection)
      defaultConfig: const RateLimitConfig(20, Duration(seconds: 10)),
      domainConfigs: {
        // OpenWeather: 60 reqs/min (Free tier limit). We set 55/60s to be safe.
        'api.openweathermap.org': const RateLimitConfig(
          55,
          Duration(seconds: 60),
        ),
        // FMI: High volume allowed, but good to throttle.
        'opendata.fmi.fi': const RateLimitConfig(200, Duration(minutes: 5)),
        'api.met.no': const RateLimitConfig(20, Duration(seconds: 1)),
        // Digitraffic:
        'tie.digitraffic.fi': const RateLimitConfig(100, Duration(minutes: 1)),
        // Väylävirasto (Nav Aids): Public API, allow high volume for map tiles
        'avoinapi.vaylapilvi.fi': const RateLimitConfig(
          100,
          Duration(minutes: 1),
        ),
        // SYKE map/WMS services
        'paikkatieto.ymparisto.fi': const RateLimitConfig(
          50,
          Duration(minutes: 1),
        ),
        // SYKE Water Quality & Algae: OData API (legacy host)
        'odata.ymparisto.fi': const RateLimitConfig(
          50,
          Duration(minutes: 1),
        ),
        // SYKE Vesla v2.0 OData + citizen observations (kansalaishavainnot)
        'rajapinnat.ymparisto.fi': const RateLimitConfig(
          50,
          Duration(minutes: 1),
        ),
        'geoserver2.ymparisto.fi': const RateLimitConfig(
          50,
          Duration(minutes: 1),
        ),
      },
      prefs: prefs,
    ),
  );

  // Resilience: Add smart retry (exponential backoff)
  dio.interceptors.add(
    RetryInterceptor(
      dio: dio,
      logPrint: (message) => Log.w('Network Retry: $message'),
      retryDelays: const [
        Duration(seconds: 1),
        Duration(seconds: 2),
        Duration(seconds: 4),
      ],
    ),
  );

  if (kIsWeb) {
    dio.interceptors.add(WebProxyInterceptor());
  }

  return dio;
}

/// A dedicated Dio client for map tile fetching.
/// Bypasses rate-limiting and smart retries to prevent blocking UI/UX during fast map panning.
@Riverpod(keepAlive: true)
Dio tileDio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      // Timeout configuration for network resilience
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 15),
    ),
  );
  dio.transformer = FlutterTransformer();
  ref.onDispose(dio.close);

  if (kIsWeb) {
    dio.interceptors.add(WebProxyInterceptor());
  }

  return dio;
}
