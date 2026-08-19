import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'user_contribution.freezed.dart';
part 'user_contribution.g.dart';

enum ContributionType { speedLimit, trafficSign }

@freezed
abstract class UserContribution with _$UserContribution {
  const factory UserContribution({
    required String id,
    required ContributionType type,
    @JsonKey(fromJson: _latLngFromJson, toJson: _latLngToJson)
    required LatLng location,

    /// For Speed Limit: the limit in km/h (e.g., 30)
    /// For Traffic Sign: the type code or description
    required String value,
    required DateTime createdAt,
    @Default(false) bool isSynced,
  }) = _UserContribution;

  factory UserContribution.fromJson(Map<String, dynamic> json) =>
      _$UserContributionFromJson(json);
}

// Custom converters for LatLng since they might not be directly serializable
LatLng _latLngFromJson(Map<String, dynamic> json) {
  return LatLng(
    (json['latitude'] as num).toDouble(),
    (json['longitude'] as num).toDouble(),
  );
}

Map<String, dynamic> _latLngToJson(LatLng instance) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
