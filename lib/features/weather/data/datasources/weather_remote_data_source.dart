import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/weather/data/datasources/fmi_weather_data_source.dart';
import 'package:sakkoja/features/weather/data/datasources/met_norway_data_source.dart';
import 'package:sakkoja/features/weather/data/datasources/met_norway_ocean_source.dart';
import 'package:sakkoja/features/weather/data/datasources/openweather_data_source.dart';
import 'package:sakkoja/features/weather/data/datasources/syke_data_source.dart';
import 'package:sakkoja/features/weather/data/models/algae_report_dto.dart';
import 'package:sakkoja/features/weather/data/models/lightning_strike_dto.dart';
import 'package:sakkoja/features/weather/data/models/sea_level_dto.dart';
import 'package:sakkoja/features/weather/data/models/water_quality_dto.dart';
import 'package:sakkoja/features/weather/data/models/wave_observation_dto.dart';
import 'package:sakkoja/features/weather/data/models/weather_alert_dto.dart';
import 'package:sakkoja/features/weather/data/models/weather_forecast_dto.dart';
import 'package:sakkoja/features/weather/data/models/weather_observation_dto.dart';

part 'weather_remote_data_source.g.dart';

/// Result from a single provider fetch, including error information.
///
/// FIX #531: Previously _safeFetchList swallowed errors and returned empty
/// lists, making it impossible for callers to distinguish "no data" from
/// "fetch failed". This wrapper surfaces errors while preserving the
/// partial-results pattern (other providers still contribute data).
class ProviderResult<T> {
  const ProviderResult({
    required this.data,
    required this.provider,
    this.error,
  });
  final List<T> data;
  final Object? error;
  final String provider;

  bool get hasError => error != null;
}

/// Thrown when every provider attempted for a weather resource failed.
///
/// An empty successful response remains valid; this exception specifically
/// distinguishes it from a request where no provider could be reached.
class AllWeatherProvidersFailedException implements Exception {
  const AllWeatherProvidersFailedException({
    required this.resource,
    required this.providers,
  });

  final String resource;
  final List<String> providers;

  @override
  String toString() =>
      'All providers failed for $resource: ${providers.join(', ')}';
}

abstract class WeatherRemoteDataSource {
  Future<List<WeatherAlertDto>> fetchActiveAlerts({String? requestId});
  Future<List<LightningStrikeDto>> fetchRecentLightning(
    DateTime startTime, {
    String? requestId,
  });
  Future<List<WeatherObservationDto>> fetchWeatherObservations(
    double lat,
    double lon, {
    String? requestId,
    String? providerOverride,
  });
  Future<List<WaveObservationDto>> fetchWaveObservations({
    String? requestId,
    double? lat,
    double? lon,
  });
  Future<List<SeaLevelDto>> fetchSeaLevel({String? requestId});
  Future<List<WeatherForecastDto>> fetchWeatherForecast(
    double lat,
    double lon, {
    String? requestId,
    String? providerOverride,
  });

  // SYKE Water Quality
  Future<List<WaterQualityDto>> fetchWaterQuality({
    double? lat,
    double? lon,
    int? limit,
  });

  // SYKE Algae Reports
  Future<List<AlgaeReportDto>> fetchAlgaeReports({
    double? lat,
    double? lon,
    DateTime? since,
  });
}

