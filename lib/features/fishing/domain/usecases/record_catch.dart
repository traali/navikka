import 'package:fpdart/fpdart.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_catch.dart';
import 'package:sakkoja/features/fishing/domain/repositories/catch_repository.dart';

/// Use case for recording a new fish catch.
///
/// Single-purpose use case following Clean Architecture.
class RecordCatch {
  RecordCatch(this.repository);
  final CatchRepository repository;

  Future<Either<Failure, Unit>> call(FishCatch fishCatch) async {
    return repository.saveCatch(fishCatch);
  }
}
