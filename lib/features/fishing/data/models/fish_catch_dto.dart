import 'package:freezed_annotation/freezed_annotation.dart';

part 'fish_catch_dto.freezed.dart';
part 'fish_catch_dto.g.dart';

/// Data Transfer Object for FishCatch entity.
///
/// Used for Sembast storage serialization/deserialization.
@freezed
abstract class FishCatchDTO with _$FishCatchDTO {
  const factory FishCatchDTO({
    required String id,
    required String species,
    required int timestampMs,
    required double latitude,
    required double longitude,
    int? weightGrams,
    double? lengthCm,
    String? lure,
    String? method,
    String? notes,
    double? weatherTemp,
    double? weatherWindSpeed,
    double? weatherWindDir,
    String? weatherDesc,
    String? weatherIcon,
  }) = _FishCatchDTO;
  const FishCatchDTO._();

  factory FishCatchDTO.fromJson(Map<String, dynamic> json) =>
      _$FishCatchDTOFromJson(json);
}
