import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/utils/lat_lng_converter.dart';

part 'algae_report_dto.freezed.dart';
part 'algae_report_dto.g.dart';

/// Algae risk level for DTO layer.
/// DTO-local enum — must mirror domain [AlgaeRiskLevel] exactly.
enum AlgaeRiskLevelDto {
  low,
  moderate,
  high,
  veryHigh,
}

@freezed
abstract class AlgaeReportDto with _$AlgaeReportDto {
  const factory AlgaeReportDto({
    required DateTime timestamp,
    @LatLngConverter() required LatLng location,
    String? speciesName,
    double? biomass,
    int? cellCount,
    String? dominantSpecies,
    AlgaeRiskLevelDto? riskLevel,
  }) = _AlgaeReportDto;

  factory AlgaeReportDto.fromJson(Map<String, dynamic> json) =>
      _$AlgaeReportDtoFromJson(json);
}

@freezed
abstract class AlgaeForecastDto with _$AlgaeForecastDto {
  const factory AlgaeForecastDto({
    required DateTime forecastDate,
    required double centerLat,
    required double centerLon,
    double? probability,
    String? season,
  }) = _AlgaeForecastDto;

  factory AlgaeForecastDto.fromJson(Map<String, dynamic> json) =>
      _$AlgaeForecastDtoFromJson(json);
}
