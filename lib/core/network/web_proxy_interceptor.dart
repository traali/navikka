import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sakkoja/core/utils/logger.dart';

/// Sensitive query parameter keys whose values must be redacted in logs.
const _sensitiveParams = {
  'appid',
  'api_key',
  'apiKey',
  'key',
  'token',
  'secret',
  'apikey',
  'x-api-key',
};

/// Redacts sensitive query parameter values from a URL string.
String _sanitizeUrl(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null || uri.queryParameters.isEmpty) return url;
  final sanitized = Map<String, String>.from(uri.queryParameters);
  for (final key in sanitized.keys) {
    if (_sensitiveParams.contains(key.toLowerCase())) {
      sanitized[key] = '***';
    }
  }
  return uri.replace(queryParameters: sanitized).toString();
}

/// Interceptor that automatically prepends a CORS proxy URL for web requests
/// targeting specific external domains.
class WebProxyInterceptor extends Interceptor {
  // Keep the public testing argument free of a private-name API.
  WebProxyInterceptor({@visibleForTesting this._forceWebForTesting});
  final bool? _forceWebForTesting;

  static const String proxyUrl =
      'https://sakkoja-cors-proxy.sakkoja.workers.dev';

  /// Secret to authenticate against the Cloudflare worker.
  /// Must be set via --dart-define=PROXY_AUTH_SECRET=xxx in release builds.
  /// In development it may be empty, but unauthenticated requests mean anyone
  /// who reads the source can abuse your CORS proxy for free API access.
  static const String proxyAuthSecret = String.fromEnvironment(
    'PROXY_AUTH_SECRET',
  );

  /// List of hostnames that require proxying on Web due to CORS restrictions.
  static const Set<String> proxiedHosts = {
    'alerts.fmi.fi',
    'opendata.fmi.fi',
    'openwms.fmi.fi',
    'julkinen.traficom.fi',
    'avoinapi.vaylapilvi.fi',
    'avoinkara-mmm.ruokavirasto-awsa.com',
    'api.met.no',
    'api.openweathermap.org',
    'paikkatieto.ymparisto.fi',
    'odata.ymparisto.fi',
    'rajapinnat.ymparisto.fi',
    'geoserver2.ymparisto.fi',
    'avoinkara.mmm.fi',
    'meri.digitraffic.fi',
    'api.lipas.fi',
    // Map tile hosts — must be proxied on web for CORS
    'tile.openstreetmap.org',      // OSM basemap tiles
    'tiles.maps.eox.at',           // EOX Sentinel-2 cloudless tiles
    'server.arcgisonline.com',     // ESRI HD satellite basemap tiles
  };

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!kIsWeb && (_forceWebForTesting != true)) {
      return handler.next(options);
    }

    if (kDebugMode && _forceWebForTesting != true && proxyAuthSecret.isEmpty) {
      Log.w(
        'WebProxyInterceptor: PROXY_AUTH_SECRET is empty in debug mode. '
        'Pass --dart-define=PROXY_AUTH_SECRET=xxx for authenticated proxy access.',
      );
    }

    final uri = options.uri;
    if (proxiedHosts.contains(uri.host)) {
      final targetUrl = uri.toString();
      final newUrl = '$proxyUrl?url=${Uri.encodeComponent(targetUrl)}';

      // Store the original URL for response/error logging
      options.extra['original_url'] = targetUrl;

      // Clear baseUrl and update path with the proxied URL
      options.baseUrl = '';
      options.path = newUrl;
      // Clear query parameters as they are now encoded in the 'url' parameter
      options.queryParameters = {};

      if (proxyAuthSecret.isNotEmpty) {
        options.headers['X-App-Auth'] = proxyAuthSecret;
      }

      Log.i(
        'WebProxyInterceptor: Proxying request to ${_sanitizeUrl(targetUrl)} via $proxyUrl',
      );
    }

    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final originalUrl =
        response.requestOptions.extra['original_url'] as String?;
    if (originalUrl != null) {
      Log.i(
        'WebProxyInterceptor: Success [${response.statusCode}] from ${_sanitizeUrl(originalUrl)}',
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final originalUrl = err.requestOptions.extra['original_url'] as String?;
    if (originalUrl != null) {
      Log.e(
        'WebProxyInterceptor: Failed [${err.response?.statusCode ?? 'N/A'}] from ${_sanitizeUrl(originalUrl)}\n'
        'Error: ${err.message}\n'
        'Response: ${err.response?.data}',
      );
    }
    handler.next(err);
  }
}
