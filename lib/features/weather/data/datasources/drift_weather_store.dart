import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/constants/weather_constants.dart';
import 'package:sakkoja/core/constants/weather_sync_constants.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/core/db/daos/weather_dao.dart';
import 'package:sakkoja/core/db/database_error_handler.dart';
import 'package:sakkoja/core/db/weather_tables.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/core/utils/logger.dart';
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

part 'drift_weather_store.g.dart';

/// Weather data store using typed Drift tables.
///
/// Replaces JSON-blob storage with normalized, typed SQL schema.
/// Supports multiple providers (FMI, OpenWeather, MET Norway).
@Riverpod(keepAlive: true)
DriftWeatherStore driftWeatherStore(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  final store = DriftWeatherStore(db);
  unawaited(store.preloadStationCache());
  return store;
}

class DriftWeatherStore {
  DriftWeatherStore(this._db) {
    _dao = _db.weatherDao;
  }
  final AppDatabase _db;
  late final WeatherDao _dao;
  final _errorHandler = DatabaseErrorHandler();

  /// Provider ID cache (avoids repeated lookups)
  int? _fmiProviderId;
  int? _openWeatherProviderId;
  int? _metNorwayProviderId;
  int? _sykeProviderId;

  /// Last cleanup timestamp
  DateTime? _lastCleanup;

  /// Station cache to avoid repetitive re-queries in reactive mappings.
  final Map<int, WeatherStation> _stationByIdCache = {};
  static const int _maxStationCacheEntries = 4096;

  /// Lazily-built provider ID maps for synchronous lookups.
  /// Populated once via [_ensureProviderMaps], then queried with no awaits.
  Map<int, int>? _dbToExternalId;
  Map<int, int>? _externalToDbId;

  /// Extra entries evicted beyond the cap to avoid frequent tiny eviction
  /// cycles under active map use (one-shot headroom per overflow event).
  static const int _evictionHeadroom = 512;

  /// Pre-loads weather station records into memory cache to eliminate stream DB lookups (issue #85).
  Future<void> preloadStationCache() async {
    final stations = await _db.select(_db.weatherStations).get();
    for (final s in stations) {
      _stationByIdCache[s.id] = s;
    }
  }

  /// Get or cache provider ID
  Future<int> _getProviderId(String code) async {
    switch (code) {
      case 'fmi':
        return _fmiProviderId ??= await _dao.getOrCreateProvider(
          'fmi',
          'FMI Open Data',
          priority: 10,
          apiVersion: '1.0',
        );
      case 'openweather':
        return _openWeatherProviderId ??= await _dao.getOrCreateProvider(
          'openweather',
          'OpenWeather',
          priority: 3,
          apiVersion: '2.5',
        );
      case 'met_no':
        return _metNorwayProviderId ??= await _dao.getOrCreateProvider(
          'met_no',
          'MET Norway',
          priority: 5,
          apiVersion: '2.0',
        );
      case 'syke':
        return _sykeProviderId ??= await _dao.getOrCreateProvider(
          'syke',
          'SYKE',
          priority: 8,
          apiVersion: '4.0',
        );
      default:
        throw ArgumentError('Unknown provider: $code');
    }
  }

  // ===========================================================================
  // OBSERVATIONS
  // ===========================================================================

  /// Ensure the provider ID maps are populated.
  /// After this runs, [_dbToExternalId] and [_externalToDbId] are usable
  /// as synchronous lookups, eliminating 4 sequential async calls per DTO row.
  Future<void> _ensureProviderMaps() async {
    if (_dbToExternalId != null) return;
    final fmi = await _getProviderId('fmi');
    final met = await _getProviderId('met_no');
    final ow = await _getProviderId('openweather');
    final syke = await _getProviderId('syke');
    // 10 = FMI, 5 = MET Norway, 3 = OpenWeather, 8 = SYKE
    _dbToExternalId = {fmi: 10, met: 5, ow: 3, syke: 8};
    _externalToDbId = {10: fmi, 5: met, 3: ow, 8: syke};
    await preloadStationCache();
  }

  /// Map external provider ID (DTO priority) to Database Foreign Key ID.
  /// Single async warm-up on first call; subsequent calls skip DB I/O.
  Future<int> _resolveDbId(int? dtoProviderId) async {
    if (dtoProviderId == null) {
      await _ensureProviderMaps();
      return _externalToDbId![10] ?? (await _getProviderId('fmi'));
    }
    await _ensureProviderMaps();
    if (!_externalToDbId!.containsKey(dtoProviderId)) {
      Log.w('[Store] Unknown providerId: $dtoProviderId, defaulting to FMI');
    }
    return _externalToDbId![dtoProviderId] ?? (await _getProviderId('fmi'));
  }

  /// Map Database Foreign Key ID back to external provider ID (synchronous).
  int _resolveExternalIdSync(int dbProviderId) {
    return _dbToExternalId?[dbProviderId] ?? 10;
  }

  /// Map Database Foreign Key ID back to external provider ID.
  Future<int> _resolveExternalId(int dbProviderId) async {
    await _ensureProviderMaps();
    return _resolveExternalIdSync(dbProviderId);
  }

  String _stationKey(String stationType, double latitude, double longitude) =>
      '$stationType|${latitude.toStringAsFixed(4)}|${longitude.toStringAsFixed(4)}';

  /// Resolve (or create) a batch of stations using a single DB transaction.
  ///
  /// Delegates to [WeatherDao.getOrCreateStationsBatch] which performs one
  /// bulk SELECT + one bulk INSERT instead of N serialised transactions,
  /// eliminating the N+1 DB round-trip pattern (issue #89).
  Future<Map<String, int>> _resolveStationsBatch(
    Iterable<({String? name, double lat, double lon, String type})> rows,
  ) async {
    return _dao.getOrCreateStationsBatch(rows.toList());
  }

