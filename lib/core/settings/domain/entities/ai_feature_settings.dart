import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_feature_settings.freezed.dart';
part 'ai_feature_settings.g.dart';

/// User preferences for individual on-device Marine AI features.
/// Each feature can be toggled on/off independently.
@freezed
abstract class AiFeatureSettings with _$AiFeatureSettings {
  const factory AiFeatureSettings({
    /// Master toggle for weather and situational awareness AI.
    @Default(true) bool weatherAiEnabled,

    /// Master toggle for intelligent route analysis and weather routing.
    @Default(true) bool routeAiEnabled,

    /// Master toggle for offline technical marine copilot and engine troubleshooting.
    @Default(true) bool technicalCopilotEnabled,

    /// Master toggle for hands-free voice marine copilot ("Hei Kippari" / "Hey Skipper").
    @Default(true) bool voiceCopilotEnabled,

    /// Master toggle for automated AI voyage recap and smart logbook.
    @Default(true) bool logbookAiEnabled,

    /// Master toggle for IMU accelerometer wave slamming & sea roughness AI.
    @Default(true) bool waveImpactAiEnabled,
  }) = _AiFeatureSettings;

  factory AiFeatureSettings.fromJson(Map<String, dynamic> json) =>
      _$AiFeatureSettingsFromJson(json);
}
