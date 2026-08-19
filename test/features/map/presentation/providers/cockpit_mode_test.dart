import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/features/map/presentation/providers/cockpit_mode_provider.dart';

void main() {
  group('CockpitModeProvider Tests', () {
    test('Default mode is cruising', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(cockpitModeProvider);
      expect(state.mode, CockpitMode.cruising);
      expect(state.isAutoTriggered, isFalse);
    });

    test('Manually setting mode updates state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(cockpitModeProvider.notifier);
      notifier.setMode(CockpitMode.harbor);

      final state = container.read(cockpitModeProvider);
      expect(state.mode, CockpitMode.harbor);
      expect(state.isAutoTriggered, isFalse);
    });

    test('Can switch to fishing and emergency modes', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(cockpitModeProvider.notifier);
      notifier.setMode(CockpitMode.fishing);
      expect(container.read(cockpitModeProvider).mode, CockpitMode.fishing);

      notifier.setMode(CockpitMode.emergency);
      expect(container.read(cockpitModeProvider).mode, CockpitMode.emergency);
    });
  });
}
