/// Weather Data Access Object
///
/// Typed DAO for all weather-related database operations.
/// Implements:
/// - Provider priority for conflict resolution
/// - TTL-aware queries via maxAge parameter
/// - Rounded coordinates for station uniqueness
/// - Semantic logging for debugging
library;

import 'dart:async';

import 'package:drift/drift.dart';
import 'package:meta/meta.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/core/db/weather_tables.dart';
import 'package:sakkoja/core/utils/logger.dart';

part 'weather_dao.g.dart';

@DriftAccessor(
  tables: [
    WeatherProviders,
    WeatherStations,
    WeatherObservations,
    WeatherForecasts,
    WaveObservations,
    SeaLevelReadings,
    WeatherAlerts,
    LightningStrikes,
    WaterQualityReadings,
    AlgaeReports,
  ],
)
class WeatherDao extends DatabaseAccessor<AppDatabase> with _$WeatherDaoMixin {
  WeatherDao(super.db);

  static const int _maxReactiveRows = 500;

  /// Recreates a time-sensitive Drift query when its first row expires.
  ///
  /// Drift only re-runs a watch query when a table changes. Freshness and
  /// alert expiry also change with wall-clock time, so this schedules a fresh
  /// query at the next boundary without mutating the database.
  Stream<List<T>> _watchWithExpiry<T>({
    required Stream<List<T>> Function(DateTime now) watch,
    required DateTime Function(T row) expiresAt,
  }) {
    late final StreamController<List<T>> controller;
    StreamSubscription<List<T>>? subscription;
    Timer? timer;
    var cancelled = false;
    late Future<void> Function() startWatch;

    void scheduleRevalidation(List<T> rows) {
      timer?.cancel();
      if (rows.isEmpty || cancelled) return;

      final now = DateTime.now();
      DateTime? nextExpiry;
      for (final row in rows) {
        final expiry = expiresAt(row);
        if (!expiry.isAfter(now)) continue;
        if (nextExpiry == null || expiry.isBefore(nextExpiry)) {
          nextExpiry = expiry;
        }
      }
      if (nextExpiry == null) {
        timer = Timer(Duration.zero, () => unawaited(startWatch()));
        return;
      }

      timer = Timer(
        nextExpiry.difference(now) + const Duration(milliseconds: 1),
        () => unawaited(startWatch()),
      );
    }

    startWatch = () async {
      if (cancelled) return;
      if (subscription != null) {
        await subscription!.cancel();
      }
      if (cancelled) return;
      subscription = watch(DateTime.now()).listen(
        (rows) {
          if (cancelled) return;
          controller.add(rows);
          scheduleRevalidation(rows);
        },
        onError: controller.addError,
      );
    };

    controller = StreamController<List<T>>(
      onListen: () => unawaited(startWatch()),
      onCancel: () async {
        cancelled = true;
        timer?.cancel();
        await subscription?.cancel();
      },
    );
    return controller.stream;
  }

  // ===========================================================================
  // PROVIDER MANAGEMENT
  // ===========================================================================

  /// Get or create a provider by code. Returns provider ID.
  Future<int> getOrCreateProvider(
    String code,
    String name, {
    int priority = 0,
    String? apiVersion,
  }) async {
    return transaction(() async {
      final existing = await (select(
        weatherProviders,
      )..where((p) => p.code.equals(code))).getSingleOrNull();

      if (existing != null) return existing.id;

      await into(weatherProviders).insert(
        WeatherProvidersCompanion.insert(
          code: code,
          name: name,
          priority: Value(priority),
          apiVersion: Value(apiVersion),
        ),
        mode: InsertMode.insertOrIgnore,
      );

      final retry = await (select(
        weatherProviders,
      )..where((p) => p.code.equals(code))).getSingleOrNull();

      if (retry != null) {
        Log.d('[DB] Provider: Resolved $name (id=${retry.id})');
        return retry.id;
      }
      throw StateError('Failed to get or create provider: $code');
    });
  }

  /// Get provider by code
  Future<WeatherProvider?> getProvider(String code) async {
    return (select(
      weatherProviders,
    )..where((p) => p.code.equals(code))).getSingleOrNull();
  }

  /// Get provider priority for conflict resolution
  Future<int> getProviderPriority(int providerId) async {
    final provider = await (select(
      weatherProviders,
    )..where((p) => p.id.equals(providerId))).getSingleOrNull();
    return provider?.priority ?? 0;
  }

  // ===========================================================================
  // STATION MANAGEMENT
  // ===========================================================================

  /// Round coordinate to 4 decimal places (11m precision)
  double _round4(double value) => (value * 10000).round() / 10000;

  /// Round coordinate to 3 decimal places (~110m) for query stabilization
  double _round3(double value) => (value * 1000).round() / 1000;

  /// Get or create a single station. Returns station ID.
  /// Coordinates are rounded to 4dp for consistent uniqueness.
  ///
  /// **CRITICAL**: For all data ingestion and caching loops, NEVER call this method.
  /// Use [getOrCreateStationsBatch] to prevent N+1 queries. This single-row method
  /// is retained exclusively for isolated unit test fixture setups.
  @visibleForTesting
  Future<int> getOrCreateStation({
    required double latitude,
    required double longitude,
    required String stationType,
    String? name,
  }) async {
    final lat4 = _round4(latitude);
    final lon4 = _round4(longitude);

    // Use transaction to prevent race conditions during concurrent inserts
    return transaction(() async {
      final existing =
          await (select(weatherStations)
                ..where(
                  (s) => s.stationType.equals(stationType),
                )
                ..where((s) => s.latitude.equals(lat4))
                ..where((s) => s.longitude.equals(lon4)))
              .getSingleOrNull();

      if (existing != null) return existing.id;

      final id = await into(weatherStations).insert(
        WeatherStationsCompanion.insert(
          name: Value(name),
          latitude: lat4,
          longitude: lon4,
          stationType: stationType,
        ),
        mode: InsertMode.insertOrIgnore,
      );

      if (id > 0) {
        Log.d('[DB] Station: Created "${name ?? 'unnamed'}" at ($lat4, $lon4)');
        return id;
      }

      // Fallback: If insert was ignored (another process beat us), find that record
      final retry =
          await (select(weatherStations)
                ..where(
                  (s) => s.stationType.equals(stationType),
                )
                ..where((s) => s.latitude.equals(lat4))
                ..where((s) => s.longitude.equals(lon4)))
              .getSingleOrNull();

      if (retry != null) return retry.id;
      throw StateError('Failed to get or create station at ($lat4, $lon4)');
    });
  }

