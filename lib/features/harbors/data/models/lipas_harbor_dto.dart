import 'package:json_annotation/json_annotation.dart';

part 'lipas_harbor_dto.g.dart';

@JsonSerializable()
class LipasHarborDto {
  const LipasHarborDto({
    required this.sportsPlaceId,
    required this.name,
    required this.typeCode,
    required this.latitude,
    required this.longitude,
    this.municipalityName,
    this.hasSauna = false,
    this.hasCampfire = false,
    this.hasWater = false,
    this.hasElectricity = false,
    this.hasSeptic = false,
    this.berths,
    this.depthMeters,
  });

  factory LipasHarborDto.fromJson(Map<String, dynamic> json) =>
      _$LipasHarborDtoFromJson(json);

  final int sportsPlaceId;
  final String name;
  final int typeCode;
  final double latitude;
  final double longitude;
  final String? municipalityName;
  final bool hasSauna;
  final bool hasCampfire;
  final bool hasWater;
  final bool hasElectricity;
  final bool hasSeptic;
  final int? berths;
  final double? depthMeters;

  Map<String, dynamic> toJson() => _$LipasHarborDtoToJson(this);
}
