import 'package:fpdart/fpdart.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/fishing/domain/entities/fishing_restriction.dart';
import 'package:sakkoja/features/fishing/domain/repositories/fishing_repository.dart';

class GetFishingRestrictions {
  GetFishingRestrictions(this.repository);
  final FishingRepository repository;

  Future<Either<Failure, List<FishingRestriction>>> call({
    required double minLat,
    required double minLng,
    required double maxLat,
    required double maxLng,
    String? category,
    bool onlyActive = false,
  }) async {
    return repository.getFishingRestrictions(
      minLat: minLat,
      minLng: minLng,
      maxLat: maxLat,
      maxLng: maxLng,
      category: category,
      onlyActive: onlyActive,
    );
  }
}