  Future<Map<int, WeatherStation>> _getStationsByIds(
    Set<int> stationIds,
  ) async {
    if (stationIds.isEmpty) return {};

    final missing = stationIds
        .where((id) => !_stationByIdCache.containsKey(id))
        .toList();
    if (missing.isNotEmpty) {
      final fetched = await (_db.select(
        _db.weatherStations,
      )..where((s) => s.id.isIn(missing))).get();
      final overflow =
          (_stationByIdCache.length + fetched.length) - _maxStationCacheEntries;
      if (overflow > 0) {
        // Evict oldest entries (insertion order) rather than wiping the whole
        // cache; keeps recently-queried stations warm across stream emissions.
        final toRemove = _stationByIdCache.keys
            .take(overflow + _evictionHeadroom)
            .toList();
        for (final key in toRemove) {
          _stationByIdCache.remove(key);
        }
      }
      for (final station in fetched) {
        _stationByIdCache[station.id] = station;
      }
    }

    final resolved = <int, WeatherStation>{};
    for (final id in stationIds) {
      final station = _stationByIdCache[id];
      if (station != null) {
        resolved[id] = station;
      }
    }
    return resolved;
  }

  // ===========================================================================
  // OBSERVATIONS
  // ===========================================================================

  /// Cache weather observations from a provider
  Future<void> cacheObservations(
    double lat,
    double lon,
    List<WeatherObservationDto> data, {
    String provider =
        'fmi', // Deprecated but kept for signature compatibility if needed
  }) async {
    if (data.isEmpty) return;

    await _errorHandler.performVoid(() async {
      final now = DateTime.now();

      // FIX #313: Batch-resolve stations for ALL observations, not just first
      final stationRows = data
          .map(
            (dto) => (
              name: dto.stationName,
              lat: dto.location.latitude,
              lon: dto.location.longitude,
              type: 'weather',
            ),
          )
          .toList();
      final stationMap = await _dao.getOrCreateStationsBatch(stationRows);

      final companions = <WeatherObservationsCompanion>[];

      for (final dto in data) {
        final lat4 = (dto.location.latitude * 10000).round() / 10000;
        final lon4 = (dto.location.longitude * 10000).round() / 10000;
        final stationKey =
            'weather|${lat4.toStringAsFixed(4)}|${lon4.toStringAsFixed(4)}';
        final stationId = stationMap[stationKey];
        if (stationId == null) continue; // Should never happen

        final dbProviderId = await _resolveDbId(dto.providerId);
        companions.add(
          WeatherObservationsCompanion.insert(
            stationId: stationId,
            providerId: dbProviderId,
            timestamp: dto.timestamp,
            fetchedAt: now,
            temperature: Value(dto.temperature),
            windSpeed: Value(dto.windSpeed),
            windGust: Value(dto.windGust),
            windDirection: Value(dto.windDirection),
            pressure: Value(dto.pressure),
            humidity: Value(dto.humidity),
            precipitation: Value(dto.precipitation),
            cloudCover: Value(dto.cloudCover),
            feelsLike: Value(dto.feelsLike),
            dewPoint: Value(dto.dewPoint),
            uvIndex: Value(dto.uvIndex),
            snowfall: Value(dto.snowfall),
            weatherCode: Value(dto.weatherCode),
            weatherIcon: Value(dto.weatherIcon),
            weatherDescription: Value(dto.weatherDescription),
            sunrise: Value(dto.sunrise),
            sunset: Value(dto.sunset),
          ),
        );
      }

      await _dao.insertObservationBatch(companions);
      await _maybeCleanup();
    }, context: 'cacheObservations');
  }

  /// Get cached observations near a location
  Future<List<WeatherObservationDto>?> getLastObservations(
    double lat,
    double lon,
  ) async {
    final result = await _errorHandler.perform(() async {
      final station = await _dao.findNearestStation(lat, lon, 'weather');
      if (station == null) {
        return null;
      }

      var observations = await _dao.getRecentObservations(
        station.id,
        const Duration(hours: 24),
        maxAge: WeatherSyncConstants.observationsTtl,
      );

      // 2. Fallback: Try fetching older data if fresh data is missing
      // (Offline Safety)
      if (observations.isEmpty) {
        observations = await _dao.getRecentObservations(
          station.id,
          const Duration(hours: 24),
          maxAge: const Duration(
            days: 7,
          ), // Allow up to 1 week old data in emergencies
        );
        if (observations.isNotEmpty) {
          Log.w(
            '[CACHE] Observations: WARN - Returning STALE data '
            '(Age > ${WeatherSyncConstants.observationsTtl.inMinutes}m)',
          );
        }
      }

      if (observations.isEmpty) {
        return null;
      }

      // Convert to DTOs
      final dtos = await Future.wait(
        observations.map((obs) async {
          return WeatherObservationDto(
            timestamp: obs.timestamp,
            location: LatLng(station.latitude, station.longitude),
            stationName: station.name,
            providerId: await _resolveExternalId(obs.providerId),
            temperature: obs.temperature,
            windSpeed: obs.windSpeed,
            windGust: obs.windGust,
            windDirection: obs.windDirection,
            pressure: obs.pressure,
            visibility: obs.visibility,
            humidity: obs.humidity,
            dewPoint: obs.dewPoint,
            precipitation: obs.precipitation,
            cloudCover: obs.cloudCover,
            feelsLike: obs.feelsLike,
            uvIndex: obs.uvIndex,
            snowfall: obs.snowfall,
            weatherCode: obs.weatherCode,
            weatherIcon: obs.weatherIcon,
            weatherDescription: obs.weatherDescription,
            sunrise: obs.sunrise,
            sunset: obs.sunset,
          );
        }),
      );
      return dtos;
    }, context: 'getLastObservations');

    return result.fold((_) => null, (data) => data);
  }

