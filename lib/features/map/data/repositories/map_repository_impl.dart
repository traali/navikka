import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/map/data/datasources/map_local_data_source.dart';
import 'package:sakkoja/features/map/data/models/last_location_dto.dart';
import 'package:sakkoja/features/map/domain/repositories/map_repository.dart';

class MapRepositoryImpl implements MapRepository {
  MapRepositoryImpl(this._dataSource);
  final MapLocalDataSource _dataSource;

  @override
  Future<Either<Failure, Unit>> saveLastLocation(LatLng location) async {
    try {
      await _dataSource.saveLastLocation(LastLocationDto.fromLatLng(location));
      return const Right(unit);
    } catch (e) {
      return Left(GeneralFailure('Failed to save location: $e'));
    }
  }

  @override
  Future<Either<Failure, LatLng?>> getLastLocation() async {
    try {
      final dto = await _dataSource.getLastLocation();
      return Right(dto?.toLatLng());
    } catch (e) {
      return Left(GeneralFailure('Failed to get location: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveLayerFilterSettings(
    Map<String, dynamic> json,
  ) async {
    try {
      await _dataSource.saveLayerFilterSettings(json);
      return const Right(unit);
    } catch (e) {
      return Left(GeneralFailure('Failed to save layer settings: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>?>>
  getLayerFilterSettings() async {
    try {
      final json = await _dataSource.getLayerFilterSettings();
      return Right(json);
    } catch (e) {
      return Left(GeneralFailure('Failed to get layer settings: $e'));
    }
  }
}
