import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb, visibleForTesting;
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/constants/openweather_constants.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/weather/data/models/weather_forecast_dto.dart';
import 'package:sakkoja/features/weather/data/models/weather_observation_dto.dart';

part 'openweather_data_source.g.dart';

abstract class OpenWeatherDataSource {
  Future<WeatherObservationDto?> fetchCurrentWeather(double lat, double lon);
  Future<List<WeatherForecastDto>> fetchThreeHourForecast(
    double lat,
    double lon,
  );
}

@Riverpod(keepAlive: true)
OpenWeatherDataSource openWeatherDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return OpenWeatherDataSourceImpl(dio);
}

class OpenWeatherDataSourceImpl implements OpenWeatherDataSource {
  // Keep the testing override name usable outside this implementation.
  OpenWeatherDataSourceImpl(
    this._dio, {
    @visibleForTesting this._apiKeyOverride,
  });
  final Dio _dio;
  final String? _apiKeyOverride;
  final Map<String, Future<dynamic>> _inFlightRequests = {};

  String get _apiKey => _apiKeyOverride ?? OpenWeatherConstants.activeApiKey;

  @override
  Future<WeatherObservationDto?> fetchCurrentWeather(
    double lat,
    double lon,
  ) async {
    final key = 'current_${lat.toStringAsFixed(4)},${lon.toStringAsFixed(4)}';

    if (_inFlightRequests.containsKey(key)) {
      Log.d('[OpenWeather] Returning in-flight request for $key');
      return _inFlightRequests[key]! as Future<WeatherObservationDto?>;
    }

    final future = _fetchCurrentWeatherInternal(lat, lon);
    _inFlightRequests[key] = future;

    try {
      return await future;
    } finally {
      _inFlightRequests.remove(key);
    }
  }

  Future<WeatherObservationDto?> _fetchCurrentWeatherInternal(
    double lat,
    double lon,
  ) async {
    final sw = Stopwatch()..start();
    Log.d('[OpenWeather] Fetching current weather for $lat, $lon');

    try {
      // Defensive: Check key before request to avoid StateError
      String apiKey;
      try {
        apiKey = _apiKey;
      } catch (e) {
        Log.i('[OpenWeather] API Key missing. Returning null observation.');
        return null;
      }

      final response = await _dio.get<dynamic>(
        '${OpenWeatherConstants.baseUrl}${OpenWeatherConstants.currentWeatherEndpoint}',
        queryParameters: {
          'lat': lat.toStringAsFixed(4),
          'lon': lon.toStringAsFixed(4),
          if (!kIsWeb) 'appid': apiKey,
          'units': OpenWeatherConstants.units,
          'lang': OpenWeatherConstants.lang,
        },
      );

      final raw = response.data;
      if (raw is! Map<String, dynamic>) return null;
      final dto = _mapCurrentToDto(raw, lat, lon);

      Log.i(
        '[OpenWeather] Current weather for ${dto.stationName} fetched in ${sw.elapsedMilliseconds}ms',
      );
      return dto;
    } catch (e, s) {
      Log.e('[OpenWeather] Current weather fetch failed', e, s);
      rethrow;
    }
  }

  @override
  Future<List<WeatherForecastDto>> fetchThreeHourForecast(
    double lat,
    double lon,
  ) async {
    final key = 'forecast_${lat.toStringAsFixed(4)},${lon.toStringAsFixed(4)}';

    if (_inFlightRequests.containsKey(key)) {
      Log.d('[OpenWeather] Returning in-flight request for $key');
      return _inFlightRequests[key]! as Future<List<WeatherForecastDto>>;
    }

    final future = _fetchThreeHourForecastInternal(lat, lon);
    _inFlightRequests[key] = future;

    try {
      return await future;
    } finally {
      _inFlightRequests.remove(key);
    }
  }

