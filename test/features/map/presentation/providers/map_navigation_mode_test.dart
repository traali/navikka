import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/features/map/presentation/providers/map_auto_follow_provider.dart';

void main() {
  group('MapNavigationModeNotifier Tests', () {
    test('Initial state is MapNavigationMode.boatingHeadingUp', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final mode = container.read(mapNavigationModeProvider);
      expect(mode, MapNavigationMode.boatingHeadingUp);
    });

    test('toggle() switches between boatingHeadingUp and northUp', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(mapNavigationModeProvider.notifier);

      notifier.toggle();
      expect(
        container.read(mapNavigationModeProvider),
        MapNavigationMode.northUp,
      );

      notifier.toggle();
      expect(
        container.read(mapNavigationModeProvider),
        MapNavigationMode.boatingHeadingUp,
      );
    });

    test('setMode() explicitly sets target mode', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(mapNavigationModeProvider.notifier);

      notifier.setMode(MapNavigationMode.northUp);
      expect(
        container.read(mapNavigationModeProvider),
        MapNavigationMode.northUp,
      );
    });
  });

  group('Map3dTiltNotifier Tests', () {
    test('Initial 3D tilt state is true', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(map3dTiltProvider), isTrue);
    });

    test('toggle() switches 3D tilt state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(map3dTiltProvider.notifier);
      notifier.toggle();
      expect(container.read(map3dTiltProvider), isFalse);

      notifier.toggle();
      expect(container.read(map3dTiltProvider), isTrue);
    });

    test('setTilt() explicitly sets 3D tilt state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(map3dTiltProvider.notifier);
      notifier.setTilt(false);
      expect(container.read(map3dTiltProvider), isFalse);
    });
  });
}