  /// Resolve (or create) multiple stations in a single transaction.
  ///
  /// Returns a map keyed by "$type|${lat4}|${lon4}" (same format as
  /// [DriftWeatherStore._stationKey]) to the resolved DB station ID.
  ///
  /// Algorithm (O(1) transactions instead of O(n)):
  /// 1. Deduplicate + round coordinates in memory.
  /// 2. Per unique station type: bulk-SELECT existing rows from a bounding-box
  ///    range that covers all requested coordinates.
  /// 3. Bulk-INSERT only missing stations (insertOrIgnore for concurrency).
  /// 4. Re-SELECT to retrieve IDs for newly inserted rows.
  Future<Map<String, int>> getOrCreateStationsBatch(
    List<({String? name, double lat, double lon, String type})> rows,
  ) async {
    if (rows.isEmpty) return {};

    final stopwatch = Stopwatch()..start();

    return transaction(() async {
      // 1. Deduplicate + round all requested coordinates.
      final deduped =
          <String, ({String? name, double lat4, double lon4, String type})>{};
      for (final row in rows) {
        final lat4 = _round4(row.lat);
        final lon4 = _round4(row.lon);
        final key =
            '${row.type}|${lat4.toStringAsFixed(4)}|${lon4.toStringAsFixed(4)}';
        deduped.putIfAbsent(
          key,
          () => (name: row.name, lat4: lat4, lon4: lon4, type: row.type),
        );
      }

      // 2. Group by station type so we can issue one bounding-box SELECT per type.
      final byType =
          <String, Map<String, ({String? name, double lat4, double lon4})>>{};
      for (final entry in deduped.entries) {
        final v = entry.value;
        byType.putIfAbsent(v.type, () => {})[entry.key] = (
          name: v.name,
          lat4: v.lat4,
          lon4: v.lon4,
        );
      }

      final result = <String, int>{};

      for (final typeEntry in byType.entries) {
        final type = typeEntry.key;
        final coordsByKey = typeEntry.value;
        if (coordsByKey.isEmpty) continue;

        // Compute bounding box for a single range SELECT.
        double minLat = double.infinity;
        double maxLat = double.negativeInfinity;
        double minLon = double.infinity;
        double maxLon = double.negativeInfinity;
        for (final c in coordsByKey.values) {
          if (c.lat4 < minLat) minLat = c.lat4;
          if (c.lat4 > maxLat) maxLat = c.lat4;
          if (c.lon4 < minLon) minLon = c.lon4;
          if (c.lon4 > maxLon) maxLon = c.lon4;
        }

        // 3a. Fetch all existing stations that fall within the bounding box.
        final existing =
            await (select(weatherStations)
                  ..where((s) => s.stationType.equals(type))
                  ..where((s) => s.latitude.isBetweenValues(minLat, maxLat))
                  ..where(
                    (s) => s.longitude.isBetweenValues(minLon, maxLon),
                  ))
                .get();

        // Build coord-key → id lookup (uses rounded 4dp strings).
        final existingByCoord = <String, int>{
          for (final s in existing)
            '${s.latitude.toStringAsFixed(4)}|${s.longitude.toStringAsFixed(4)}':
                s.id,
        };

        // 3b. Separate already-known stations from missing ones.
        final missing =
            <MapEntry<String, ({String? name, double lat4, double lon4})>>[];
        for (final entry in coordsByKey.entries) {
          final coordKey =
              '${entry.value.lat4.toStringAsFixed(4)}|${entry.value.lon4.toStringAsFixed(4)}';
          final id = existingByCoord[coordKey];
          if (id != null) {
            result[entry.key] = id;
          } else {
            missing.add(entry);
          }
        }

        if (missing.isEmpty) continue;

        // 4. Bulk-insert all missing stations in one batch (insertOrIgnore handles
        //    rare concurrent races gracefully).
        await batch((b) {
          for (final m in missing) {
            b.insert(
              weatherStations,
              WeatherStationsCompanion.insert(
                name: Value(m.value.name),
                latitude: m.value.lat4,
                longitude: m.value.lon4,
                stationType: type,
              ),
              mode: InsertMode.insertOrIgnore,
            );
          }
        });

        Log.d(
          '[DB] Station batch: Inserted ${missing.length} new $type stations',
        );

        // 5. Re-SELECT to pick up IDs (handles insertOrIgnore races).
        final requeried =
            await (select(weatherStations)
                  ..where((s) => s.stationType.equals(type))
                  ..where((s) => s.latitude.isBetweenValues(minLat, maxLat))
                  ..where(
                    (s) => s.longitude.isBetweenValues(minLon, maxLon),
                  ))
                .get();

        final requeryMap = <String, int>{
          for (final s in requeried)
            '${s.latitude.toStringAsFixed(4)}|${s.longitude.toStringAsFixed(4)}':
                s.id,
        };

        for (final m in missing) {
          final coordKey =
              '${m.value.lat4.toStringAsFixed(4)}|${m.value.lon4.toStringAsFixed(4)}';
          final id = requeryMap[coordKey];
          if (id != null) {
            result[m.key] = id;
          } else {
            throw StateError(
              'Failed to resolve station $type at '
              '(${m.value.lat4}, ${m.value.lon4})',
            );
          }
        }
      }

      stopwatch.stop();
      Log.d(
        '[DB Metrics] getOrCreateStationsBatch: ${rows.length} requested, '
        '${deduped.length} unique, ${result.length} resolved in ${stopwatch.elapsedMilliseconds}ms',
      );

      return result;
    });
  }

