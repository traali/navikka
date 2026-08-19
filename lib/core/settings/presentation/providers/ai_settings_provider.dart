import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/settings/domain/entities/ai_feature_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AiSettingsNotifier extends Notifier<AiFeatureSettings> {
  static const _keyWeatherAi = 'ai_setting_weather';
  static const _keyRouteAi = 'ai_setting_route';
  static const _keyTechnicalCopilot = 'ai_setting_technical_copilot';
  static const _keyVoiceCopilot = 'ai_setting_voice_copilot';
  static const _keyLogbookAi = 'ai_setting_logbook';
  static const _keyWaveImpactAi = 'ai_setting_wave_impact';

  @override
  AiFeatureSettings build() {
    _loadPreferences();
    return const AiFeatureSettings();
  }

  Future<void> _loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      state = AiFeatureSettings(
        weatherAiEnabled: prefs.getBool(_keyWeatherAi) ?? true,
        routeAiEnabled: prefs.getBool(_keyRouteAi) ?? true,
        technicalCopilotEnabled: prefs.getBool(_keyTechnicalCopilot) ?? true,
        voiceCopilotEnabled: prefs.getBool(_keyVoiceCopilot) ?? true,
        logbookAiEnabled: prefs.getBool(_keyLogbookAi) ?? true,
        waveImpactAiEnabled: prefs.getBool(_keyWaveImpactAi) ?? true,
      );
    } catch (_) {
      // Default to all enabled on initial error
    }
  }

  Future<void> toggleWeatherAi(bool enabled) async {
    state = state.copyWith(weatherAiEnabled: enabled);
    await _persistBool(_keyWeatherAi, enabled);
  }

  Future<void> toggleRouteAi(bool enabled) async {
    state = state.copyWith(routeAiEnabled: enabled);
    await _persistBool(_keyRouteAi, enabled);
  }

  Future<void> toggleTechnicalCopilot(bool enabled) async {
    state = state.copyWith(technicalCopilotEnabled: enabled);
    await _persistBool(_keyTechnicalCopilot, enabled);
  }

  Future<void> toggleVoiceCopilot(bool enabled) async {
    state = state.copyWith(voiceCopilotEnabled: enabled);
    await _persistBool(_keyVoiceCopilot, enabled);
  }

  Future<void> toggleLogbookAi(bool enabled) async {
    state = state.copyWith(logbookAiEnabled: enabled);
    await _persistBool(_keyLogbookAi, enabled);
  }

  Future<void> toggleWaveImpactAi(bool enabled) async {
    state = state.copyWith(waveImpactAiEnabled: enabled);
    await _persistBool(_keyWaveImpactAi, enabled);
  }

  Future<void> _persistBool(String key, bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(key, value);
    } catch (_) {}
  }
}

final aiSettingsProvider =
    NotifierProvider<AiSettingsNotifier, AiFeatureSettings>(
      AiSettingsNotifier.new,
    );