  /// Watch observations near a location (reactive stream)
  Stream<List<WeatherObservationDto>> watchObservations(
    double lat,
    double lon,
  ) {
    return _errorHandler.handleStream(
      _dao
          .watchNearbyObservations(
            lat,
            lon,
            maxAge: WeatherSyncConstants.observationsTtl,
          )
          .asyncMap((observations) async {
            if (observations.isEmpty) return [];

            // Get station info for mapping
            final stationIds = observations.map((o) => o.stationId).toSet();
            final stations = await _getStationsByIds(stationIds);

            final filtered = observations
                .where((obs) => stations.containsKey(obs.stationId))
                .toList();
            await _ensureProviderMaps();
            return filtered.map((obs) {
              final station = stations[obs.stationId]!;
              return WeatherObservationDto(
                timestamp: obs.timestamp,
                location: LatLng(station.latitude, station.longitude),
                stationName: station.name,
                providerId: _resolveExternalIdSync(obs.providerId),
                temperature: obs.temperature,
                windSpeed: obs.windSpeed,
                windGust: obs.windGust,
                windDirection: obs.windDirection,
                pressure: obs.pressure,
                visibility: obs.visibility,
                humidity: obs.humidity,
                dewPoint: obs.dewPoint,
                precipitation: obs.precipitation,
                cloudCover: obs.cloudCover,
                feelsLike: obs.feelsLike,
                uvIndex: obs.uvIndex,
                snowfall: obs.snowfall,
                weatherCode: obs.weatherCode,
                weatherIcon: obs.weatherIcon,
                weatherDescription: obs.weatherDescription,
                sunrise: obs.sunrise,
                sunset: obs.sunset,
              );
            }).toList();
          }),
      context: 'watchObservations',
    );
  }

  // ===========================================================================
  // FORECASTS
  // ===========================================================================

  /// Cache weather forecasts
  Future<void> cacheForecast(
    double lat,
    double lon,
    List<WeatherForecastDto> data, {
    String provider = 'fmi',
  }) async {
    if (data.isEmpty) return;

    await _errorHandler.perform(() async {
      final now = DateTime.now();

      // FIX #520: Batch-resolve station (single entry, but uses batch API for consistency)
      final stationRows = [
        (name: 'Forecast ($lat, $lon)', lat: lat, lon: lon, type: 'weather'),
      ];
      final stationMap = await _dao.getOrCreateStationsBatch(stationRows);
      final stationKey = _stationKey('weather', lat, lon);
      final stationId = stationMap[stationKey];
      if (stationId == null) {
        Log.w('[Store] Station not found in batch for forecast: $stationKey');
        return;
      }

      final companions = <WeatherForecastsCompanion>[];

      for (final dto in data) {
        final dbProviderId = await _resolveDbId(dto.providerId);
        companions.add(
          WeatherForecastsCompanion.insert(
            stationId: stationId,
            providerId: dbProviderId,
            forecastTime: dto.timestamp,
            issuedAt: dto.issuedAt ?? now,
            fetchedAt: now,
            temperature: Value(dto.temperature),
            windSpeed: Value(dto.windSpeed),
            windGust: Value(dto.windGust),
            windDirection: Value(dto.windDirection),
            precipitation: Value(dto.precipitation),
            feelsLike: Value(dto.feelsLike),
            pressure: Value(dto.pressure),
            humidity: Value(dto.humidity),
            dewPoint: Value(dto.dewPoint),
            precipitationProbability: Value(dto.precipitationProbability),
            cloudCover: Value(dto.cloudCover),
            uvIndex: Value(dto.uvIndex),
            weatherIcon: Value(dto.weatherIcon),
            weatherDescription: Value(dto.weatherDescription),
          ),
        );
      }

      await _dao.insertForecastBatch(companions);
      await _maybeCleanup();
    }, context: 'cacheForecast');
  }

  /// Get cached forecasts
  Future<List<WeatherForecastDto>?> getLastForecast(
    double lat,
    double lon,
  ) async {
    final result = await _errorHandler.perform(() async {
      final station = await _dao.findNearestStation(lat, lon, 'weather');
      if (station == null) {
        return null;
      }

      var forecasts = await _dao.getForecastsForStation(
        station.id,
        maxAge: WeatherSyncConstants.forecastTtl,
      );

      // 2. Fallback: Try fetching older data
      if (forecasts.isEmpty) {
        forecasts = await _dao.getForecastsForStation(
          station.id,
          maxAge: const Duration(days: 7),
        );
        if (forecasts.isNotEmpty) {
          Log.w('[CACHE] Forecast: WARN - Returning STALE data');
        }
      }

      if (forecasts.isEmpty) {
        return null;
      }

      final forecastDtos = await Future.wait(
        forecasts.map((f) async {
          return WeatherForecastDto(
            timestamp: f.forecastTime,
            location: LatLng(station.latitude, station.longitude),
            issuedAt: f.issuedAt,
            providerId: await _resolveExternalId(f.providerId),
            temperature: f.temperature,
            windSpeed: f.windSpeed,
            windGust: f.windGust,
            windDirection: f.windDirection,
            precipitation: f.precipitation,
            feelsLike: f.feelsLike,
            pressure: f.pressure,
            humidity: f.humidity,
            dewPoint: f.dewPoint,
            precipitationProbability: f.precipitationProbability,
            cloudCover: f.cloudCover,
            uvIndex: f.uvIndex,
            weatherIcon: f.weatherIcon,
            weatherDescription: f.weatherDescription,
          );
        }),
      );
      return forecastDtos;
    }, context: 'getLastForecast');

    return result.fold((_) => null, (data) => data);
  }