  /// Find nearest station within radius (bounding box approximation)
  Future<WeatherStation?> findNearestStation(
    double lat,
    double lon,
    String stationType, {
    double radiusDegrees = 0.05, // ~5.5km at 60°N
  }) async {
    final stations =
        await (select(weatherStations)
              ..where((s) => s.stationType.equals(stationType))
              ..where(
                (s) => s.latitude.isBetweenValues(
                  lat - radiusDegrees,
                  lat + radiusDegrees,
                ),
              )
              ..where(
                (s) => s.longitude.isBetweenValues(
                  lon - radiusDegrees,
                  lon + radiusDegrees,
                ),
              ))
            .get();

    if (stations.isEmpty) return null;

    // Sort by Manhattan distance (sufficient for bounding box)
    stations.sort((a, b) {
      final distA = (a.latitude - lat).abs() + (a.longitude - lon).abs();
      final distB = (b.latitude - lat).abs() + (b.longitude - lon).abs();
      return distA.compareTo(distB);
    });

    final nearest = stations.first;
    final distKm =
        ((nearest.latitude - lat).abs() + (nearest.longitude - lon).abs()) *
        111;
    Log.d(
      '[DB] Station: Found "${nearest.name ?? 'unnamed'}" ${distKm.toStringAsFixed(1)}km away',
    );
    return nearest;
  }

  // ===========================================================================
  // OBSERVATIONS
  // ===========================================================================

  /// Insert observation batch with provider priority check.
  /// Only inserts/updates if incoming provider priority >= existing.
  /// Helper to get provider priorities
  Future<Map<int, int>> _getProviderPriorities() async {
    final providers = await select(weatherProviders).get();
    return {for (final p in providers) p.id: p.priority};
  }

  /// Insert observation batch with provider priority check.
  ///
  /// Only inserts if incoming provider priority >= existing row priority.
  ///
  /// Performance: Uses O(1) DB queries (1 bulk SELECT + 1 batch INSERT) instead
  /// of O(N) per-station queries. Trade-off: bulk SELECT may fetch more rows than
  /// exact pair lookup, but is still faster than N sequential queries when
  /// station count > 1 (typical case: 5-50 stations per sync cycle).
  Future<int> insertObservationBatch(
    List<WeatherObservationsCompanion> items,
  ) async {
    if (items.isEmpty) return 0;

    final sw = Stopwatch()..start();

    // 1. Get priorities
    final priorities = await _getProviderPriorities();

    // 2. Collect unique station IDs and timestamps for bulk fetch
    final allStationIds = items.map((i) => i.stationId.value).toSet().toList();
    final allTimestamps = items.map((i) => i.timestamp.value).toSet().toList();

    // 3. Fetch all existing rows in ONE query (N+1 fix: was per-station)
    // Note: This fetches cross-product, but is still faster than N queries
    // for typical sync cycles with 5-50 stations.
    final existing =
        await (select(weatherObservations)
              ..where((o) => o.stationId.isIn(allStationIds))
              ..where((o) => o.timestamp.isIn(allTimestamps)))
            .get();

    // 4. Group existing in memory by station (for efficient lookup)
    final existingByStation =
        <int, Map<DateTime, ({int priority, DateTime fetchedAt})>>{};
    for (final e in existing) {
      final stationMap = existingByStation.putIfAbsent(
        e.stationId,
        () => <DateTime, ({int priority, DateTime fetchedAt})>{},
      );
      final existingPrio = priorities[e.providerId] ?? 0;
      final existingEntry = stationMap[e.timestamp];
      if (existingEntry == null || existingPrio > existingEntry.priority) {
        stationMap[e.timestamp] = (
          priority: existingPrio,
          fetchedAt: e.fetchedAt,
        );
      }
    }

    // 5. Filter items in memory (no additional queries)
    final toInsert = <WeatherObservationsCompanion>[];
    var filteredCount = 0;

    for (final item in items) {
      final sId = item.stationId.value;
      final t = item.timestamp.value;
      final newPid = item.providerId.value;
      final newPrio = priorities[newPid] ?? 0;

      final stationMap = existingByStation[sId];
      final existingEntry = stationMap?[t];

      if (existingEntry == null ||
          newPrio >= existingEntry.priority ||
          item.fetchedAt.value.isAfter(existingEntry.fetchedAt)) {
        toInsert.add(item);
      } else {
        filteredCount++;
      }
    }

    if (toInsert.isNotEmpty) {
      await batch((b) {
        for (final item in toInsert) {
          b.insert(weatherObservations, item, mode: InsertMode.insertOrReplace);
        }
      });
    }

    Log.i(
      '[DB] Observations: Batch ${items.length} -> Upserted ${toInsert.length} (Filtered $filteredCount) | ${sw.elapsedMilliseconds}ms',
    );
    return toInsert.length;
  }

