import 'dart:async';

import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/weather/data/models/wave_observation_dto.dart';

part 'open_meteo_marine_data_source.g.dart';

abstract class OpenMeteoMarineDataSource {
  Future<List<WaveObservationDto>> fetchMarineForecast(double lat, double lon);
}

@Riverpod(keepAlive: true)
OpenMeteoMarineDataSource openMeteoMarineDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return OpenMeteoMarineDataSourceImpl(dio);
}

class OpenMeteoMarineDataSourceImpl implements OpenMeteoMarineDataSource {
  OpenMeteoMarineDataSourceImpl(this._dio);

  final Dio _dio;
  final Map<String, Future<List<WaveObservationDto>>> _inFlightRequests = {};

  @override
  Future<List<WaveObservationDto>> fetchMarineForecast(
    double lat,
    double lon,
  ) async {
    final latStr = lat.toStringAsFixed(4);
    final lonStr = lon.toStringAsFixed(4);
    final cacheKey = 'openmeteo_marine_$latStr,$lonStr';

    if (_inFlightRequests.containsKey(cacheKey)) {
      Log.d('[Open-Meteo Marine] Reusing in-flight request for $cacheKey');
      return _inFlightRequests[cacheKey]!;
    }

    final sw = Stopwatch()..start();
    Log.d('[Open-Meteo Marine] Fetching marine forecast for $lat, $lon');

    final future = () async {
      try {
        final response = await _dio.get<Map<String, dynamic>>(
          'https://marine-api.open-meteo.com/v1/marine',
          queryParameters: {
            'latitude': latStr,
            'longitude': lonStr,
            'hourly':
                'wave_height,wave_direction,wave_period,ocean_current_velocity,sea_water_temperature',
            'forecast_hours': 24,
          },
        );

        final data = response.data;
        if (data == null) return <WaveObservationDto>[];

        final hourly = data['hourly'] as Map<String, dynamic>?;
        if (hourly == null) return <WaveObservationDto>[];

        final times = hourly['time'] as List<dynamic>? ?? [];
        final heights = hourly['wave_height'] as List<dynamic>? ?? [];
        final dirs = hourly['wave_direction'] as List<dynamic>? ?? [];
        final periods = hourly['wave_period'] as List<dynamic>? ?? [];
        final temps = hourly['sea_water_temperature'] as List<dynamic>? ?? [];

        final location = LatLng(lat, lon);
        final dtos = <WaveObservationDto>[];

        for (int i = 0; i < times.length; i++) {
          final time = DateTime.parse(times[i] as String);
          dtos.add(
            WaveObservationDto(
              timestamp: time,
              location: location,
              stationName: 'Open-Meteo Marine',
              waveHeight: _toDouble(heights.length > i ? heights[i] : null),
              waveDirection: _toDouble(dirs.length > i ? dirs[i] : null),
              wavePeriod: _toDouble(periods.length > i ? periods[i] : null),
              waterTemperature: _toDouble(temps.length > i ? temps[i] : null),
            ),
          );
        }

        Log.i(
          '[Open-Meteo Marine] Fetched ${dtos.length} points in ${sw.elapsedMilliseconds}ms',
        );
        return dtos;
      } catch (e, s) {
        Log.e('[Open-Meteo Marine] Fetch failed', e, s);
        rethrow;
      } finally {
        unawaited(_inFlightRequests.remove(cacheKey));
      }
    }();

    _inFlightRequests[cacheKey] = future;
    return future;
  }

  double? _toDouble(dynamic val) {
    if (val == null) return null;
    if (val is num) return val.toDouble();
    if (val is String) return double.tryParse(val);
    return null;
  }
}
