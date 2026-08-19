import 'package:fpdart/fpdart.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/core/models/bbox.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';
import 'package:sakkoja/features/speed_limits/domain/repositories/speed_limit_repository.dart';

class GetSpeedLimitsWithBBox {
  GetSpeedLimitsWithBBox(this.repository);
  final SpeedLimitRepository repository;

  Future<Either<Failure, List<SpeedLimitZone>>> call(BBox bbox) async {
    return repository.getSpeedLimitsWithBBox(bbox);
  }
}
