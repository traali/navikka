import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/features/fishing/data/repositories/drift_catch_repository.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_catch.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_species.dart';

void main() {
  late AppDatabase db;
  late DriftCatchRepository repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftCatchRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  final tCatchWithWeather = FishCatch(
    id: 'weather-catch-1',
    species: FishSpecies.kuha,
    timestamp: DateTime.fromMillisecondsSinceEpoch(100000),
    location: const LatLng(60.123, 24.456),
    weightGrams: 1200,
    lengthCm: 45.5,
    lure: 'Jig',
    method: FishingMethod.jigging,
    notes: 'Caught at sunset',
    weatherTemp: 19.5,
    weatherWindSpeed: 4.8,
    weatherWindDir: 220.0,
    weatherDesc: 'Clear Sky',
    weatherIcon: '01d',
  );

  final tCatchWithoutWeather = FishCatch(
    id: 'weather-catch-2',
    species: FishSpecies.ahven,
    timestamp: DateTime.fromMillisecondsSinceEpoch(200000),
    location: const LatLng(60.200, 24.500),
    weightGrams: 350,
    lengthCm: 22.0,
    lure: 'Spinner',
    method: FishingMethod.spinning,
    notes: 'No weather details cached',
  );

  group('DriftCatchRepository persistence & mapping tests', () {
    test('saveCatch saves catch with weather fields successfully', () async {
      final saveResult = await repository.saveCatch(tCatchWithWeather);
      expect(saveResult.isRight(), true);

      final getResult = await repository.getAllCatches();
      expect(getResult.isRight(), true);

      final list = getResult.getOrElse((_) => []);
      expect(list.length, 1);

      final saved = list.first;
      expect(saved.id, tCatchWithWeather.id);
      expect(saved.species, tCatchWithWeather.species);
      expect(saved.timestamp, tCatchWithWeather.timestamp);
      expect(saved.location, tCatchWithWeather.location);
      expect(saved.weightGrams, tCatchWithWeather.weightGrams);
      expect(saved.lengthCm, tCatchWithWeather.lengthCm);
      expect(saved.lure, tCatchWithWeather.lure);
      expect(saved.method, tCatchWithWeather.method);
      expect(saved.notes, tCatchWithWeather.notes);

      // Verify new Weather Fields are correct
      expect(saved.weatherTemp, tCatchWithWeather.weatherTemp);
      expect(saved.weatherWindSpeed, tCatchWithWeather.weatherWindSpeed);
      expect(saved.weatherWindDir, tCatchWithWeather.weatherWindDir);
      expect(saved.weatherDesc, tCatchWithWeather.weatherDesc);
      expect(saved.weatherIcon, tCatchWithWeather.weatherIcon);
    });

    test(
      'saveCatch saves catch with null weather fields successfully',
      () async {
        final saveResult = await repository.saveCatch(tCatchWithoutWeather);
        expect(saveResult.isRight(), true);

        final getResult = await repository.getAllCatches();
        expect(getResult.isRight(), true);

        final list = getResult.getOrElse((_) => []);
        expect(list.length, 1);

        final saved = list.first;
        expect(saved.id, tCatchWithoutWeather.id);
        expect(saved.weatherTemp, null);
        expect(saved.weatherWindSpeed, null);
        expect(saved.weatherWindDir, null);
        expect(saved.weatherDesc, null);
        expect(saved.weatherIcon, null);
      },
    );

    test('deleteCatch removes record from database', () async {
      await repository.saveCatch(tCatchWithWeather);
      await repository.saveCatch(tCatchWithoutWeather);

      final deleteResult = await repository.deleteCatch(tCatchWithWeather.id);
      expect(deleteResult.isRight(), true);

      final getResult = await repository.getAllCatches();
      final list = getResult.getOrElse((_) => []);
      expect(list.length, 1);
      expect(list.first.id, tCatchWithoutWeather.id);
    });

    test('getCatchesByDateRange returns matching catches in range', () async {
      await repository.saveCatch(tCatchWithWeather); // ts: 100000 (100 seconds)
      await repository.saveCatch(
        tCatchWithoutWeather,
      ); // ts: 200000 (200 seconds)

      final rangeResult = await repository.getCatchesByDateRange(
        DateTime.fromMillisecondsSinceEpoch(50000),
        DateTime.fromMillisecondsSinceEpoch(150000),
      );

      expect(rangeResult.isRight(), true);
      final list = rangeResult.getOrElse((_) => []);
      expect(list.length, 1);
      expect(list.first.id, tCatchWithWeather.id);
    });
  });
}
