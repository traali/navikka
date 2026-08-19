import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/speed_limits/presentation/providers/bbox_fetch_throttle_provider.dart';

/// Integration tests for provider fallback behavior under network failure scenarios.
void main() {
  // Test data
  const testLocation = LatLng(60.155, 24.89); // Lauttasaari

  group('BboxFetchThrottle (Smart Grid)', () {
    test('U-THROTTLE-001: shouldFetch returns true when never fetched', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final throttle = container.read(bboxFetchThrottleProvider.notifier);

      expect(throttle.shouldFetch(testLocation), isTrue);
    });

    test(
      'U-THROTTLE-002: shouldFetch returns false for same location (Same Tile)',
      () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final throttle = container.read(bboxFetchThrottleProvider.notifier);

        // 1. Fetch at location
        throttle.markFetched(testLocation);

        // 2. Check same location again -> Should be false (same tile)
        expect(throttle.shouldFetch(testLocation), isFalse);
      },
    );

    test(
      'U-THROTTLE-003: shouldFetch returns false for nearby location (Same Tile)',
      () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final throttle = container.read(bboxFetchThrottleProvider.notifier);

        throttle.markFetched(testLocation);

        // A location very close by (~100m) should definitely be in same tile
        const nearbyLocation = LatLng(60.156, 24.891);

        expect(throttle.shouldFetch(nearbyLocation), isFalse);
      },
    );

    test(
      'U-THROTTLE-004: shouldFetch returns true for distant location (New Tile)',
      () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final throttle = container.read(bboxFetchThrottleProvider.notifier);

        throttle.markFetched(testLocation);

        // A location far away (e.g. Tampere) requires new fetch
        const distantLocation = LatLng(61.49, 23.78);

        expect(throttle.shouldFetch(distantLocation), isTrue);
      },
    );

    test('U-THROTTLE-005: shouldFetch handles null location gracefully', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final throttle = container.read(bboxFetchThrottleProvider.notifier);

      expect(throttle.shouldFetch(null), isFalse);
    });

    test('U-THROTTLE-006: reset clears throttle state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final throttle = container.read(bboxFetchThrottleProvider.notifier);

      throttle.markFetched(testLocation);
      expect(throttle.shouldFetch(testLocation), isFalse);

      throttle.reset();

      // Should be true again as state was cleared
      expect(throttle.shouldFetch(testLocation), isTrue);
    });
  });
}