  /// Get recent observations for a station within time window.
  /// Deduplicates by returning only the highest priority provider per timestamp.
  Future<List<WeatherObservation>> getRecentObservations(
    int stationId,
    Duration window, {
    Duration? maxAge,
  }) async {
    final timeThreshold = DateTime.now().subtract(window);
    final ageThreshold = maxAge != null
        ? DateTime.now().subtract(maxAge)
        : DateTime.fromMillisecondsSinceEpoch(0);

    // Fetch all candidates
    final rows =
        await (select(weatherObservations)
              ..where((o) => o.stationId.equals(stationId))
              ..where(
                (o) => o.timestamp.isBiggerOrEqualValue(timeThreshold),
              )
              ..where(
                (o) => o.fetchedAt.isBiggerOrEqualValue(ageThreshold),
              )
              ..orderBy([
                (WeatherObservations o) => OrderingTerm.desc(o.timestamp),
              ])
              ..limit(100))
            .get();

    if (rows.isEmpty) return [];

    final priorities = await _getProviderPriorities();
    final bestRows = <DateTime, WeatherObservation>{};

    for (final row in rows) {
      final p = priorities[row.providerId] ?? 0;
      final existing = bestRows[row.timestamp];

      if (existing == null) {
        bestRows[row.timestamp] = row;
      } else {
        final oldP = priorities[existing.providerId] ?? 0;
        if (p > oldP) {
          bestRows[row.timestamp] = row;
        }
      }
    }

    final result = bestRows.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return result;
  }

  /// Watch nearby observations (reactive stream)
  Stream<List<WeatherObservation>> watchNearbyObservations(
    double lat,
    double lon, {
    double radiusDegrees = 0.05,
    Duration? maxAge,
  }) {
    final rLat = _round3(lat);
    final rLon = _round3(lon);

    Stream<List<WeatherObservation>> watchAt(DateTime now) {
      final ageThreshold = maxAge != null
          ? now.subtract(maxAge)
          : DateTime.fromMillisecondsSinceEpoch(0);
      final query =
          select(weatherObservations).join([
              innerJoin(
                weatherStations,
                weatherStations.id.equalsExp(weatherObservations.stationId),
              ),
            ])
            ..where(
              weatherStations.latitude.isBetweenValues(
                rLat - radiusDegrees,
                rLat + radiusDegrees,
              ),
            )
            ..where(
              weatherStations.longitude.isBetweenValues(
                rLon - radiusDegrees,
                rLon + radiusDegrees,
              ),
            )
            ..where(
              weatherObservations.fetchedAt.isBiggerOrEqualValue(ageThreshold),
            )
            ..orderBy([OrderingTerm.desc(weatherObservations.timestamp)])
            ..limit(100);

      return query.watch().map(
        (rows) =>
            rows.map((row) => row.readTable(weatherObservations)).toList(),
      );
    }

    if (maxAge == null) return watchAt(DateTime.now());
    return _watchWithExpiry(
      watch: watchAt,
      expiresAt: (row) => row.fetchedAt.add(maxAge),
    );
  }

  // ===========================================================================
  // FORECASTS
  // ===========================================================================

  /// Watch nearby forecasts (reactive stream)
  Stream<List<WeatherForecast>> watchNearbyForecasts(
    double lat,
    double lon, {
    double radiusDegrees = 0.05,
    Duration? maxAge,
  }) {
    final rLat = _round3(lat);
    final rLon = _round3(lon);

    Stream<List<WeatherForecast>> watchAt(DateTime now) {
      final ageThreshold = maxAge != null
          ? now.subtract(maxAge)
          : DateTime.fromMillisecondsSinceEpoch(0);
      final query =
          select(weatherForecasts).join([
              innerJoin(
                weatherStations,
                weatherStations.id.equalsExp(weatherForecasts.stationId),
              ),
            ])
            ..where(
              weatherStations.latitude.isBetweenValues(
                rLat - radiusDegrees,
                rLat + radiusDegrees,
              ),
            )
            ..where(
              weatherStations.longitude.isBetweenValues(
                rLon - radiusDegrees,
                rLon + radiusDegrees,
              ),
            )
            ..where(weatherForecasts.forecastTime.isBiggerOrEqualValue(now))
            ..where(
              weatherForecasts.fetchedAt.isBiggerOrEqualValue(ageThreshold),
            )
            ..orderBy([OrderingTerm.asc(weatherForecasts.forecastTime)])
            ..limit(100);

      return query.watch().map(
        (rows) => rows.map((row) => row.readTable(weatherForecasts)).toList(),
      );
    }

    DateTime expiresAt(WeatherForecast row) {
      final sourceExpiry = maxAge == null
          ? row.forecastTime
          : row.fetchedAt.add(maxAge);
      return row.forecastTime.isBefore(sourceExpiry)
          ? row.forecastTime
          : sourceExpiry;
    }

    return _watchWithExpiry(watch: watchAt, expiresAt: expiresAt);
  }

