import 'package:fpdart/fpdart.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/core/models/bbox.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/traffic_sign.dart';
import 'package:sakkoja/features/speed_limits/domain/repositories/speed_limit_repository.dart';

class GetTrafficSignsWithBBox {
  GetTrafficSignsWithBBox(this._repository);
  final SpeedLimitRepository _repository;

  Future<Either<Failure, List<TrafficSign>>> call(BBox bbox) {
    return _repository.getTrafficSignsWithBBox(bbox);
  }
}
