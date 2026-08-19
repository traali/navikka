import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/constants/weather_sync_constants.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:sakkoja/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:sakkoja/features/weather/data/models/algae_report_dto.dart';
import 'package:sakkoja/features/weather/data/models/lightning_strike_dto.dart';
import 'package:sakkoja/features/weather/data/models/sea_level_dto.dart';
import 'package:sakkoja/features/weather/data/models/water_quality_dto.dart';
import 'package:sakkoja/features/weather/data/models/wave_observation_dto.dart';
import 'package:sakkoja/features/weather/data/models/weather_alert_dto.dart';
import 'package:sakkoja/features/weather/data/models/weather_forecast_dto.dart';
import 'package:sakkoja/features/weather/data/models/weather_mappers.dart';
import 'package:sakkoja/features/weather/data/models/weather_observation_dto.dart';
import 'package:sakkoja/features/weather/domain/entities/algae_data.dart';
import 'package:sakkoja/features/weather/domain/entities/lightning_strike.dart';
import 'package:sakkoja/features/weather/domain/entities/sea_level.dart';
import 'package:sakkoja/features/weather/domain/entities/water_quality_data.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_alert.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_forecast.dart';
import 'package:sakkoja/features/weather/domain/repositories/weather_repository.dart';

part 'weather_repository_impl.g.dart';

/// Content-based cache that avoids re-creating entity lists when the
/// underlying DTO stream emits unchanged data.
///
/// Drift's reactive queries may re-emit the same DTO data on a table change
/// notification even when the queried rows are unchanged. This cache detects
/// that via [Object.hashAll] and returns the previous entity list, eliminating
/// redundant `dtos.map(toEntity).toList()` allocations on every stream tick.
class _EntityCache<T, R> {
  int? _lastHash;
  int? _lastLength;
  List<R>? _lastEntities;

  List<R> transform(List<T> dtos, R Function(T) toEntity) {
    final length = dtos.length;
    final hash = Object.hashAll(dtos);
    if (_lastLength == length && _lastHash == hash && _lastEntities != null) {
      return _lastEntities!;
    }
    _lastLength = length;
    _lastHash = hash;
    _lastEntities = dtos.map(toEntity).toList(growable: false);
    return _lastEntities!;
  }

  void clear() {
    _lastLength = null;
    _lastHash = null;
    _lastEntities = null;
  }
}

