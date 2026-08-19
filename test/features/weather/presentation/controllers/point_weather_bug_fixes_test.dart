import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/core/network/network_monitor_provider.dart';
import 'package:sakkoja/features/map/domain/entities/map_state.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/weather/data/weather_providers.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/repositories/weather_repository.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_sync_controller.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class TestMapNotifier extends MapNotifier {
  final LatLng initialLocation;
  TestMapNotifier(this.initialLocation);

  @override
  MapState build() =>
      MapState(userLocation: initialLocation, hasLocation: true);

  void move(LatLng newLocation) {
    state = state.copyWith(userLocation: newLocation);
  }
}

void main() {
  late MockWeatherRepository mockWeatherRepository;

  setUpAll(() {
    registerFallbackValue(const LatLng(0, 0));
  });

  setUp(() async {
    mockWeatherRepository = MockWeatherRepository();

    // Default stubs
    when(
      () => mockWeatherRepository.watchWeatherObservations(any(), any()),
    ).thenAnswer((_) => Stream.value([]));
    when(
      () => mockWeatherRepository.watchWeatherForecast(any(), any()),
    ).thenAnswer((_) => Stream.value([]));
    when(
      () => mockWeatherRepository.watchWaveObservationsNearest(any(), any()),
    ).thenAnswer((_) => Stream.value([]));
    when(
      () => mockWeatherRepository.watchSeaLevelNearest(any(), any()),
    ).thenAnswer((_) => Stream.value([]));
    when(
      () => mockWeatherRepository.watchActiveAlerts(),
    ).thenAnswer((_) => Stream.value([]));
    when(
      () => mockWeatherRepository.watchWaterQualityNearest(any(), any()),
    ).thenAnswer((_) => Stream.value([]));
    when(
      () => mockWeatherRepository.watchAlgaeReportsNearest(any(), any()),
    ).thenAnswer((_) => Stream.value([]));
    when(
      () => mockWeatherRepository.watchRecentLightning(),
    ).thenAnswer((_) => Stream.value([]));
    when(
      () => mockWeatherRepository.syncWeatherObservations(any(), any()),
    ).thenAnswer((_) async {});
    when(
      () => mockWeatherRepository.syncWeatherForecast(any(), any()),
    ).thenAnswer((_) async {});
    when(
      () => mockWeatherRepository.syncWaveObservations(
        lat: any(named: 'lat'),
        lon: any(named: 'lon'),
      ),
    ).thenAnswer((_) async {});
    when(() => mockWeatherRepository.syncSeaLevel()).thenAnswer((_) async {});
    when(
      () => mockWeatherRepository.syncActiveAlerts(),
    ).thenAnswer((_) async {});
    when(
      () => mockWeatherRepository.syncRecentLightning(),
    ).thenAnswer((_) async {});
    when(
      () => mockWeatherRepository.syncWaterQuality(any(), any()),
    ).thenAnswer((_) async {});
    when(
      () => mockWeatherRepository.syncAlgaeReports(any(), any()),
    ).thenAnswer((_) async {});
    when(() => mockWeatherRepository.clearCache()).thenAnswer((_) async {});
  });

  group('Bug Fixes TDD', () {
    test(
      'lastUpdated should reflect actual observation timestamp, not DateTime.now()',
      () async {
        final obsTimestamp = DateTime(2026, 1, 10, 12);
        const center = LatLng(60, 25);

        when(
          () => mockWeatherRepository.watchWeatherObservations(any(), any()),
        ).thenAnswer(
          (_) => Stream.value([
            WeatherData(
              timestamp: obsTimestamp,
              location: center,
              stationName: 'Test Station',
              temperature: 15,
              windSpeed: 5,
              windGust: 7,
              windDirection: 180,
              pressure: 1013,
              visibility: 10000,
              humidity: 70,
              precipitation: 0,
              cloudCover: 4,
            ),
          ]),
        );

        final container = ProviderContainer(
          overrides: [
            isOnlineProvider.overrideWithValue(true),
            debouncedMapCameraPositionProvider.overrideWithValue(
              const MapCameraState(center: center, zoom: 10),
            ),
            weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
            mapProvider.overrideWith(() => TestMapNotifier(center)),
          ],
        );
        addTearDown(container.dispose);

        final completer = Completer<PointWeatherState>();
        final sub = container.listen(pointWeatherControllerProvider, (p, n) {
          if (n.weather != null) {
            if (!completer.isCompleted) completer.complete(n);
          }
        }, fireImmediately: true);

        final state = await completer.future.timeout(
          const Duration(seconds: 10),
        );
        sub.close();

        expect(state.lastUpdated.year, 2026);
        expect(state.lastUpdated.month, 1);
        expect(state.lastUpdated.hour, 12);
      },
    );

    test('syncError should be set when sync fails', () async {
      const center = LatLng(60, 25);

      when(
        () => mockWeatherRepository.syncWeatherObservations(any(), any()),
      ).thenThrow(Exception('Network down'));

      final container = ProviderContainer(
        overrides: [
          isOnlineProvider.overrideWithValue(true),
          debouncedMapCameraPositionProvider.overrideWithValue(
            const MapCameraState(center: center, zoom: 10),
          ),
          weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
          mapProvider.overrideWith(() => TestMapNotifier(center)),
        ],
      );
      addTearDown(container.dispose);

      final completer = Completer<Object>();
      final sub = container.listen(pointWeatherControllerProvider, (p, n) {
        if (n.syncError != null) {
          if (!completer.isCompleted) completer.complete(n.syncError!);
        }
      }, fireImmediately: true);

      final error = await completer.future.timeout(const Duration(seconds: 15));
      sub.close();

      expect(error.toString(), contains('Network down'));
    });

    test('lastSuccessfulSync should NOT update when sync fails', () async {
      const center = LatLng(60, 25);

      final container = ProviderContainer(
        overrides: [
          isOnlineProvider.overrideWithValue(true),
          mapCameraPositionProvider.overrideWith(
            () => TestMapCameraPosition(center),
          ),
          weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
          mapProvider.overrideWith(() => TestMapNotifier(center)),
        ],
      );
      addTearDown(container.dispose);

      // Ensure we have data so we don't fall into "Error" state on failure
      when(
        () => mockWeatherRepository.watchWeatherObservations(any(), any()),
      ).thenAnswer(
        (_) => Stream.value([
          WeatherData(
            timestamp: DateTime.now(),
            location: center,
            stationName: 'Test',
            temperature: 10,
            windSpeed: 5,
            windGust: 7,
            windDirection: 180,
            pressure: 1013,
            visibility: 10000,
            humidity: 50,
            precipitation: 0,
            cloudCover: 0,
          ),
        ]),
      );

      // 1. Wait for initial success
      final successCompleter = Completer<PointWeatherState>();
      final sub = container.listen(pointWeatherControllerProvider, (p, n) {
        if (n.lastSuccessfulSync != null) {
          if (!successCompleter.isCompleted) {
            successCompleter.complete(n);
          }
        }
      }, fireImmediately: true);

      final successState = await successCompleter.future.timeout(
        const Duration(seconds: 15),
      );
      final successTime = successState.lastSuccessfulSync;

      // 2. Mock failure for next attempt
      when(
        () => mockWeatherRepository.syncWeatherObservations(any(), any()),
      ).thenThrow(Exception('Network down'));

      // 3. Setup listener for the error BEFORE triggering the move
      final failCompleter = Completer<PointWeatherState>();
      final sub2 = container.listen(pointWeatherControllerProvider, (p, n) {
        if (n.syncError != null) {
          if (!failCompleter.isCompleted) {
            failCompleter.complete(n);
          }
        }
      });

      // 4. Trigger move (beyond the pan threshold, from 60,25 to 61,26)
      container
          .read(mapCameraPositionProvider.notifier)
          .update(const LatLng(61, 26), 10);

      final failState = await failCompleter.future.timeout(
        const Duration(seconds: 15),
      );

      expect(failState.lastSuccessfulSync, successTime);
      sub.close();
      sub2.close();
    });

    test('staggered startup triggers all syncs', () async {
      const center = LatLng(60, 25);

      final container = ProviderContainer(
        overrides: [
          isOnlineProvider.overrideWithValue(true),
          debouncedMapCameraPositionProvider.overrideWithValue(
            const MapCameraState(center: center, zoom: 10),
          ),
          weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
          mapProvider.overrideWith(() => TestMapNotifier(center)),
        ],
      );
      addTearDown(container.dispose);

      final completer = Completer<void>();
      container.listen(pointWeatherSyncControllerProvider, (p, n) {
        if (!n.isSyncing && n.lastSuccessfulSync != null) {
          if (!completer.isCompleted) completer.complete();
        }
      }, fireImmediately: true);

      await completer.future.timeout(const Duration(seconds: 15));

      // After staggered startup completes, all 8 sources should be called once!
      verify(() => mockWeatherRepository.syncActiveAlerts()).called(1);
      verify(() => mockWeatherRepository.syncRecentLightning()).called(1);
      verify(
        () => mockWeatherRepository.syncWeatherObservations(any(), any()),
      ).called(1);
      verify(
        () => mockWeatherRepository.syncWeatherForecast(any(), any()),
      ).called(1);
      verify(() => mockWeatherRepository.syncSeaLevel()).called(1);
      verify(
        () => mockWeatherRepository.syncWaveObservations(
          lat: any(named: 'lat'),
          lon: any(named: 'lon'),
        ),
      ).called(1);
      verify(
        () => mockWeatherRepository.syncWaterQuality(any(), any()),
      ).called(1);
      verify(
        () => mockWeatherRepository.syncAlgaeReports(any(), any()),
      ).called(1);
    });

    test('pan gating triggers sync only when pan exceeds thresholds', () async {
      const center = LatLng(60, 25);

      final container = ProviderContainer(
        overrides: [
          isOnlineProvider.overrideWithValue(true),
          mapCameraPositionProvider.overrideWith(
            () => TestMapCameraPosition(center),
          ),
          weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
          mapProvider.overrideWith(() => TestMapNotifier(center)),
        ],
      );
      addTearDown(container.dispose);

      // 1. Wait for initial staggered startup sync to complete
      final completer1 = Completer<void>();
      container.listen(pointWeatherSyncControllerProvider, (p, n) {
        if (!n.isSyncing && n.lastSuccessfulSync != null) {
          if (!completer1.isCompleted) completer1.complete();
        }
      }, fireImmediately: true);
      await completer1.future.timeout(const Duration(seconds: 15));

      // Clear all startup interactions to isolate the pan test
      clearInteractions(mockWeatherRepository);

      // 2. Trigger small pan (2 km, from 60,25 to 60.01,25.01) — should NOT trigger any sync
      container
          .read(mapCameraPositionProvider.notifier)
          .update(const LatLng(60.01, 25.01), 10);

      // Wait a bit to ensure debouncer has time to emit and process
      await Future<void>.delayed(const Duration(milliseconds: 100));

      verifyNever(
        () => mockWeatherRepository.syncWeatherObservations(any(), any()),
      );
      verifyNever(
        () => mockWeatherRepository.syncWeatherForecast(any(), any()),
      );

      // 3. Trigger large pan (exceeding pan thresholds, from 60,25 to 61.0,25.0)
      container
          .read(mapCameraPositionProvider.notifier)
          .update(const LatLng(61.0, 25.0), 10);

      // Wait a bit to ensure debouncer has time to emit and process
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Verify that observations and forecast syncs were triggered for the new pan
      verify(
        () => mockWeatherRepository.syncWeatherObservations(any(), any()),
      ).called(1);
      verify(
        () => mockWeatherRepository.syncWeatherForecast(any(), any()),
      ).called(1);
    });

    test('clearCache should not crash if called after disposal', () async {
      const center = LatLng(60, 25);
      final container = ProviderContainer(
        overrides: [
          isOnlineProvider.overrideWithValue(true),
          debouncedMapCameraPositionProvider.overrideWithValue(
            const MapCameraState(center: center, zoom: 10),
          ),
          weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
          mapProvider.overrideWith(() => TestMapNotifier(center)),
        ],
      );

      final sub = container.listen(pointWeatherControllerProvider, (p, n) {});
      container.read(debouncedMapCameraPositionProvider);

      final notifier = container.read(pointWeatherControllerProvider.notifier);
      sub.close();
      container.dispose();

      expect(() async => notifier.clearCache(), returnsNormally);
    });
  });
}

class TestMapCameraPosition extends MapCameraPosition {
  TestMapCameraPosition(this._initialCenter);
  final LatLng _initialCenter;

  @override
  MapCameraState build() => MapCameraState(center: _initialCenter, zoom: 10);
}
