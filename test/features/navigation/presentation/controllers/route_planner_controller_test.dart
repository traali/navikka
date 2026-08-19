import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/fishing/domain/entities/fishing_restriction.dart';
import 'package:sakkoja/features/fishing/domain/usecases/get_fishing_restrictions.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_data_providers.dart';
import 'package:sakkoja/features/navigation/domain/entities/waypoint_entity.dart';
import 'package:sakkoja/features/navigation/domain/services/route_service.dart';
import 'package:sakkoja/features/navigation/presentation/providers/navigation_providers.dart';
import 'package:sakkoja/features/vessel/domain/entities/vessel_entity.dart';
import 'package:sakkoja/features/vessel/domain/services/vessel_service.dart';
import 'package:sakkoja/features/vessel/presentation/controllers/vessel_controller.dart';

// Fake instead of Mock to avoid code generation issues
class FakeRouteService implements RouteService {
  @override
  double calculateTotalDistance(List<WaypointEntity> waypoints) {
    if (waypoints.length < 2) return 0;
    return (waypoints.length - 1) * 10.0; // Mock 10m per segment
  }

  @override
  Future<int> createRoute(String name, List<WaypointEntity> waypoints) async {
    return 1;
  }

  @override
  int calculateETA(double distanceMeters, double sogKnots) {
    return 0;
  }

  @override
  Future<RouteStats> calculateEnhancedStats({
    required List<WaypointEntity> waypoints,
    required double cruisingSpeedKmh,
  }) async {
    return RouteStats(
      totalDistanceMeters: calculateTotalDistance(waypoints),
      totalDurationMinutes: 5,
    );
  }
}

