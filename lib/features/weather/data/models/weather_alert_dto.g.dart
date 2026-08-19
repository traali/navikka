// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_alert_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeatherAlertDto _$WeatherAlertDtoFromJson(Map<String, dynamic> json) =>
    _WeatherAlertDto(
      id: json['id'] as String,
      event: json['event'] as String,
      description: json['description'] as String,
      severity: json['severity'] as String,
      onset: DateTime.parse(json['onset'] as String),
      expires: DateTime.parse(json['expires'] as String),
      polygon: const LatLngListConverter().fromJson(json['polygon'] as List),
      areaDescription: json['areaDescription'] as String,
      issued: json['issued'] == null
          ? null
          : DateTime.parse(json['issued'] as String),
    );

Map<String, dynamic> _$WeatherAlertDtoToJson(_WeatherAlertDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event': instance.event,
      'description': instance.description,
      'severity': instance.severity,
      'onset': instance.onset.toIso8601String(),
      'expires': instance.expires.toIso8601String(),
      'polygon': const LatLngListConverter().toJson(instance.polygon),
      'areaDescription': instance.areaDescription,
      'issued': instance.issued?.toIso8601String(),
    };
