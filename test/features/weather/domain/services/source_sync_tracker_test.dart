import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/weather/domain/services/source_sync_tracker.dart';

void main() {
  group('SourceSyncTracker', () {
    test('first sync always returns true', () {
      final tracker = SourceSyncTracker(name: 'test');
      expect(
        tracker.shouldSyncForBoat(
          ttl: const Duration(minutes: 10),
          distanceThresholdKm: 25.0,
          boatPosition: const LatLng(60.155, 24.89),
        ),
        isTrue,
      );
    });

    test('returns false if TTL not expired and boat not moved', () {
      final tracker = SourceSyncTracker(name: 'test');
      tracker.markSynced(const LatLng(60.155, 24.89));
      expect(
        tracker.shouldSyncForBoat(
          ttl: const Duration(minutes: 10),
          distanceThresholdKm: 25.0,
          boatPosition: const LatLng(60.155, 24.89), // same position
        ),
        isFalse,
      );
    });

    test('returns true if boat moved beyond threshold', () {
      final tracker = SourceSyncTracker(name: 'test');
      tracker.markSynced(const LatLng(60.155, 24.89));
      expect(
        tracker.shouldSyncForBoat(
          ttl: const Duration(hours: 1), // TTL not expired
          distanceThresholdKm: 15.0,
          boatPosition: const LatLng(60.30, 24.89), // ~16 km north
        ),
        isTrue,
      );
    });

    test('uses TTL when the boat has not moved', () {
      var now = DateTime(2026, 7, 27, 12);
      final tracker = SourceSyncTracker(name: 'test', now: () => now);
      const boat = LatLng(60.155, 24.89);

      tracker.markSynced(boat);
      now = now.add(const Duration(minutes: 9));
      expect(
        tracker.shouldSyncForBoat(
          ttl: const Duration(minutes: 10),
          distanceThresholdKm: 25,
          boatPosition: boat,
        ),
        isFalse,
      );

      now = now.add(const Duration(minutes: 1));
      expect(
        tracker.shouldSyncForBoat(
          ttl: const Duration(minutes: 10),
          distanceThresholdKm: 25,
          boatPosition: boat,
        ),
        isTrue,
      );
    });

    test('does not sync for every GPS update while the boat stays nearby', () {
      final tracker = SourceSyncTracker(name: 'test');
      const origin = LatLng(60, 25);
      tracker.markSynced(origin);

      var syncs = 0;
      for (var i = 1; i <= 20; i++) {
        final position = LatLng(60 + i / 10000, 25);
        if (tracker.shouldSyncForBoat(
          ttl: const Duration(hours: 1),
          distanceThresholdKm: 1,
          boatPosition: position,
        )) {
          syncs++;
          tracker.markSynced(position);
        }
      }

      expect(syncs, 0);
    });

    test('pan tracking does not change the boat movement reference', () {
      final tracker = SourceSyncTracker(name: 'test');
      const boat = LatLng(60, 25);
      tracker.markSynced(boat);
      tracker.markPanSynced(const LatLng(61, 25));

      expect(
        tracker.shouldSyncForBoat(
          ttl: const Duration(hours: 1),
          distanceThresholdKm: 10,
          boatPosition: const LatLng(60.11, 25),
        ),
        isTrue,
      );
    });

    test('pan cooldown is enforced', () {
      final tracker = SourceSyncTracker(name: 'test');
      tracker.markSynced(const LatLng(60.155, 24.89));
      tracker.markPanSynced(const LatLng(60.5, 25.0));

      // Immediate re-pan should be blocked by cooldown
      expect(
        tracker.shouldSyncForPan(
          panDistanceKm: 20.0,
          panCooldown: const Duration(minutes: 10),
          cameraPosition: const LatLng(61.0, 25.5), // far away
        ),
        isFalse,
      );
    });

    test('reset clears all state', () {
      final tracker = SourceSyncTracker(name: 'test');
      tracker.markSynced(const LatLng(60.155, 24.89));
      tracker.reset();
      expect(tracker.hasSynced, isFalse);
    });

    test('returns false for shouldSync if request is in flight', () {
      final tracker = SourceSyncTracker(name: 'test');
      tracker.startSync();
      expect(tracker.isSyncing, isTrue);

      expect(
        tracker.shouldSyncForBoat(
          ttl: const Duration(minutes: 10),
          distanceThresholdKm: 25.0,
          boatPosition: const LatLng(60.155, 24.89),
        ),
        isFalse,
      );

      expect(
        tracker.shouldSyncForPan(
          panDistanceKm: 20.0,
          panCooldown: const Duration(minutes: 10),
          cameraPosition: const LatLng(61.0, 25.5),
        ),
        isFalse,
      );

      tracker.endSync();
      expect(tracker.isSyncing, isFalse);
    });
  });
}