class FakeVesselService implements VesselService {
  @override
  Future<VesselEntity?> getSelectedProfile() async => null;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockGetFishingRestrictions extends Mock
    implements GetFishingRestrictions {}

void main() {
  late FakeRouteService fakeService;
  late FakeVesselService fakeVesselService;
  late MockGetFishingRestrictions mockGetFishingRestrictions;
  late ProviderContainer container;

  setUp(() {
    fakeService = FakeRouteService();
    fakeVesselService = FakeVesselService();
    mockGetFishingRestrictions = MockGetFishingRestrictions();
    when(
      () => mockGetFishingRestrictions(
        minLat: any(named: 'minLat'),
        minLng: any(named: 'minLng'),
        maxLat: any(named: 'maxLat'),
        maxLng: any(named: 'maxLng'),
      ),
    ).thenAnswer((_) async => const Right([]));

    container = ProviderContainer(
      overrides: [
        routeServiceProvider.overrideWithValue(fakeService),
        vesselServiceProvider.overrideWithValue(fakeVesselService),
        getFishingRestrictionsProvider.overrideWithValue(
          mockGetFishingRestrictions,
        ),
        displayedFishingRestrictionsProvider.overrideWith((ref) => []),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('Initial state is empty', () {
    final state = container.read(routePlannerControllerProvider);
    expect(state.waypoints, isEmpty);
    expect(state.totalDistanceMeters, 0.0);
  });

  test('Adding waypoint updates state', () async {
    final controller = container.read(routePlannerControllerProvider.notifier);

    await controller.addWaypoint(60, 25);

    final state = container.read(routePlannerControllerProvider);
    expect(state.waypoints.length, 1);
    expect(state.waypoints.first.lat, 60.0);
    expect(state.waypoints.first.orderIndex, 0);
  });

  test('Removing waypoint re-indexes', () async {
    final controller = container.read(routePlannerControllerProvider.notifier);

    await controller.addWaypoint(60, 25);
    await controller.addWaypoint(60.1, 25.1);

    expect(container.read(routePlannerControllerProvider).waypoints.length, 2);

    await controller.removeWaypoint(0);

    final state = container.read(routePlannerControllerProvider);
    expect(state.waypoints.length, 1);
    expect(state.waypoints.first.lat, 60.1);
    expect(state.waypoints.first.orderIndex, 0); // Re-indexed
  });

  test('Reordering waypoints updates order', () async {
    final controller = container.read(routePlannerControllerProvider.notifier);
    await controller.addWaypoint(60, 25); // 0
    await controller.addWaypoint(60.1, 25.1); // 1
    await controller.addWaypoint(60.2, 25.2); // 2

    // Move index 0 to index 2 (end) based on reorderable list view logic
    await controller.reorderWaypoints(0, 3);

    final state = container.read(routePlannerControllerProvider);
    // Expected order: 60.1, 60.2, 60.0
    expect(state.waypoints[0].lat, 60.1);
    expect(state.waypoints[1].lat, 60.2);
    expect(state.waypoints[2].lat, 60.0);

    // Verify order indices
    expect(state.waypoints[0].orderIndex, 0);
    expect(state.waypoints[2].orderIndex, 2);
  });

  test('trailing metrics use the newest waypoint snapshot', () async {
    final controller = container.read(routePlannerControllerProvider.notifier);

    await controller.addWaypoint(60, 25);
    await controller.addWaypoint(60.1, 25.1);

    await Future<void>.delayed(const Duration(milliseconds: 800));

    expect(
      container.read(routePlannerControllerProvider).totalDistanceMeters,
      greaterThan(0),
    );

    final call = verify(
      () => mockGetFishingRestrictions(
        minLat: captureAny(named: 'minLat'),
        minLng: captureAny(named: 'minLng'),
        maxLat: captureAny(named: 'maxLat'),
        maxLng: captureAny(named: 'maxLng'),
      ),
    ).captured;
    expect(call[0] as double, lessThan(60));
    expect(call[1] as double, lessThan(25));
    expect(call[2] as double, greaterThan(60.1));
    expect(call[3] as double, greaterThan(25.1));
  });

  test('route conflicts do not depend on camera-loaded restrictions', () async {
    final restriction = FishingRestriction.withCalculatedBBox(
      id: 'crossing',
      title: 'Kalastuskielto',
      rings: const [
        [
          LatLng(60.04, 25.04),
          LatLng(60.04, 25.06),
          LatLng(60.06, 25.06),
          LatLng(60.06, 25.04),
          LatLng(60.04, 25.04),
        ],
      ],
    );
    when(
      () => mockGetFishingRestrictions(
        minLat: any(named: 'minLat'),
        minLng: any(named: 'minLng'),
        maxLat: any(named: 'maxLat'),
        maxLng: any(named: 'maxLng'),
      ),
    ).thenAnswer((_) async => Right([restriction]));

    final controller = container.read(routePlannerControllerProvider.notifier);
    await controller.addWaypoint(60, 25);
    await controller.addWaypoint(60.1, 25.1);
    await Future<void>.delayed(const Duration(milliseconds: 800));

    final state = container.read(routePlannerControllerProvider);
    expect(state.conflicts, [restriction]);
    expect(state.restrictionCheckError, isNull);
  });

  test('restriction API failure is visible in planner state', () async {
    when(
      () => mockGetFishingRestrictions(
        minLat: any(named: 'minLat'),
        minLng: any(named: 'minLng'),
        maxLat: any(named: 'maxLat'),
        maxLng: any(named: 'maxLng'),
      ),
    ).thenAnswer((_) async => const Left(NetworkFailure()));

    final controller = container.read(routePlannerControllerProvider.notifier);
    await controller.addWaypoint(60, 25);
    await controller.addWaypoint(60.1, 25.1);
    await Future<void>.delayed(const Duration(milliseconds: 800));

    final state = container.read(routePlannerControllerProvider);
    expect(state.isCheckingRestrictions, isFalse);
    expect(state.restrictionCheckError, isNotNull);
  });

  test('clearing invalidates pending metrics results', () async {
    final controller = container.read(routePlannerControllerProvider.notifier);

    await controller.addWaypoint(60, 25);
    controller.clear();

    await Future<void>.delayed(const Duration(milliseconds: 800));

    final state = container.read(routePlannerControllerProvider);
    expect(state.waypoints, isEmpty);
    expect(state.totalDistanceMeters, 0);
  });
}
