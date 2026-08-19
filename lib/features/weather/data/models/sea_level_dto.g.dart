// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sea_level_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SeaLevelDto _$SeaLevelDtoFromJson(Map<String, dynamic> json) => _SeaLevelDto(
  timestamp: DateTime.parse(json['timestamp'] as String),
  location: const LatLngConverter().fromJson(
    json['location'] as Map<String, dynamic>,
  ),
  stationName: json['stationName'] as String?,
  seaLevel: (json['seaLevel'] as num?)?.toDouble(),
);

Map<String, dynamic> _$SeaLevelDtoToJson(_SeaLevelDto instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'location': const LatLngConverter().toJson(instance.location),
      'stationName': instance.stationName,
      'seaLevel': instance.seaLevel,
    };
