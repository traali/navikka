import 'package:sakkoja/features/fishing/data/models/fishing_restriction_dto.dart';
import 'package:sakkoja/features/fishing/data/models/waterway_feature_dto.dart';
import 'package:sakkoja/features/fishing/domain/entities/fishing_restriction.dart';
import 'package:sakkoja/features/fishing/domain/entities/waterway_feature.dart';

extension FishingRestrictionDtoX on FishingRestrictionDto {
  FishingRestriction toEntity() {
    return FishingRestriction.withCalculatedBBox(
      id: id,
      title: title,
      rings: rings,
      type: type,
      description: description,
      validity: validity,
    );
  }
}

extension WaterwayFeatureDtoX on WaterwayFeatureDto {
  WaterwayFeature toEntity() {
    return WaterwayFeature(
      id: id,
      name: name,
      type: WaterwayFeatureType.values.byName(type.name),
      rings: rings,
      points: points,
      position: position,
    );
  }
}
