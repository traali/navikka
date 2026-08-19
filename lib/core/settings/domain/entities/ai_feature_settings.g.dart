// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_feature_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiFeatureSettings _$AiFeatureSettingsFromJson(Map<String, dynamic> json) =>
    _AiFeatureSettings(
      weatherAiEnabled: json['weatherAiEnabled'] as bool? ?? true,
      routeAiEnabled: json['routeAiEnabled'] as bool? ?? true,
      technicalCopilotEnabled: json['technicalCopilotEnabled'] as bool? ?? true,
      voiceCopilotEnabled: json['voiceCopilotEnabled'] as bool? ?? true,
      logbookAiEnabled: json['logbookAiEnabled'] as bool? ?? true,
      waveImpactAiEnabled: json['waveImpactAiEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$AiFeatureSettingsToJson(_AiFeatureSettings instance) =>
    <String, dynamic>{
      'weatherAiEnabled': instance.weatherAiEnabled,
      'routeAiEnabled': instance.routeAiEnabled,
      'technicalCopilotEnabled': instance.technicalCopilotEnabled,
      'voiceCopilotEnabled': instance.voiceCopilotEnabled,
      'logbookAiEnabled': instance.logbookAiEnabled,
      'waveImpactAiEnabled': instance.waveImpactAiEnabled,
    };
