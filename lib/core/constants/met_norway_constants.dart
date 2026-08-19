/// MET Norway (YR) API Configuration
///
/// Locationforecast 2.0
/// Documentation: https://api.met.no/weatherapi/locationforecast/2.0/documentation
library;

class MetNorwayConstants {
  /// MET Norway API base URL
  static const String baseUrl = 'https://api.met.no/weatherapi';

  /// Locationforecast 2.0 endpoints
  static const String forecastCompact = '/locationforecast/2.0/compact';
  static const String forecastComplete = '/locationforecast/2.0/complete';

  /// Required User-Agent header
  /// MET Norway requires identifying information in User-Agent
  /// Format: AppName/Version ContactInfo
  static const String userAgent = 'Sakkoja/1.0 github.com/traali/sakkoja';

  /// Rate limits
  /// MET Norway is generous but require respectful usage
  static const int recommendedCallsPerSecond = 20;

  /// Weather icon base URL (GitHub hosted)
  static const String iconBaseUrl =
      'https://raw.githubusercontent.com/metno/weathericons/main/weather/svg';

  /// Build forecast URL
  /// Using compact by default (smaller, sufficient for most use cases)
  static String buildForecastUrl({
    required double lat,
    required double lon,
    int? altitude,
    bool complete = false,
  }) {
    final endpoint = complete ? forecastComplete : forecastCompact;
    final params = <String, String>{
      'lat': lat.toStringAsFixed(4),
      'lon': lon.toStringAsFixed(4),
    };

    if (altitude != null) {
      params['altitude'] = altitude.toString();
    }

    final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);
    return uri.toString();
  }

  /// Get weather icon URL from symbol_code
  /// Symbol codes like: 'clearsky_day', 'cloudy', 'rain'
  static String getIconUrl(String symbolCode) {
    return '$iconBaseUrl/$symbolCode.svg';
  }

  /// Symbol codes used in Locationforecast
  /// These map to icon files in the weathericons repository
  static const List<String> symbolCodes = [
    'clearsky_day',
    'clearsky_night',
    'clearsky_polartwilight',
    'fair_day',
    'fair_night',
    'fair_polartwilight',
    'partlycloudy_day',
    'partlycloudy_night',
    'partlycloudy_polartwilight',
    'cloudy',
    'fog',
    'heavyrain',
    'heavyrainandthunder',
    'heavyrainshowers_day',
    'heavyrainshowers_night',
    'heavyrainshowers_polartwilight',
    'heavyrainshowersandthunder_day',
    'heavyrainshowersandthunder_night',
    'heavyrainshowersandthunder_polartwilight',
    'heavysleet',
    'heavysleetandthunder',
    'heavysleetshowers_day',
    'heavysleetshowers_night',
    'heavysleetshowers_polartwilight',
    'heavysleetshowersandthunder_day',
    'heavysleetshowersandthunder_night',
    'heavysleetshowersandthunder_polartwilight',
    'heavysnow',
    'heavysnowandthunder',
    'heavysnowshowers_day',
    'heavysnowshowers_night',
    'heavysnowshowers_polartwilight',
    'heavysnowshowersandthunder_day',
    'heavysnowshowersandthunder_night',
    'heavysnowshowersandthunder_polartwilight',
    'lightrain',
    'lightrainandthunder',
    'lightrainshowers_day',
    'lightrainshowers_night',
    'lightrainshowers_polartwilight',
    'lightrainshowersandthunder_day',
    'lightrainshowersandthunder_night',
    'lightrainshowersandthunder_polartwilight',
    'lightsleet',
    'lightsleetandthunder',
    'lightsleetshowers_day',
    'lightsleetshowers_night',
    'lightsleetshowers_polartwilight',
    'lightsnow',
    'lightsnowandthunder',
    'lightsnowshowers_day',
    'lightsnowshowers_night',
    'lightsnowshowers_polartwilight',
    'lightssleetshowersandthunder_day', // Note: typo in official API
    'lightssleetshowersandthunder_night',
    'lightssleetshowersandthunder_polartwilight',
    'lightssnowshowersandthunder_day', // Note: typo in official API
    'lightssnowshowersandthunder_night',
    'lightssnowshowersandthunder_polartwilight',
    'rain',
    'rainandthunder',
    'rainshowers_day',
    'rainshowers_night',
    'rainshowers_polartwilight',
    'rainshowersandthunder_day',
    'rainshowersandthunder_night',
    'rainshowersandthunder_polartwilight',
    'sleet',
    'sleetandthunder',
    'sleetshowers_day',
    'sleetshowers_night',
    'sleetshowers_polartwilight',
    'sleetshowersandthunder_day',
    'sleetshowersandthunder_night',
    'sleetshowersandthunder_polartwilight',
    'snow',
    'snowandthunder',
    'snowshowers_day',
    'snowshowers_night',
    'snowshowers_polartwilight',
    'snowshowersandthunder_day',
    'snowshowersandthunder_night',
    'snowshowersandthunder_polartwilight',
  ];
}
