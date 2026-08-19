import 'package:fpdart/fpdart.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_catch.dart';

/// Abstract repository interface for fish catch operations.
///
/// Follows Clean Architecture - domain layer defines the contract,
/// data layer provides the implementation.
abstract class CatchRepository {
  /// Save a new fish catch to storage.
  Future<Either<Failure, Unit>> saveCatch(FishCatch fishCatch);

  /// Get all recorded catches, ordered by timestamp (newest first).
  Future<Either<Failure, List<FishCatch>>> getAllCatches();

  /// Delete a catch by its ID.
  Future<Either<Failure, Unit>> deleteCatch(String id);

  /// Get catches from a specific date range.
  Future<Either<Failure, List<FishCatch>>> getCatchesByDateRange(
    DateTime start,
    DateTime end,
  );
}
