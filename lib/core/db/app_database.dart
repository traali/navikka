import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:sakkoja/core/db/daos/tile_dao.dart';
import 'package:sakkoja/core/db/daos/weather_dao.dart';
import 'package:sakkoja/core/db/tile_tables.dart';
import 'package:sakkoja/core/db/track_tables.dart';
import 'package:sakkoja/core/db/weather_tables.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/ai/data/daos/skipper_settings_dao.dart';
import 'package:sakkoja/features/ai/data/tables/skipper_settings_table.dart';
import 'package:sakkoja/features/contribution/domain/entities/user_contribution.dart';
import 'package:sakkoja/features/navigation/data/daos/route_dao.dart';
import 'package:sakkoja/features/navigation/data/tables.dart';
import 'package:sakkoja/features/vessel/data/daos/vessel_dao.dart';
import 'package:sakkoja/features/vessel/data/tables.dart';

part 'app_database.g.dart';

/// Table to store user's fish catches.
@DataClassName('Catch')
class Catches extends Table {
  TextColumn get id => text()();
  TextColumn get species => text()();
  IntColumn get timestampMs => integer()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  IntColumn get weightGrams => integer().nullable()();
  RealColumn get lengthCm => real().nullable()();
  TextColumn get lure => text().nullable()();
  TextColumn get method => text().nullable()();
  TextColumn get notes => text().nullable()();
  RealColumn get weatherTemp => real().nullable()();
  RealColumn get weatherWindSpeed => real().nullable()();
  RealColumn get weatherWindDir => real().nullable()();
  TextColumn get weatherDesc => text().nullable()();
  TextColumn get weatherIcon => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table to store user contributions (radar/speed limit reports).
@DataClassName('UserContributionEntry')
class UserContributions extends Table {
  TextColumn get id => text()();
  IntColumn get type => intEnum<ContributionType>()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  TextColumn get value => text()();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Generic table for caching GeoJSON features or other large lists.
class CachedFeatures extends Table {
  TextColumn get id => text()();
  TextColumn get category =>
      text()(); // 'fishing_restriction', 'waterway_feature', etc.
  DateTimeColumn get cachedAt => dateTime()();
  TextColumn get dataJson => text()();

