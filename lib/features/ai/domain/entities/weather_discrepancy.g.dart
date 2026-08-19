// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_discrepancy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeatherDiscrepancy _$WeatherDiscrepancyFromJson(Map<String, dynamic> json) =>
    _WeatherDiscrepancy(
      status: $enumDecode(_$SafetyStatusEnumMap, json['status']),
      message: json['message'] as String,
      windDeltaMs: (json['windDeltaMs'] as num).toDouble(),
      waveDeltaM: (json['waveDeltaM'] as num).toDouble(),
      pressureDeltaHpa: (json['pressureDeltaHpa'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$WeatherDiscrepancyToJson(_WeatherDiscrepancy instance) =>
    <String, dynamic>{
      'status': _$SafetyStatusEnumMap[instance.status]!,
      'message': instance.message,
      'windDeltaMs': instance.windDeltaMs,
      'waveDeltaM': instance.waveDeltaM,
      'pressureDeltaHpa': instance.pressureDeltaHpa,
      'timestamp': instance.timestamp.toIso8601String(),
    };

const _$SafetyStatusEnumMap = {
  SafetyStatus.green: 'green',
  SafetyStatus.yellow: 'yellow',
  SafetyStatus.orange: 'orange',
  SafetyStatus.red: 'red',
};
