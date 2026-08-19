// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'algae_report_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AlgaeReportDto _$AlgaeReportDtoFromJson(Map<String, dynamic> json) =>
    _AlgaeReportDto(
      timestamp: DateTime.parse(json['timestamp'] as String),
      location: const LatLngConverter().fromJson(
        json['location'] as Map<String, dynamic>,
      ),
      speciesName: json['speciesName'] as String?,
      biomass: (json['biomass'] as num?)?.toDouble(),
      cellCount: (json['cellCount'] as num?)?.toInt(),
      dominantSpecies: json['dominantSpecies'] as String?,
      riskLevel: $enumDecodeNullable(
        _$AlgaeRiskLevelDtoEnumMap,
        json['riskLevel'],
      ),
    );

Map<String, dynamic> _$AlgaeReportDtoToJson(_AlgaeReportDto instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'location': const LatLngConverter().toJson(instance.location),
      'speciesName': instance.speciesName,
      'biomass': instance.biomass,
      'cellCount': instance.cellCount,
      'dominantSpecies': instance.dominantSpecies,
      'riskLevel': _$AlgaeRiskLevelDtoEnumMap[instance.riskLevel],
    };

const _$AlgaeRiskLevelDtoEnumMap = {
  AlgaeRiskLevelDto.low: 'low',
  AlgaeRiskLevelDto.moderate: 'moderate',
  AlgaeRiskLevelDto.high: 'high',
  AlgaeRiskLevelDto.veryHigh: 'veryHigh',
};

_AlgaeForecastDto _$AlgaeForecastDtoFromJson(Map<String, dynamic> json) =>
    _AlgaeForecastDto(
      forecastDate: DateTime.parse(json['forecastDate'] as String),
      centerLat: (json['centerLat'] as num).toDouble(),
      centerLon: (json['centerLon'] as num).toDouble(),
      probability: (json['probability'] as num?)?.toDouble(),
      season: json['season'] as String?,
    );

Map<String, dynamic> _$AlgaeForecastDtoToJson(_AlgaeForecastDto instance) =>
    <String, dynamic>{
      'forecastDate': instance.forecastDate.toIso8601String(),
      'centerLat': instance.centerLat,
      'centerLon': instance.centerLon,
      'probability': instance.probability,
      'season': instance.season,
    };
