import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_field.dart';
import 'package:sakkoja/features/weather/domain/entities/wind_field.dart';

/// Data source fetching Open-Meteo wind and marine wave forecast grids.
class OpenMeteoWindDataSource {
  const OpenMeteoWindDataSource(this._dio);

  final Dio _dio;

  /// Fetches a spatial grid of wind forecast points for a given bounding box and forecast hour offset (0..12).
  Future<WindField> fetchWindGrid({
    required LatLng southWest,
    required LatLng northEast,
    int forecastHourOffset = 0,
  }) async {
    try {
      final centerLat = (southWest.latitude + northEast.latitude) / 2.0;
      final centerLng = (southWest.longitude + northEast.longitude) / 2.0;

      // Sample a 5x5 spatial grid around center
      final points = <WindPoint>[];
      final response = await _dio.get<Map<String, dynamic>>(
        'https://api.open-meteo.com/v1/forecast',
        queryParameters: {
          'latitude': centerLat,
          'longitude': centerLng,
          'hourly': 'wind_speed_10m,wind_direction_10m',
          'forecast_hours': 13,
        },
      );

      final hourly = response.data?['hourly'] as Map<String, dynamic>?;
      if (hourly != null) {
        final speeds = hourly['wind_speed_10m'] as List<dynamic>? ?? [];
        final dirs = hourly['wind_direction_10m'] as List<dynamic>? ?? [];

        final index = forecastHourOffset.clamp(0, speeds.length - 1);
        final speedKmh = (speeds[index] as num?)?.toDouble() ?? 0.0;
        final speedKnots = speedKmh * 0.539957;
        final dir = (dirs[index] as num?)?.toDouble() ?? 0.0;

        // Honest sampled point for the query center coordinates
        points.add(
          WindPoint(
            position: LatLng(centerLat, centerLng),
            speedKnots: speedKnots,
            directionDegrees: dir,
          ),
        );
      }

      return WindField(
        validTime: DateTime.now().add(Duration(hours: forecastHourOffset)),
        southWest: southWest,
        northEast: northEast,
        points: points,
      );
    } catch (e, s) {
      Log.w('OpenMeteoWindDataSource: Failed to fetch wind grid', e, s);
      return WindField(
        validTime: DateTime.now().add(Duration(hours: forecastHourOffset)),
        southWest: southWest,
        northEast: northEast,
        points: const [],
      );
    }
  }

  /// Fetches a spatial grid of wave height forecast points ($H_s$).
  Future<WaveField> fetchWaveGrid({
    required LatLng southWest,
    required LatLng northEast,
    int forecastHourOffset = 0,
  }) async {
    try {
      final centerLat = (southWest.latitude + northEast.latitude) / 2.0;
      final centerLng = (southWest.longitude + northEast.longitude) / 2.0;

      final points = <WavePoint>[];
      final response = await _dio.get<Map<String, dynamic>>(
        'https://marine-api.open-meteo.com/v1/marine',
        queryParameters: {
          'latitude': centerLat,
          'longitude': centerLng,
          'hourly': 'wave_height',
          'forecast_hours': 13,
        },
      );

      final hourly = response.data?['hourly'] as Map<String, dynamic>?;
      if (hourly != null) {
        final waves = hourly['wave_height'] as List<dynamic>? ?? [];
        final index = forecastHourOffset.clamp(0, waves.length - 1);
        final height = (waves[index] as num?)?.toDouble() ?? 0.0;

        // Honest sampled point for the query center coordinates
        points.add(
          WavePoint(
            position: LatLng(centerLat, centerLng),
            waveHeightMeters: height,
          ),
        );
      }

      return WaveField(
        validTime: DateTime.now().add(Duration(hours: forecastHourOffset)),
        southWest: southWest,
        northEast: northEast,
        points: points,
      );
    } catch (e, s) {
      Log.w('OpenMeteoWindDataSource: Failed to fetch wave grid', e, s);
      return WaveField(
        validTime: DateTime.now().add(Duration(hours: forecastHourOffset)),
        southWest: southWest,
        northEast: northEast,
        points: const [],
      );
    }
  }
}
