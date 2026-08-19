import 'package:fpdart/fpdart.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/harbors/domain/entities/harbor.dart';

abstract class HarborRepository {
  Future<Either<Failure, List<Harbor>>> getHarbors();
}
