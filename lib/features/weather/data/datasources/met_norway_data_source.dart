import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/constants/met_norway_constants.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/weather/data/models/weather_forecast_dto.dart';

part 'met_norway_data_source.g.dart';

abstract class MetNorwayDataSource {
  Future<List<WeatherForecastDto>> fetchLocationForecast(
    double lat,
    double lon,
  );
}

@Riverpod(keepAlive: true)
MetNorwayDataSource metNorwayDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return MetNorwayDataSourceImpl(dio);
}

class MetNorwayDataSourceImpl implements MetNorwayDataSource {
  MetNorwayDataSourceImpl(this._dio);
  final Dio _dio;
  final Map<String, Future<List<WeatherForecastDto>>> _inFlightRequests = {};

  @override
  Future<List<WeatherForecastDto>> fetchLocationForecast(
    double lat,
    double lon,
  ) async {
    final latStr = lat.toStringAsFixed(4);
    final lonStr = lon.toStringAsFixed(4);
    final cacheKey = '$latStr,$lonStr';

    if (_inFlightRequests.containsKey(cacheKey)) {
      Log.d('[MET Norway] Reusing in-flight request for $cacheKey');
      return _inFlightRequests[cacheKey]!;
    }

    final sw = Stopwatch()..start();
    Log.d('[MET Norway] Fetching forecast for $lat, $lon');

    final future = () async {
      try {
        final response = await _dio.get<Map<String, dynamic>>(
          '${MetNorwayConstants.baseUrl}${MetNorwayConstants.forecastComplete}',
          queryParameters: {
            'lat': lat.toStringAsFixed(4),
            'lon': lon.toStringAsFixed(4),
          },
          options: Options(
            // On web, browsers strictly prohibit setting the 'User-Agent' header.
            // The sakkoja-cors-proxy injects a valid User-Agent when forwarding to
            // the Met Norway API to ensure identification compliance.
            headers: {
              if (!kIsWeb) 'User-Agent': MetNorwayConstants.userAgent,
            },
          ),
        );

        final data = response.data;
        if (data == null) return <WeatherForecastDto>[];
        final props = data['properties'] as Map<String, dynamic>;
        final timeseries = props['timeseries'] as List<dynamic>;
        final location = LatLng(lat, lon);

        final meta = props['meta'] as Map<String, dynamic>;
        final updatedTime = DateTime.parse(meta['updated_at'] as String);
        final dtos = timeseries
            .map(
              (dynamic json) => _mapToForecastDto(
                json as Map<String, dynamic>,
                location,
                updatedTime,
              ),
            )
            .toList();

        Log.i(
          '[MET Norway] Forecast fetched '
          '(${dtos.length} points) in ${sw.elapsedMilliseconds}ms',
        );
        return dtos;
      } catch (e, s) {
        Log.e('[MET Norway] Forecast fetch failed', e, s);
        rethrow;
      } finally {
        unawaited(_inFlightRequests.remove(cacheKey));
      }
    }();

    _inFlightRequests[cacheKey] = future;
    return future;
  }

  WeatherForecastDto _mapToForecastDto(
    Map<String, dynamic> json,
    LatLng location,
    DateTime issuedAt,
  ) {
    final time = DateTime.parse(json['time'] as String);
    final data = json['data'] as Map<String, dynamic>? ?? {};
    final instant =
        (data['instant'] as Map<String, dynamic>?)?['details']
            as Map<String, dynamic>? ??
        {};

    // Summary info is usually in next_1_hours, next_6_hours, etc.
    final next1h = data['next_1_hours'] as Map<String, dynamic>?;
    final next6h = data['next_6_hours'] as Map<String, dynamic>?;

    final summary =
        (next1h?['summary'] ?? next6h?['summary']) as Map<String, dynamic>?;
    final symbolCode = summary?['symbol_code'] as String?;

    // Precipitation info
    final precip =
        (next1h?['details']
            as Map<String, dynamic>?)?['precipitation_amount'] ??
        (next6h?['details'] as Map<String, dynamic>?)?['precipitation_amount'];

    return WeatherForecastDto(
      timestamp: time,
      issuedAt: issuedAt,
      location: location,
      temperature: _toDouble(instant['air_temperature']),
      windSpeed: _toDouble(instant['wind_speed']),
      windGust: _toDouble(instant['wind_speed_of_gust']),
      windDirection: _toDouble(instant['wind_from_direction']),
      pressure: _toDouble(instant['air_pressure_at_sea_level']),
      humidity: _toDouble(instant['relative_humidity']),
      dewPoint: _toDouble(instant['dew_point_temperature']),
      cloudCover: _toDouble(instant['cloud_area_fraction']),
      uvIndex: _toDouble(instant['ultraviolet_index_clear_sky']),
      precipitation: _toDouble(precip),
      precipitationProbability: _toDouble(
        (next1h?['details']
                as Map<String, dynamic>?)?['probability_of_precipitation'] ??
            (next6h?['details']
                as Map<String, dynamic>?)?['probability_of_precipitation'],
      ),
      weatherIcon: symbolCode,
      weatherDescription: symbolCode?.replaceAll('_', ' '),
      providerId: 5,
    );
  }

  double? _toDouble(dynamic val) => switch (val) {
    final num n => n.toDouble(),
    final String s => double.tryParse(s),
    _ => null,
  };
}
