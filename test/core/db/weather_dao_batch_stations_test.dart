/// Unit tests for WeatherDao.getOrCreateStationsBatch
///
/// Covers:
/// - Empty input returns empty map
/// - Single station created and its key is returned
/// - Duplicate coordinates deduplicated (one DB row, one key)
/// - Mixed station types stay isolated (no cross-type collision)
/// - Null names are accepted
/// - All stations already existing — no INSERT, just lookup
/// - Concurrent calls don't corrupt results (insertOrIgnore safety)
library;

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/core/db/daos/weather_dao.dart';

AppDatabase _makeDb() => AppDatabase(NativeDatabase.memory());

/// Build the key string the same way DriftWeatherStore._stationKey does.
String _key(String type, double lat, double lon) {
  final lat4 = (lat * 10000).round() / 10000;
  final lon4 = (lon * 10000).round() / 10000;
  return '$type|${lat4.toStringAsFixed(4)}|${lon4.toStringAsFixed(4)}';
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WeatherDao.getOrCreateStationsBatch', () {
    late AppDatabase db;
    late WeatherDao dao;

    setUp(() {
      db = _makeDb();
      dao = db.weatherDao;
    });

    tearDown(() async {
      await db.close();
    });

    // ------------------------------------------------------------------
    test('empty input returns empty map', () async {
      final result = await dao.getOrCreateStationsBatch([]);
      expect(result, isEmpty);
    });

    // ------------------------------------------------------------------
    test('single station is created and its key is returned', () async {
      const lat = 60.1234;
      const lon = 24.5678;
      const type = 'buoy';

      final result = await dao.getOrCreateStationsBatch([
        (name: 'Test Buoy', lat: lat, lon: lon, type: type),
      ]);

      final key = _key(type, lat, lon);
      expect(result.containsKey(key), isTrue);
      expect(result[key], isPositive);
    });

    // ------------------------------------------------------------------
    test('duplicate coordinate rows deduplicate to one DB row', () async {
      const lat = 60.1234;
      const lon = 24.5678;
      const type = 'weather';

      final result = await dao.getOrCreateStationsBatch([
        (name: 'Station A', lat: lat, lon: lon, type: type),
        (name: 'Station A duplicate', lat: lat, lon: lon, type: type),
      ]);

      // Only one key (deduped)
      expect(result.length, 1);

      // Verify only one row was written to the DB
      final rows = await (db.select(
        db.weatherStations,
      )..where((s) => s.stationType.equals(type))).get();
      expect(rows.length, 1);
    });

    // ------------------------------------------------------------------
    test('coordinates rounded to 4dp before dedup', () async {
      // These two coords differ only past 4dp — should collapse to one station
      const lat1 = 60.12341;
      const lat2 = 60.12344; // rounds to same 60.1234 as lat1
      const lon = 24.5678;
      const type = 'mareograph';

      final result = await dao.getOrCreateStationsBatch([
        (name: 'A', lat: lat1, lon: lon, type: type),
        (name: 'B', lat: lat2, lon: lon, type: type),
      ]);

      expect(result.length, 1);
    });

    // ------------------------------------------------------------------
    test(
      'mixed station types are isolated — no cross-type collision',
      () async {
        const lat = 61.0;
        const lon = 25.0;

        final result = await dao.getOrCreateStationsBatch([
          (name: 'Buoy', lat: lat, lon: lon, type: 'buoy'),
          (name: 'Weather', lat: lat, lon: lon, type: 'weather'),
          (name: 'Algae', lat: lat, lon: lon, type: 'algae'),
        ]);

        // Three distinct keys (same coords, different types)
        expect(result.length, 3);

        // All IDs are distinct
        final ids = result.values.toSet();
        expect(ids.length, 3);
      },
    );

    // ------------------------------------------------------------------
    test('null name is accepted', () async {
      final result = await dao.getOrCreateStationsBatch([
        (name: null, lat: 62.0, lon: 26.0, type: 'water_quality'),
      ]);

      expect(result.length, 1);
      expect(result.values.first, isPositive);
    });

    // ------------------------------------------------------------------
    test('pre-existing stations are looked up without INSERT', () async {
      const lat = 63.0;
      const lon = 27.0;
      const type = 'buoy';

      // Create the station via the regular single-station method first
      final existingId = await dao.getOrCreateStation(
        latitude: lat,
        longitude: lon,
        stationType: type,
        name: 'Pre-existing',
      );

      // Now call batch — should return the same ID, not create a duplicate
      final result = await dao.getOrCreateStationsBatch([
        (name: 'Pre-existing', lat: lat, lon: lon, type: type),
      ]);

      expect(result.values.first, equals(existingId));

      // Still only one row
      final rows = await (db.select(
        db.weatherStations,
      )..where((s) => s.stationType.equals(type))).get();
      expect(rows.length, 1);
    });

    // ------------------------------------------------------------------
    test('mix of existing and new stations returns correct IDs', () async {
      const type = 'weather';

      final existingId = await dao.getOrCreateStation(
        latitude: 64.0,
        longitude: 28.0,
        stationType: type,
        name: 'Existing',
      );

      final result = await dao.getOrCreateStationsBatch([
        (name: 'Existing', lat: 64.0, lon: 28.0, type: type), // pre-existing
        (name: 'New', lat: 64.1, lon: 28.1, type: type), // new
      ]);

      expect(result.length, 2);
      expect(result[_key(type, 64.0, 28.0)], equals(existingId));
      expect(result[_key(type, 64.1, 28.1)], isPositive);
      expect(
        result[_key(type, 64.1, 28.1)],
        isNot(equals(existingId)),
      );
    });

    // ------------------------------------------------------------------
    test('large batch with multiple types resolves all stations', () async {
      final rows = <({String? name, double lat, double lon, String type})>[];
      final types = ['buoy', 'weather', 'mareograph'];

      for (var i = 0; i < 30; i++) {
        rows.add((
          name: 'Station $i',
          lat: 60.0 + i * 0.01,
          lon: 24.0 + i * 0.01,
          type: types[i % types.length],
        ));
      }

      final result = await dao.getOrCreateStationsBatch(rows);

      expect(result.length, 30);
      // All IDs positive and distinct
      expect(result.values.every((id) => id > 0), isTrue);
      expect(result.values.toSet().length, 30);
    });

    // ------------------------------------------------------------------
    test(
      'concurrent calls produce consistent results (no duplicates)',
      () async {
        const type = 'buoy';

        // Fire the same batch from two concurrent callers
        final futures = List.generate(
          5,
          (_) => dao.getOrCreateStationsBatch([
            (name: 'Concurrent', lat: 65.0, lon: 29.0, type: type),
          ]),
        );

        final results = await Future.wait(futures);

        // All callers must receive the same ID
        final ids = results.map((r) => r.values.first).toSet();
        expect(ids.length, 1);

        // Only one row in DB
        final rows = await (db.select(
          db.weatherStations,
        )..where((s) => s.stationType.equals(type))).get();
        expect(rows.length, 1);
      },
    );
  });
}
