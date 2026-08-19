import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';

void main() {
  group('MapCameraPosition', () {
    test('initial state matches build defaults', () {
      final container = ProviderContainer();
      final state = container.read(mapCameraPositionProvider);

      expect(state.center, const LatLng(60.155, 24.89));
      expect(state.zoom, 14.0);
    });

    test('update reflects new center and zoom', () {
      final container = ProviderContainer();
      const newCenter = LatLng(61, 25);
      const newZoom = 15.0;

      container
          .read(mapCameraPositionProvider.notifier)
          .update(newCenter, newZoom);

      final state = container.read(mapCameraPositionProvider);
      expect(state.center, newCenter);
      expect(state.zoom, newZoom);
    });

    test(
      'update ignores identical values to prevent unnecessary state changes',
      () {
        final container = ProviderContainer();
        final originalState = container.read(mapCameraPositionProvider);

        container
            .read(mapCameraPositionProvider.notifier)
            .update(
              LatLng(
                originalState.center.latitude,
                originalState.center.longitude,
              ),
              originalState.zoom,
            );

        final newState = container.read(mapCameraPositionProvider);
        // MapCameraState doesn't have custom equality, but we can check if it's the same instance
        // if update() didn't assign state = ..., then it's the same.
        expect(identical(originalState, newState), true);
      },
    );
  });

  testWidgets(
    'API camera publishes during continuous movement and trails the latest',
    (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final subscription = container.listen<MapCameraState>(
        debouncedMapCameraPositionProvider,
        (_, _) {},
      );
      addTearDown(subscription.close);
      final notifier = container.read(mapCameraPositionProvider.notifier);

      for (var i = 1; i <= 8; i++) {
        notifier.update(LatLng(60 + i / 1000, 24), 14);
        await tester.pump(const Duration(milliseconds: 100));
      }

      final duringMovement = container.read(
        debouncedMapCameraPositionProvider,
      );
      expect(
        duringMovement.center.latitude,
        greaterThan(60),
        reason: 'continuous movement must not starve camera consumers',
      );

      await tester.pump(DebouncedMapCameraPosition.updateInterval);
      expect(
        container.read(debouncedMapCameraPositionProvider).center,
        const LatLng(60.008, 24),
      );
    },
  );
}
