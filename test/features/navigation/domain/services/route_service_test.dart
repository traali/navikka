import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/features/navigation/domain/entities/waypoint_entity.dart';
import 'package:sakkoja/features/navigation/domain/repositories/navigation_repository.dart';
import 'package:sakkoja/features/navigation/domain/services/route_service.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';
import 'package:sakkoja/features/speed_limits/domain/repositories/speed_limit_repository.dart';

// Mock repository
class MockNavigationRepository extends Mock implements NavigationRepository {}

class MockSpeedLimitRepository extends Mock implements SpeedLimitRepository {}

void main() {
  late RouteService routeService;
  late MockNavigationRepository mockRepo;
  late MockSpeedLimitRepository mockSpeedLimitRepo;

  setUp(() {
    mockRepo = MockNavigationRepository();
    mockSpeedLimitRepo = MockSpeedLimitRepository();
    routeService = RouteService(mockRepo, mockSpeedLimitRepo);
  });

  group('RouteService Math Tests', () {
    test('Haversine distance calculation is accurate', () {
      // Helsinki (60.1699, 24.9384) to Tallinn (59.4370, 24.7536)
      // Distance is roughly 82 km (44 NM).

      const wp1 = WaypointEntity(
        id: 1,
        routeId: 1,
        lat: 60.1699,
        lon: 24.9384,
        orderIndex: 0,
      );
      const wp2 = WaypointEntity(
        id: 2,
        routeId: 1,
        lat: 59.4370,
        lon: 24.7536,
        orderIndex: 1,
      );

      final distance = routeService.calculateTotalDistance([wp1, wp2]);

      // Allow slight variance due to spherical model vs geoid
      // 82000 meters +/- 1000m
      expect(distance, closeTo(82000, 1000));
    });

    test('ETA Calculation logic', () {
      // 10000 meters ~ 5.4 NM.
      // At 10 knots, speed = 5.144 m/s.
      // Time = 10000 / 5.144 = 1943 seconds ~ 32 minutes.

      final eta = routeService.calculateETA(10000, 10);
      expect(eta, closeTo(32, 1));
    });

    test('Zero distance for single waypoint', () {
      const wp1 = WaypointEntity(
        id: 1,
        routeId: 1,
        lat: 60,
        lon: 25,
        orderIndex: 0,
      );
      final distance = routeService.calculateTotalDistance([wp1]);
      expect(distance, 0.0);
    });

    test(
      'calculateEnhancedStats correctly identifies over-speed segments',
      () async {
        // 1. Mock Speed Limits
        final zone = SpeedLimitZone(
          id: 'zone10',
          speedLimitKmh: 10,
          rings: [
            [
              const LatLng(60.16, 24.93),
              const LatLng(60.18, 24.93),
              const LatLng(60.18, 24.95),
              const LatLng(60.16, 24.95),
              const LatLng(60.16, 24.93),
            ],
          ],
        );

        when(
          () => mockSpeedLimitRepo.getSpeedLimits(),
        ).thenAnswer((_) async => Right([zone]));

        // 2. Waypoints passing through zone
        const wp1 = WaypointEntity(
          id: 1,
          routeId: 1,
          lat: 60.165,
          lon: 24.935,
          orderIndex: 0,
        );
        const wp2 = WaypointEntity(
          id: 2,
          routeId: 1,
          lat: 60.175,
          lon: 24.945,
          orderIndex: 1,
        );

        final stats = await routeService.calculateEnhancedStats(
          waypoints: [wp1, wp2],
          cruisingSpeedKmh: 25, // Over the 10 limit
        );

        expect(stats.segments.length, 1);
        expect(stats.segments.first.isOverSpeed, isTrue);
        expect(stats.segments.first.speedLimitKmh, 10);
      },
    );

    test(
      'calculateEnhancedStats catches segments via 3-point sampling when midpoint misses zone',
      () async {
        // Zone: small 10 km/h limit area
        final zone = SpeedLimitZone(
          id: 'zone10',
          speedLimitKmh: 10,
          rings: [
            [
              const LatLng(60.16, 24.93),
              const LatLng(60.18, 24.93),
              const LatLng(60.18, 24.95),
              const LatLng(60.16, 24.95),
              const LatLng(60.16, 24.93),
            ],
          ],
        );

        when(
          () => mockSpeedLimitRepo.getSpeedLimits(),
        ).thenAnswer((_) async => Right([zone]));

        // FIX #166: Long segment where midpoint is OUTSIDE zone
        // but one endpoint is INSIDE. Midpoint-only check would miss this.
        // Start inside (60.165, 24.935), end far away, midpoint outside zone.
        const wp1 = WaypointEntity(
          id: 1,
          routeId: 1,
          lat: 60.165,
          lon: 24.935, // Inside zone
          orderIndex: 0,
        );
        const wp2 = WaypointEntity(
          id: 2,
          routeId: 1,
          lat: 60.25, // Far north, outside zone
          lon: 24.935,
          orderIndex: 1,
        );

        final stats = await routeService.calculateEnhancedStats(
          waypoints: [wp1, wp2],
          cruisingSpeedKmh: 25, // Over the 10 limit
        );

        // With 3-point sampling, start point hits the zone
        expect(stats.segments.length, 1);
        expect(stats.segments.first.isOverSpeed, isTrue);
        expect(stats.segments.first.speedLimitKmh, 10);
      },
    );
  });
}