  /// Watch forecasts (reactive)
  Stream<List<WeatherForecastDto>> watchForecast(double lat, double lon) {
    return _errorHandler.handleStream(
      _dao
          .watchNearbyForecasts(
            lat,
            lon,
            maxAge: WeatherSyncConstants.forecastTtl,
          )
          .asyncMap((forecasts) async {
            if (forecasts.isEmpty) return [];

            // Get station info for mapping
            final stationIds = forecasts.map((f) => f.stationId).toSet();
            final stations = await _getStationsByIds(stationIds);

            final filtered = forecasts
                .where((f) => stations.containsKey(f.stationId))
                .toList();
            return Future.wait(
              filtered.map((f) async {
                final station = stations[f.stationId]!;
                return WeatherForecastDto(
                  timestamp: f.forecastTime,
                  location: LatLng(station.latitude, station.longitude),
                  issuedAt: f.issuedAt,
                  providerId: await _resolveExternalId(f.providerId),
                  temperature: f.temperature,
                  windSpeed: f.windSpeed,
                  windGust: f.windGust,
                  windDirection: f.windDirection,
                  precipitation: f.precipitation,
                  feelsLike: f.feelsLike,
                  pressure: f.pressure,
                  humidity: f.humidity,
                  dewPoint: f.dewPoint,
                  precipitationProbability: f.precipitationProbability,
                  cloudCover: f.cloudCover,
                  uvIndex: f.uvIndex,
                  weatherIcon: f.weatherIcon,
                  weatherDescription: f.weatherDescription,
                );
              }),
            );
          }),
      context: 'watchForecast',
    );
  }

  // ===========================================================================
  // WAVES (FMI Marine)
  // ===========================================================================

  /// Cache wave observations
  Future<void> cacheWaves(List<WaveObservationDto> data) async {
    if (data.isEmpty) return;

    await _errorHandler.perform(() async {
      final providerId = await _getProviderId('fmi');
      final now = DateTime.now();

      final companions = <WaveObservationsCompanion>[];
      final stationIds = await _resolveStationsBatch(
        data.map(
          (dto) => (
            name: dto.stationName,
            lat: dto.location.latitude,
            lon: dto.location.longitude,
            type: 'buoy',
          ),
        ),
      );

      for (final dto in data) {
        final key = _stationKey(
          'buoy',
          dto.location.latitude,
          dto.location.longitude,
        );
        final stationId = stationIds[key];
        if (stationId == null) continue;

        companions.add(
          WaveObservationsCompanion.insert(
            stationId: stationId,
            providerId: providerId,
            timestamp: dto.timestamp,
            fetchedAt: now,
            waveHeight: Value(dto.waveHeight),
            wavePeriod: Value(dto.wavePeriod),
            waveDirection: Value(dto.waveDirection),
            waterTemperature: Value(dto.waterTemperature),
          ),
        );
      }

      await _dao.insertWavesBatch(companions);
      await _maybeCleanup();
    }, context: 'cacheWaves');
  }

  /// Get cached wave observations
  Future<List<WaveObservationDto>?> getLastWaves() async {
    final result = await _errorHandler.perform(() async {
      final stations = await (_db.select(
        _db.weatherStations,
      )..where((s) => s.stationType.equals('buoy'))).get();

      if (stations.isEmpty) {
        return null;
      }

      final stationIds = stations.map((s) => s.id).toList();
      final stationMap = {for (final s in stations) s.id: s};
      final cutoff = DateTime.now().subtract(WeatherSyncConstants.wavesTtl);
      final staleCutoff = DateTime.now().subtract(const Duration(days: 7));

      final waves =
          await (_db.select(_db.waveObservations)
                ..where((w) => w.stationId.isIn(stationIds))
                ..where((w) => w.fetchedAt.isBiggerOrEqualValue(cutoff)))
              .get();

      if (waves.isEmpty) {
        final staleWaves =
            await (_db.select(_db.waveObservations)
                  ..where((w) => w.stationId.isIn(stationIds))
                  ..where((w) => w.fetchedAt.isBiggerOrEqualValue(staleCutoff)))
                .get();

        if (staleWaves.isEmpty) {
          return null;
        }
        Log.w('[CACHE] Waves: WARN - Returning STALE data');

        return _mapWavesToDtos(staleWaves, stationMap);
      }

      return _mapWavesToDtos(waves, stationMap);
    }, context: 'getLastWaves');

    return result.fold((_) => null, (data) => data);
  }

  List<WaveObservationDto> _mapWavesToDtos(
    List<WaveObservation> waves,
    Map<int, WeatherStation> stationMap,
  ) {
    return waves.map((wave) {
      final station = stationMap[wave.stationId];
      return WaveObservationDto(
        timestamp: wave.timestamp,
        location: LatLng(station?.latitude ?? 0, station?.longitude ?? 0),
        stationName: station?.name ?? 'Unknown',
        waveHeight: wave.waveHeight,
        wavePeriod: wave.wavePeriod,
        waveDirection: wave.waveDirection,
        waterTemperature: wave.waterTemperature,
      );
    }).toList();
  }

  /// Watch waves (reactive)
  Stream<List<WaveObservationDto>> watchWaves() {
    return _errorHandler.handleStream(
      _dao.watchWaves(maxAge: WeatherSyncConstants.wavesTtl).asyncMap((
        waves,
      ) async {
        if (waves.isEmpty) return [];

        final stationIds = waves.map((w) => w.stationId).toSet();
        final stations = await _getStationsByIds(stationIds);

        return waves.where((w) => stations.containsKey(w.stationId)).map((w) {
          final station = stations[w.stationId]!;
          return WaveObservationDto(
            timestamp: w.timestamp,
            location: LatLng(station.latitude, station.longitude),
            stationName: station.name,
            waveHeight: w.waveHeight,
            wavePeriod: w.wavePeriod,
            waveDirection: w.waveDirection,
            waterTemperature: w.waterTemperature,
          );
        }).toList();
      }),
      context: 'watchWaves',
    );
  }

