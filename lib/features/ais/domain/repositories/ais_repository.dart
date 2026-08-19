import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/ais/domain/entities/ais_target.dart';

abstract class AisRepository {
  /// Fetches active AIS targets within the specified bounding box area.
  Future<Either<Failure, List<AisTarget>>> getAisTargetsInBounds({
    required LatLng southWest,
    required LatLng northEast,
  });
}
