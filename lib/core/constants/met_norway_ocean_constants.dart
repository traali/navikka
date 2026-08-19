/// MET Norway OceanForecast 2.0 API Configuration
///
/// API Documentation: https://api.met.no/weatherapi/oceanforecast/2.0/documentation
library;

class MetNorwayOceanConstants {
  /// Base URL
  static const String baseUrl = 'https://api.met.no/weatherapi';

  /// OceanForecast endpoint
  static const String oceanForecastComplete = '/oceanforecast/2.0/complete';

  /// Required User-Agent header
  static const String userAgent = 'Sakkoja/1.0 github.com/traali/sakkoja';

  /// Rate limits (same as Locationforecast)
  static const int recommendedCallsPerSecond = 20;

  /// Build OceanForecast URL
  static String buildOceanForecastUrl({
    required double lat,
    required double lon,
  }) {
    final params = <String, String>{
      'lat': lat.toStringAsFixed(4),
      'lon': lon.toStringAsFixed(4),
    };

    final uri = Uri.parse(
      '$baseUrl$oceanForecastComplete',
    ).replace(queryParameters: params);
    return uri.toString();
  }
}