@Riverpod(keepAlive: true)
WeatherRemoteDataSource weatherRemoteDataSource(Ref ref) {
  return WeatherRemoteDataSourceImpl(
    ref.watch(fmiWeatherDataSourceProvider),
    ref.watch(openWeatherDataSourceProvider),
    ref.watch(metNorwayDataSourceProvider),
    ref.watch(metNorwayOceanSourceProvider),
    ref.watch(sykeDataSourceProvider),
  );
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  WeatherRemoteDataSourceImpl(
    this._fmiSource,
    this._openWeatherSource,
    this._metNorwaySource,
    this._metOceanSource,
    this._sykeSource,
  );
  final FmiWeatherDataSource _fmiSource;
  final OpenWeatherDataSource _openWeatherSource;
  final MetNorwayDataSource _metNorwaySource;
  final MetNorwayOceanSource _metOceanSource;
  final SykeDataSource _sykeSource;

  List<T> _combineProviderResults<T>(
    String resource,
    List<ProviderResult<T>> providerResults,
  ) {
    final results = <T>[];
    final failures = <String>[];

    for (final result in providerResults) {
      results.addAll(result.data);
      if (result.hasError) failures.add(result.provider);
    }

    if (failures.isNotEmpty) {
      Log.w(
        '[Parallel] ${failures.length} provider(s) failed: ${failures.join(', ')}',
      );
    }

    if (failures.length == providerResults.length) {
      throw AllWeatherProvidersFailedException(
        resource: resource,
        providers: failures,
      );
    }

    return results;
  }

  @override
  Future<List<WeatherObservationDto>> fetchWeatherObservations(
    double lat,
    double lon, {
    String? requestId,
    String? providerOverride,
  }) async {
    final sw = Stopwatch()..start();

    final futures = [
      _safeFetchList(
        () =>
            _fmiSource.fetchWeatherObservations(lat, lon, requestId: requestId),
        'FMI',
      ),
      _safeFetchSingleNullable(
        () => _openWeatherSource.fetchCurrentWeather(lat, lon),
        'OpenWeather',
      ),
      _safeFetchList(() async {
        final forecasts = await _metNorwaySource.fetchLocationForecast(
          lat,
          lon,
        );
        return forecasts
            .take(1)
            .map(
              (f) => WeatherObservationDto(
                timestamp: f.timestamp,
                location: f.location,
                temperature: f.temperature,
                feelsLike: f.feelsLike,
                windSpeed: f.windSpeed,
                windGust: f.windGust,
                windDirection: f.windDirection,
                pressure: f.pressure,
                humidity: f.humidity,
                dewPoint: f.dewPoint,
                cloudCover: f.cloudCover,
                uvIndex: f.uvIndex,
                weatherIcon: f.weatherIcon,
                weatherDescription: f.weatherDescription,
                precipitation: f.precipitation,
                providerId: 5,
              ),
            )
            .toList();
      }, 'MET Norway'),
    ];

    final fetchedResults = await Future.wait(futures);
    final results = _combineProviderResults(
      'weather observations',
      fetchedResults,
    );
    Log.i(
      '[Parallel] Fetched ${results.length} combined observations in ${sw.elapsedMilliseconds}ms',
    );
    return results;
  }

  @override
  Future<List<WeatherForecastDto>> fetchWeatherForecast(
    double lat,
    double lon, {
    String? requestId,
    String? providerOverride,
  }) async {
    final sw = Stopwatch()..start();

    final futures = [
      _safeFetchList(
        () => _fmiSource.fetchWeatherForecast(lat, lon, requestId: requestId),
        'FMI',
      ),
      _safeFetchList(
        () => _openWeatherSource.fetchThreeHourForecast(lat, lon),
        'OpenWeather',
      ),
      _safeFetchList(
        () => _metNorwaySource.fetchLocationForecast(lat, lon),
        'MET Norway',
      ),
    ];

    final fetchedResults = await Future.wait(futures);
    final results = _combineProviderResults('weather forecast', fetchedResults);
    Log.i(
      '[Parallel] Fetched ${results.length} combined forecasts in ${sw.elapsedMilliseconds}ms',
    );
    return results;
  }

  Future<ProviderResult<T>> _safeFetchList<T>(
    Future<List<T>> Function() fetcher,
    String provider,
  ) async {
    try {
      return ProviderResult(
        data: await fetcher(),
        provider: provider,
      );
    } catch (e, s) {
      Log.e('[$provider] Data fetch failed: $e', e, s);
      return ProviderResult(data: [], error: e, provider: provider);
    }
  }

  Future<ProviderResult<WeatherObservationDto>> _safeFetchSingleNullable(
    Future<WeatherObservationDto?> Function() fetcher,
    String provider,
  ) async {
    try {
      final item = await fetcher();
      return ProviderResult(
        data: item != null ? [item] : [],
        provider: provider,
      );
    } catch (e, s) {
      Log.e('[$provider] Data fetch failed: $e', e, s);
      return ProviderResult(data: [], error: e, provider: provider);
    }
  }

  @override
  Future<List<WeatherAlertDto>> fetchActiveAlerts({String? requestId}) {
    return _fmiSource.fetchActiveAlerts(requestId: requestId);
  }

  @override
  Future<List<LightningStrikeDto>> fetchRecentLightning(
    DateTime startTime, {
    String? requestId,
  }) {
    return _fmiSource.fetchRecentLightning(startTime, requestId: requestId);
  }

  @override
  Future<List<SeaLevelDto>> fetchSeaLevel({String? requestId}) {
    return _fmiSource.fetchSeaLevel(requestId: requestId);
  }

  @override
  Future<List<WaveObservationDto>> fetchWaveObservations({
    String? requestId,
    double? lat,
    double? lon,
  }) async {
    final sw = Stopwatch()..start();

    final futures = [
      _safeFetchList(
        () => _fmiSource.fetchWaveObservations(requestId: requestId),
        'FMI Waves',
      ),
    ];

    if (lat != null && lon != null) {
      futures.add(
        _safeFetchList(
          () => _metOceanSource.fetchOceanForecast(lat, lon),
          'MET Ocean',
        ),
      );
    }

    final fetchedResults = await Future.wait(futures);
    final results = _combineProviderResults(
      'wave observations',
      fetchedResults,
    );
    Log.i(
      '[Parallel] Fetched ${results.length} combined wave observations/forecasts in ${sw.elapsedMilliseconds}ms',
    );
    return results;
  }

  @override
  Future<List<WaterQualityDto>> fetchWaterQuality({
    double? lat,
    double? lon,
    int? limit,
  }) async {
    final sw = Stopwatch()..start();
    final results = await _sykeSource.fetchWaterQuality(
      lat: lat,
      lon: lon,
      limit: limit,
    );
    Log.i(
      '[SYKE] Fetched ${results.length} water quality samples in ${sw.elapsedMilliseconds}ms',
    );
    return results;
  }

  @override
  Future<List<AlgaeReportDto>> fetchAlgaeReports({
    double? lat,
    double? lon,
    DateTime? since,
  }) async {
    final sw = Stopwatch()..start();
    final results = await _sykeSource.fetchAlgaeReports(
      lat: lat,
      lon: lon,
      since: since,
    );
    Log.i(
      '[SYKE] Fetched ${results.length} algae reports in ${sw.elapsedMilliseconds}ms',
    );
    return results;
  }
}