  // ===========================================================================
  // SEA LEVELS (FMI Marine)
  // ===========================================================================

  /// Cache sea level readings
  Future<void> cacheSeaLevels(List<SeaLevelDto> data) async {
    if (data.isEmpty) return;

    await _errorHandler.perform(() async {
      final providerId = await _getProviderId('fmi');
      final now = DateTime.now();

      final companions = <SeaLevelReadingsCompanion>[];
      final stationIds = await _resolveStationsBatch(
        data.map(
          (dto) => (
            name: dto.stationName,
            lat: dto.location.latitude,
            lon: dto.location.longitude,
            type: 'mareograph',
          ),
        ),
      );

      for (final dto in data) {
        final key = _stationKey(
          'mareograph',
          dto.location.latitude,
          dto.location.longitude,
        );
        final stationId = stationIds[key];
        if (stationId == null) continue;

        companions.add(
          SeaLevelReadingsCompanion.insert(
            stationId: stationId,
            providerId: providerId,
            timestamp: dto.timestamp,
            fetchedAt: now,
            seaLevelMm: Value(dto.seaLevel),
          ),
        );
      }

      await _dao.insertSeaLevelBatch(companions);
      await _maybeCleanup();
    }, context: 'cacheSeaLevels');
  }

  /// Get cached sea levels
  Future<List<SeaLevelDto>?> getLastSeaLevels() async {
    final result = await _errorHandler.perform(() async {
      final stations = await (_db.select(
        _db.weatherStations,
      )..where((s) => s.stationType.equals('mareograph'))).get();

      if (stations.isEmpty) {
        return null;
      }

      final stationIds = stations.map((s) => s.id).toList();
      final stationMap = {for (final s in stations) s.id: s};
      final cutoff = DateTime.now().subtract(WeatherSyncConstants.seaLevelTtl);
      final staleCutoff = DateTime.now().subtract(const Duration(days: 7));

      final levels =
          await (_db.select(_db.seaLevelReadings)
                ..where((l) => l.stationId.isIn(stationIds))
                ..where((l) => l.fetchedAt.isBiggerOrEqualValue(cutoff)))
              .get();

      if (levels.isEmpty) {
        final staleLevels =
            await (_db.select(_db.seaLevelReadings)
                  ..where((l) => l.stationId.isIn(stationIds))
                  ..where((l) => l.fetchedAt.isBiggerOrEqualValue(staleCutoff)))
                .get();

        if (staleLevels.isEmpty) {
          return null;
        }
        Log.w('[CACHE] SeaLevels: WARN - Returning STALE data');

        return _mapSeaLevelsToDtos(staleLevels, stationMap);
      }

      return _mapSeaLevelsToDtos(levels, stationMap);
    }, context: 'getLastSeaLevels');

    return result.fold((_) => null, (data) => data);
  }

  List<SeaLevelDto> _mapSeaLevelsToDtos(
    List<SeaLevelReading> levels,
    Map<int, WeatherStation> stationMap,
  ) {
    return levels.map((level) {
      final station = stationMap[level.stationId];
      return SeaLevelDto(
        timestamp: level.timestamp,
        location: LatLng(station?.latitude ?? 0, station?.longitude ?? 0),
        stationName: station?.name ?? 'Unknown',
        seaLevel: level.seaLevelMm,
      );
    }).toList();
  }

  /// Watch sea levels (reactive)
  Stream<List<SeaLevelDto>> watchSeaLevels() {
    return _errorHandler.handleStream(
      _dao.watchSeaLevels(maxAge: WeatherSyncConstants.seaLevelTtl).asyncMap((
        levels,
      ) async {
        if (levels.isEmpty) return [];

        final stationIds = levels.map((l) => l.stationId).toSet();
        final stations = await _getStationsByIds(stationIds);

        return levels.where((l) => stations.containsKey(l.stationId)).map((l) {
          final station = stations[l.stationId]!;
          return SeaLevelDto(
            timestamp: l.timestamp,
            location: LatLng(station.latitude, station.longitude),
            stationName: station.name,
            seaLevel: l.seaLevelMm,
          );
        }).toList();
      }),
      context: 'watchSeaLevels',
    );
  }

  /// Watch waves sorted by distance (reactive)
  Stream<List<WaveObservationDto>> watchWavesNearest(double lat, double lon) {
    return _errorHandler.handleStream(
      _dao
          .watchWavesNearest(
            lat,
            lon,
            maxAge: WeatherSyncConstants.wavesTtl,
          )
          .asyncMap((waves) async {
            if (waves.isEmpty) return [];

            final stationIds = waves.map((w) => w.stationId).toSet();
            final stations = await _getStationsByIds(stationIds);

            return waves.where((w) => stations.containsKey(w.stationId)).map((
              w,
            ) {
              final station = stations[w.stationId]!;
              return WaveObservationDto(
                timestamp: w.timestamp,
                location: LatLng(station.latitude, station.longitude),
                stationName: station.name,
                waveHeight: w.waveHeight,
                wavePeriod: w.wavePeriod,
                waveDirection: w.waveDirection,
                waterTemperature: w.waterTemperature,
              );
            }).toList();
          }),
      context: 'watchWavesNearest',
    );
  }

