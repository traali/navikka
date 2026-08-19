// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_insight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeatherInsight _$WeatherInsightFromJson(Map<String, dynamic> json) =>
    _WeatherInsight(
      status: $enumDecode(_$SafetyStatusEnumMap, json['status']),
      advice: json['advice'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isAIInference: json['isAIInference'] as bool? ?? false,
      insightId: json['insightId'] as String?,
      reasons:
          (json['reasons'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      riskScore: (json['riskScore'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$WeatherInsightToJson(_WeatherInsight instance) =>
    <String, dynamic>{
      'status': _$SafetyStatusEnumMap[instance.status]!,
      'advice': instance.advice,
      'timestamp': instance.timestamp.toIso8601String(),
      'isAIInference': instance.isAIInference,
      'insightId': instance.insightId,
      'reasons': instance.reasons,
      'riskScore': instance.riskScore,
    };

const _$SafetyStatusEnumMap = {
  SafetyStatus.green: 'green',
  SafetyStatus.yellow: 'yellow',
  SafetyStatus.orange: 'orange',
  SafetyStatus.red: 'red',
};

_SkipperSettings _$SkipperSettingsFromJson(
  Map<String, dynamic> json,
) => _SkipperSettings(
  isAIEnabled: json['isAIEnabled'] as bool? ?? true,
  hasAcknowledgedAISafety: json['hasAcknowledgedAISafety'] as bool? ?? false,
  forecastWindowHours: (json['forecastWindowHours'] as num?)?.toInt() ?? 3,
  thresholds: json['thresholds'] == null
      ? const SkipperThresholds()
      : SkipperThresholds.fromJson(json['thresholds'] as Map<String, dynamic>),
  aiApiKey: json['aiApiKey'] as String?,
  aiModelId:
      json['aiModelId'] as String? ?? 'meta-llama/llama-3.3-70b-instruct:free',
);

Map<String, dynamic> _$SkipperSettingsToJson(_SkipperSettings instance) =>
    <String, dynamic>{
      'isAIEnabled': instance.isAIEnabled,
      'hasAcknowledgedAISafety': instance.hasAcknowledgedAISafety,
      'forecastWindowHours': instance.forecastWindowHours,
      'thresholds': instance.thresholds,
      'aiApiKey': instance.aiApiKey,
      'aiModelId': instance.aiModelId,
    };

_SkipperThresholds _$SkipperThresholdsFromJson(Map<String, dynamic> json) =>
    _SkipperThresholds(
      windYellowMs: (json['windYellowMs'] as num?)?.toDouble() ?? 10.0,
      windOrangeMs: (json['windOrangeMs'] as num?)?.toDouble() ?? 12.0,
      windRedMs: (json['windRedMs'] as num?)?.toDouble() ?? 14.0,
      waveYellowM: (json['waveYellowM'] as num?)?.toDouble() ?? 1.0,
      waveOrangeM: (json['waveOrangeM'] as num?)?.toDouble() ?? 1.5,
      waveRedM: (json['waveRedM'] as num?)?.toDouble() ?? 2.5,
      pressureDropThresholdHpa:
          (json['pressureDropThresholdHpa'] as num?)?.toDouble() ?? 2.0,
    );

Map<String, dynamic> _$SkipperThresholdsToJson(_SkipperThresholds instance) =>
    <String, dynamic>{
      'windYellowMs': instance.windYellowMs,
      'windOrangeMs': instance.windOrangeMs,
      'windRedMs': instance.windRedMs,
      'waveYellowM': instance.waveYellowM,
      'waveOrangeM': instance.waveOrangeM,
      'waveRedM': instance.waveRedM,
      'pressureDropThresholdHpa': instance.pressureDropThresholdHpa,
    };
