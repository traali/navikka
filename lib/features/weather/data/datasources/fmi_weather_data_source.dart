import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/constants/fmi_constants.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/core/utils/xml_stream_parser.dart';
import 'package:sakkoja/features/weather/data/models/lightning_strike_dto.dart';
import 'package:sakkoja/features/weather/data/models/sea_level_dto.dart';
import 'package:sakkoja/features/weather/data/models/wave_observation_dto.dart';
import 'package:sakkoja/features/weather/data/models/weather_alert_dto.dart';
import 'package:sakkoja/features/weather/data/models/weather_forecast_dto.dart';
import 'package:sakkoja/features/weather/data/models/weather_observation_dto.dart';
import 'package:xml/xml.dart';

part 'fmi_weather_data_source.g.dart';

abstract class FmiWeatherDataSource {
  Future<List<WeatherAlertDto>> fetchActiveAlerts({String? requestId});
  Future<List<LightningStrikeDto>> fetchRecentLightning(
    DateTime startTime, {
    String? requestId,
  });
  Future<List<WeatherObservationDto>> fetchWeatherObservations(
    double lat,
    double lon, {
    String? requestId,
  });
  Future<List<WaveObservationDto>> fetchWaveObservations({String? requestId});
  Future<List<SeaLevelDto>> fetchSeaLevel({String? requestId});
  Future<List<WeatherForecastDto>> fetchWeatherForecast(
    double lat,
    double lon, {
    String? requestId,
  });
}

@Riverpod(keepAlive: true)
FmiWeatherDataSource fmiWeatherDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return FmiWeatherDataSourceImpl(dio);
}

class FmiWeatherDataSourceImpl implements FmiWeatherDataSource {
  FmiWeatherDataSourceImpl(this._dio);
  final Dio _dio;
  final Map<String, Future<dynamic>> _inFlightRequests = {};

  Future<T> _deduplicate<T>(String key, Future<T> Function() fetcher) async {
    if (_inFlightRequests.containsKey(key)) {
      Log.d('[FMI] Returning in-flight request for key: $key');
      return _inFlightRequests[key]! as Future<T>;
    }

    final future = fetcher();
    _inFlightRequests[key] = future;

    try {
      return await future;
    } finally {
      _inFlightRequests.remove(key);
    }
  }

  @override
  Future<List<WeatherAlertDto>> fetchActiveAlerts({String? requestId}) async {
    return _deduplicate('alerts', () async {
      final sw = Stopwatch()..start();
      try {
        final response = await _dio.get<dynamic>(FmiConstants.capAlertsUrl);
        final xmlString = response.data.toString();
        // On Web, compute() can be flaky with workers in this code path,
        // so parsing is kept synchronous for compatibility.
        final dtos = kIsWeb
            ? _parseAlertsInIsolate(xmlString)
            : await compute(_parseAlertsInIsolate, xmlString);
        Log.i(
          '[FMI] Fetched ${dtos.length} alerts in '
          '${sw.elapsedMilliseconds}ms',
        );
        return dtos;
      } catch (e, s) {
        Log.e('[FMI] Alerts fetch failed', e, s);
        rethrow;
      }
    });
  }

  @override
  Future<List<LightningStrikeDto>> fetchRecentLightning(
    DateTime startTime, {
    String? requestId,
  }) async {
    final startTimeStr = _formatDateTime(startTime);
    return _deduplicate('lightning_$startTimeStr', () async {
      final sw = Stopwatch()..start();
      try {
        final response = await _dio.get<dynamic>(
          FmiConstants.wfsBaseUrl,
          queryParameters: {
            'service': 'WFS',
            'version': '2.0.0',
            'request': 'GetFeature',
            'storedquery_id': FmiConstants.queryLightning,
            'parameters': FmiConstants.lightningParams,
            'starttime': startTimeStr,
          },
        );
        final xmlString = response.data.toString();
        final dtos = XmlStreamParser.parseLightning(xmlString);
        Log.i(
          '[FMI] Fetched ${dtos.length} lightning strikes in '
          '${sw.elapsedMilliseconds}ms',
        );
        return dtos;
      } catch (e, s) {
        Log.e('[FMI] Lightning fetch failed', e, s);
        rethrow;
      }
    });
  }

  @override
  Future<List<WeatherObservationDto>> fetchWeatherObservations(
    double lat,
    double lon, {
    String? requestId,
  }) async {
    final latlon = '${lat.toStringAsFixed(4)},${lon.toStringAsFixed(4)}';
    return _deduplicate('obs_$latlon', () async {
      final sw = Stopwatch()..start();
      final startTime = DateTime.now().subtract(const Duration(hours: 1));
      final startTimeStr = _formatDateTime(startTime);
      try {
        final response = await _dio.get<dynamic>(
          FmiConstants.wfsBaseUrl,
          queryParameters: {
            'service': 'WFS',
            'version': '2.0.0',
            'request': 'GetFeature',
            'storedquery_id': FmiConstants.queryWeatherObservations,
            'parameters': FmiConstants.observationParams,
            'latlon': latlon,
            'maxlocations': '1',
            'starttime': startTimeStr,
          },
        );
        final xmlString = response.data.toString();

        // Offload to isolate (Safety V-002: 120 FPS requirement)
        // On Web, compute() can be flaky with workers, so we run directly.
        final rawDtos = kIsWeb
            ? XmlStreamParser.parseObservations(xmlString)
            : await compute(XmlStreamParser.parseObservations, xmlString);

        // Inject Provider ID (FMI = 10)
        final dtos = rawDtos.map((e) => e.copyWith(providerId: 10)).toList();

        Log.i(
          '[FMI] Fetched ${dtos.length} observations in '
          '${sw.elapsedMilliseconds}ms',
        );
        return dtos;
      } catch (e, s) {
        Log.e('[FMI] Observations fetch failed', e, s);
        rethrow;
      }
    });
  }