  /// Watch sea levels sorted by distance (reactive)
  Stream<List<SeaLevelDto>> watchSeaLevelsNearest(double lat, double lon) {
    return _errorHandler.handleStream(
      _dao
          .watchSeaLevelsNearest(
            lat,
            lon,
            maxAge: WeatherSyncConstants.seaLevelTtl,
          )
          .asyncMap((levels) async {
            if (levels.isEmpty) return [];

            final stationIds = levels.map((l) => l.stationId).toSet();
            final stations = await _getStationsByIds(stationIds);

            return levels.where((l) => stations.containsKey(l.stationId)).map((
              l,
            ) {
              final station = stations[l.stationId]!;
              return SeaLevelDto(
                timestamp: l.timestamp,
                location: LatLng(station.latitude, station.longitude),
                stationName: station.name,
                seaLevel: l.seaLevelMm,
              );
            }).toList();
          }),
      context: 'watchSeaLevelsNearest',
    );
  }

  // ===========================================================================
  // ALERTS
  // ===========================================================================

  /// Cache weather alerts
  Future<void> cacheAlerts(List<WeatherAlertDto> data) async {
    if (data.isEmpty) return;

    await _errorHandler.perform(() async {
      final providerId = await _getProviderId('fmi');
      final now = DateTime.now();

      final companions = data.map((dto) {
        return WeatherAlertsCompanion.insert(
          externalId: dto.id,
          providerId: providerId,
          event: dto.event,
          description: dto.description,
          severity: dto.severity,
          onset: dto.onset,
          expires: dto.expires,
          fetchedAt: now,
          polygonJson: jsonEncode(
            dto.polygon.map((p) => [p.latitude, p.longitude]).toList(),
          ),
          areaDescription: dto.areaDescription,
        );
      }).toList();

      await _dao.upsertAlerts(companions);
      await _maybeCleanup();
    }, context: 'cacheAlerts');
  }

  /// Get active alerts
  Future<List<WeatherAlertDto>?> getLastAlerts() async {
    final result = await _errorHandler.perform(() async {
      final alerts = await _dao.getActiveAlerts();

      if (alerts.isEmpty) {
        return null;
      }

      return alerts.map((a) {
        final polygonData = jsonDecode(a.polygonJson) as List;
        final polygon = polygonData.map((p) {
          final coords = p as List;
          return LatLng(coords[0] as double, coords[1] as double);
        }).toList();

        return WeatherAlertDto(
          id: a.externalId,
          event: a.event,
          description: a.description,
          severity: a.severity,
          onset: a.onset,
          expires: a.expires,
          polygon: polygon,
          areaDescription: a.areaDescription,
        );
      }).toList();
    }, context: 'getLastAlerts');

    return result.fold((_) => null, (data) => data);
  }

  /// Watch alerts (reactive)
  Stream<List<WeatherAlertDto>> watchAlerts() {
    return _errorHandler.handleStream(
      _dao.watchActiveAlerts().map((alerts) {
        return alerts.map((a) {
          final polygonData = jsonDecode(a.polygonJson) as List;
          final polygon = polygonData.map((p) {
            final coords = p as List;
            return LatLng(coords[0] as double, coords[1] as double);
          }).toList();

          return WeatherAlertDto(
            id: a.externalId,
            event: a.event,
            description: a.description,
            severity: a.severity,
            onset: a.onset,
            expires: a.expires,
            polygon: polygon,
            areaDescription: a.areaDescription,
          );
        }).toList();
      }),
      context: 'watchAlerts',
    );
  }

  // ===========================================================================
  // LIGHTNING
  // ===========================================================================

  /// Cache lightning strikes
  Future<void> cacheLightning(List<LightningStrikeDto> data) async {
    if (data.isEmpty) return;

    await _errorHandler.perform(() async {
      final providerId = await _getProviderId('fmi');
      final now = DateTime.now();

      final companions = data.map((dto) {
        return LightningStrikesCompanion.insert(
          providerId: providerId,
          strikeTime: dto.time,
          fetchedAt: now,
          latitude: dto.location.latitude,
          longitude: dto.location.longitude,
          peakCurrentKa: dto.peakCurrent,
          multiplicity: dto.multiplicity,
        );
      }).toList();

      await _dao.insertLightningBatch(companions);
      await _maybeCleanup();
    }, context: 'cacheLightning');
  }

  /// Get recent lightning strikes
  Future<List<LightningStrikeDto>?> getLastLightning() async {
    final result = await _errorHandler.perform(() async {
      final strikes = await _dao.getRecentLightning(LightningStrikes.retention);

      if (strikes.isEmpty) {
        return null;
      }

      return strikes.map((s) {
        return LightningStrikeDto(
          time: s.strikeTime,
          location: LatLng(s.latitude, s.longitude),
          peakCurrent: s.peakCurrentKa,
          multiplicity: s.multiplicity,
        );
      }).toList();
    }, context: 'getLastLightning');

    return result.fold((_) => null, (data) => data);
  }

  /// Watch lightning (reactive)
  Stream<List<LightningStrikeDto>> watchLightning({Duration? window}) {
    return _errorHandler.handleStream(
      _dao.watchRecentLightning(window ?? LightningStrikes.retention).map((
        strikes,
      ) {
        return strikes.map((s) {
          return LightningStrikeDto(
            time: s.strikeTime,
            location: LatLng(s.latitude, s.longitude),
            peakCurrent: s.peakCurrentKa,
            multiplicity: s.multiplicity,
          );
        }).toList();
      }),
      context: 'watchLightning',
    );
  }

  // ===========================================================================
  // CLEANUP
  // ===========================================================================

  /// Run cleanup if enough time has passed
  Future<void> _maybeCleanup() async {
    final now = DateTime.now();
    if (_lastCleanup != null &&
        now.difference(_lastCleanup!) < WeatherConstants.cleanupInterval) {
      return;
    }

    await _runCleanup();
    _lastCleanup = now;
  }

  // ===========================================================================
  // SYKE WATER QUALITY
  // ===========================================================================

