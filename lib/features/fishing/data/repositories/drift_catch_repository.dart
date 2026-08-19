import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_catch.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_species.dart';
import 'package:sakkoja/features/fishing/domain/repositories/catch_repository.dart';

class DriftCatchRepository implements CatchRepository {
  DriftCatchRepository(this._db);
  final AppDatabase _db;

  @override
  Future<Either<Failure, Unit>> saveCatch(FishCatch fishCatch) async {
    try {
      await _db
          .into(_db.catches)
          .insertOnConflictUpdate(
            CatchesCompanion(
              id: Value(fishCatch.id),
              species: Value(fishCatch.species.name),
              timestampMs: Value(fishCatch.timestamp.millisecondsSinceEpoch),
              latitude: Value(fishCatch.location.latitude),
              longitude: Value(fishCatch.location.longitude),
              weightGrams: Value(fishCatch.weightGrams),
              lengthCm: Value(fishCatch.lengthCm),
              lure: Value(fishCatch.lure),
              method: Value(fishCatch.method?.name),
              notes: Value(fishCatch.notes),
              weatherTemp: Value(fishCatch.weatherTemp),
              weatherWindSpeed: Value(fishCatch.weatherWindSpeed),
              weatherWindDir: Value(fishCatch.weatherWindDir),
              weatherDesc: Value(fishCatch.weatherDesc),
              weatherIcon: Value(fishCatch.weatherIcon),
            ),
          );
      return const Right(unit);
    } catch (e, s) {
      Log.e('DriftCatchRepo: Failed to save catch', e, s);
      return Left(CacheFailure('Failed to save catch: $e'));
    }
  }

  @override
  Future<Either<Failure, List<FishCatch>>> getAllCatches() async {
    try {
      final query = _db.select(_db.catches)
        ..orderBy([
          (t) =>
              OrderingTerm(expression: t.timestampMs, mode: OrderingMode.desc),
        ]);

      final rows = await query.get();
      final entities = rows.map(_mapRowToEntity).toList();
      return Right(entities);
    } catch (e, s) {
      Log.e('DriftCatchRepo: Failed to get all catches', e, s);
      return Left(CacheFailure('Failed to load catches: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCatch(String id) async {
    try {
      await (_db.delete(_db.catches)..where((t) => t.id.equals(id))).go();
      return const Right(unit);
    } catch (e, s) {
      Log.e('DriftCatchRepo: Failed to delete catch', e, s);
      return Left(CacheFailure('Failed to delete catch: $e'));
    }
  }

  @override
  Future<Either<Failure, List<FishCatch>>> getCatchesByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    try {
      final startMs = start.millisecondsSinceEpoch;
      final endMs = end.millisecondsSinceEpoch;

      final query = _db.select(_db.catches)
        ..where((t) => t.timestampMs.isBetweenValues(startMs, endMs))
        ..orderBy([
          (t) =>
              OrderingTerm(expression: t.timestampMs, mode: OrderingMode.desc),
        ]);

      final rows = await query.get();
      final entities = rows.map(_mapRowToEntity).toList();
      return Right(entities);
    } catch (e, s) {
      Log.e('DriftCatchRepo: Failed to get catches by range', e, s);
      return Left(CacheFailure('Failed to load catches by range: $e'));
    }
  }

  FishCatch _mapRowToEntity(Catch row) {
    return FishCatch(
      id: row.id,
      species: FishSpecies.values.firstWhere(
        (s) => s.name == row.species,
        orElse: () => FishSpecies.other,
      ),
      timestamp: DateTime.fromMillisecondsSinceEpoch(row.timestampMs),
      location: LatLng(row.latitude, row.longitude),
      weightGrams: row.weightGrams,
      lengthCm: row.lengthCm,
      lure: row.lure,
      method: row.method != null
          ? FishingMethod.values.firstWhere(
              (m) => m.name == row.method,
              orElse: () => FishingMethod.other,
            )
          : null,
      notes: row.notes,
      weatherTemp: row.weatherTemp,
      weatherWindSpeed: row.weatherWindSpeed,
      weatherWindDir: row.weatherWindDir,
      weatherDesc: row.weatherDesc,
      weatherIcon: row.weatherIcon,
    );
  }
}
