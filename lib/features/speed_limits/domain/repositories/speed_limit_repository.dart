import 'package:fpdart/fpdart.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/core/models/bbox.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/traffic_sign.dart';

abstract class SpeedLimitRepository {
  /// Fetches all speed limit zones (no spatial filtering)
  Future<Either<Failure, List<SpeedLimitZone>>> getSpeedLimits();

  /// Fetches speed limit zones within a bounding box
  Future<Either<Failure, List<SpeedLimitZone>>> getSpeedLimitsWithBBox(
    BBox bbox,
  );

  /// Fetches traffic signs within a bounding box
  Future<Either<Failure, List<TrafficSign>>> getTrafficSignsWithBBox(BBox bbox);
}