  // Quick-look product thresholds (non-regulatory):
  // - Chlorophyll-a: >=10 µg/L often indicates elevated algae activity,
  //   >=25 µg/L indicates pronounced bloom potential.
  // - Turbidity: >=10 NTU indicates reduced clarity, >=20 NTU high turbidity.
  // These are intentionally conservative UI heuristics, pending formal
  // domain-expert calibration for Sakkoja operations.
  /// Chlorophyll-a moderate threshold (µg/L), quick-look heuristic.
  static const double _chlorophyllModerateThreshold = 10;

  /// Chlorophyll-a high threshold (µg/L), quick-look heuristic.
  static const double _chlorophyllHighThreshold = 25;

  /// Turbidity moderate threshold (NTU), quick-look heuristic.
  static const double _turbidityModerateThreshold = 10;

  /// Turbidity high threshold (NTU), quick-look heuristic.
  static const double _turbidityHighThreshold = 20;

  /// Heuristic qualitative status used for UI surfacing when SYKE does not
  /// provide a direct textual algae class in this feed.
  ///
  /// Thresholds are internal product heuristics for "quick look" guidance:
  /// chlorophyll-a at 10/25 µg/L and turbidity at 10/20 NTU split low,
  /// moderate, and high categories. These thresholds are product defaults and
  /// should be reviewed against domain guidance when formal limits are adopted.
  String? _algaeStatusFromWaterQuality({
    double? chlorophyllA,
    double? turbidity,
  }) {
    if (chlorophyllA == null && turbidity == null) return null;
    if ((chlorophyllA != null && chlorophyllA >= _chlorophyllHighThreshold) ||
        (turbidity != null && turbidity >= _turbidityHighThreshold)) {
      return 'High';
    }
    if ((chlorophyllA != null &&
            chlorophyllA >= _chlorophyllModerateThreshold) ||
        (turbidity != null && turbidity >= _turbidityModerateThreshold)) {
      return 'Moderate';
    }
    return 'Low';
  }

  WaterQualityData _toWaterQualityData(
    WaterQualityReading reading,
    WeatherStation station,
  ) {
    return WaterQualityData(
      sampleDate: reading.sampleTime,
      location: LatLng(station.latitude, station.longitude),
      stationName: station.name,
      temperature: null,
      chlorophyllA: reading.chlorophyllA,
      turbidity: reading.turbidity,
      algaeStatus: _algaeStatusFromWaterQuality(
        chlorophyllA: reading.chlorophyllA,
        turbidity: reading.turbidity,
      ),
      dissolvedOxygen: reading.dissolvedOxygen,
      ph: reading.pH,
    );
  }

  AlgaeData _toAlgaeData(AlgaeReport report, WeatherStation station) {
    return AlgaeData(
      observationTime: report.observationTime,
      location: LatLng(station.latitude, station.longitude),
      speciesName: report.speciesName,
      biomass: report.biomass,
      cellCount: report.cellCount,
      dominantSpecies: report.dominantSpecies,
      riskLevel: _mapAlgaeRisk(report.riskLevel),
    );
  }

  Future<List<T>> _mapWithStations<T, R>({
    required List<R> rows,
    required int Function(R row) stationIdOf,
    required T Function(R row, WeatherStation station) mapper,
  }) async {
    if (rows.isEmpty) return [];
    final stationIds = rows.map(stationIdOf).toSet();
    final stations = await _getStationsByIds(stationIds);
    return rows.where((r) => stations.containsKey(stationIdOf(r))).map((row) {
      final station = stations[stationIdOf(row)]!;
      return mapper(row, station);
    }).toList();
  }

  Stream<List<WaterQualityData>> watchWaterQuality() {
    return _errorHandler.handleStream(
      _dao
          .watchWaterQuality(maxAge: WeatherSyncConstants.waterQualityTtl)
          .asyncMap((readings) async {
            return _mapWithStations(
              rows: readings,
              stationIdOf: (r) => r.stationId,
              mapper: _toWaterQualityData,
            );
          }),
      context: 'watchWaterQuality',
    );
  }

  Stream<List<WaterQualityData>> watchWaterQualityNearest(
    double lat,
    double lon,
  ) {
    return _errorHandler.handleStream(
      _dao
          .watchWaterQualityNearest(
            lat,
            lon,
            maxAge: WeatherSyncConstants.waterQualityTtl,
          )
          .asyncMap((readings) async {
            return _mapWithStations(
              rows: readings,
              stationIdOf: (r) => r.stationId,
              mapper: _toWaterQualityData,
            );
          }),
      context: 'watchWaterQualityNearest',
    );
  }

  // ===========================================================================
  // SYKE ALGAE REPORTS
  // ===========================================================================

  Stream<List<AlgaeData>> watchAlgaeReports() {
    return _errorHandler.handleStream(
      _dao.watchAlgaeReports(maxAge: WeatherSyncConstants.algaeTtl).asyncMap((
        reports,
      ) async {
        return _mapWithStations(
          rows: reports,
          stationIdOf: (r) => r.stationId,
          mapper: _toAlgaeData,
        );
      }),
      context: 'watchAlgaeReports',
    );
  }

  Stream<List<AlgaeData>> watchAlgaeReportsNearest(double lat, double lon) {
    return _errorHandler.handleStream(
      _dao
          .watchAlgaeReportsNearest(
            lat,
            lon,
            maxAge: WeatherSyncConstants.algaeTtl,
          )
          .asyncMap((reports) async {
            return _mapWithStations(
              rows: reports,
              stationIdOf: (r) => r.stationId,
              mapper: _toAlgaeData,
            );
          }),
      context: 'watchAlgaeReportsNearest',
    );
  }

  AlgaeRiskLevel? _mapAlgaeRisk(int? riskLevel) {
    if (riskLevel == null) return null;
    switch (riskLevel) {
      case 0:
        return AlgaeRiskLevel.low;
      case 1:
        return AlgaeRiskLevel.moderate;
      case 2:
        return AlgaeRiskLevel.high;
      case 3:
        return AlgaeRiskLevel.veryHigh;
      default:
        return null;
    }
  }