  @override
  Set<Column> get primaryKey => {id, category};
}

@DriftDatabase(
  tables: [
    // Core app tables
    Catches,
    UserContributions,
    CachedFeatures,
    // Weather tables (from weather_tables.dart)
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
    // Offline map tables
    MarineMapTiles,
    OfflineRegions,
    RegionTileRefs,
    // Navigation & Vessel tables (Phase 1 Boating Core)
    Routes,
    Waypoints,
    VesselProfiles,
    // AI tables
    SkipperSettingsTable,
    // Track tables
    RecordedTracks,
    TrackPoints,
  ],
  daos: [WeatherDao, TileDao, RouteDao, VesselDao, SkipperSettingsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openAppDatabaseConnection());

  @override
  int get schemaVersion => 18;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _seedProviders();
      await _createIndices();
      Log.i('[DB] Created fresh database with weather tables v3');
    },
    onUpgrade: (m, from, to) async {
      if (from < 5) {
        // Clean slate migration for old versions
        Log.i('[DB] Migrating from v$from to v$to - clean slate');
        await _dropOldTables();
        await m.createAll();
        await _seedProviders();
        await _createIndices();
        return;
      }

      if (from < 6) {
        Log.i('[DB] Migrating to v6 - adding user_contributions table');
        await m.createTable(userContributions);
      }

      if (from < 7) {
        Log.i('[DB] Migrating to v7 - adding offline map tables');
        await m.createTable(marineMapTiles);
        await m.createTable(offlineRegions);
        await m.createTable(regionTileRefs);
      }

      if (from < 8) {
        // Incremental migration for v7 -> v8 (Phase 1 Boating Core)
        Log.i('[DB] Migrating from v7 to v8 - adding navigation tables');
        await m.createTable(routes);
        await m.createTable(waypoints);
        await m.createTable(vesselProfiles);
      }

      if (from < 9) {
        // Incremental migration for v8 -> v9 (Virtual Skipper)
        Log.i('[DB] Migrating from v8 to v9 - adding skipper_settings_table');
        await m.createTable(skipperSettingsTable);
      }

      if (from < 10) {
        // Incremental migration for v9 -> v10 (Safety & AI)
        Log.i(
          '[DB] Migrating from v9 to v10 - '
          'adding hasAcknowledgedAISafety column',
        );
        if (from >= 9) {
          await m.addColumn(
            skipperSettingsTable,
            skipperSettingsTable.hasAcknowledgedAISafety,
          );
        }
      }

      if (from < 11) {
        Log.i(
          '[DB] Migrating to v11 - '
          'recreating map tile tables with sourceId support',
        );
        await m.deleteTable('marine_map_tiles');
        await m.deleteTable('region_tile_refs');
        await m.createTable(marineMapTiles);
        await m.createTable(regionTileRefs);
      }

      if (from < 13) {
        Log.i(
          '[DB] Migrating to v13 - expanding station_type CHECK constraint '
          'to include water_quality and algae',
        );
        await m.alterTable(TableMigration(weatherStations));
      }

      if (from < 12) {
        Log.i(
          '[DB] Migrating to v12 - ensuring SYKE water quality and algae tables exist',
        );

        final tableRows = await customSelect(
          "SELECT name FROM sqlite_master WHERE type='table' AND "
          "(name='water_quality_readings' OR name='algae_reports')",
        ).get();
        final existingTables = tableRows
            .map((r) => r.read<String>('name'))
            .toSet();

        if (!existingTables.contains('water_quality_readings')) {
          await m.createTable(waterQualityReadings);
        } else {
          try {
            await m.addColumn(
              waterQualityReadings,
              waterQualityReadings.providerId,
            );
          } on Exception catch (_) {
            Log.d(
              '[DB] Column provider_id might already exist in '
              'water_quality_readings',
            );
          }
        }

        if (!existingTables.contains('algae_reports')) {
          await m.createTable(algaeReports);
        } else {
          try {
            await m.addColumn(algaeReports, algaeReports.providerId);
          } on Exception catch (_) {
            Log.d(
              '[DB] Column provider_id might already exist in algae_reports',
            );
          }
        }

        await customStatement(
          'INSERT OR IGNORE INTO weather_providers '
          '(code, name, priority, api_version, is_active) '
          "VALUES ('syke', 'SYKE', 8, '4.0', 1)",
        );

        await customStatement(
          'UPDATE water_quality_readings SET provider_id = '
          "(SELECT id FROM weather_providers WHERE code = 'syke') "
          'WHERE provider_id IS NULL',
        );
        await customStatement(
          'UPDATE algae_reports SET provider_id = '
          "(SELECT id FROM weather_providers WHERE code = 'syke') "
          'WHERE provider_id IS NULL',
        );
      }

      if (from < 14) {
        Log.i('[DB] Migrating to v14 - adding track recording tables');
        await m.createTable(recordedTracks);
        await m.createTable(trackPoints);
      }

      if (from < 15) {
        Log.i(
          '[DB] Migrating to v15 - '
          'adding AI explanation config columns to skipper_settings',
        );
        await m.addColumn(
          skipperSettingsTable,
          skipperSettingsTable.aiApiKey,
        );
        await m.addColumn(
          skipperSettingsTable,
          skipperSettingsTable.aiModelId,
        );
      }

      if (from < 16) {
        Log.i(
          '[DB] Migrating to v16 - '
          'adding weather columns to catches',
        );
        await m.addColumn(catches, catches.weatherTemp);
        await m.addColumn(catches, catches.weatherWindSpeed);
        await m.addColumn(catches, catches.weatherWindDir);
        await m.addColumn(catches, catches.weatherDesc);
        await m.addColumn(catches, catches.weatherIcon);
      }

      if (from < 17) {
        Log.i('[DB] Migrating to v17 - creating performance indices');
      }

      if (from < 18) {
        Log.i(
          '[DB] Migrating to v18 - '
          'adding engine and VIN/HIN columns to vessel_profiles',
        );
        await m.addColumn(vesselProfiles, vesselProfiles.hinCode);
        await m.addColumn(vesselProfiles, vesselProfiles.engineManufacturer);
        await m.addColumn(vesselProfiles, vesselProfiles.engineModel);
        await m.addColumn(vesselProfiles, vesselProfiles.fuelType);
      }

      await _createIndices();
    },
    beforeOpen: (details) async {
      // Enable foreign keys (SQLite requires this)
      await customStatement('PRAGMA foreign_keys = ON');
      // Enable WAL mode for concurrent read/write (essential for background downloads)
      await customStatement('PRAGMA journal_mode = WAL');
    },
  );

