import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/features/map/domain/entities/map_state.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/navigation/domain/entities/route_entity.dart';
import 'package:sakkoja/features/navigation/domain/entities/waypoint_entity.dart';
import 'package:sakkoja/features/navigation/domain/repositories/navigation_repository.dart';
import 'package:sakkoja/features/navigation/presentation/controllers/navigation_controller.dart';
import 'package:sakkoja/features/navigation/presentation/providers/navigation_providers.dart';

class MockNavigationRepository extends Mock implements NavigationRepository {}

class TestMapNotifier extends MapNotifier {
  @override
  MapState build() {
    return const MapState(userLocation: LatLng(60, 24));
  }

  void emit(MapState value) {
    state = value;
  }
}

void main() {
  late MockNavigationRepository repository;
  late ProviderContainer container;
  late TestMapNotifier mapNotifier;

  final route = RouteEntity(
    id: 7,
    name: 'Sea route',
    createdAt: DateTime.utc(2026),
    updatedAt: DateTime.utc(2026),
    isActive: true,
    totalDistanceMeters: 0,
  );
  const waypoints = [
    WaypointEntity(id: 1, routeId: 7, lat: 60, lon: 24, orderIndex: 0),
    WaypointEntity(id: 2, routeId: 7, lat: 60, lon: 24.01, orderIndex: 1),
    WaypointEntity(id: 3, routeId: 7, lat: 60, lon: 24.02, orderIndex: 2),
  ];

  setUp(() {
    repository = MockNavigationRepository();
    when(repository.getActiveRoute).thenAnswer((_) async => route);
    when(
      () => repository.getWaypointsForRoute(route.id),
    ).thenAnswer((_) async => waypoints);

    container = ProviderContainer(
      overrides: [
        navigationRepositoryProvider.overrideWithValue(repository),
        mapProvider.overrideWith(TestMapNotifier.new),
      ],
    );
    mapNotifier = container.read(mapProvider.notifier) as TestMapNotifier;
    final subscription = container.listen(
      navigationControllerProvider,
      (_, _) {},
    );
    addTearDown(subscription.close);
    addTearDown(container.dispose);
  });

  Future<void> waitFor(
    bool Function() predicate, {
    Duration timeout = const Duration(seconds: 2),
  }) async {
    final deadline = DateTime.now().add(timeout);
    while (!predicate()) {
      if (DateTime.now().isAfter(deadline)) {
        fail('Navigation state did not reach the expected value.');
      }
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }

  test('starts for the active route and follows fresh GPS samples', () async {
    final initial = await container.read(navigationControllerProvider.future);
    expect(initial.isActive, isTrue);
    expect(initial.totalLegs, 2);

    final sampleAt = DateTime.utc(2026, 7, 27, 12);
    mapNotifier.emit(
      MapState(
        userLocation: const LatLng(60, 24.005),
        hasLocation: true,
        isLocationFresh: true,
        lastPositionAt: sampleAt,
        currentSpeedKmh: 18,
      ),
    );

    await waitFor(
      () =>
          container.read(navigationControllerProvider).value?.lastUpdate ==
          sampleAt,
    );
    final state = container.read(navigationControllerProvider).requireValue;
    expect(state.isPositionFresh, isTrue);
    expect(state.currentPosition, const LatLng(60, 24.005));
    expect(state.bearingToNextWp, closeTo(90, 1));
    expect(state.distanceRemainingMeters, isNotNull);
    expect(state.etaDestination, isNotNull);
  });

  test('pauses guidance and clears ETA when GPS becomes stale', () async {
    await container.read(navigationControllerProvider.future);
    final sampleAt = DateTime.utc(2026, 7, 27, 12);
    mapNotifier.emit(
      MapState(
        userLocation: const LatLng(60, 24.005),
        hasLocation: true,
        isLocationFresh: true,
        lastPositionAt: sampleAt,
        currentSpeedKmh: 18,
      ),
    );
    await waitFor(
      () =>
          container.read(navigationControllerProvider).value?.isPositionFresh ==
          true,
    );

    mapNotifier.emit(
      MapState(
        userLocation: const LatLng(60, 24.005),
        hasLocation: true,
        lastPositionAt: sampleAt,
      ),
    );

    await waitFor(
      () =>
          container.read(navigationControllerProvider).value?.isPositionFresh ==
          false,
    );
    final stale = container.read(navigationControllerProvider).requireValue;
    expect(stale.lastUpdate, sampleAt);
    expect(stale.etaNextWp, isNull);
    expect(stale.etaDestination, isNull);
  });

  test('recomputes target immediately after arriving at a waypoint', () async {
    await container.read(navigationControllerProvider.future);
    final sampleAt = DateTime.utc(2026, 7, 27, 12);
    mapNotifier.emit(
      MapState(
        userLocation: const LatLng(60, 24.01),
        hasLocation: true,
        isLocationFresh: true,
        lastPositionAt: sampleAt,
        currentSpeedKmh: 12,
      ),
    );

    await waitFor(
      () =>
          container.read(navigationControllerProvider).value?.currentLegIndex ==
          1,
    );
    final state = container.read(navigationControllerProvider).requireValue;
    expect(state.bearingToNextWp, closeTo(90, 1));
    expect(state.distanceToNextWpMeters, greaterThan(500));
  });

  test('coalesces rapid GPS samples and applies the latest one', () async {
    await container.read(navigationControllerProvider.future);
    final firstAt = DateTime.utc(2026, 7, 27, 12);
    mapNotifier.emit(
      MapState(
        userLocation: const LatLng(60, 24.001),
        hasLocation: true,
        isLocationFresh: true,
        lastPositionAt: firstAt,
        currentSpeedKmh: 15,
      ),
    );
    await waitFor(
      () =>
          container.read(navigationControllerProvider).value?.lastUpdate ==
          firstAt,
    );

    final latestAt = firstAt.add(const Duration(milliseconds: 200));
    mapNotifier
      ..emit(
        MapState(
          userLocation: const LatLng(60, 24.002),
          hasLocation: true,
          isLocationFresh: true,
          lastPositionAt: firstAt.add(const Duration(milliseconds: 100)),
          currentSpeedKmh: 15,
        ),
      )
      ..emit(
        MapState(
          userLocation: const LatLng(60, 24.003),
          hasLocation: true,
          isLocationFresh: true,
          lastPositionAt: latestAt,
          currentSpeedKmh: 15,
        ),
      );

    await waitFor(
      () =>
          container.read(navigationControllerProvider).value?.lastUpdate ==
          latestAt,
    );
    expect(
      container.read(navigationControllerProvider).requireValue.currentPosition,
      const LatLng(60, 24.003),
    );
  });
}
