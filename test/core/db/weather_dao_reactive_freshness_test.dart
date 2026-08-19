library;

import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/core/db/daos/weather_dao.dart';
import 'package:sakkoja/core/db/weather_tables.dart';

AppDatabase _makeDb() => AppDatabase(NativeDatabase.memory());

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WeatherDao reactive freshness', () {
    late AppDatabase db;
    late WeatherDao dao;
    late int providerId;

    setUp(() async {
      db = _makeDb();
      dao = db.weatherDao;
      providerId = await dao.getOrCreateProvider('test', 'Test Provider');
    });

    tearDown(() async {
      await db.close();
    });

    test('removes alerts at expiry without a database write', () async {
      final now = DateTime.now();
      await dao.upsertAlerts([
        WeatherAlertsCompanion.insert(
          externalId: 'expiry-test',
          providerId: providerId,
          event: 'Wind',
          description: 'Expires shortly',
          severity: 'moderate',
          onset: now,
          expires: now.add(const Duration(milliseconds: 500)),
          fetchedAt: now,
          polygonJson: '[]',
          areaDescription: 'Test area',
        ),
      ]);

      final events = <List<WeatherAlert>>[];
      final expired = Completer<void>();
      final subscription = dao.watchActiveAlerts().listen((alerts) {
        events.add(alerts);
        if (alerts.isEmpty && !expired.isCompleted) expired.complete();
      });

      await expired.future.timeout(const Duration(seconds: 3));
      await subscription.cancel();

      expect(events.first, hasLength(1));
      expect(events.last, isEmpty);
    });

    test(
      'uses a short safety window while retaining lightning history',
      () async {
        final now = DateTime.now();
        await dao.insertLightningBatch([
          LightningStrikesCompanion.insert(
            providerId: providerId,
            strikeTime: now,
            fetchedAt: now,
            latitude: 60,
            longitude: 25,
            peakCurrentKa: 5,
            multiplicity: 1,
          ),
        ]);

        final safetyEvents = <List<LightningStrike>>[];
        final expired = Completer<void>();
        final subscription = dao
            .watchRecentLightning(const Duration(milliseconds: 500))
            .listen((strikes) {
              safetyEvents.add(strikes);
              if (strikes.isEmpty && !expired.isCompleted) expired.complete();
            });

        await expired.future.timeout(const Duration(seconds: 3));
        await subscription.cancel();

        expect(safetyEvents.first, hasLength(1));
        expect(safetyEvents.last, isEmpty);
        expect(
          await dao.getRecentLightning(LightningStrikes.retention),
          hasLength(1),
        );
      },
    );
  });
}
