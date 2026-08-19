import 'package:json_annotation/json_annotation.dart';

part 'digitraffic_geojson_dto.g.dart';

@JsonSerializable(createToJson: false)
class DigitrafficFeatureCollectionDto {
  final String type;
  final List<DigitrafficFeatureDto> features;

  const DigitrafficFeatureCollectionDto({
    required this.type,
    required this.features,
  });

  factory DigitrafficFeatureCollectionDto.fromJson(Map<String, dynamic> json) =>
      _$DigitrafficFeatureCollectionDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class DigitrafficFeatureDto {
  final String type;
  final DigitrafficGeometryDto geometry;
  final DigitrafficPropertiesDto properties;

  const DigitrafficFeatureDto({
    required this.type,
    required this.geometry,
    required this.properties,
  });

  factory DigitrafficFeatureDto.fromJson(Map<String, dynamic> json) =>
      _$DigitrafficFeatureDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class DigitrafficGeometryDto {
  final String type;

  /// GeoJSON coordinate pair: [longitude, latitude]
  final List<double> coordinates;

  const DigitrafficGeometryDto({
    required this.type,
    required this.coordinates,
  });

  double get longitude => coordinates.isNotEmpty ? coordinates[0] : 0.0;
  double get latitude => coordinates.length > 1 ? coordinates[1] : 0.0;

  factory DigitrafficGeometryDto.fromJson(Map<String, dynamic> json) =>
      _$DigitrafficGeometryDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class DigitrafficPropertiesDto {
  final int mmsi;
  final double sog;
  final double cog;
  final double? heading;
  @JsonKey(name: 'navStat', defaultValue: 0)
  final int navStatus;
  @JsonKey(name: 'timestampExternal')
  final int? timestampMs;
  final String? name;
  final int? shipType;

  const DigitrafficPropertiesDto({
    required this.mmsi,
    required this.sog,
    required this.cog,
    this.navStatus = 0,
    this.timestampMs,
    this.heading,
    this.name,
    this.shipType,
  });

  factory DigitrafficPropertiesDto.fromJson(Map<String, dynamic> json) =>
      _$DigitrafficPropertiesDtoFromJson(json);
}
