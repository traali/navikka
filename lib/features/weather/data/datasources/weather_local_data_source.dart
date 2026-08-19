import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/weather/data/datasources/drift_weather_store.dart';
import 'package:sakkoja/features/weather/data/models/algae_report_dto.dart';
import 'package:sakkoja/features/weather/data/models/lightning_strike_dto.dart';
import 'package:sakkoja/features/weather/data/models/sea_level_dto.dart';
import 'package:sakkoja/features/weather/data/models/water_quality_dto.dart';
import 'package:sakkoja/features/weather/data/models/wave_observation_dto.dart';
import 'package:sakkoja/features/weather/data/models/weather_alert_dto.dart';
import 'package:sakkoja/features/weather/data/models/weather_forecast_dto.dart';
import 'package:sakkoja/features/weather/data/models/weather_observation_dto.dart';
import 'package:sakkoja/features/weather/domain/entities/algae_data.dart';
import 'package:sakkoja/features/weather/domain/entities/water_quality_data.dart';

part 'weather_local_data_source.g.dart';

abstract class WeatherLocalDataSource {
  Future<List<WeatherObservationDto>?> getLastObservations(
    double lat,
    double lon,
  );
  Future<void> cacheObservations(
    double lat,
    double lon,
    List<WeatherObservationDto> data,
  );

  Future<List<WeatherForecastDto>?> getLastForecast(double lat, double lon);
  Future<void> cacheForecast(
    double lat,
    double lon,
    List<WeatherForecastDto> data,
  );

  Future<List<WaveObservationDto>?> getLastWaves();
  Future<void> cacheWaves(List<WaveObservationDto> data);

  Future<List<SeaLevelDto>?> getLastSeaLevels();
  Future<void> cacheSeaLevels(List<SeaLevelDto> data);

  Future<List<WeatherAlertDto>?> getLastAlerts();
  Future<void> cacheAlerts(List<WeatherAlertDto> data);

  Future<List<LightningStrikeDto>?> getLastLightning();
  Future<void> cacheLightning(List<LightningStrikeDto> data);

  Future<List<WaterQualityData>?> getLastWaterQuality();
  Future<List<WaterQualityData>> cacheWaterQuality(List<WaterQualityDto> data);

  Future<List<AlgaeData>?> getLastAlgaeReports();
  Future<List<AlgaeData>> cacheAlgaeReports(List<AlgaeReportDto> data);

  // Reactive Streams
  Stream<List<WeatherObservationDto>> watchObservations(double lat, double lon);
  Stream<List<WeatherForecastDto>> watchForecast(double lat, double lon);
  Stream<List<WaveObservationDto>> watchWaves();
  Stream<List<WaveObservationDto>> watchWavesNearest(double lat, double lon);
  Stream<List<SeaLevelDto>> watchSeaLevels();
  Stream<List<SeaLevelDto>> watchSeaLevelsNearest(double lat, double lon);
  Stream<List<WeatherAlertDto>> watchAlerts();
  Stream<List<LightningStrikeDto>> watchLightning({Duration? window});

  // SYKE Water Quality & Algae
  Stream<List<WaterQualityData>> watchWaterQuality();
  Stream<List<WaterQualityData>> watchWaterQualityNearest(
    double lat,
    double lon,
  );
  Stream<List<AlgaeData>> watchAlgaeReports();
  Stream<List<AlgaeData>> watchAlgaeReportsNearest(double lat, double lon);

  /// Force clear all cached weather data.
  Future<void> clearCache();
}