  /// Insert forecast batch with provider priority check.
  ///
  /// Only inserts if incoming provider priority >= existing row priority.
  ///
  /// Performance: Uses O(1) DB queries (1 bulk SELECT + 1 batch INSERT) instead
  /// of O(N) per-station queries. Trade-off: bulk SELECT may fetch more rows than
  /// exact pair lookup, but is still faster than N sequential queries when
  /// station count > 1 (typical case: 5-50 stations per sync cycle).
  Future<int> insertForecastBatch(List<WeatherForecastsCompanion> items) async {
    if (items.isEmpty) return 0;

    final sw = Stopwatch()..start();

    // 1. Get priorities
    final priorities = await _getProviderPriorities();

    // 2. Collect unique station IDs and times for bulk fetch
    final allStationIds = items.map((i) => i.stationId.value).toSet().toList();
    final allTimes = items.map((i) => i.forecastTime.value).toSet().toList();

    // 3. Fetch all existing rows in ONE query (N+1 fix: was per-station)
    // Note: This fetches cross-product, but is still faster than N queries
    // for typical sync cycles with 5-50 stations.
    final existing =
        await (select(weatherForecasts)
              ..where((f) => f.stationId.isIn(allStationIds))
              ..where((f) => f.forecastTime.isIn(allTimes)))
            .get();

    // 4. Group existing in memory by station (for efficient lookup)
    // Keep highest priority per timestamp per station
    final existingByStation =
        <int, Map<DateTime, ({int priority, DateTime fetchedAt})>>{};
    for (final e in existing) {
      final stationMap = existingByStation.putIfAbsent(
        e.stationId,
        () => <DateTime, ({int priority, DateTime fetchedAt})>{},
      );
      final prio = priorities[e.providerId] ?? 0;
      final existingEntry = stationMap[e.forecastTime];
      if (existingEntry == null || prio > existingEntry.priority) {
        stationMap[e.forecastTime] = (priority: prio, fetchedAt: e.fetchedAt);
      }
    }

    // 5. Filter items in memory (no additional queries)
    final toInsert = <WeatherForecastsCompanion>[];
    var filteredCount = 0;

    for (final item in items) {
      final sId = item.stationId.value;
      final t = item.forecastTime.value;
      final newPid = item.providerId.value;
      final newPrio = priorities[newPid] ?? 0;

      final stationMap = existingByStation[sId];
      final existingEntry = stationMap?[t];

      // Higher priority data wins, but fresher data overrides lower-prio cached
      if (existingEntry == null ||
          newPrio >= existingEntry.priority ||
          item.fetchedAt.value.isAfter(existingEntry.fetchedAt)) {
        toInsert.add(item);
      } else {
        filteredCount++;
      }
    }

    if (toInsert.isNotEmpty) {
      await batch((b) {
        for (final item in toInsert) {
          b.insert(weatherForecasts, item, mode: InsertMode.insertOrReplace);
        }
      });
    }

    Log.i(
      '[DB] Forecasts: Batch ${items.length} -> Upserted ${toInsert.length} (Filtered $filteredCount) | ${sw.elapsedMilliseconds}ms',
    );
    return toInsert.length;
  }

  /// Get forecasts for a station (future times only)
  Future<List<WeatherForecast>> getForecastsForStation(
    int stationId, {
    Duration? maxAge,
  }) async {
    final now = DateTime.now();
    final ageThreshold = maxAge != null
        ? now.subtract(maxAge)
        : DateTime.fromMillisecondsSinceEpoch(0);

    return (select(weatherForecasts)
          ..where((f) => f.stationId.equals(stationId))
          ..where(
            (f) => f.forecastTime.isBiggerOrEqualValue(now),
          )
          ..where(
            (f) => f.fetchedAt.isBiggerOrEqualValue(ageThreshold),
          )
          ..orderBy([(WeatherForecasts f) => OrderingTerm.asc(f.forecastTime)]))
        .get();
  }

  /// Watch forecasts for a station (reactive)
  Stream<List<WeatherForecast>> watchForecastsForStation(
    int stationId, {
    Duration? maxAge,
  }) {
    Stream<List<WeatherForecast>> watchAt(DateTime now) {
      final ageThreshold = maxAge != null
          ? now.subtract(maxAge)
          : DateTime.fromMillisecondsSinceEpoch(0);

      return (select(weatherForecasts)
            ..where((f) => f.stationId.equals(stationId))
            ..where(
              (f) => f.forecastTime.isBiggerOrEqualValue(now),
            )
            ..where(
              (f) => f.fetchedAt.isBiggerOrEqualValue(ageThreshold),
            )
            ..orderBy([
              (WeatherForecasts f) => OrderingTerm.asc(f.forecastTime),
            ]))
          .watch();
    }

    DateTime expiresAt(WeatherForecast row) {
      final sourceExpiry = maxAge == null
          ? row.forecastTime
          : row.fetchedAt.add(maxAge);
      return row.forecastTime.isBefore(sourceExpiry)
          ? row.forecastTime
          : sourceExpiry;
    }

    return _watchWithExpiry(watch: watchAt, expiresAt: expiresAt);
  }

  // ===========================================================================
  // MARINE DATA (FMI)
  // ===========================================================================

  /// Insert wave observations batch
  Future<int> insertWavesBatch(List<WaveObservationsCompanion> items) async {
    if (items.isEmpty) return 0;

    final sw = Stopwatch()..start();
    var insertedCount = 0;
    await batch((b) {
      for (final item in items) {
        b.insert(waveObservations, item, mode: InsertMode.insertOrReplace);
        insertedCount++;
      }
    });

    Log.i(
      '[DB] Waves: Upserted $insertedCount rows | ${sw.elapsedMilliseconds}ms',
    );
    return insertedCount;
  }

  /// Insert sea level readings batch
  Future<int> insertSeaLevelBatch(List<SeaLevelReadingsCompanion> items) async {
    if (items.isEmpty) return 0;

    final sw = Stopwatch()..start();
    var insertedCount = 0;
    await batch((b) {
      for (final item in items) {
        b.insert(seaLevelReadings, item, mode: InsertMode.insertOrReplace);
        insertedCount++;
      }
    });

    Log.i(
      '[DB] SeaLevel: Upserted $insertedCount rows | ${sw.elapsedMilliseconds}ms',
    );
    return insertedCount;
  }

