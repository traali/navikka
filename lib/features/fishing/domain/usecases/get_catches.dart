import 'package:fpdart/fpdart.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_catch.dart';
import 'package:sakkoja/features/fishing/domain/repositories/catch_repository.dart';

/// Use case for retrieving all recorded fish catches.
///
/// Single-purpose use case following Clean Architecture.
class GetCatches {
  GetCatches(this.repository);
  final CatchRepository repository;

  Future<Either<Failure, List<FishCatch>>> call() async {
    return repository.getAllCatches();
  }
}
