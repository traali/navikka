import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sakkoja/core/network/network_monitor_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';
import 'package:sakkoja/features/weather/data/weather_providers.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/repositories/weather_repository.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';

// Mocks
class MockWeatherRepository extends Mock implements WeatherRepository {}

// Helper to create a fake stream
Stream<List<T>> streamOf<T>(List<T> data) => Stream.value(data);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();

    // Default Stubs: Return empty streams
    when(
      () => mockWeatherRepository.watchWeatherObservations(any(), any()),
    ).thenAnswer((_) => streamOf([]));
    when(
      () => mockWeatherRepository.watchWeatherForecast(any(), any()),
    ).thenAnswer((_) => streamOf([]));
    when(
      () => mockWeatherRepository.watchWaveObservationsNearest(any(), any()),
    ).thenAnswer((_) => streamOf([]));
    when(
      () => mockWeatherRepository.watchSeaLevelNearest(any(), any()),
    ).thenAnswer((_) => streamOf([]));
    when(
      () => mockWeatherRepository.watchActiveAlerts(),
    ).thenAnswer((_) => streamOf([]));
    when(
      () => mockWeatherRepository.watchRecentLightning(),
    ).thenAnswer((_) => streamOf([]));
    when(
      () => mockWeatherRepository.watchWaterQualityNearest(any(), any()),
    ).thenAnswer((_) => streamOf([]));
    when(
      () => mockWeatherRepository.watchAlgaeReportsNearest(any(), any()),
    ).thenAnswer((_) => streamOf([]));

    // Default Stubs: Syncs (Future<void>)
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

  test('PointWeatherController initializes with default state', () async {
    const center = LatLng(60, 25);
    final container = ProviderContainer(
      overrides: [
        isOnlineProvider.overrideWithValue(true),
        debouncedMapCameraPositionProvider.overrideWithValue(
          const MapCameraState(center: center, zoom: 10),
        ),
        weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
      ],
    );
    addTearDown(container.dispose);

    // Keep the controller alive
    final sub = container.listen(
      pointWeatherControllerProvider,
      (previous, next) {},
    );
    addTearDown(sub.close);

    final state = container.read(pointWeatherControllerProvider);
    expect(state.isLoading, false);
    expect(state.isRadarVisible, false);
    expect(state.weather, isNull);
  });

  test('PointWeatherController toggles radar via UI Controller', () async {
    const center = LatLng(60, 25);
    final container = ProviderContainer(
      overrides: [
        isOnlineProvider.overrideWithValue(true),
        debouncedMapCameraPositionProvider.overrideWithValue(
          const MapCameraState(center: center, zoom: 10),
        ),
        weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
      ],
    );
    addTearDown(container.dispose);

    // Keep the controller alive
    final sub = container.listen(
      pointWeatherControllerProvider,
      (previous, next) {},
    );
    addTearDown(sub.close);

    container.read(debouncedMapCameraPositionProvider);

    container.read(pointWeatherControllerProvider.notifier).toggleRadar();

    // Assert
    final state = container.read(pointWeatherControllerProvider);
    expect(state.isRadarVisible, true);
  });

  test('PointWeatherController updates when Data Stream emits', () async {
    const center = LatLng(60, 25);
    final testWeather = [
      WeatherData(
        timestamp: DateTime.now(),
        location: center,
        stationName: 'TestStation',
        temperature: 20,
      ),
    ];

    // Override repo to return our data
    when(
      () => mockWeatherRepository.watchWeatherObservations(any(), any()),
    ).thenAnswer((_) => streamOf(testWeather));

    final container = ProviderContainer(
      overrides: [
        isOnlineProvider.overrideWithValue(true),
        debouncedMapCameraPositionProvider.overrideWithValue(
          const MapCameraState(center: center, zoom: 10),
        ),
        weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
      ],
    );
    addTearDown(container.dispose);

    // Keep the controller alive
    final sub = container.listen(
      pointWeatherControllerProvider,
      (previous, next) {},
    );
    addTearDown(sub.close);

    // Wait for camera
    container.read(debouncedMapCameraPositionProvider);
    // Wait for observations stream to resolve
    await container.read(weatherObservationsStreamProvider(center).future);

    // Act: Read the current state
    final state = container.read(pointWeatherControllerProvider);

    // Assert: State should reflect the data
    expect(state.weather, isNotNull);
    expect(state.weather!.temperature, 20.0);
  });
}