  /// Watch wave observations (global)
  Stream<List<WaveObservation>> watchWaves({Duration? maxAge}) {
    Stream<List<WaveObservation>> watchAt(DateTime now) {
      final query = select(waveObservations)
        ..orderBy([(w) => OrderingTerm.desc(w.timestamp)])
        ..limit(_maxReactiveRows);
      if (maxAge != null) {
        query.where(
          (w) => w.fetchedAt.isBiggerOrEqualValue(now.subtract(maxAge)),
        );
      }
      return query.watch();
    }

    if (maxAge == null) return watchAt(DateTime.now());
    return _watchWithExpiry(
      watch: watchAt,
      expiresAt: (row) => row.fetchedAt.add(maxAge),
    );
  }

  /// Watch sea level readings (global)
  Stream<List<SeaLevelReading>> watchSeaLevels({Duration? maxAge}) {
    Stream<List<SeaLevelReading>> watchAt(DateTime now) {
      final query = select(seaLevelReadings)
        ..orderBy([(l) => OrderingTerm.desc(l.timestamp)])
        ..limit(_maxReactiveRows);
      if (maxAge != null) {
        query.where(
          (l) => l.fetchedAt.isBiggerOrEqualValue(now.subtract(maxAge)),
        );
      }
      return query.watch();
    }

    if (maxAge == null) return watchAt(DateTime.now());
    return _watchWithExpiry(
      watch: watchAt,
      expiresAt: (row) => row.fetchedAt.add(maxAge),
    );
  }

  /// Watch wave observations sorted by distance to target (nearest first)
  Stream<List<WaveObservation>> watchWavesNearest(
    double lat,
    double lon, {
    Duration? maxAge,
  }) {
    // Squared Euclidean distance approximation for sorting: (lat-tLat)^2 + (lon-tLon)^2
    // Sufficient for "nearest" ordering without expensive trig functions
    final latDiff = weatherStations.latitude - Variable(lat);
    final lonDiff = weatherStations.longitude - Variable(lon);
    final distSq = latDiff * latDiff + lonDiff * lonDiff;

    Stream<List<WaveObservation>> watchAt(DateTime now) {
      final query =
          select(waveObservations).join([
              innerJoin(
                weatherStations,
                weatherStations.id.equalsExp(waveObservations.stationId),
              ),
            ])
            ..orderBy([OrderingTerm.asc(distSq)])
            ..limit(_maxReactiveRows);
      if (maxAge != null) {
        query.where(
          waveObservations.fetchedAt.isBiggerOrEqualValue(now.subtract(maxAge)),
        );
      }
      return query.watch().map(
        (rows) => rows.map((row) => row.readTable(waveObservations)).toList(),
      );
    }

    if (maxAge == null) return watchAt(DateTime.now());
    return _watchWithExpiry(
      watch: watchAt,
      expiresAt: (row) => row.fetchedAt.add(maxAge),
    );
  }

  /// Watch sea level readings sorted by distance to target (nearest first)
  Stream<List<SeaLevelReading>> watchSeaLevelsNearest(
    double lat,
    double lon, {
    Duration? maxAge,
  }) {
    final latDiff = weatherStations.latitude - Variable(lat);
    final lonDiff = weatherStations.longitude - Variable(lon);
    final distSq = latDiff * latDiff + lonDiff * lonDiff;

    Stream<List<SeaLevelReading>> watchAt(DateTime now) {
      final query =
          select(seaLevelReadings).join([
              innerJoin(
                weatherStations,
                weatherStations.id.equalsExp(seaLevelReadings.stationId),
              ),
            ])
            ..orderBy([OrderingTerm.asc(distSq)])
            ..limit(_maxReactiveRows);
      if (maxAge != null) {
        query.where(
          seaLevelReadings.fetchedAt.isBiggerOrEqualValue(
            now.subtract(maxAge),
          ),
        );
      }
      return query.watch().map(
        (rows) => rows.map((row) => row.readTable(seaLevelReadings)).toList(),
      );
    }

    if (maxAge == null) return watchAt(DateTime.now());
    return _watchWithExpiry(
      watch: watchAt,
      expiresAt: (row) => row.fetchedAt.add(maxAge),
    );
  }

  // ===========================================================================
  // ALERTS
  // ===========================================================================

  /// Insert or update alerts (by externalId)
  Future<int> upsertAlerts(List<WeatherAlertsCompanion> items) async {
    if (items.isEmpty) return 0;

    final sw = Stopwatch()..start();
    await batch((b) {
      for (final item in items) {
        // Use insertOrReplace so updated alerts overwrite stale ones
        b.insert(weatherAlerts, item, mode: InsertMode.insertOrReplace);
      }
    });

    Log.i(
      '[DB] Alerts: Upserted ${items.length} | ${sw.elapsedMilliseconds}ms',
    );
    return items.length;
  }

  /// Get active (non-expired) alerts
  Future<List<WeatherAlert>> getActiveAlerts() async {
    final now = DateTime.now();
    return (select(weatherAlerts)
          ..where((a) => a.expires.isBiggerOrEqualValue(now))
          ..orderBy([(WeatherAlerts a) => OrderingTerm.asc(a.onset)]))
        .get();
  }

  /// Watch active (non-expired) alerts (reactive)
  Stream<List<WeatherAlert>> watchActiveAlerts() {
    Stream<List<WeatherAlert>> watchAt(DateTime now) {
      return (select(weatherAlerts)
            ..where((a) => a.expires.isBiggerOrEqualValue(now))
            ..orderBy([(WeatherAlerts a) => OrderingTerm.asc(a.onset)]))
          .watch();
    }

    return _watchWithExpiry(
      watch: watchAt,
      expiresAt: (alert) => alert.expires,
    );
  }

  // ===========================================================================
  // LIGHTNING
  // ===========================================================================

