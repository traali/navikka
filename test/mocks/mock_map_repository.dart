import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/map/domain/repositories/map_repository.dart';

/// Mock MapRepository for testing purposes.
/// Use this in test overrides to avoid GetIt dependency.
class MockMapRepository implements MapRepository {
  @override
  Future<Either<Failure, Unit>> saveLastLocation(LatLng location) async {
    return const Right(unit);
  }

  @override
  Future<Either<Failure, LatLng?>> getLastLocation() async {
    return const Right(null);
  }

  @override
  Future<Either<Failure, Unit>> saveLayerFilterSettings(
    Map<String, dynamic> json,
  ) async {
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Map<String, dynamic>?>>
  getLayerFilterSettings() async {
    return const Right(null);
  }
}
