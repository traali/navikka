import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/settings/domain/entities/ui_element_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiElementPreferencesNotifier extends Notifier<UiElementPreferences> {
  static const _keySpeedHud = 'ui_elem_speed_hud';
  static const _keyWaveImpactHud = 'ui_elem_wave_impact_hud';
  static const _keyCompassHud = 'ui_elem_compass_hud';
  static const _keyScaleBar = 'ui_elem_scale_bar';
  static const _keyToolDock = 'ui_elem_tool_dock';
  static const _keyZoomButtons = 'ui_elem_zoom_buttons';
  static const _keyVoiceButton = 'ui_elem_voice_button';
  static const _keyTopCapsule = 'ui_elem_top_capsule';
  static const _keyVoyageRecordButton = 'ui_elem_voyage_record_button';
  static const _keyKeepScreenAwake = 'ui_elem_keep_screen_awake';

  @override
  UiElementPreferences build() {
    _loadPreferences();
    return const UiElementPreferences();
  }

  Future<void> _loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      state = UiElementPreferences(
        showSpeedHud: prefs.getBool(_keySpeedHud) ?? true,
        showWaveImpactHud: prefs.getBool(_keyWaveImpactHud) ?? true,
        showCompassHud: prefs.getBool(_keyCompassHud) ?? true,
        showScaleBar: prefs.getBool(_keyScaleBar) ?? true,
        showToolDock: prefs.getBool(_keyToolDock) ?? true,
        showZoomButtons: prefs.getBool(_keyZoomButtons) ?? true,
        showVoiceButton: prefs.getBool(_keyVoiceButton) ?? true,
        showTopCapsule: prefs.getBool(_keyTopCapsule) ?? true,
        showVoyageRecordButton: prefs.getBool(_keyVoyageRecordButton) ?? true,
        keepScreenAwake: prefs.getBool(_keyKeepScreenAwake) ?? true,
      );
    } catch (_) {
      // Default fallback
    }
  }

  Future<void> toggleSpeedHud(bool enabled) async {
    state = state.copyWith(showSpeedHud: enabled);
    await _persistBool(_keySpeedHud, enabled);
  }

  Future<void> toggleWaveImpactHud(bool enabled) async {
    state = state.copyWith(showWaveImpactHud: enabled);
    await _persistBool(_keyWaveImpactHud, enabled);
  }

  Future<void> toggleCompassHud(bool enabled) async {
    state = state.copyWith(showCompassHud: enabled);
    await _persistBool(_keyCompassHud, enabled);
  }

  Future<void> toggleScaleBar(bool enabled) async {
    state = state.copyWith(showScaleBar: enabled);
    await _persistBool(_keyScaleBar, enabled);
  }

  Future<void> toggleToolDock(bool enabled) async {
    state = state.copyWith(showToolDock: enabled);
    await _persistBool(_keyToolDock, enabled);
  }

  Future<void> toggleZoomButtons(bool enabled) async {
    state = state.copyWith(showZoomButtons: enabled);
    await _persistBool(_keyZoomButtons, enabled);
  }

  Future<void> toggleVoiceButton(bool enabled) async {
    state = state.copyWith(showVoiceButton: enabled);
    await _persistBool(_keyVoiceButton, enabled);
  }

  Future<void> toggleTopCapsule(bool enabled) async {
    state = state.copyWith(showTopCapsule: enabled);
    await _persistBool(_keyTopCapsule, enabled);
  }

  Future<void> toggleVoyageRecordButton(bool enabled) async {
    state = state.copyWith(showVoyageRecordButton: enabled);
    await _persistBool(_keyVoyageRecordButton, enabled);
  }

  Future<void> toggleKeepScreenAwake(bool enabled) async {
    state = state.copyWith(keepScreenAwake: enabled);
    await _persistBool(_keyKeepScreenAwake, enabled);
  }

  Future<void> _persistBool(String key, bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(key, value);
    } catch (_) {}
  }
}

final uiElementPreferencesProvider =
    NotifierProvider<UiElementPreferencesNotifier, UiElementPreferences>(
  UiElementPreferencesNotifier.new,
);