  /// Insert lightning strikes batch
  Future<int> insertLightningBatch(
    List<LightningStrikesCompanion> items,
  ) async {
    if (items.isEmpty) return 0;

    final sw = Stopwatch()..start();
    await batch((b) {
      for (final item in items) {
        b.insert(lightningStrikes, item, mode: InsertMode.insertOrReplace);
      }
    });

    Log.i(
      '[DB] Lightning: Upserted ${items.length} strikes | ${sw.elapsedMilliseconds}ms',
    );
    return items.length;
  }

  /// Get recent lightning strikes
  Future<List<LightningStrike>> getRecentLightning(Duration window) async {
    final threshold = DateTime.now().subtract(window);
    return (select(lightningStrikes)
          ..where(
            (l) => l.strikeTime.isBiggerOrEqualValue(threshold),
          )
          ..orderBy([(LightningStrikes l) => OrderingTerm.desc(l.strikeTime)])
          ..limit(500))
        .get();
  }

  /// Watch recent lightning strikes (reactive)
  Stream<List<LightningStrike>> watchRecentLightning(Duration window) {
    Stream<List<LightningStrike>> watchAt(DateTime now) {
      final threshold = now.subtract(window);
      return (select(lightningStrikes)
            ..where(
              (l) => l.strikeTime.isBiggerOrEqualValue(threshold),
            )
            ..orderBy([(LightningStrikes l) => OrderingTerm.desc(l.strikeTime)])
            ..limit(_maxReactiveRows))
          .watch();
    }

    return _watchWithExpiry(
      watch: watchAt,
      expiresAt: (strike) => strike.strikeTime.add(window),
    );
  }

  // ===========================================================================
  // SYKE DATA (Water Quality & Algae)
  // ===========================================================================

  /// Insert water quality readings batch
  Future<int> insertWaterQualityBatch(
    List<WaterQualityReadingsCompanion> items,
  ) async {
    if (items.isEmpty) return 0;

    final sw = Stopwatch()..start();
    var insertedCount = 0;
    await batch((b) {
      for (final item in items) {
        b.insert(
          waterQualityReadings,
          item,
          mode: InsertMode.insertOrReplace,
        );
        insertedCount++;
      }
    });

    Log.i(
      '[DB] WaterQuality: Upserted $insertedCount rows | ${sw.elapsedMilliseconds}ms',
    );
    return insertedCount;
  }

  /// Insert algae reports batch
  Future<int> insertAlgaeBatch(List<AlgaeReportsCompanion> items) async {
    if (items.isEmpty) return 0;

    final sw = Stopwatch()..start();
    var insertedCount = 0;
    await batch((b) {
      for (final item in items) {
        b.insert(algaeReports, item, mode: InsertMode.insertOrReplace);
        insertedCount++;
      }
    });

    Log.i(
      '[DB] Algae: Upserted $insertedCount rows | ${sw.elapsedMilliseconds}ms',
    );
    return insertedCount;
  }

  /// Watch all water quality readings
  Stream<List<WaterQualityReading>> watchWaterQuality({Duration? maxAge}) {
    Stream<List<WaterQualityReading>> watchAt(DateTime now) {
      final query = select(waterQualityReadings)
        ..orderBy([(w) => OrderingTerm.desc(w.sampleTime)])
        ..limit(_maxReactiveRows);
      if (maxAge != null) {
        query.where(
          (w) => w.fetchedAt.isBiggerOrEqualValue(now.subtract(maxAge)),
        );
      }
      return query.watch();
    }

    if (maxAge == null) return watchAt(DateTime.now());
    return _watchWithExpiry(
      watch: watchAt,
      expiresAt: (reading) => reading.fetchedAt.add(maxAge),
    );
  }

  /// Watch water quality readings sorted by distance
  Stream<List<WaterQualityReading>> watchWaterQualityNearest(
    double lat,
    double lon, {
    Duration? maxAge,
  }) {
    final latDiff = weatherStations.latitude - Variable(lat);
    final lonDiff = weatherStations.longitude - Variable(lon);
    final distSq = latDiff * latDiff + lonDiff * lonDiff;

    Stream<List<WaterQualityReading>> watchAt(DateTime now) {
      final query =
          select(waterQualityReadings).join([
              innerJoin(
                weatherStations,
                weatherStations.id.equalsExp(waterQualityReadings.stationId),
              ),
            ])
            ..orderBy([OrderingTerm.asc(distSq)])
            ..limit(_maxReactiveRows);
      if (maxAge != null) {
        query.where(
          waterQualityReadings.fetchedAt.isBiggerOrEqualValue(
            now.subtract(maxAge),
          ),
        );
      }
      return query.watch().map(
        (rows) =>
            rows.map((row) => row.readTable(waterQualityReadings)).toList(),
      );
    }

    if (maxAge == null) return watchAt(DateTime.now());
    return _watchWithExpiry(
      watch: watchAt,
      expiresAt: (reading) => reading.fetchedAt.add(maxAge),
    );
  }

  /// Watch all algae reports
  Stream<List<AlgaeReport>> watchAlgaeReports({Duration? maxAge}) {
    Stream<List<AlgaeReport>> watchAt(DateTime now) {
      final query = select(algaeReports)
        ..orderBy([(a) => OrderingTerm.desc(a.observationTime)])
        ..limit(_maxReactiveRows);
      if (maxAge != null) {
        query.where(
          (a) => a.fetchedAt.isBiggerOrEqualValue(now.subtract(maxAge)),
        );
      }
      return query.watch();
    }

    if (maxAge == null) return watchAt(DateTime.now());
    return _watchWithExpiry(
      watch: watchAt,
      expiresAt: (report) => report.fetchedAt.add(maxAge),
    );
  }

