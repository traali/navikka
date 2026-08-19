import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'lightning_strike_dto.freezed.dart';
part 'lightning_strike_dto.g.dart';

@freezed
abstract class LightningStrikeDto with _$LightningStrikeDto {
  const factory LightningStrikeDto({
    required DateTime time,
    required LatLng location,
    required double peakCurrent,
    @Default(0) int multiplicity,
  }) = _LightningStrikeDto;

  factory LightningStrikeDto.fromJson(Map<String, dynamic> json) =>
      _$LightningStrikeDtoFromJson(json);

  // DEPRECATED: Use XmlStreamParser.parseLightning(xmlString) instead.
}
