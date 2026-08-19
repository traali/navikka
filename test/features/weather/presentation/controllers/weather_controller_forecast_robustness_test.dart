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
import 'package:sakkoja/features/weather/domain/repositories/weather_repository.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';

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

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    reset(mockWeatherRepository);

    // Default Stubs for Streams
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

    // Default Stubs for Syncs (success)
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

    when(
      () => mockWeatherRepository.watchRecentLightning(),
    ).thenAnswer((_) => Stream.value([]));
    when(
      () => mockWeatherRepository.watchWaterQualityNearest(any(), any()),
    ).thenAnswer((_) => Stream.value([]));
    when(
      () => mockWeatherRepository.watchAlgaeReportsNearest(any(), any()),
    ).thenAnswer((_) => Stream.value([]));
  });

  test(
    'PointWeatherController should not crash if Forecast sync throws',
    () async {
      // Arrange
      const center = LatLng(60, 25);

      // Make forecast sync fail
      when(
        () => mockWeatherRepository.syncWeatherForecast(any(), any()),
      ).thenThrow(Exception('Simulated Forecast Critical Failure'));

      final container = ProviderContainer(
        overrides: [
          weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
          isOnlineProvider.overrideWithValue(true),
          debouncedMapCameraPositionProvider.overrideWithValue(
            const MapCameraState(center: center, zoom: 10),
          ),
          mapProvider.overrideWith(() => TestMapNotifier(center)),
        ],
      );
      addTearDown(container.dispose);

      final errorCompleter = Completer<void>();
      final sub = container.listen(pointWeatherControllerProvider, (
        prev,
        next,
      ) {
        if (next.syncError != null) {
          if (!errorCompleter.isCompleted) errorCompleter.complete();
        }
      });

      // Staggered startup reaches forecast after 2 seconds, so wait up to 15 seconds
      await errorCompleter.future.timeout(const Duration(seconds: 15));
      final state = container.read(pointWeatherControllerProvider);
      sub.close();

      // Assert
      expect(
        state.syncError != null,
        isTrue,
        reason: 'State should reflect syncError',
      );

      expect(state.syncError, contains('Forecast'));
    },
  );
}