  /// Watch algae reports sorted by distance
  Stream<List<AlgaeReport>> watchAlgaeReportsNearest(
    double lat,
    double lon, {
    Duration? maxAge,
  }) {
    final latDiff = weatherStations.latitude - Variable(lat);
    final lonDiff = weatherStations.longitude - Variable(lon);
    final distSq = latDiff * latDiff + lonDiff * lonDiff;

    Stream<List<AlgaeReport>> watchAt(DateTime now) {
      final query =
          select(algaeReports).join([
              innerJoin(
                weatherStations,
                weatherStations.id.equalsExp(algaeReports.stationId),
              ),
            ])
            ..orderBy([OrderingTerm.asc(distSq)])
            ..limit(_maxReactiveRows);
      if (maxAge != null) {
        query.where(
          algaeReports.fetchedAt.isBiggerOrEqualValue(now.subtract(maxAge)),
        );
      }
      return query.watch().map(
        (rows) => rows.map((row) => row.readTable(algaeReports)).toList(),
      );
    }

    if (maxAge == null) return watchAt(DateTime.now());
    return _watchWithExpiry(
      watch: watchAt,
      expiresAt: (report) => report.fetchedAt.add(maxAge),
    );
  }

  /// Get recent water quality readings
  Future<List<WaterQualityReading>> getRecentWaterQuality({
    Duration? maxAge,
  }) async {
    final query = select(waterQualityReadings)
      ..orderBy([
        (w) => OrderingTerm.desc(w.sampleTime),
      ])
      ..limit(500);
    if (maxAge != null) {
      final cutoff = DateTime.now().subtract(maxAge);
      query.where((w) => w.fetchedAt.isBiggerThanValue(cutoff));
    }
    return query.get();
  }

  /// Get recent algae reports
  Future<List<AlgaeReport>> getRecentAlgaeReports({
    Duration? maxAge,
  }) async {
    final query = select(algaeReports)
      ..orderBy([
        (a) => OrderingTerm.desc(a.observationTime),
      ])
      ..limit(500);
    if (maxAge != null) {
      final cutoff = DateTime.now().subtract(maxAge);
      query.where((a) => a.fetchedAt.isBiggerThanValue(cutoff));
    }
    return query.get();
  }

  /// Cleanup old water quality data (30 days retention)
  Future<int> cleanupOldWaterQuality() async {
    final sw = Stopwatch()..start();
    final threshold = DateTime.now().subtract(const Duration(days: 30));
    final count =
        await (delete(waterQualityReadings)..where(
              (w) => w.sampleTime.isSmallerThanValue(threshold),
            ))
            .go();
    if (count > 0) {
      Log.i(
        '[DB] Cleanup: Removed $count water quality readings | ${sw.elapsedMilliseconds}ms',
      );
    }
    return count;
  }

  /// Cleanup old algae reports (30 days retention)
  Future<int> cleanupOldAlgaeReports() async {
    final sw = Stopwatch()..start();
    final threshold = DateTime.now().subtract(const Duration(days: 30));
    final count =
        await (delete(algaeReports)..where(
              (a) => a.observationTime.isSmallerThanValue(threshold),
            ))
            .go();
    if (count > 0) {
      Log.i(
        '[DB] Cleanup: Removed $count algae reports | ${sw.elapsedMilliseconds}ms',
      );
    }
    return count;
  }

  // ===========================================================================
  // CLEANUP
  // ===========================================================================

  /// Cleanup old observations
  Future<int> cleanupOldObservations(Duration retention) async {
    final sw = Stopwatch()..start();
    final threshold = DateTime.now().subtract(retention);
    final count =
        await (delete(weatherObservations)..where(
              (o) => o.fetchedAt.isSmallerThanValue(threshold),
            ))
            .go();
    if (count > 0) {
      Log.i(
        '[DB] Cleanup: Removed $count observations | ${sw.elapsedMilliseconds}ms',
      );
    }
    return count;
  }

  /// Cleanup old forecasts
  Future<int> cleanupOldForecasts(Duration retention) async {
    final sw = Stopwatch()..start();
    final threshold = DateTime.now().subtract(retention);
    final count =
        await (delete(weatherForecasts)..where(
              (f) => f.fetchedAt.isSmallerThanValue(threshold),
            ))
            .go();
    if (count > 0) {
      Log.i(
        '[DB] Cleanup: Removed $count forecasts | ${sw.elapsedMilliseconds}ms',
      );
    }
    return count;
  }

  /// Cleanup old lightning (uses table's retention constant)
  Future<int> cleanupOldLightning() async {
    final sw = Stopwatch()..start();
    final threshold = DateTime.now().subtract(LightningStrikes.retention);
    final count =
        await (delete(lightningStrikes)..where(
              (l) => l.strikeTime.isSmallerThanValue(threshold),
            ))
            .go();
    if (count > 0) {
      Log.i(
        '[DB] Cleanup: Removed $count lightning strikes | ${sw.elapsedMilliseconds}ms',
      );
    }
    return count;
  }

  /// Cleanup expired alerts
  Future<int> cleanupExpiredAlerts() async {
    final sw = Stopwatch()..start();
    final now = DateTime.now();
    final count = await (delete(
      weatherAlerts,
    )..where((a) => a.expires.isSmallerThanValue(now))).go();
    if (count > 0) {
      Log.i(
        '[DB] Cleanup: Removed $count expired alerts | ${sw.elapsedMilliseconds}ms',
      );
    }
    return count;
  }

  /// Run all cleanup tasks
  Future<void> runAllCleanup(Duration dataRetention) async {
    await cleanupOldObservations(dataRetention);
    await cleanupOldForecasts(dataRetention);
    await cleanupOldLightning();
    await cleanupExpiredAlerts();
    await cleanupOldWaterQuality();
    await cleanupOldAlgaeReports();
  }
}
