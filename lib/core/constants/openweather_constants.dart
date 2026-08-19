import 'package:sakkoja/core/config/env.dart';

class OpenWeatherConstants {
  /// OpenWeather API 2.5 base URL (FREE)
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';

  /// OpenWeather API 3.0 base URL (PAID - requires subscription)
  static const String baseUrl30 = 'https://api.openweathermap.org/data/3.0';

  /// API 2.5 Endpoints (FREE)
  static const String currentWeatherEndpoint = '/weather';
  static const String forecastEndpoint = '/forecast'; // 5-day / 3-hour

  /// API 3.0 Endpoints (PAID)
  static const String oneCallEndpoint = '/onecall';

  /// API key environment variable name
  static const String apiKeyEnvVar = 'OPENWEATHER_API_KEY';

  /// Default API key (loaded from .env at runtime)
  static String get apiKey => Env.openWeatherKey;

  /// Get the active API key (fails explicitly if not configured)
  static String get activeApiKey {
    if (apiKey.isEmpty) {
      throw StateError('OPENWEATHER_API_KEY not configured in .env file.');
    }
    return apiKey;
  }

  /// Rate limits
  /// Free tier: 60 calls/minute, 1,000,000 calls/month
  static const int freeCallsPerMinute = 60;

  /// Request parameters

  /// Units: 'standard' (Kelvin), 'metric' (Celsius), 'imperial' (Fahrenheit)
  static const String units = 'metric';

  /// Language for weather descriptions
  static const String lang = 'en';

  /// Data sections that can be excluded to reduce response size
  /// Values: current, minutely, hourly, daily, alerts
  static const List<String> excludeOptions = [
    'current',
    'minutely',
    'hourly',
    'daily',
    'alerts',
  ];

  /// Build One Call API URL for forecast
  static String buildOneCallUrl({
    required double lat,
    required double lon,
    List<String>? exclude,
  }) {
    final params = <String, String>{
      'lat': lat.toStringAsFixed(4),
      'lon': lon.toStringAsFixed(4),
      'appid': apiKey,
      'units': units,
      'lang': lang,
    };

    if (exclude != null && exclude.isNotEmpty) {
      params['exclude'] = exclude.join(',');
    }

    final uri = Uri.parse(
      '$baseUrl$oneCallEndpoint',
    ).replace(queryParameters: params);
    return uri.toString();
  }
}
