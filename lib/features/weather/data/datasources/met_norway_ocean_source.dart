import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/constants/met_norway_constants.dart';
import 'package:sakkoja/core/constants/met_norway_ocean_constants.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/weather/data/models/wave_observation_dto.dart';

part 'met_norway_ocean_source.g.dart';

abstract class MetNorwayOceanSource {
  Future<List<WaveObservationDto>> fetchOceanForecast(double lat, double lon);
}

@Riverpod(keepAlive: true)
MetNorwayOceanSource metNorwayOceanSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return MetNorwayOceanSourceImpl(dio);
}

class MetNorwayOceanSourceImpl implements MetNorwayOceanSource {
  MetNorwayOceanSourceImpl(this._dio);
  final Dio _dio;
  final Map<String, Future<List<WaveObservationDto>>> _inFlightRequests = {};

  @override
  Future<List<WaveObservationDto>> fetchOceanForecast(
    double lat,
    double lon,
  ) async {
    final latStr = lat.toStringAsFixed(4);
    final lonStr = lon.toStringAsFixed(4);
    final cacheKey = 'ocean_$latStr,$lonStr';

    if (_inFlightRequests.containsKey(cacheKey)) {
      Log.d('[MET Ocean] Reusing in-flight request for $cacheKey');
      return _inFlightRequests[cacheKey]!;
    }

    final sw = Stopwatch()..start();
    Log.d('[MET Ocean] Fetching ocean forecast for $lat, $lon');

    final future = () async {
      try {
        final response = await _dio.get<Map<String, dynamic>>(
          '${MetNorwayOceanConstants.baseUrl}'
          '${MetNorwayOceanConstants.oceanForecastComplete}',
          queryParameters: {'lat': latStr, 'lon': lonStr},
          options: Options(
            headers: {
              // On web, browsers strictly prohibit setting the 'User-Agent' header.
              // The sakkoja-cors-proxy injects a valid User-Agent when forwarding to
              // the Met Norway API to ensure identification compliance.
              if (!kIsWeb) 'User-Agent': MetNorwayConstants.userAgent,
            },
          ),
        );

        final data = response.data;
        if (data == null) return <WaveObservationDto>[];
        final props = data['properties'] as Map<String, dynamic>;
        final timeseries = props['timeseries'] as List<dynamic>;
        final location = LatLng(lat, lon);

        final dtos = timeseries
            .map(
              (json) => _mapToWaveDto(json as Map<String, dynamic>, location),
            )
            .toList();

        Log.i(
          '[MET Ocean] Fetched ${dtos.length} wave forecast points '
          'in ${sw.elapsedMilliseconds}ms',
        );
        return dtos;
      } catch (e, s) {
        Log.e('[MET Ocean] Fetch failed', e, s);
        rethrow;
      } finally {
        unawaited(_inFlightRequests.remove(cacheKey));
      }
    }();

    _inFlightRequests[cacheKey] = future;
    return future;
  }

  WaveObservationDto _mapToWaveDto(Map<String, dynamic> json, LatLng location) {
    final time = DateTime.parse(json['time'] as String);
    final data = json['data'] as Map<String, dynamic>;
    final instant =
        (data['instant'] as Map<String, dynamic>)['details']
            as Map<String, dynamic>;

    return WaveObservationDto(
      timestamp: time,
      location: location,
      stationName: 'MET Ocean Forecast',
      waveHeight: _toDouble(instant['sea_surface_wave_height']),
      waveDirection: _toDouble(instant['sea_surface_wave_from_direction']),
      waterTemperature: _toDouble(instant['sea_water_temperature']),
    );
  }

  double? _toDouble(dynamic val) {
    if (val == null) return null;
    if (val is num) return val.toDouble();
    if (val is String) return double.tryParse(val);
    return null;
  }
}
