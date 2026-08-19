import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/models/bbox.dart';
import 'package:sakkoja/features/fishing/domain/entities/fishing_restriction.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_data_providers.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';

// Helper to create a dummy restriction
FishingRestriction createRestriction({
  required String id,
  required BBox? bbox,
}) {
  return FishingRestriction(
    id: id,
    title: 'Test Restriction $id',
    rings: [], // Empty rings for test, we rely on cached bbox
    boundingBox: bbox,
    isCurrentlyActive: true,
    category: 'Test',
  );
}

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer(
      overrides: [
        // Mock the upstream data source (filtered restrictions)
        filteredFishingRestrictionsProvider.overrideWith((ref) async {
          return [
            // 1. Center of Helsinki (Visible at default camera)
            createRestriction(
              id: 'visible',
              bbox: const BBox(
                minLat: 60.15,
                maxLat: 60.16,
                minLon: 24.90,
                maxLon: 24.91,
              ),
            ),
            // 2. Far away (Oulu ~500km away) - Should be culled even with 30km buffer
            createRestriction(
              id: 'hidden',
              bbox: const BBox(
                minLat: 65,
                maxLat: 65.1,
                minLon: 25.4,
                maxLon: 25.5,
              ),
            ),
            // 3. No BBox (Should always be visible fallback)
            createRestriction(id: 'always_visible', bbox: null),
          ];
        }),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test(
    'displayedFishingRestrictions culls items outside 30km viewport',
    () async {
      // Arrange: Camera at Helsinki (60.155, 24.89)
      // Default zoom is 14.0.
      // Provider uses 30km buffer.
      // Oulu is ~500km away, so it should be culled.

      // IMPORTANT: Must wait for upstream async provider to resolve first
      await container.read(filteredFishingRestrictionsProvider.future);

      // Act - SYNC provider reads from resolved AsyncValue
      final visible = container.read(displayedFishingRestrictionsProvider);

      // Assert
      expect(visible.map((r) => r.id), contains('visible'));
      expect(visible.map((r) => r.id), contains('always_visible'));
      expect(visible.map((r) => r.id), isNot(contains('hidden')));
      expect(visible.length, 2);
    },
  );

  test('displayedFishingRestrictions updates when camera moves', () async {
    // IMPORTANT: Must wait for upstream async provider to resolve first
    await container.read(filteredFishingRestrictionsProvider.future);

    // Arrange: Move camera to Oulu
    final cameraNotifier = container.read(mapCameraPositionProvider.notifier);
    cameraNotifier.update(const LatLng(65, 25.4), 14);

    // Act - SYNC provider reads from resolved AsyncValue
    final visible = container.read(displayedFishingRestrictionsProvider);

    // Assert
    // Now Oulu should be visible, Helsinki hidden (>30km away)
    expect(visible.map((r) => r.id), contains('hidden'));
    expect(visible.map((r) => r.id), contains('always_visible'));
    expect(visible.map((r) => r.id), isNot(contains('visible')));
    expect(visible.length, 2);
  });
}