  @override
  Future<List<WaveObservationDto>> fetchWaveObservations({
    String? requestId,
  }) async {
    return _deduplicate('waves', () async {
      final sw = Stopwatch()..start();
      final startTime = DateTime.now().subtract(const Duration(hours: 1));
      final startTimeStr = _formatDateTime(startTime);
      try {
        final response = await _dio.get<dynamic>(
          FmiConstants.wfsBaseUrl,
          queryParameters: {
            'service': 'WFS',
            'version': '2.0.0',
            'request': 'GetFeature',
            'storedquery_id': FmiConstants.queryWaveObservations,
            'parameters': FmiConstants.waveParams,
            'bbox': FmiConstants.finlandBBox,
            'starttime': startTimeStr,
          },
        );
        final xmlString = response.data.toString();
        final dtos = kIsWeb
            ? _parseWavesInIsolate(xmlString)
            : await compute(_parseWavesInIsolate, xmlString);
        Log.i(
          '[FMI] Fetched ${dtos.length} wave records in '
          '${sw.elapsedMilliseconds}ms',
        );
        return dtos;
      } catch (e, s) {
        Log.e('[FMI] Waves fetch failed', e, s);
        rethrow;
      }
    });
  }

  @override
  Future<List<SeaLevelDto>> fetchSeaLevel({String? requestId}) async {
    return _deduplicate('sealevel', () async {
      final sw = Stopwatch()..start();
      final startTime = DateTime.now().subtract(const Duration(hours: 1));
      final startTimeStr = _formatDateTime(startTime);
      try {
        final response = await _dio.get<dynamic>(
          FmiConstants.wfsBaseUrl,
          queryParameters: {
            'service': 'WFS',
            'version': '2.0.0',
            'request': 'GetFeature',
            'storedquery_id': FmiConstants.queryMareograph,
            'parameters': FmiConstants.mareographParams,
            'starttime': startTimeStr,
          },
        );
        final xmlString = response.data.toString();
        final dtos = kIsWeb
            ? _parseSeaLevelsInIsolate(xmlString)
            : await compute(_parseSeaLevelsInIsolate, xmlString);
        Log.i(
          '[FMI] Fetched ${dtos.length} sea level records in '
          '${sw.elapsedMilliseconds}ms',
        );
        return dtos;
      } catch (e, s) {
        Log.e('[FMI] Sea level fetch failed', e, s);
        rethrow;
      }
    });
  }

  @override
  Future<List<WeatherForecastDto>> fetchWeatherForecast(
    double lat,
    double lon, {
    String? requestId,
  }) async {
    final latlon = '${lat.toStringAsFixed(4)},${lon.toStringAsFixed(4)}';
    return _deduplicate('forecast_$latlon', () async {
      final sw = Stopwatch()..start();
      try {
        final response = await _dio.get<dynamic>(
          FmiConstants.wfsBaseUrl,
          queryParameters: {
            'service': 'WFS',
            'version': '2.0.0',
            'request': 'GetFeature',
            'storedquery_id': FmiConstants.queryForecast,
            'parameters': FmiConstants.forecastParams,
            'latlon': latlon,
            'maxlocations': '1',
          },
        );
        final xmlString = response.data.toString();
        // Offload to isolate
        final rawDtos = kIsWeb
            ? XmlStreamParser.parseForecast(xmlString)
            : await compute(XmlStreamParser.parseForecast, xmlString);

        // Inject Provider ID (FMI = 10)
        final dtos = rawDtos.map((e) => e.copyWith(providerId: 10)).toList();

        Log.i(
          '[FMI] Fetched ${dtos.length} forecast points in '
          '${sw.elapsedMilliseconds}ms',
        );
        return dtos;
      } catch (e, s) {
        Log.e('[FMI] Forecast fetch failed', e, s);
        rethrow;
      }
    });
  }

  String _formatDateTime(DateTime dt) {
    final iso = dt.toUtc().toIso8601String();
    final noZ = iso.replaceAll('Z', '');
    final noMillis = noZ.split('.').first;
    return '${noMillis}Z';
  }

  static List<WeatherAlertDto> _parseAlertsInIsolate(String xmlString) {
    final document = XmlDocument.parse(xmlString);
    final alertElements = document.descendants
        .whereType<XmlElement>()
        .where((e) => e.name.local == 'alert')
        .toList();
    return alertElements.map(WeatherAlertDto.fromXml).toList();
  }

  static List<WaveObservationDto> _parseWavesInIsolate(String xmlString) {
    final document = XmlDocument.parse(xmlString);
    return WaveObservationDto.fromTimeValuePair(document.rootElement);
  }

  static List<SeaLevelDto> _parseSeaLevelsInIsolate(String xmlString) {
    final document = XmlDocument.parse(xmlString);
    return SeaLevelDto.fromTimeValuePair(document.rootElement);
  }
}