@Riverpod(keepAlive: true)
WeatherLocalDataSource weatherLocalDataSource(Ref ref) {
  final store = ref.watch(driftWeatherStoreProvider);
  return WeatherLocalDataSourceImpl(store);
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  WeatherLocalDataSourceImpl(this._driftStore);
  final DriftWeatherStore _driftStore;

  @override
  Future<void> cacheObservations(
    double lat,
    double lon,
    List<WeatherObservationDto> data,
  ) async {
    Log.d('WeatherLocalDS: Caching ${data.length} obs for $lat,$lon');
    await _driftStore.cacheObservations(lat, lon, data);
  }

  @override
  Future<List<WeatherObservationDto>?> getLastObservations(
    double lat,
    double lon,
  ) async {
    final list = await _driftStore.getLastObservations(lat, lon);
    if (list != null && list.isNotEmpty) {
      Log.d(
        'WeatherLocalDS: Cache HIT for obs $lat,$lon (${list.length} items)',
      );
      return list;
    } else {
      Log.d('WeatherLocalDS: Cache MISS for obs $lat,$lon');
      return null;
    }
  }

  @override
  Future<void> cacheForecast(
    double lat,
    double lon,
    List<WeatherForecastDto> data,
  ) async {
    Log.d(
      'WeatherLocalDS: Caching ${data.length} forecast points for $lat,$lon',
    );
    await _driftStore.cacheForecast(lat, lon, data);
  }

  @override
  Future<List<WeatherForecastDto>?> getLastForecast(
    double lat,
    double lon,
  ) async {
    final list = await _driftStore.getLastForecast(lat, lon);
    if (list != null && list.isNotEmpty) {
      Log.d(
        'WeatherLocalDS: Cache HIT for forecast $lat,$lon (${list.length} items)',
      );
      return list;
    } else {
      Log.d('WeatherLocalDS: Cache MISS for forecast $lat,$lon');
      return null;
    }
  }

  @override
  Future<void> cacheWaves(List<WaveObservationDto> data) async {
    Log.d('WeatherLocalDS: Caching ${data.length} wave obs');
    await _driftStore.cacheWaves(data);
  }

  @override
  Future<List<WaveObservationDto>?> getLastWaves() async {
    final list = await _driftStore.getLastWaves();
    if (list != null && list.isNotEmpty) {
      Log.d('WeatherLocalDS: Cache HIT for waves (${list.length} items)');
      return list;
    } else {
      Log.d('WeatherLocalDS: Cache MISS for waves');
      return null;
    }
  }

  @override
  Future<void> cacheSeaLevels(List<SeaLevelDto> data) async {
    Log.d('WeatherLocalDS: Caching ${data.length} sea level points');
    await _driftStore.cacheSeaLevels(data);
  }

  @override
  Future<List<SeaLevelDto>?> getLastSeaLevels() async {
    final list = await _driftStore.getLastSeaLevels();
    if (list != null && list.isNotEmpty) {
      Log.d('WeatherLocalDS: Cache HIT for sea levels (${list.length} items)');
      return list;
    } else {
      Log.d('WeatherLocalDS: Cache MISS for sea levels');
      return null;
    }
  }

  @override
  Future<void> cacheAlerts(List<WeatherAlertDto> data) async {
    Log.d('WeatherLocalDS: Caching ${data.length} alerts');
    await _driftStore.cacheAlerts(data);
  }

  @override
  Future<List<WeatherAlertDto>?> getLastAlerts() async {
    final list = await _driftStore.getLastAlerts();
    if (list != null && list.isNotEmpty) {
      Log.d('WeatherLocalDS: Cache HIT for alerts (${list.length} items)');
      return list;
    } else {
      Log.d('WeatherLocalDS: Cache MISS for alerts');
      return null;
    }
  }

  @override
  Future<void> cacheLightning(List<LightningStrikeDto> data) async {
    Log.d('WeatherLocalDS: Caching ${data.length} lightning strikes');
    await _driftStore.cacheLightning(data);
  }

  @override
  Future<List<LightningStrikeDto>?> getLastLightning() async {
    final list = await _driftStore.getLastLightning();
    if (list != null && list.isNotEmpty) {
      Log.d('WeatherLocalDS: Cache HIT for lightning (${list.length} items)');
      return list;
    } else {
      Log.d('WeatherLocalDS: Cache MISS for lightning');
      return null;
    }
  }

  @override
  Future<List<WaterQualityData>> cacheWaterQuality(
    List<WaterQualityDto> data,
  ) async {
    Log.d('WeatherLocalDS: Caching ${data.length} water quality readings');
    return _driftStore.cacheWaterQuality(data);
  }

  @override
  Future<List<WaterQualityData>?> getLastWaterQuality() async {
    final list = await _driftStore.getLastWaterQuality();
    if (list.isNotEmpty) {
      Log.d(
        'WeatherLocalDS: Cache HIT for water quality (${list.length} items)',
      );
      return list;
    } else {
      Log.d('WeatherLocalDS: Cache MISS for water quality');
      return null;
    }
  }

  @override
  Future<List<AlgaeData>> cacheAlgaeReports(List<AlgaeReportDto> data) async {
    Log.d('WeatherLocalDS: Caching ${data.length} algae reports');
    return _driftStore.cacheAlgaeReports(data);
  }

  @override
  Future<List<AlgaeData>?> getLastAlgaeReports() async {
    final list = await _driftStore.getLastAlgaeReports();
    if (list.isNotEmpty) {
      Log.d(
        'WeatherLocalDS: Cache HIT for algae reports (${list.length} items)',
      );
      return list;
    } else {
      Log.d('WeatherLocalDS: Cache MISS for algae reports');
      return null;
    }
  }

  @override
  Stream<List<WeatherObservationDto>> watchObservations(
    double lat,
    double lon,
  ) {
    return _driftStore.watchObservations(lat, lon);
  }

  @override
  Stream<List<WeatherForecastDto>> watchForecast(double lat, double lon) {
    return _driftStore.watchForecast(lat, lon);
  }

  @override
  Stream<List<WaveObservationDto>> watchWaves() {
    return _driftStore.watchWaves();
  }

  @override
  Stream<List<WaveObservationDto>> watchWavesNearest(double lat, double lon) {
    return _driftStore.watchWavesNearest(lat, lon);
  }

  @override
  Stream<List<SeaLevelDto>> watchSeaLevels() {
    return _driftStore.watchSeaLevels();
  }

  @override
  Stream<List<SeaLevelDto>> watchSeaLevelsNearest(double lat, double lon) {
    return _driftStore.watchSeaLevelsNearest(lat, lon);
  }

  @override
  Stream<List<WeatherAlertDto>> watchAlerts() {
    return _driftStore.watchAlerts();
  }

  @override
  Stream<List<LightningStrikeDto>> watchLightning({Duration? window}) {
    return _driftStore.watchLightning(window: window);
  }

  @override
  Stream<List<WaterQualityData>> watchWaterQuality() {
    return _driftStore.watchWaterQuality();
  }

  @override
  Stream<List<WaterQualityData>> watchWaterQualityNearest(
    double lat,
    double lon,
  ) {
    return _driftStore.watchWaterQualityNearest(lat, lon);
  }

  @override
  Stream<List<AlgaeData>> watchAlgaeReports() {
    return _driftStore.watchAlgaeReports();
  }

  @override
  Stream<List<AlgaeData>> watchAlgaeReportsNearest(double lat, double lon) {
    return _driftStore.watchAlgaeReportsNearest(lat, lon);
  }

  @override
  Future<void> clearCache() async {
    await _driftStore.nuke();
  }
}
