/// Unit tests for WeatherDao insertObservationBatch and insertForecastBatch
library;

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/core/db/daos/weather_dao.dart';

AppDatabase _makeDb() => AppDatabase(NativeDatabase.memory());

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WeatherDao.insertObservationBatch', () {
    late AppDatabase db;
    late WeatherDao dao;

    setUp(() {
      db = _makeDb();
      dao = db.weatherDao;
    });

    tearDown(() async {
      await db.close();
    });

    test('inserts all items when no existing rows', () async {
      final providerId = await dao.getOrCreateProvider(
        'test',
        'Test Provider',
        priority: 10,
      );
      final stationId = await dao.getOrCreateStation(
        latitude: 60.0,
        longitude: 25.0,
        stationType: 'weather',
        name: 'Test Station',
      );

      final items = [
        WeatherObservationsCompanion.insert(
          stationId: stationId,
          providerId: providerId,
          timestamp: DateTime(2026, 5, 11, 12, 0),
          fetchedAt: DateTime.now(),
          temperature: const Value(20.0),
        ),
      ];

      final inserted = await dao.insertObservationBatch(items);
      expect(inserted, 1);
    });

    test('skips when higher-priority row already exists', () async {
      final fmiId = await dao.getOrCreateProvider('fmi', 'FMI', priority: 10);
      final owId = await dao.getOrCreateProvider(
        'openweather',
        'OpenWeather',
        priority: 3,
      );
      final stationId = await dao.getOrCreateStation(
        latitude: 60.0,
        longitude: 25.0,
        stationType: 'weather',
        name: 'Test Station',
      );

      await dao.insertObservationBatch([
        WeatherObservationsCompanion.insert(
          stationId: stationId,
          providerId: fmiId,
          timestamp: DateTime(2026, 5, 11, 12, 0),
          fetchedAt: DateTime(2026, 5, 11, 13, 0),
          temperature: const Value(20.0),
        ),
      ]);

      final filtered = await dao.insertObservationBatch([
        WeatherObservationsCompanion.insert(
          stationId: stationId,
          providerId: owId,
          timestamp: DateTime(2026, 5, 11, 12, 0),
          fetchedAt: DateTime(2026, 5, 11, 12, 0), // OLDER than existing
          temperature: const Value(18.0),
        ),
      ]);

      expect(filtered, 0);
    });

    test('allows insert when existing has lower priority', () async {
      final lowId = await dao.getOrCreateProvider(
        'low',
        'Low Priority',
        priority: 3,
      );
      final highId = await dao.getOrCreateProvider(
        'high',
        'High Priority',
        priority: 10,
      );
      final stationId = await dao.getOrCreateStation(
        latitude: 60.0,
        longitude: 25.0,
        stationType: 'weather',
        name: 'Test Station',
      );

      await dao.insertObservationBatch([
        WeatherObservationsCompanion.insert(
          stationId: stationId,
          providerId: lowId,
          timestamp: DateTime(2026, 5, 11, 12, 0),
          fetchedAt: DateTime.now(),
          temperature: const Value(20.0),
        ),
      ]);

      final inserted = await dao.insertObservationBatch([
        WeatherObservationsCompanion.insert(
          stationId: stationId,
          providerId: highId,
          timestamp: DateTime(2026, 5, 11, 12, 0),
          fetchedAt: DateTime.now(),
          temperature: const Value(22.0),
        ),
      ]);

      expect(inserted, 1);
    });
  });

  group('WeatherDao.insertForecastBatch', () {
    late AppDatabase db;
    late WeatherDao dao;

    setUp(() {
      db = _makeDb();
      dao = db.weatherDao;
    });

    tearDown(() async {
      await db.close();
    });

    test('inserts all items when no existing rows', () async {
      final providerId = await dao.getOrCreateProvider(
        'test',
        'Test Provider',
        priority: 10,
      );
      final stationId = await dao.getOrCreateStation(
        latitude: 60.0,
        longitude: 25.0,
        stationType: 'weather',
        name: 'Test Station',
      );

      final items = [
        WeatherForecastsCompanion.insert(
          stationId: stationId,
          providerId: providerId,
          forecastTime: DateTime(2026, 5, 11, 18, 0),
          issuedAt: DateTime.now(),
          fetchedAt: DateTime.now(),
          temperature: const Value(20.0),
        ),
      ];

      final inserted = await dao.insertForecastBatch(items);
      expect(inserted, 1);
    });

    test('skips when higher-priority forecast already exists', () async {
      final fmiId = await dao.getOrCreateProvider('fmi', 'FMI', priority: 10);
      final owId = await dao.getOrCreateProvider(
        'openweather',
        'OpenWeather',
        priority: 3,
      );
      final stationId = await dao.getOrCreateStation(
        latitude: 60.0,
        longitude: 25.0,
        stationType: 'weather',
        name: 'Test Station',
      );

      await dao.insertForecastBatch([
        WeatherForecastsCompanion.insert(
          stationId: stationId,
          providerId: fmiId,
          forecastTime: DateTime(2026, 5, 11, 18, 0),
          issuedAt: DateTime.now(),
          fetchedAt: DateTime(2026, 5, 11, 13, 0),
          temperature: const Value(20.0),
        ),
      ]);

      final filtered = await dao.insertForecastBatch([
        WeatherForecastsCompanion.insert(
          stationId: stationId,
          providerId: owId,
          forecastTime: DateTime(2026, 5, 11, 18, 0),
          issuedAt: DateTime.now(),
          fetchedAt: DateTime(2026, 5, 11, 12, 0), // OLDER than existing
          temperature: const Value(18.0),
        ),
      ]);

      expect(filtered, 0);
    });
  });
}
