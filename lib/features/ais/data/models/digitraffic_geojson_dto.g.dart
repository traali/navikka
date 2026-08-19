// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'digitraffic_geojson_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DigitrafficFeatureCollectionDto _$DigitrafficFeatureCollectionDtoFromJson(
  Map<String, dynamic> json,
) => DigitrafficFeatureCollectionDto(
  type: json['type'] as String,
  features: (json['features'] as List<dynamic>)
      .map((e) => DigitrafficFeatureDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

DigitrafficFeatureDto _$DigitrafficFeatureDtoFromJson(
  Map<String, dynamic> json,
) => DigitrafficFeatureDto(
  type: json['type'] as String,
  geometry: DigitrafficGeometryDto.fromJson(
    json['geometry'] as Map<String, dynamic>,
  ),
  properties: DigitrafficPropertiesDto.fromJson(
    json['properties'] as Map<String, dynamic>,
  ),
);

DigitrafficGeometryDto _$DigitrafficGeometryDtoFromJson(
  Map<String, dynamic> json,
) => DigitrafficGeometryDto(
  type: json['type'] as String,
  coordinates: (json['coordinates'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
);

DigitrafficPropertiesDto _$DigitrafficPropertiesDtoFromJson(
  Map<String, dynamic> json,
) => DigitrafficPropertiesDto(
  mmsi: (json['mmsi'] as num).toInt(),
  sog: (json['sog'] as num).toDouble(),
  cog: (json['cog'] as num).toDouble(),
  navStatus: (json['navStat'] as num?)?.toInt() ?? 0,
  timestampMs: (json['timestampExternal'] as num?)?.toInt(),
  heading: (json['heading'] as num?)?.toDouble(),
  name: json['name'] as String?,
  shipType: (json['shipType'] as num?)?.toInt(),
);
