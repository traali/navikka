import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/settings/domain/entities/ui_element_preferences.dart';
import 'package:sakkoja/core/settings/presentation/providers/ui_element_preferences_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  group('UiElementPreferences', () {
    test('defaults to all elements enabled', () {
      const prefs = UiElementPreferences();
      expect(prefs.showSpeedHud, isTrue);
      expect(prefs.showWaveImpactHud, isTrue);
      expect(prefs.showCompassHud, isTrue);
      expect(prefs.showScaleBar, isTrue);
      expect(prefs.showToolDock, isTrue);
      expect(prefs.showZoomButtons, isTrue);
      expect(prefs.showVoiceButton, isTrue);
      expect(prefs.showTopCapsule, isTrue);
      expect(prefs.showVoyageRecordButton, isTrue);
      expect(prefs.keepScreenAwake, isTrue);
    });

    test('copyWith updates specific preferences', () {
      const prefs = UiElementPreferences();
      final updated = prefs.copyWith(
        showSpeedHud: false,
        showToolDock: false,
        showVoyageRecordButton: false,
      );
      expect(updated.showSpeedHud, isFalse);
      expect(updated.showToolDock, isFalse);
      expect(updated.showVoyageRecordButton, isFalse);
      expect(updated.showCompassHud, isTrue);
      expect(updated.showWaveImpactHud, isTrue);
    });

    test('UiElementPreferencesNotifier toggles states correctly', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(uiElementPreferencesProvider.notifier);
      expect(container.read(uiElementPreferencesProvider).showSpeedHud, isTrue);

      await notifier.toggleSpeedHud(false);
      expect(container.read(uiElementPreferencesProvider).showSpeedHud, isFalse);

      await notifier.toggleVoyageRecordButton(false);
      expect(container.read(uiElementPreferencesProvider).showVoyageRecordButton, isFalse);

      await notifier.toggleToolDock(false);
      expect(container.read(uiElementPreferencesProvider).showToolDock, isFalse);

      await notifier.toggleSpeedHud(true);
      expect(container.read(uiElementPreferencesProvider).showSpeedHud, isTrue);
    });
  });
}
