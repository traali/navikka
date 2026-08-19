// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_quality_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WaterQualityDto _$WaterQualityDtoFromJson(Map<String, dynamic> json) =>
    _WaterQualityDto(
      timestamp: DateTime.parse(json['timestamp'] as String),
      location: const LatLngConverter().fromJson(
        json['location'] as Map<String, dynamic>,
      ),
      stationName: json['stationName'] as String,
      dissolvedOxygen: (json['dissolvedOxygen'] as num?)?.toDouble(),
      pH: (json['pH'] as num?)?.toDouble(),
      chlorophyllA: (json['chlorophyllA'] as num?)?.toDouble(),
      turbidity: (json['turbidity'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WaterQualityDtoToJson(_WaterQualityDto instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'location': const LatLngConverter().toJson(instance.location),
      'stationName': instance.stationName,
      'dissolvedOxygen': instance.dissolvedOxygen,
      'pH': instance.pH,
      'chlorophyllA': instance.chlorophyllA,
      'turbidity': instance.turbidity,
    };
