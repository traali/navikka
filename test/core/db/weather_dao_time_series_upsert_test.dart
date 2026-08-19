library;

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/core/db/daos/weather_dao.dart';

AppDatabase _makeDb() => AppDatabase(NativeDatabase.memory());

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WeatherDao exact-key time-series writes', () {
    late AppDatabase db;
    late WeatherDao dao;
    late int providerId;
    late int stationId;
    final timestamp = DateTime(2026, 7, 1, 12);
    final refreshedAt = DateTime(2026, 7, 1, 12, 5);

    setUp(() async {
      db = _makeDb();
      dao = db.weatherDao;
      providerId = await dao.getOrCreateProvider('test', 'Test Provider');
      stationId = await dao.getOrCreateStation(
        latitude: 60,
        longitude: 25,
        stationType: 'weather',
        name: 'Test station',
      );
    });

    tearDown(() async {
      await db.close();
    });

    test(
      'replaces corrected payloads and fetchedAt for every series',
      () async {
        await dao.insertObservationBatch([
          WeatherObservationsCompanion.insert(
            stationId: stationId,
            providerId: providerId,
            timestamp: timestamp,
            fetchedAt: timestamp,
            temperature: const Value(10),
          ),
        ]);
        await dao.insertObservationBatch([
          WeatherObservationsCompanion.insert(
            stationId: stationId,
            providerId: providerId,
            timestamp: timestamp,
            fetchedAt: refreshedAt,
            temperature: const Value(11),
          ),
        ]);

        await dao.insertForecastBatch([
          WeatherForecastsCompanion.insert(
            stationId: stationId,
            providerId: providerId,
            forecastTime: timestamp,
            issuedAt: timestamp,
            fetchedAt: timestamp,
            temperature: const Value(10),
          ),
        ]);
        await dao.insertForecastBatch([
          WeatherForecastsCompanion.insert(
            stationId: stationId,
            providerId: providerId,
            forecastTime: timestamp,
            issuedAt: timestamp,
            fetchedAt: refreshedAt,
            temperature: const Value(11),
          ),
        ]);

        await dao.insertWavesBatch([
          WaveObservationsCompanion.insert(
            stationId: stationId,
            providerId: providerId,
            timestamp: timestamp,
            fetchedAt: timestamp,
            waveHeight: const Value(1),
          ),
        ]);
        await dao.insertWavesBatch([
          WaveObservationsCompanion.insert(
            stationId: stationId,
            providerId: providerId,
            timestamp: timestamp,
            fetchedAt: refreshedAt,
            waveHeight: const Value(2),
          ),
        ]);

        await dao.insertSeaLevelBatch([
          SeaLevelReadingsCompanion.insert(
            stationId: stationId,
            providerId: providerId,
            timestamp: timestamp,
            fetchedAt: timestamp,
            seaLevelMm: const Value(10),
          ),
        ]);
        await dao.insertSeaLevelBatch([
          SeaLevelReadingsCompanion.insert(
            stationId: stationId,
            providerId: providerId,
            timestamp: timestamp,
            fetchedAt: refreshedAt,
            seaLevelMm: const Value(20),
          ),
        ]);

        await dao.insertLightningBatch([
          LightningStrikesCompanion.insert(
            providerId: providerId,
            strikeTime: timestamp,
            fetchedAt: timestamp,
            latitude: 60,
            longitude: 25,
            peakCurrentKa: 5,
            multiplicity: 1,
          ),
        ]);
        await dao.insertLightningBatch([
          LightningStrikesCompanion.insert(
            providerId: providerId,
            strikeTime: timestamp,
            fetchedAt: refreshedAt,
            latitude: 60,
            longitude: 25,
            peakCurrentKa: 7,
            multiplicity: 2,
          ),
        ]);

        await dao.insertWaterQualityBatch([
          WaterQualityReadingsCompanion.insert(
            stationId: stationId,
            providerId: providerId,
            sampleTime: timestamp,
            fetchedAt: timestamp,
            turbidity: const Value(1),
          ),
        ]);
        await dao.insertWaterQualityBatch([
          WaterQualityReadingsCompanion.insert(
            stationId: stationId,
            providerId: providerId,
            sampleTime: timestamp,
            fetchedAt: refreshedAt,
            turbidity: const Value(2),
          ),
        ]);

        await dao.insertAlgaeBatch([
          AlgaeReportsCompanion.insert(
            stationId: stationId,
            providerId: providerId,
            observationTime: timestamp,
            fetchedAt: timestamp,
            speciesName: const Value('Initial'),
          ),
        ]);
        await dao.insertAlgaeBatch([
          AlgaeReportsCompanion.insert(
            stationId: stationId,
            providerId: providerId,
            observationTime: timestamp,
            fetchedAt: refreshedAt,
            speciesName: const Value('Corrected'),
          ),
        ]);

        final observation = await db.select(db.weatherObservations).getSingle();
        final forecast = await db.select(db.weatherForecasts).getSingle();
        final wave = await db.select(db.waveObservations).getSingle();
        final seaLevel = await db.select(db.seaLevelReadings).getSingle();
        final lightning = await db.select(db.lightningStrikes).getSingle();
        final waterQuality = await db
            .select(db.waterQualityReadings)
            .getSingle();
        final algae = await db.select(db.algaeReports).getSingle();

        expect(observation.temperature, 11);
        expect(forecast.temperature, 11);
        expect(wave.waveHeight, 2);
        expect(seaLevel.seaLevelMm, 20);
        expect(lightning.peakCurrentKa, 7);
        expect(waterQuality.turbidity, 2);
        expect(algae.speciesName, 'Corrected');
        expect(observation.fetchedAt, refreshedAt);
        expect(forecast.fetchedAt, refreshedAt);
        expect(wave.fetchedAt, refreshedAt);
        expect(seaLevel.fetchedAt, refreshedAt);
        expect(lightning.fetchedAt, refreshedAt);
        expect(waterQuality.fetchedAt, refreshedAt);
        expect(algae.fetchedAt, refreshedAt);
      },
    );
  });
}
