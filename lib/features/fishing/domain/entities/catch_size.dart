import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_species.dart';

part 'catch_size.freezed.dart';
part 'catch_size.g.dart';

/// Represents legal fishing regulations for a specific species and region.
///
/// Includes minimum and maximum allowed sizes, and seasonal protection status.
@freezed
abstract class CatchSize with _$CatchSize {
  const factory CatchSize({
    /// The species this regulation applies to.
    required FishSpecies species,

    /// Minimum length in centimeters to keep the catch.
    required double minimumSizeCm,

    /// Maximum length in centimeters (optional, e.g. for trophy fish protection).
    double? maximumSizeCm,

    /// Whether the species is currently under seasonal protection.
    @Default(false) bool isProtected,

    /// Optional region name if the regulation is location-specific (e.g. "Saimaa").
    String? region,

    /// Start date of the seasonal protection period (optional).
    DateTime? protectionStartDate,

    /// End date of the seasonal protection period (optional).
    DateTime? protectionEndDate,
  }) = _CatchSize;

  factory CatchSize.fromJson(Map<String, dynamic> json) =>
      _$CatchSizeFromJson(json);
}