  Future<void> _dropOldTables() async {
    Log.i('[DB] Dropping all tables for fresh start');
    await customStatement('DROP TABLE IF EXISTS weather_items');
    await customStatement('DROP INDEX IF EXISTS idx_weather_spatial');
    await customStatement('DROP TABLE IF EXISTS weather_providers');
    await customStatement('DROP TABLE IF EXISTS weather_stations');
    await customStatement('DROP TABLE IF EXISTS weather_observations');
    await customStatement('DROP TABLE IF EXISTS weather_forecasts');
    await customStatement('DROP TABLE IF EXISTS wave_observations');
    await customStatement('DROP TABLE IF EXISTS sea_level_readings');
    await customStatement('DROP TABLE IF EXISTS weather_alerts');
    await customStatement('DROP TABLE IF EXISTS lightning_strikes');
    await customStatement('DROP TABLE IF EXISTS catches');
    await customStatement('DROP TABLE IF EXISTS cached_features');
    await customStatement('DROP TABLE IF EXISTS user_contributions');
  }

  /// Seed initial weather providers
  Future<void> _seedProviders() async {
    await batch((b) {
      b.insert(
        weatherProviders,
        WeatherProvidersCompanion.insert(
          code: 'fmi',
          name: 'FMI Open Data',
          priority: const Value(10),
          apiVersion: const Value('1.0'),
        ),
      );
      b.insert(
        weatherProviders,
        WeatherProvidersCompanion.insert(
          code: 'openweather',
          name: 'OpenWeather',
          priority: const Value(3),
          apiVersion: const Value('2.5'),
        ),
      );
      b.insert(
        weatherProviders,
        WeatherProvidersCompanion.insert(
          code: 'met_no',
          name: 'MET Norway',
          priority: const Value(5),
          apiVersion: const Value('2.0'),
        ),
      );
    });
    Log.d('[DB] Seeded 3 weather providers (FMI, OpenWeather, MET Norway)');
  }

  /// Create performance indices
  Future<void> _createIndices() async {
    // Observation queries by station and time
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_obs_station_time 
      ON weather_observations(station_id, timestamp DESC)
    ''');

    // Station spatial lookups
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_stations_location 
      ON weather_stations(latitude, longitude)
    ''');
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_stations_type 
      ON weather_stations(station_type)
    ''');

    // Forecast queries
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_forecast_composite 
      ON weather_forecasts(station_id, forecast_time, issued_at DESC)
    ''');

    // Lightning spatiotemporal
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_lightning_time 
      ON lightning_strikes(strike_time DESC)
    ''');
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_lightning_location 
      ON lightning_strikes(latitude, longitude)
    ''');

    // Alert management
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_alerts_expires 
      ON weather_alerts(expires)
    ''');

    // Cleanup operations (fetched_at based)
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_obs_fetched 
      ON weather_observations(fetched_at)
    ''');
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_forecast_fetched 
      ON weather_forecasts(fetched_at)
    ''');
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_waves_fetched 
      ON wave_observations(fetched_at)
    ''');
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_sealevel_fetched 
      ON sea_level_readings(fetched_at)
    ''');
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_lightning_fetched 
      ON lightning_strikes(fetched_at)
    ''');

    // Tile & Region indices
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_tiles_lru 
      ON marine_map_tiles(ref_count, last_accessed ASC)
    ''');
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_region_tile_refs_lookup 
      ON region_tile_refs(zoom, x, y, source_id)
    ''');

    // Track points index
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_track_points_track_time 
      ON track_points(track_id, timestamp DESC)
    ''');

    // Water quality & Algae indices
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_water_quality_station_time 
      ON water_quality_readings(station_id, sample_time DESC)
    ''');
    await customStatement('''
      CREATE INDEX IF NOT EXISTS idx_algae_station_time 
      ON algae_reports(station_id, observation_time DESC)
    ''');

    Log.d('[DB] Created performance indices');
  }
}

QueryExecutor _openAppDatabaseConnection() {
  return driftDatabase(
    name: 'app_drift_db',
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
    ),
  );
}