  Future<List<WeatherForecastDto>> _fetchThreeHourForecastInternal(
    double lat,
    double lon,
  ) async {
    final sw = Stopwatch()..start();
    Log.d('[OpenWeather] Fetching 5-day/3-hour forecast for $lat, $lon');

    try {
      // Defensive: Check key before request to avoid StateError
      String apiKey;
      try {
        apiKey = _apiKey;
      } catch (e) {
        Log.i('[OpenWeather] API Key missing. Returning empty forecast.');
        return [];
      }

      final response = await _dio.get<dynamic>(
        '${OpenWeatherConstants.baseUrl}${OpenWeatherConstants.forecastEndpoint}',
        queryParameters: {
          'lat': lat.toStringAsFixed(4),
          'lon': lon.toStringAsFixed(4),
          if (!kIsWeb) 'appid': apiKey,
          'units': OpenWeatherConstants.units,
          'lang': OpenWeatherConstants.lang,
        },
      );

      final raw = response.data;
      if (raw is! Map<String, dynamic>) return [];
      final list = (raw['list'] as List<dynamic>?) ?? [];
      final cityName = raw['city']?['name'] as String?;

      final dtos = list.map((item) {
        return _mapForecastToDto(item as Map<String, dynamic>, lat, lon);
      }).toList();

      Log.i(
        '[OpenWeather] Forecast for $cityName (${dtos.length} points) fetched in ${sw.elapsedMilliseconds}ms',
      );
      return dtos;
    } catch (e, s) {
      Log.e('[OpenWeather] Forecast fetch failed', e, s);
      rethrow;
    }
  }

  WeatherObservationDto _mapCurrentToDto(
    Map<String, dynamic> json,
    double lat,
    double lon,
  ) {
    final main = json['main'] as Map<String, dynamic>? ?? {};
    final wind = json['wind'] as Map<String, dynamic>? ?? {};
    final clouds = json['clouds'] as Map<String, dynamic>? ?? {};
    final weather =
        (json['weather'] as List<dynamic>?)?.firstOrNull
            as Map<String, dynamic>? ??
        {};
    final sys = json['sys'] as Map<String, dynamic>? ?? {};

    return WeatherObservationDto(
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        _toInt(json['dt']) * 1000,
        isUtc: true,
      ),
      location: LatLng(lat, lon),
      stationName: json['name'] as String? ?? 'OpenWeather',
      temperature: _toDouble(main['temp']),
      feelsLike: _toDouble(main['feels_like']),
      pressure: _toDouble(main['pressure']),
      humidity: _toDouble(main['humidity']),
      windSpeed: _toDouble(wind['speed']),
      windDirection: _toDouble(wind['deg']),
      windGust: _toDouble(wind['gust']),
      cloudCover: _toDouble(clouds['all']),
      visibility: _toDouble(json['visibility']),
      precipitation: _toDouble(json['rain']?['1h'] ?? json['snow']?['1h']),
      weatherCode: weather['id'] as int?,
      weatherIcon: weather['icon'] as String?,
      weatherDescription: weather['description'] as String?,
      sunrise: sys['sunrise'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              _toInt(sys['sunrise']) * 1000,
              isUtc: true,
            )
          : null,
      sunset: sys['sunset'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              _toInt(sys['sunset']) * 1000,
              isUtc: true,
            )
          : null,
      providerId: 3,
    );
  }

  WeatherForecastDto _mapForecastToDto(
    Map<String, dynamic> json,
    double lat,
    double lon,
  ) {
    final main = json['main'] as Map<String, dynamic>? ?? {};
    final wind = json['wind'] as Map<String, dynamic>? ?? {};
    final clouds = json['clouds'] as Map<String, dynamic>? ?? {};
    final weather =
        (json['weather'] as List<dynamic>?)?.firstOrNull
            as Map<String, dynamic>? ??
        {};

    return WeatherForecastDto(
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        _toInt(json['dt']) * 1000,
        isUtc: true,
      ),
      location: LatLng(lat, lon),
      temperature: _toDouble(main['temp']),
      feelsLike: _toDouble(main['feels_like']),
      pressure: _toDouble(main['pressure']),
      humidity: _toDouble(main['humidity']),
      windSpeed: _toDouble(wind['speed']),
      windDirection: _toDouble(wind['deg']),
      windGust: _toDouble(wind['gust']),
      cloudCover: _toDouble(clouds['all']),
      precipitationProbability: (json['pop'] as num?)?.toDouble() != null
          ? (json['pop'] as num).toDouble() * 100
          : null,
      precipitation: _toDouble(json['rain']?['3h'] ?? json['snow']?['3h']),
      weatherIcon: weather['icon'] as String?,
      weatherDescription: weather['description'] as String?,
      providerId: 3,
    );
  }

  double? _toDouble(dynamic val) {
    if (val == null) return null;
    if (val is double) return val;
    if (val is int) return val.toDouble();
    return double.tryParse(val.toString());
  }

  int _toInt(dynamic val) {
    if (val is int) return val;
    if (val is double) return val.toInt();
    if (val is String) return int.tryParse(val) ?? 0;
    return 0;
  }
}
