import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_species.dart';

part 'fish_catch.freezed.dart';
part 'fish_catch.g.dart';

/// Represents a fish catch recorded by the user.
///
/// Immutable entity following Clean Architecture principles.
@freezed
abstract class FishCatch with _$FishCatch {
  @Assert('weightGrams == null || weightGrams > 0', 'Weight must be positive')
  @Assert('lengthCm == null || lengthCm > 0', 'Length must be positive')
  const factory FishCatch({
    /// Unique identifier (UUID).
    required String id,

    /// Species of fish caught.
    required FishSpecies species,

    /// Timestamp when the catch was recorded.
    required DateTime timestamp,

    /// GPS location where the fish was caught.
    @JsonKey(fromJson: _latLngFromJson, toJson: _latLngToJson)
    required LatLng location,

    /// Weight in grams (optional).
    int? weightGrams,

    /// Length in centimeters (optional).
    double? lengthCm,

    /// Lure or bait used (optional).
    String? lure,

    /// Fishing method used (optional).
    FishingMethod? method,

    /// Free-form notes (optional).
    String? notes,

    /// Temperature at time of catch (optional).
    double? weatherTemp,

    /// Wind speed at time of catch (optional).
    double? weatherWindSpeed,

    /// Wind direction at time of catch (optional).
    double? weatherWindDir,

    /// Weather description at time of catch (optional).
    String? weatherDesc,

    /// Weather icon code at time of catch (optional).
    String? weatherIcon,
  }) = _FishCatch;

  factory FishCatch.fromJson(Map<String, dynamic> json) =>
      _$FishCatchFromJson(json);
}

// Custom converters for LatLng serialization
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
