import 'package:fpdart/fpdart.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/fishing/domain/entities/catch_size.dart';
import 'package:sakkoja/features/fishing/domain/entities/fishing_restriction.dart';
import 'package:sakkoja/features/fishing/domain/entities/waterway_feature.dart';

abstract class FishingRepository {
  Future<Either<Failure, List<CatchSize>>> getCatchSizes({
    required double lat,
    required double lon,
  });

  Future<Either<Failure, List<FishingRestriction>>> getFishingRestrictions({
    required double minLat,
    required double minLng,
    required double maxLat,
    required double maxLng,
    String? category,
    bool onlyActive = false,
  });

  Future<Either<Failure, List<WaterwayFeature>>> getWaterwayFeatures({
    required double minLat,
    required double minLng,
    required double maxLat,
    required double maxLng,
  });

  Future<void> saveFishingMode(bool isEnabled);
  Future<bool> getFishingMode();
}
