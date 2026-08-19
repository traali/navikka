library;

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/features/weather/data/datasources/drift_weather_store.dart';
import 'package:sakkoja/features/weather/data/models/weather_observation_dto.dart';

void main() {
  group('DriftWeatherStore', () {
    late AppDatabase db;
    late DriftWeatherStore store;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      store = DriftWeatherStore(db);
    });

    tearDown(() async {
      await db.close();
    });

    test('nuke on empty store does not crash', () async {
      await store.nuke();
    });

    test('getLastObservations returns null when no station exists', () async {
      final result = await store.getLastObservations(60.0, 25.0);
      expect(result, isNull);
    });

    test('round-trips observation through cache/getLast', () async {
      final now = DateTime.now();
      await store.cacheObservations(
        60.0,
        25.0,
        [
          WeatherObservationDto(
            timestamp: now,
            location: LatLng(60.0, 25.0),
            temperature: 20.0,
            stationName: 'Test Station',
          ),
        ],
      );

      final result = await store.getLastObservations(60.0, 25.0);
      expect(result, isNotNull);
      expect(result!.length, 1);
      expect(result.first.temperature, 20.0);
    });

    test('nuke after caching clears all data', () async {
      final now = DateTime.now();
      await store.cacheObservations(
        60.0,
        25.0,
        [
          WeatherObservationDto(
            timestamp: now,
            location: LatLng(60.0, 25.0),
            temperature: 20.0,
            stationName: 'Test',
          ),
        ],
      );

      await store.nuke();

      final result = await store.getLastObservations(60.0, 25.0);
      expect(result, isNull);
    });

    test('cache multiple observations returns all', () async {
      final now = DateTime.now();
      await store.cacheObservations(
        60.0,
        25.0,
        [
          WeatherObservationDto(
            timestamp: now,
            location: LatLng(60.0, 25.0),
            temperature: 20.0,
            stationName: 'Station A',
          ),
          WeatherObservationDto(
            timestamp: now.subtract(const Duration(hours: 1)),
            location: LatLng(60.0, 25.0),
            temperature: 18.0,
            stationName: 'Station A',
          ),
        ],
      );

      final result = await store.getLastObservations(60.0, 25.0);
      expect(result, isNotNull);
      expect(result!.length, 2);
    });
  });
}
