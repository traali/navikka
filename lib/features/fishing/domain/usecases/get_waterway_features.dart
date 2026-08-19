import 'package:fpdart/fpdart.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/fishing/domain/entities/waterway_feature.dart';
import 'package:sakkoja/features/fishing/domain/repositories/fishing_repository.dart';

class GetWaterwayFeatures {
  GetWaterwayFeatures(this.repository);
  final FishingRepository repository;

  Future<Either<Failure, List<WaterwayFeature>>> call({
    required double minLat,
    required double minLng,
    required double maxLat,
    required double maxLng,
  }) async {
    return repository.getWaterwayFeatures(
      minLat: minLat,
      minLng: minLng,
      maxLat: maxLat,
      maxLng: maxLng,
    );
  }
}