@Riverpod(keepAlive: true)
WeatherRepository weatherRepository(Ref ref) {
  return WeatherRepositoryImpl(
    ref.watch(weatherRemoteDataSourceProvider),
    ref.watch(weatherLocalDataSourceProvider),
  );
}

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl(this._remoteDataSource, this._localDataSource);
  final WeatherRemoteDataSource _remoteDataSource;
  final WeatherLocalDataSource _localDataSource;

  /// Lightweight tracker that prevents background syncs from firing more
  /// often than the source's TTL. This is a safety net — the primary sync
  /// orchestration lives in [PointWeatherSyncController] and its
  /// [SourceSyncTracker] instances. Repository-level background syncs only
  /// run when the widget reads stale cached data.
  final Map<String, DateTime> _lastBgSync = {};
  final Set<String> _bgSyncInFlight = {};

  /// Content-based caches for each DTO→entity stream mapping.
  /// Eliminates redundant `.map().toList()` allocations (~22 call sites)
  /// when Drift re-emits unchanged data.
  final _EntityCache<WeatherObservationDto, WeatherData> _obsCache =
      _EntityCache();
  final _EntityCache<WeatherForecastDto, WeatherForecast> _forecastCache =
      _EntityCache();
  final _EntityCache<SeaLevelDto, SeaLevel> _seaLevelCache = _EntityCache();
  final _EntityCache<SeaLevelDto, SeaLevel> _seaLevelNearestCache =
      _EntityCache();
  final _EntityCache<WeatherAlertDto, WeatherAlert> _alertCache =
      _EntityCache();
  final _EntityCache<LightningStrikeDto, LightningStrike> _lightningCache =
      _EntityCache();

  int? _lastWaveHash;
  List<WaveData>? _lastWaves;
  int? _lastWaveNearestHash;
  List<WaveData>? _lastWaveNearest;
  int? _lastWaterQualityHash;
  List<WaterQualityData>? _lastWaterQuality;
  int? _lastWaterQualityNearestHash;
  List<WaterQualityData>? _lastWaterQualityNearest;
  int? _lastAlgaeHash;
  List<AlgaeData>? _lastAlgae;
  int? _lastAlgaeNearestHash;
  List<AlgaeData>? _lastAlgaeNearest;

  /// Whether enough wall-clock time has passed to fire a background sync
  /// for the given source. Uses the source's [WeatherSyncConstants] TTL
  /// as the minimum gap.
  bool _canBgSync(String source, Duration ttl) {
    final last = _lastBgSync[source];
    if (last == null) return true;
    return DateTime.now().difference(last) >= ttl;
  }

  void _scheduleBgSync(
    String source,
    Duration ttl,
    Future<void> Function() sync,
  ) {
    if (!_canBgSync(source, ttl) || !_bgSyncInFlight.add(source)) return;

    Future<void> run() async {
      try {
        await sync();
        _lastBgSync[source] = DateTime.now();
      } catch (error, stackTrace) {
        Log.w(
          'WeatherRepo: Background $source sync failed',
          error,
          stackTrace,
        );
      } finally {
        _bgSyncInFlight.remove(source);
      }
    }

    unawaited(run());
  }

  // --- DTO-to-entity helpers (explicit types for extension method resolution) ---

  WeatherData _obsToEntity(WeatherObservationDto dto) => dto.toEntity();
  WeatherForecast _forecastToEntity(WeatherForecastDto dto) => dto.toEntity();
  SeaLevel _seaLevelToEntity(SeaLevelDto dto) => dto.toEntity();
  WeatherAlert _alertToEntity(WeatherAlertDto dto) => dto.toEntity();
  LightningStrike _lightningToEntity(LightningStrikeDto dto) => dto.toEntity();

  @override
  Future<Either<Failure, List<WeatherAlert>>> getActiveAlerts() async {
    // 1. Try Cache-First
    try {
      final localData = await _localDataSource.getLastAlerts();
      if (localData != null && localData.isNotEmpty) {
        Log.i(
          'WeatherRepo: Returning ${localData.length} cached alerts (Cache-First).',
        );
        _scheduleBgSync(
          'alerts',
          WeatherSyncConstants.alertsTtl,
          syncActiveAlerts,
        );
        return Right(localData.map((e) => e.toEntity()).toList());
      }
    } catch (e, s) {
      Log.w('WeatherRepo: Cache access failed, proceeding with remote', e, s);
    }

    try {
      final reqId = 'req_${DateTime.now().millisecondsSinceEpoch}';
      Log.d('WeatherRepo [Req: $reqId]: Fetching active alerts...');
      final alertsDto = await _remoteDataSource.fetchActiveAlerts(
        requestId: reqId,
      );

      await _localDataSource.cacheAlerts(alertsDto);

      final alerts = alertsDto.map((e) => e.toEntity()).toList();

      if (alerts.isNotEmpty) {
        final alertSummary = alerts
            .map((a) => '${a.event} (${a.severity})')
            .join(', ');
        Log.i(
          '[SUCCESS] Alerts: Found ${alerts.length} active warnings: $alertSummary',
        );
      }

      return Right(alerts);
    } catch (e, s) {
      Log.w('WeatherRepo: Alerts fetch failed. Checking cache... ($e)');

      final localData = await _localDataSource.getLastAlerts();
      if (localData != null && localData.isNotEmpty) {
        Log.i('WeatherRepo: Returning ${localData.length} cached alerts.');
        return Right(localData.map((e) => e.toEntity()).toList());
      }

      Log.e('WeatherRepo: No remote OR cached alerts available.', e, s);
      return Left(ServerFailure('Alerts unavailable: $e'));
    }
  }

  @override
  Future<Either<Failure, List<LightningStrike>>> getRecentLightning({
    DateTime? startTime,
    DateTime? endTime,
  }) async {
    // 1. Try Cache-First
    try {
      final localData = await _localDataSource.getLastLightning();
      if (localData != null && localData.isNotEmpty) {
        Log.i(
          'WeatherRepo: Returning ${localData.length} cached lightning strikes (Cache-First).',
        );
        _scheduleBgSync(
          'lightning',
          WeatherSyncConstants.lightningTtl,
          () => syncRecentLightning(startTime: startTime),
        );
        return Right(localData.map((e) => e.toEntity()).toList());
      }
    } catch (e, s) {
      Log.w('WeatherRepo: Cache access failed', e, s);
    }

    final sw = Stopwatch()..start();
    try {
      final reqId = 'req_${DateTime.now().millisecondsSinceEpoch}';
      Log.d('WeatherRepo [Req: $reqId]: Fetching lightning...');
      final effectiveStartTime =
          startTime ?? DateTime.now().subtract(const Duration(hours: 1));
      final strikesDto = await _remoteDataSource.fetchRecentLightning(
        effectiveStartTime,
        requestId: reqId,
      );
      Log.d('WeatherRepo: Lightning fetched (${sw.elapsedMilliseconds} ms).');

      await _localDataSource.cacheLightning(strikesDto);

      return Right(strikesDto.map((e) => e.toEntity()).toList());
    } catch (e, s) {
      Log.e('WeatherRepo: Lightning fetch failed', e, s);
      return Left(ServerFailure(e.toString()));
    }
  }

  List<WaveData> _processWaveDtosToEntities(List<WaveObservationDto> rawWaves) {
    final stationMap = <String, WaveData>{};

    for (final dto in rawWaves) {
      final wave = dto.toEntity();
      final key = wave.stationName ?? 'unknown';

      if (stationMap.containsKey(key)) {
        final existing = stationMap[key]!;
        stationMap[key] = WaveData(
          timestamp: wave.timestamp.isAfter(existing.timestamp)
              ? wave.timestamp
              : existing.timestamp,
          location: existing.location,
          stationName: existing.stationName,
          waveHeight: wave.waveHeight ?? existing.waveHeight,
          wavePeriod: wave.wavePeriod ?? existing.wavePeriod,
          waveDirection: wave.waveDirection ?? existing.waveDirection,
          waterTemperature: wave.waterTemperature ?? existing.waterTemperature,
        );
      } else {
        stationMap[key] = wave;
      }
    }

    return stationMap.values.toList();
  }

  @override
  Future<Either<Failure, List<WeatherData>>> getWeatherObservations({
    required double lat,
    required double lon,
  }) async {
    // 1. Try Cache-First
    try {
      final localData = await _localDataSource.getLastObservations(lat, lon);
      if (localData != null && localData.isNotEmpty) {
        Log.i(
          'WeatherRepo: Returning ${localData.length} cached observations (Cache-First).',
        );
        _scheduleBgSync(
          'observations',
          WeatherSyncConstants.observationsTtl,
          () => syncWeatherObservations(lat, lon),
        );
        return Right(localData.map((e) => e.toEntity()).toList());
      }
    } catch (e, s) {
      Log.w('WeatherRepo: Cache access failed', e, s);
    }

    try {
      final reqId = 'req_${DateTime.now().millisecondsSinceEpoch}';
      Log.d(
        'WeatherRepo [Req: $reqId]: Fetching observations for $lat, $lon...',
      );
      final observationsDto = await _remoteDataSource.fetchWeatherObservations(
        lat,
        lon,
        requestId: reqId,
      );

      await _localDataSource.cacheObservations(lat, lon, observationsDto);

      final observations = observationsDto.map((e) => e.toEntity()).toList();

      if (observations.isNotEmpty) {
        final latest = observations.last;
        Log.i(
          '[SUCCESS] Weather: ${latest.stationName ?? 'Unknown Station'} | ${latest.temperature?.toStringAsFixed(1) ?? '--'}°C | Wind ${latest.windSpeed?.toStringAsFixed(1) ?? '--'} m/s',
        );
      }

      return Right(observations);
    } catch (e, s) {
      Log.w('WeatherRepo: Observations fetch failed. Checking cache... ($e)');

      try {
        final localData = await _localDataSource.getLastObservations(lat, lon);
        if (localData != null && localData.isNotEmpty) {
          Log.i(
            'WeatherRepo: Returning ${localData.length} cached observations.',
          );
          return Right(localData.map((e) => e.toEntity()).toList());
        }
      } catch (localE, localS) {
        Log.e('WeatherRepo: Local cache access failed', localE, localS);
      }

      Log.e('WeatherRepo: No remote OR cached observations available.', e, s);
      return Left(ServerFailure('Observations unavailable: $e'));
    }
  }

  @override
  Future<Either<Failure, List<WaveData>>> getWaveObservations() async {
    // 1. Try Cache-First (same pattern as other data types)
    try {
      final localData = await _localDataSource.getLastWaves();
      if (localData != null && localData.isNotEmpty) {
        Log.i(
          'WeatherRepo: Returning ${localData.length} cached wave records (Cache-First).',
        );
        _scheduleBgSync(
          'waves',
          WeatherSyncConstants.wavesTtl,
          syncWaveObservations,
        );
        return Right(_processWaveDtosToEntities(localData));
      }
    } catch (e, s) {
      Log.w('WeatherRepo: Cache access failed', e, s);
    }

    try {
      final reqId = 'req_${DateTime.now().millisecondsSinceEpoch}';
      Log.d('WeatherRepo [Req: $reqId]: Fetching wave observations...');
      final wavesDto = await _remoteDataSource.fetchWaveObservations(
        requestId: reqId,
      );

      await _localDataSource.cacheWaves(wavesDto);

      final waves = _processWaveDtosToEntities(wavesDto);

      if (waves.isNotEmpty) {
        Log.i('[SUCCESS] Waves: Loaded ${waves.length} buoy stations.');
      }

      return Right(waves);
    } catch (e, s) {
      Log.w('WeatherRepo: Waves fetch failed. Checking cache... ($e)');

      final localData = await _localDataSource.getLastWaves();
      if (localData != null && localData.isNotEmpty) {
        final waves = _processWaveDtosToEntities(localData);
        Log.i('WeatherRepo: Returning ${waves.length} cached wave stations.');
        return Right(waves);
      }

      Log.e('WeatherRepo: No remote OR cached waves available.', e, s);
      return Left(ServerFailure('Waves unavailable: $e'));
    }
  }

  @override
  Future<Either<Failure, List<WeatherForecast>>> getWeatherForecast({
    required double lat,
    required double lon,
  }) async {
    // 1. Try Cache-First
    try {
      final localData = await _localDataSource.getLastForecast(lat, lon);
      if (localData != null && localData.isNotEmpty) {
        Log.i(
          'WeatherRepo: Returning ${localData.length} cached forecasts (Cache-First).',
        );
        _scheduleBgSync(
          'forecast',
          WeatherSyncConstants.forecastTtl,
          () => syncWeatherForecast(lat, lon),
        );
        return Right(localData.map((e) => e.toEntity()).toList());
      }
    } catch (e, s) {
      Log.w('WeatherRepo: Cache access failed', e, s);
    }

    try {
      final reqId = 'req_${DateTime.now().millisecondsSinceEpoch}';
      Log.d('WeatherRepo [Req: $reqId]: Fetching forecast...');
      final forecastDto = await _remoteDataSource.fetchWeatherForecast(
        lat,
        lon,
        requestId: reqId,
      );

      await _localDataSource.cacheForecast(lat, lon, forecastDto);

      final forecast = forecastDto.map((e) => e.toEntity()).toList();

      if (forecast.isNotEmpty) {
        final temps = forecast
            .take(6)
            .map((f) => f.temperature)
            .whereType<double>();
        if (temps.isNotEmpty) {
          final min = temps.reduce((a, b) => a < b ? a : b);
          final max = temps.reduce((a, b) => a > b ? a : b);
          Log.i(
            '[SUCCESS] Forecast: Next 6h temp range ${min.toStringAsFixed(1)}...${max.toStringAsFixed(1)}°C',
          );
        }
      }

      return Right(forecast);
    } catch (e, s) {
      Log.w('WeatherRepo: Forecast fetch failed. Checking cache... ($e)');

      final localData = await _localDataSource.getLastForecast(lat, lon);
      if (localData != null && localData.isNotEmpty) {
        Log.i('WeatherRepo: Returning ${localData.length} cached forecasts.');
        return Right(localData.map((e) => e.toEntity()).toList());
      }

      Log.e('WeatherRepo: No remote OR cached forecast available.', e, s);
      return Left(ServerFailure('Forecast unavailable: $e'));
    }
  }

  @override
  Future<Either<Failure, List<SeaLevel>>> getSeaLevel() async {
    // 1. Try Cache-First
    try {
      final localData = await _localDataSource.getLastSeaLevels();
      if (localData != null && localData.isNotEmpty) {
        Log.i(
          'WeatherRepo: Returning ${localData.length} cached sea level records (Cache-First).',
        );
        _scheduleBgSync(
          'seaLevel',
          WeatherSyncConstants.seaLevelTtl,
          syncSeaLevel,
        );
        return Right(localData.map((dto) => dto.toEntity()).toList());
      }
    } catch (e, s) {
      Log.w('WeatherRepo: Cache access failed', e, s);
    }

    try {
      final reqId = 'req_${DateTime.now().millisecondsSinceEpoch}';
      Log.d('WeatherRepo [Req: $reqId]: Fetching sea level...');
      final seaLevelsDto = await _remoteDataSource.fetchSeaLevel(
        requestId: reqId,
      );
      await _localDataSource.cacheSeaLevels(seaLevelsDto);

      final seaLevels = seaLevelsDto.map((dto) => dto.toEntity()).toList();

      if (seaLevels.isNotEmpty) {
        final latest = seaLevels.last;
        Log.i(
          '[SUCCESS] Sea Level: ${latest.stationName ?? 'Unknown'} | ${latest.seaLevel} mm (${latest.timestamp.hour}:${latest.timestamp.minute.toString().padLeft(2, '0')})',
        );
      }

      return Right(seaLevels);
    } catch (e, s) {
      Log.w('WeatherRepo: Sea level fetch failed. Checking cache... ($e)');

      final localData = await _localDataSource.getLastSeaLevels();
      if (localData != null && localData.isNotEmpty) {
        Log.i(
          'WeatherRepo: Returning ${localData.length} cached sea level records.',
        );
        return Right(localData.map((dto) => dto.toEntity()).toList());
      }

      Log.e('WeatherRepo: No remote OR cached sea level available.', e, s);
      return Left(ServerFailure('Sea level unavailable: $e'));
    }
  }

  @override
  Future<void> clearCache() async {
    await _localDataSource.clearCache();
    _lastBgSync.clear();
    _bgSyncInFlight.clear();
    _obsCache.clear();
    _forecastCache.clear();
    _seaLevelCache.clear();
    _seaLevelNearestCache.clear();
    _alertCache.clear();
    _lightningCache.clear();
    _lastWaveHash = null;
    _lastWaves = null;
    _lastWaveNearestHash = null;
    _lastWaveNearest = null;
    _lastWaterQualityHash = null;
    _lastWaterQuality = null;
    _lastWaterQualityNearestHash = null;
    _lastWaterQualityNearest = null;
    _lastAlgaeHash = null;
    _lastAlgae = null;
    _lastAlgaeNearestHash = null;
    _lastAlgaeNearest = null;
  }

  // --- Reactive Methods (Offline-First) ---

  @override
  Stream<List<WeatherData>> watchWeatherObservations(double lat, double lon) {
    return _localDataSource
        .watchObservations(lat, lon)
        .map((dtos) => _obsCache.transform(dtos, _obsToEntity));
  }

  @override
  Stream<List<WeatherForecast>> watchWeatherForecast(double lat, double lon) {
    return _localDataSource
        .watchForecast(lat, lon)
        .map((dtos) => _forecastCache.transform(dtos, _forecastToEntity));
  }

  @override
  Stream<List<WaveData>> watchWaveObservations() {
    return _localDataSource.watchWaves().map((dtos) {
      final hash = Object.hashAll(dtos);
      if (_lastWaveHash == hash && _lastWaves != null) return _lastWaves!;
      _lastWaveHash = hash;
      _lastWaves = _processWaveDtosToEntities(dtos);
      return _lastWaves!;
    });
  }

  @override
  Stream<List<WaveData>> watchWaveObservationsNearest(double lat, double lon) {
    return _localDataSource.watchWavesNearest(lat, lon).map((dtos) {
      final hash = Object.hashAll(dtos);
      if (_lastWaveNearestHash == hash && _lastWaveNearest != null) {
        return _lastWaveNearest!;
      }
      _lastWaveNearestHash = hash;
      _lastWaveNearest = _processWaveDtosToEntities(dtos);
      return _lastWaveNearest!;
    });
  }

  @override
  Stream<List<SeaLevel>> watchSeaLevel() {
    return _localDataSource.watchSeaLevels().map(
      (dtos) => _seaLevelCache.transform(dtos, _seaLevelToEntity),
    );
  }

  @override
  Stream<List<SeaLevel>> watchSeaLevelNearest(double lat, double lon) {
    return _localDataSource
        .watchSeaLevelsNearest(lat, lon)
        .map(
          (dtos) => _seaLevelNearestCache.transform(dtos, _seaLevelToEntity),
        );
  }

  @override
  Stream<List<WeatherAlert>> watchActiveAlerts() {
    return _localDataSource.watchAlerts().map(
      (dtos) => _alertCache.transform(dtos, _alertToEntity),
    );
  }

  @override
  Stream<List<LightningStrike>> watchRecentLightning() {
    return _localDataSource.watchLightning().map(
      (dtos) => _lightningCache.transform(dtos, _lightningToEntity),
    );
  }

  @override
  Stream<List<LightningStrike>> watchSafetyLightning() {
    return _localDataSource
        .watchLightning(window: WeatherSyncConstants.lightningTtl)
        .map((dtos) => _lightningCache.transform(dtos, _lightningToEntity));
  }

  // --- SYKE Water Quality & Algae ---

  @override
  Stream<List<WaterQualityData>> watchWaterQuality() {
    return _localDataSource.watchWaterQuality().map((items) {
      final hash = Object.hashAll(items);
      if (_lastWaterQualityHash == hash && _lastWaterQuality != null) {
        return _lastWaterQuality!;
      }
      _lastWaterQualityHash = hash;
      _lastWaterQuality = items;
      return _lastWaterQuality!;
    });
  }

  @override
  Stream<List<WaterQualityData>> watchWaterQualityNearest(
    double lat,
    double lon,
  ) {
    return _localDataSource.watchWaterQualityNearest(lat, lon).map((items) {
      final hash = Object.hashAll(items);
      if (_lastWaterQualityNearestHash == hash &&
          _lastWaterQualityNearest != null) {
        return _lastWaterQualityNearest!;
      }
      _lastWaterQualityNearestHash = hash;
      _lastWaterQualityNearest = items;
      return _lastWaterQualityNearest!;
    });
  }

  @override
  Stream<List<AlgaeData>> watchAlgaeReports() {
    return _localDataSource.watchAlgaeReports().map((items) {
      final hash = Object.hashAll(items);
      if (_lastAlgaeHash == hash && _lastAlgae != null) return _lastAlgae!;
      _lastAlgaeHash = hash;
      _lastAlgae = items;
      return _lastAlgae!;
    });
  }

  @override
  Stream<List<AlgaeData>> watchAlgaeReportsNearest(
    double lat,
    double lon,
  ) {
    return _localDataSource.watchAlgaeReportsNearest(lat, lon).map((items) {
      final hash = Object.hashAll(items);
      if (_lastAlgaeNearestHash == hash && _lastAlgaeNearest != null) {
        return _lastAlgaeNearest!;
      }
      _lastAlgaeNearestHash = hash;
      _lastAlgaeNearest = items;
      return _lastAlgaeNearest!;
    });
  }

  // --- Sync Methods ---

  @override
  Future<void> syncWeatherObservations(double lat, double lon) async {
    final dtos = await _remoteDataSource.fetchWeatherObservations(lat, lon);
    await _localDataSource.cacheObservations(lat, lon, dtos);
  }

  @override
  Future<void> syncWeatherForecast(double lat, double lon) async {
    final dtos = await _remoteDataSource.fetchWeatherForecast(lat, lon);
    await _localDataSource.cacheForecast(lat, lon, dtos);
  }

  @override
  Future<void> syncWaveObservations({double? lat, double? lon}) async {
    final dtos = await _remoteDataSource.fetchWaveObservations(
      lat: lat,
      lon: lon,
    );
    await _localDataSource.cacheWaves(dtos);
  }

  @override
  Future<void> syncSeaLevel() async {
    final dtos = await _remoteDataSource.fetchSeaLevel();
    await _localDataSource.cacheSeaLevels(dtos);
  }

  @override
  Future<void> syncActiveAlerts() async {
    final dtos = await _remoteDataSource.fetchActiveAlerts();
    await _localDataSource.cacheAlerts(dtos);
  }

  @override
  Future<void> syncRecentLightning({DateTime? startTime}) async {
    final effectiveStartTime =
        startTime ?? DateTime.now().subtract(const Duration(hours: 1));
    final dtos = await _remoteDataSource.fetchRecentLightning(
      effectiveStartTime,
    );

    await _localDataSource.cacheLightning(dtos);
  }

  @override
  Future<Either<Failure, List<WaterQualityData>>> getWaterQuality({
    double? lat,
    double? lon,
  }) async {
    // 1. Try cache
    final cached = await _localDataSource.getLastWaterQuality();
    if (cached != null && cached.isNotEmpty) {
      return Right(cached);
    }

    // 2. Fetch remote
    try {
      final dtos = await _remoteDataSource.fetchWaterQuality(
        lat: lat,
        lon: lon,
        limit: 100,
      );

      // 3. Cache and return station-resolved entities directly
      final cachedEntities = await _localDataSource.cacheWaterQuality(dtos);
      return Right(
        cachedEntities.isNotEmpty
            ? cachedEntities
            : dtos.map(_waterQualityToEntity).toList(),
      );
    } catch (e, s) {
      Log.e('WeatherRepo: getWaterQuality failed', e, s);
      return Left(ServerFailure('Water quality unavailable: $e'));
    }
  }

  @override
  Future<Either<Failure, List<AlgaeData>>> getAlgaeReports({
    double? lat,
    double? lon,
  }) async {
    // 1. Try cache
    final cached = await _localDataSource.getLastAlgaeReports();
    if (cached != null && cached.isNotEmpty) {
      return Right(cached);
    }

    // 2. Fetch remote
    try {
      final dtos = await _remoteDataSource.fetchAlgaeReports(
        lat: lat,
        lon: lon,
      );

      // 3. Cache and return station-resolved entities directly
      final cachedEntities = await _localDataSource.cacheAlgaeReports(dtos);
      return Right(
        cachedEntities.isNotEmpty
            ? cachedEntities
            : dtos.map(_algaeToEntity).toList(),
      );
    } catch (e, s) {
      Log.e('WeatherRepo: getAlgaeReports failed', e, s);
      return Left(ServerFailure('Algae reports unavailable: $e'));
    }
  }

  @override
  Future<void> syncWaterQuality(double lat, double lon) async {
    final dtos = await _remoteDataSource.fetchWaterQuality(
      lat: lat,
      lon: lon,
      limit: 100,
    );
    await _localDataSource.cacheWaterQuality(dtos);
    Log.d('WeatherRepo: Synced ${dtos.length} water quality readings');
  }

  @override
  Future<void> syncAlgaeReports(double lat, double lon) async {
    final dtos = await _remoteDataSource.fetchAlgaeReports(
      lat: lat,
      lon: lon,
    );
    await _localDataSource.cacheAlgaeReports(dtos);
    Log.d('WeatherRepo: Synced ${dtos.length} algae reports');
  }

  WaterQualityData _waterQualityToEntity(WaterQualityDto dto) {
    return WaterQualityData(
      sampleDate: dto.timestamp,
      location: dto.location,
      stationName: dto.stationName,
      temperature: null,
      chlorophyllA: dto.chlorophyllA,
      turbidity: dto.turbidity,
      algaeStatus: null,
      dissolvedOxygen: dto.dissolvedOxygen,
      ph: dto.pH,
    );
  }

  AlgaeRiskLevel? _parseAlgaeRiskLevel(String name) {
    for (final level in AlgaeRiskLevel.values) {
      if (level.name == name) return level;
    }
    return null;
  }

  AlgaeData _algaeToEntity(AlgaeReportDto dto) {
    return AlgaeData(
      observationTime: dto.timestamp,
      location: dto.location,
      speciesName: dto.speciesName,
      biomass: dto.biomass,
      cellCount: dto.cellCount,
      dominantSpecies: dto.dominantSpecies,
      riskLevel: dto.riskLevel != null
          ? _parseAlgaeRiskLevel(dto.riskLevel!.name)
          : null,
    );
  }
}
