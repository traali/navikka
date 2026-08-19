import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/constants/geometry_constants.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/features/weather/data/datasources/drift_weather_store.dart';
import 'package:sakkoja/features/weather/data/datasources/fmi_weather_data_source.dart';
import 'package:sakkoja/features/weather/data/datasources/met_norway_data_source.dart';
import 'package:sakkoja/features/weather/data/datasources/met_norway_ocean_source.dart';
import 'package:sakkoja/features/weather/data/datasources/openweather_data_source.dart';
import 'package:sakkoja/features/weather/data/datasources/syke_data_source.dart';
import 'package:sakkoja/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:sakkoja/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:sakkoja/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:sakkoja/features/weather/domain/entities/algae_data.dart';
import 'package:sakkoja/features/weather/domain/entities/lightning_strike.dart';
import 'package:sakkoja/features/weather/domain/entities/sea_level.dart';
import 'package:sakkoja/features/weather/domain/entities/water_quality_data.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_alert.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_forecast.dart';
import 'package:sakkoja/features/weather/domain/repositories/weather_repository.dart';

part 'weather_providers.g.dart';

/// Snap coordinates to Tier-1 grid to deduplicate nearby SYKE queries.
///
/// This reduces provider family key churn from small camera movements and
/// improves cache hit-rate in nearest-stream lookups.
({double lat, double lon}) _snapToTier1(double lat, double lon) {
  const m = GeometryConstants.multiplierTier1;
  return (
    lat: (lat * m).round() / m,
    lon: (lon * m).round() / m,
  );
}

// --- Data Sources (Remote) ---

@Riverpod(keepAlive: true)
FmiWeatherDataSource fmiWeatherDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return FmiWeatherDataSourceImpl(dio);
}

@Riverpod(keepAlive: true)
OpenWeatherDataSource openWeatherDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return OpenWeatherDataSourceImpl(dio);
}

@Riverpod(keepAlive: true)
MetNorwayDataSource metNorwayDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return MetNorwayDataSourceImpl(dio);
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

// --- Data Sources (Local) ---

@Riverpod(keepAlive: true)
DriftWeatherStore driftWeatherStore(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftWeatherStore(db);
}

@Riverpod(keepAlive: true)
WeatherLocalDataSource weatherLocalDataSource(Ref ref) {
  return WeatherLocalDataSourceImpl(ref.watch(driftWeatherStoreProvider));
}

// --- Repository ---

@Riverpod(keepAlive: true)
WeatherRepository weatherRepository(Ref ref) {
  return WeatherRepositoryImpl(
    ref.watch(weatherRemoteDataSourceProvider),
    ref.watch(weatherLocalDataSourceProvider),
  );
}

// --- Data Streams (Domain) ---

@riverpod
Stream<List<WeatherData>> weatherObservationsStream(Ref ref, LatLng center) {
  final snapped = _snapToTier1(center.latitude, center.longitude);
  return ref
      .watch(weatherRepositoryProvider)
      .watchWeatherObservations(snapped.lat, snapped.lon);
}

@riverpod
Stream<List<WeatherForecast>> weatherForecastStream(Ref ref, LatLng center) {
  final snapped = _snapToTier1(center.latitude, center.longitude);
  return ref
      .watch(weatherRepositoryProvider)
      .watchWeatherForecast(snapped.lat, snapped.lon);
}

@riverpod
Stream<List<WaveData>> waveObservationsStream(Ref ref, LatLng center) {
  final snapped = _snapToTier1(center.latitude, center.longitude);
  return ref
      .watch(weatherRepositoryProvider)
      .watchWaveObservationsNearest(snapped.lat, snapped.lon);
}

@riverpod
Stream<List<WaveData>> allWaveObservationsStream(Ref ref) {
  return ref.watch(weatherRepositoryProvider).watchWaveObservations();
}

@riverpod
Stream<List<SeaLevel>> seaLevelStream(Ref ref, LatLng center) {
  final snapped = _snapToTier1(center.latitude, center.longitude);
  return ref
      .watch(weatherRepositoryProvider)
      .watchSeaLevelNearest(snapped.lat, snapped.lon);
}

@riverpod
Stream<List<WeatherAlert>> activeAlertsStream(Ref ref) {
  return ref.watch(weatherRepositoryProvider).watchActiveAlerts();
}

@riverpod
Stream<List<LightningStrike>> recentLightningStream(Ref ref) {
  return ref.watch(weatherRepositoryProvider).watchRecentLightning();
}

/// Lightning used for proximity alarms. Historical map/display data remains
/// available through [recentLightningStreamProvider] for its longer retention.
final StreamProvider<List<LightningStrike>> safetyLightningStreamProvider =
    StreamProvider.autoDispose<List<LightningStrike>>((ref) {
      return ref.watch(weatherRepositoryProvider).watchSafetyLightning();
    });

@riverpod
Stream<List<WaterQualityData>> waterQualityStream(
  Ref ref, {
  double? lat,
  double? lon,
}) {
  final repo = ref.watch(weatherRepositoryProvider);
  if (lat != null && lon != null) {
    final snapped = _snapToTier1(lat, lon);
    return repo.watchWaterQualityNearest(snapped.lat, snapped.lon);
  }
  return repo.watchWaterQuality();
}

@riverpod
Stream<List<AlgaeData>> algaeReportsStream(
  Ref ref, {
  double? lat,
  double? lon,
}) {
  final repo = ref.watch(weatherRepositoryProvider);
  if (lat != null && lon != null) {
    final snapped = _snapToTier1(lat, lon);
    return repo.watchAlgaeReportsNearest(snapped.lat, snapped.lon);
  }
  return repo.watchAlgaeReports();
}
