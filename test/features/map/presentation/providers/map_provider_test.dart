import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/core/services/location_service.dart';
import 'package:sakkoja/features/map/data/models/last_location_dto.dart';
import 'package:sakkoja/features/map/data/services/zone_spatial_service.dart';
import 'package:sakkoja/features/map/di/map_di.dart';
import 'package:sakkoja/features/map/domain/entities/map_state.dart';
import 'package:sakkoja/features/map/domain/repositories/map_repository.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';
import 'package:sakkoja/features/speed_limits/presentation/providers/speed_limit_provider.dart';

class MockMapRepository extends Mock implements MapRepository {}

class MockLocationService extends Mock implements LocationService {}

class DelayedZoneSpatialService extends ZoneSpatialService {
  final requests = <Completer<SpatialResult>>[];

  @override
  Future<SpatialResult> calculateOptimized({
    required LatLng userLocation,
    required List<SpeedLimitZone> allZones,
    double visibleRadiusKm = 5.0,
  }) {
    final completer = Completer<SpatialResult>();
    requests.add(completer);
    return completer.future;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockMapRepository mockRepository;
  late MockLocationService mockLocationService;
  late StreamController<Position> locationController;

  setUpAll(() {
    registerFallbackValue(const LatLng(0, 0));
    registerFallbackValue(const LastLocationDto(latitude: 0, longitude: 0));
  });

  setUp(() {
    mockRepository = MockMapRepository();
    mockLocationService = MockLocationService();
    locationController = StreamController<Position>.broadcast();

    when(
      () => mockRepository.getLastLocation(),
    ).thenAnswer((_) async => const Right(null));
    when(
      () => mockRepository.saveLastLocation(any()),
    ).thenAnswer((_) async => const Right(unit));
    when(
      () => mockLocationService.requestPermission(),
    ).thenAnswer((_) async => LocationPermissionResult.granted);
    when(
      () => mockLocationService.getPositionStream(),
    ).thenAnswer((_) => locationController.stream);
  });

  tearDown(() => locationController.close());

  ProviderContainer createContainer({ZoneSpatialService? spatialService}) {
    final container = ProviderContainer(
      overrides: [
        mapRepositoryProvider.overrideWithValue(mockRepository),
        locationServiceProvider.overrideWithValue(mockLocationService),
        zoneSpatialServiceProvider.overrideWithValue(
          spatialService ?? ZoneSpatialService(),
        ),
        speedLimitsProvider.overrideWith((ref) => <SpeedLimitZone>[]),
      ],
    );
    final subscription = container.listen<MapState>(mapProvider, (_, _) {});
    addTearDown(subscription.close);
    addTearDown(container.dispose);
    return container;
  }

  Position createPosition({
    required double lat,
    required double lng,
    required DateTime timestamp,
    double? speedKmh,
    double? heading,
    double accuracy = 2,
  }) {
    return Position(
      latitude: lat,
      longitude: lng,
      timestamp: timestamp,
      accuracy: accuracy,
      altitude: 0,
      heading: heading ?? 0,
      speed: (speedKmh ?? 10) / 3.6,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );
  }

  Future<void> waitFor(
    ProviderContainer container,
    bool Function(MapState state) predicate,
  ) async {
    for (var attempt = 0; attempt < 50; attempt++) {
      if (predicate(container.read(mapProvider))) return;
      await Future<void>.delayed(Duration.zero);
    }
    fail('Map state did not reach the expected value.');
  }

  Future<void> waitForRequestCount(
    DelayedZoneSpatialService service,
    int expectedCount,
  ) async {
    for (var attempt = 0; attempt < 50; attempt++) {
      if (service.requests.length == expectedCount) return;
      await Future<void>.delayed(Duration.zero);
    }
    fail(
      'Expected $expectedCount spatial requests, got ${service.requests.length}.',
    );
  }

  Future<void> waitForSaveCount(List<LatLng> saves, int expectedCount) async {
    for (var attempt = 0; attempt < 50; attempt++) {
      if (saves.length == expectedCount) return;
      await Future<void>.delayed(Duration.zero);
    }
    fail('Expected $expectedCount saves, got ${saves.length}.');
  }

  group('MapNotifier', () {
    test('initial state uses the default Helsinki location', () {
      final container = createContainer();

      final state = container.read(mapProvider);

      expect(state.userLocation, const LatLng(60.155, 24.89));
      expect(state.hasLocation, isFalse);
    });

    test('updates navigation state when the location stream emits', () async {
      final container = createContainer();
      final timestamp = DateTime.utc(2026, 1, 1, 12);

      container.read(mapProvider);
      await untilCalled(() => mockLocationService.getPositionStream());
      locationController.add(
        createPosition(
          lat: 60.1,
          lng: 24.8,
          timestamp: timestamp,
          speedKmh: 50,
          heading: 45,
        ),
      );
      await waitFor(container, (state) => state.hasLocation);

      final state = container.read(mapProvider);
      expect(state.userLocation, const LatLng(60.1, 24.8));
      expect(state.isLocationFresh, isTrue);
      expect(state.lastPositionAt, timestamp);
      expect(state.currentSpeedKmh, 50);
      expect(state.heading, 45);
      expect(state.projectedCenter, isNotNull);
      verify(() => mockRepository.saveLastLocation(any())).called(1);
    });

    testWidgets('clears stale motion without changing the last position', (
      tester,
    ) async {
      final container = createContainer();
      final subscription = container.listen<MapState>(mapProvider, (_, _) {});
      addTearDown(subscription.close);
      final timestamp = DateTime.utc(2026, 1, 1, 12);
      const location = LatLng(60.1, 24.8);

      container.read(mapProvider);
      await untilCalled(() => mockLocationService.getPositionStream());
      locationController.add(
        createPosition(
          lat: location.latitude,
          lng: location.longitude,
          timestamp: timestamp,
          speedKmh: 50,
          heading: 45,
        ),
      );
      await tester.runAsync(
        () => waitFor(container, (state) => state.hasLocation),
      );

      final movingState = container.read(mapProvider);
      expect(movingState.currentSpeedKmh, 50);
      expect(movingState.projectedCenter, isNot(movingState.userLocation));

      await tester.pump(MapNotifier.locationStaleAfter);

      final staleState = container.read(mapProvider);
      expect(staleState.userLocation, location);
      expect(staleState.hasLocation, isTrue);
      expect(staleState.isLocationFresh, isFalse);
      expect(staleState.lastPositionAt, timestamp);
      expect(staleState.currentSpeedKmh, 0);
      expect(staleState.projectedCenter, location);
      expect(staleState.heading, 45);
      expect(staleState.currentZone, isNull);
    });

    test('updates location and projection for a sub-20m sample', () async {
      final container = createContainer();
      final firstTimestamp = DateTime.utc(2026, 1, 1, 12);
      const secondLocation = LatLng(60.10001, 24.90001);

      container.read(mapProvider);
      await untilCalled(() => mockLocationService.getPositionStream());
      locationController.add(
        createPosition(
          lat: 60.1,
          lng: 24.9,
          timestamp: firstTimestamp,
          speedKmh: 40,
          heading: 20,
        ),
      );
      await waitFor(container, (state) => state.hasLocation);
      final firstProjectedCenter = container.read(mapProvider).projectedCenter;

      locationController.add(
        createPosition(
          lat: secondLocation.latitude,
          lng: secondLocation.longitude,
          timestamp: firstTimestamp.add(const Duration(seconds: 1)),
          speedKmh: 60,
          heading: 70,
        ),
      );
      await waitFor(
        container,
        (state) => state.userLocation == secondLocation && state.heading == 70,
      );

      final state = container.read(mapProvider);
      expect(state.currentSpeedKmh, closeTo(60, 0.001));
      expect(state.projectedCenter, isNot(firstProjectedCenter));
      verify(() => mockRepository.saveLastLocation(any())).called(1);
    });

    test(
      'derives motion when the browser reports zero speed and heading',
      () async {
        final container = createContainer();
        final timestamp = DateTime.utc(2026, 1, 1, 12);

        container.read(mapProvider);
        await untilCalled(() => mockLocationService.getPositionStream());
        locationController.add(
          createPosition(
            lat: 60,
            lng: 24,
            timestamp: timestamp,
            speedKmh: 0,
            heading: 0,
          ),
        );
        await waitFor(container, (state) => state.hasLocation);
        final initialStationaryState = container.read(mapProvider);
        expect(initialStationaryState.currentSpeedKmh, 0);
        expect(
          initialStationaryState.projectedCenter,
          initialStationaryState.userLocation,
        );

        locationController.add(
          createPosition(
            lat: 60.0001,
            lng: 24,
            timestamp: timestamp.add(const Duration(seconds: 2)),
            speedKmh: 0,
            heading: 0,
          ),
        );
        await waitFor(container, (state) => state.currentSpeedKmh > 10);

        final movingState = container.read(mapProvider);
        expect(movingState.heading, closeTo(0, 1));

        locationController.add(
          createPosition(
            lat: 60.00011,
            lng: 24,
            timestamp: timestamp.add(const Duration(seconds: 3)),
            speedKmh: 0,
            heading: 0,
          ),
        );
        await waitFor(
          container,
          (state) => state.userLocation.latitude == 60.00011,
        );

        final stationaryState = container.read(mapProvider);
        expect(stationaryState.currentSpeedKmh, 0);
        expect(stationaryState.projectedCenter, stationaryState.userLocation);
        expect(stationaryState.heading, closeTo(movingState.heading, 0.001));
      },
    );

    test(
      'does not apply an older spatial result after a newer sample',
      () async {
        final spatialService = DelayedZoneSpatialService();
        final container = createContainer(spatialService: spatialService);
        final timestamp = DateTime.utc(2026, 1, 1, 12);
        final firstZone = SpeedLimitZone(
          id: 'first',
          speedLimitKmh: 10,
          rings: [],
        );
        final secondZone = SpeedLimitZone(
          id: 'second',
          speedLimitKmh: 20,
          rings: [],
        );

        container.read(mapProvider);
        await untilCalled(() => mockLocationService.getPositionStream());
        locationController.add(
          createPosition(
            lat: 60,
            lng: 24,
            timestamp: timestamp,
            speedKmh: 20,
          ),
        );
        await waitForRequestCount(spatialService, 1);

        locationController.add(
          createPosition(
            lat: 60.0002,
            lng: 24,
            timestamp: timestamp.add(const Duration(seconds: 2)),
            speedKmh: 20,
          ),
        );
        await waitForRequestCount(spatialService, 2);

        spatialService.requests[1].complete(
          SpatialResult(visibleZones: [secondZone]),
        );
        await waitFor(
          container,
          (state) =>
              state.visibleZones.length == 1 &&
              state.visibleZones.single.id == secondZone.id,
        );

        spatialService.requests[0].complete(
          SpatialResult(visibleZones: [firstZone]),
        );
        await Future<void>.delayed(Duration.zero);

        expect(
          container.read(mapProvider).visibleZones.single.id,
          secondZone.id,
        );
      },
    );

    test(
      'serializes persistence and writes the newest queued location last',
      () async {
        final firstSave = Completer<Either<Failure, Unit>>();
        final savedLocations = <LatLng>[];
        when(() => mockRepository.saveLastLocation(any())).thenAnswer((
          invocation,
        ) {
          final location = invocation.positionalArguments.single as LatLng;
          savedLocations.add(location);
          if (savedLocations.length == 1) return firstSave.future;
          return Future.value(const Right(unit));
        });
        final container = createContainer();
        final timestamp = DateTime.utc(2026, 1, 1, 12);
        const firstLocation = LatLng(60, 24);
        const latestLocation = LatLng(60.00002, 24);

        container.read(mapProvider);
        await untilCalled(() => mockLocationService.getPositionStream());
        locationController.add(
          createPosition(
            lat: firstLocation.latitude,
            lng: firstLocation.longitude,
            timestamp: timestamp,
          ),
        );
        await waitForSaveCount(savedLocations, 1);

        locationController.add(
          createPosition(
            lat: 60.00001,
            lng: 24,
            timestamp: timestamp.add(const Duration(seconds: 1)),
          ),
        );
        locationController.add(
          createPosition(
            lat: latestLocation.latitude,
            lng: latestLocation.longitude,
            timestamp: timestamp.add(const Duration(seconds: 2)),
          ),
        );
        await waitFor(
          container,
          (state) => state.userLocation == latestLocation,
        );

        firstSave.complete(const Right(unit));
        await waitForSaveCount(savedLocations, 2);

        expect(savedLocations, [firstLocation, latestLocation]);
      },
    );

    test('retries persistence after a failed save on a later sample', () async {
      final savedLocations = <LatLng>[];
      when(() => mockRepository.saveLastLocation(any())).thenAnswer((
        invocation,
      ) async {
        savedLocations.add(invocation.positionalArguments.single as LatLng);
        if (savedLocations.length == 1) {
          return const Left(GeneralFailure('write failed'));
        }
        return const Right(unit);
      });
      final container = createContainer();
      final timestamp = DateTime.utc(2026, 1, 1, 12);

      container.read(mapProvider);
      await untilCalled(() => mockLocationService.getPositionStream());
      locationController.add(
        createPosition(lat: 60, lng: 24, timestamp: timestamp),
      );
      await waitForSaveCount(savedLocations, 1);

      locationController.add(
        createPosition(
          lat: 60.00001,
          lng: 24,
          timestamp: timestamp.add(const Duration(seconds: 1)),
        ),
      );
      await waitForSaveCount(savedLocations, 2);

      expect(savedLocations.last, const LatLng(60.00001, 24));
    });

    test('loads the last location during initialization', () async {
      final loadCompleter = Completer<Either<Failure, LatLng?>>();
      when(
        () => mockRepository.getLastLocation(),
      ).thenAnswer((_) => loadCompleter.future);
      final container = createContainer();
      const lastLocation = LatLng(61, 25);

      container.read(mapProvider);
      loadCompleter.complete(const Right(lastLocation));
      await waitFor(
        container,
        (state) => state.userLocation == lastLocation,
      );

      expect(container.read(mapProvider).userLocation, lastLocation);
    });
  });
}