  /// Run all cleanup tasks
  Future<void> _runCleanup() async {
    await _errorHandler.perform(
      () => _dao.runAllCleanup(WeatherConstants.dataRetention),
      context: '_runCleanup',
    );
  }

  /// Delete all weather data (for testing)
  Future<void> nuke() async {
    await _errorHandler.performTransaction(() async {
      await _db.transaction(() async {
        await _db.delete(_db.weatherObservations).go();
        await _db.delete(_db.weatherForecasts).go();
        await _db.delete(_db.waveObservations).go();
        await _db.delete(_db.seaLevelReadings).go();
        await _db.delete(_db.weatherAlerts).go();
        await _db.delete(_db.lightningStrikes).go();
        await _db.delete(_db.waterQualityReadings).go();
        await _db.delete(_db.algaeReports).go();
        await _db.delete(_db.weatherStations).go();
      });
      _stationByIdCache.clear();
      Log.i('[Store] Nuked all weather data');
    }, context: 'nuke');
  }

  // ===========================================================================
  // SYKE CACHING
  // ===========================================================================

  Future<List<WaterQualityData>> cacheWaterQuality(
    List<WaterQualityDto> data,
  ) async {
    if (data.isEmpty) return <WaterQualityData>[];

    final result = await _errorHandler.perform(() async {
      final providerId = await _getProviderId('syke');

      final companions = <WaterQualityReadingsCompanion>[];
      final stationIds = await _resolveStationsBatch(
        data.map(
          (dto) => (
            name: dto.stationName,
            lat: dto.location.latitude,
            lon: dto.location.longitude,
            type: 'water_quality',
          ),
        ),
      );
      for (final dto in data) {
        final key = _stationKey(
          'water_quality',
          dto.location.latitude,
          dto.location.longitude,
        );
        final stationId = stationIds[key];
        if (stationId == null) continue;

        companions.add(
          WaterQualityReadingsCompanion.insert(
            providerId: providerId,
            stationId: stationId,
            sampleTime: dto.timestamp,
            fetchedAt: DateTime.now(),
            chlorophyllA: Value(dto.chlorophyllA),
            turbidity: Value(dto.turbidity),
            dissolvedOxygen: Value(dto.dissolvedOxygen),
            pH: Value(dto.pH),
          ),
        );
      }

      await _dao.insertWaterQualityBatch(companions);
      await _maybeCleanup();
      return getLastWaterQuality();
    }, context: 'cacheWaterQuality');

    return result.fold((_) => <WaterQualityData>[], (list) => list);
  }

  Future<List<WaterQualityData>> getLastWaterQuality() async {
    final result = await _errorHandler.perform(() async {
      final readings = await _dao.getRecentWaterQuality(
        maxAge: WeatherSyncConstants.waterQualityTtl,
      );
      if (readings.isEmpty) return <WaterQualityData>[];

      final stationIds = readings.map((r) => r.stationId).toSet();
      final stationList = await (_db.select(
        _db.weatherStations,
      )..where((s) => s.id.isIn(stationIds))).get();
      final stations = {for (final s in stationList) s.id: s};

      return readings
          .where((r) => stations.containsKey(r.stationId))
          .map((r) => _toWaterQualityData(r, stations[r.stationId]!))
          .toList();
    }, context: 'getLastWaterQuality');

    return result.fold((_) => [], (data) => data);
  }

  Future<List<AlgaeData>> cacheAlgaeReports(List<AlgaeReportDto> data) async {
    if (data.isEmpty) return <AlgaeData>[];

    final result = await _errorHandler.perform(() async {
      final providerId = await _getProviderId('syke');

      final companions = <AlgaeReportsCompanion>[];
      final stationIds = await _resolveStationsBatch(
        data.map(
          (dto) => (
            name: 'Algae Observation',
            lat: dto.location.latitude,
            lon: dto.location.longitude,
            type: 'algae',
          ),
        ),
      );
      for (final dto in data) {
        final key = _stationKey(
          'algae',
          dto.location.latitude,
          dto.location.longitude,
        );
        final stationId = stationIds[key];
        if (stationId == null) continue;

        companions.add(
          AlgaeReportsCompanion.insert(
            providerId: providerId,
            stationId: stationId,
            observationTime: dto.timestamp,
            fetchedAt: DateTime.now(),
            riskLevel: Value(dto.riskLevel?.index),
            speciesName: Value(dto.speciesName),
            biomass: Value(dto.biomass),
            cellCount: Value(dto.cellCount),
            dominantSpecies: Value(dto.dominantSpecies),
          ),
        );
      }

      await _dao.insertAlgaeBatch(companions);
      await _maybeCleanup();
      return getLastAlgaeReports();
    }, context: 'cacheAlgaeReports');

    return result.fold((_) => <AlgaeData>[], (list) => list);
  }

  Future<List<AlgaeData>> getLastAlgaeReports() async {
    final result = await _errorHandler.perform(() async {
      final reports = await _dao.getRecentAlgaeReports(
        maxAge: WeatherSyncConstants.algaeTtl,
      );
      if (reports.isEmpty) return <AlgaeData>[];

      final stationIds = reports.map((r) => r.stationId).toSet();
      final stationList = await (_db.select(
        _db.weatherStations,
      )..where((s) => s.id.isIn(stationIds))).get();
      final stations = {for (final s in stationList) s.id: s};

      return reports
          .where((r) => stations.containsKey(r.stationId))
          .map((r) => _toAlgaeData(r, stations[r.stationId]!))
          .toList();
    }, context: 'getLastAlgaeReports');

    return result.fold((_) => [], (data) => data);
  }
}
