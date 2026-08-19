import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/errors/failure.dart';

abstract class MapRepository {
  /// Save the last known user location to persistent storage
  Future<Either<Failure, Unit>> saveLastLocation(LatLng location);

  /// Get the last known user location from persistent storage
  Future<Either<Failure, LatLng?>> getLastLocation();

  /// Save layer filter settings to persistent storage
  Future<Either<Failure, Unit>> saveLayerFilterSettings(
    Map<String, dynamic> json,
  );

  /// Get layer filter settings from persistent storage
  Future<Either<Failure, Map<String, dynamic>?>> getLayerFilterSettings();
}
