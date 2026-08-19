import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/utils/lat_lng_converter.dart';

part 'water_quality_dto.freezed.dart';
part 'water_quality_dto.g.dart';

@freezed
abstract class WaterQualityDto with _$WaterQualityDto {
  const factory WaterQualityDto({
    required DateTime timestamp,
    @LatLngConverter() required LatLng location,
    required String stationName,
    double? dissolvedOxygen,
    double? pH,
    double? chlorophyllA,
    double? turbidity,
  }) = _WaterQualityDto;

  factory WaterQualityDto.fromJson(Map<String, dynamic> json) =>
      _$WaterQualityDtoFromJson(json);
}
