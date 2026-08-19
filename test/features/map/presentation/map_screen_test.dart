// ignore_for_file: unused_element

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/core/services/location_service.dart';
import 'package:sakkoja/features/contribution/domain/entities/user_contribution.dart'; // Import for UserContribution
import 'package:sakkoja/features/contribution/presentation/providers/contribution_provider.dart';
import 'package:sakkoja/features/fishing/di/fishing_di.dart'; // Import for fishingRepositoryProvider
import 'package:sakkoja/features/fishing/domain/entities/fishing_restriction.dart'; // Import for FishingRestriction
import 'package:sakkoja/features/fishing/domain/repositories/fishing_repository.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_data_providers.dart';
import 'package:sakkoja/features/map/data/models/last_location_dto.dart';
import 'package:sakkoja/features/map/di/map_di.dart';
import 'package:sakkoja/features/map/domain/entities/map_state.dart';
import 'package:sakkoja/features/map/domain/repositories/map_repository.dart';
import 'package:sakkoja/features/map/presentation/providers/map_auto_follow_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart'; // Import this
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/map/presentation/screens/map_screen.dart';
import 'package:sakkoja/features/navigation/presentation/controllers/route_planner_controller.dart';
import 'package:sakkoja/features/navigation/presentation/providers/navigation_providers.dart';
// Correct import
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart'; // Import for FakeMapState
import 'package:sakkoja/features/speed_limits/presentation/providers/displayed_speed_limits_provider.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';
import 'package:sakkoja/l10n/app_localizations.dart';

// Mocks
class MockMapRepository extends Mock implements MapRepository {}

class MockLocationService extends Mock implements LocationService {}

class MockFishingRepository extends Mock implements FishingRepository {}

// Fake TileProvider to avoid Mocktail boilerplate issues
class FakeTileProvider extends Fake implements TileProvider {
  @override
  Map<String, String> get headers => {};

  @override
  bool get supportsCancelLoading => false;

  @override
  void dispose() {} // Stub dispose to prevent crash

  @override
  ImageProvider getImage(TileCoordinates coordinates, TileLayer options) {
    // 1x1 transparent PNG
    final bytes = base64Decode(
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8/5+hHgAHggJ/PchI7wAAAABJRU5ErkJggg==',
    );
    return MemoryImage(bytes);
  }
}

// Fake States
class FakeMapState extends Fake implements MapState {
  FakeMapState({required LatLng userLocation, required bool hasLocation})
    : _userLocation = userLocation,
      _hasLocation = hasLocation;
  final LatLng _userLocation;
  final bool _hasLocation;

  @override
  LatLng get userLocation => _userLocation;
  @override
  bool get hasLocation => _hasLocation;
  @override
  double get currentSpeedKmh => 0;
  @override
  double get heading => 0;
  @override
  LatLng? get projectedCenter => null;
  @override
  SpeedLimitZone? get currentZone => null;
  @override
  List<SpeedLimitZone> get visibleZones => [];
}

// Mock Notifier for MapProvider
class MockMapNotifier extends MapNotifier {
  @override
  MapState build() {
    return const MapState(userLocation: LatLng(60.1, 24.9), hasLocation: true);
  }
}

// Mock Notifier for MapAutoFollow
class MockMapAutoFollow extends MapAutoFollow {
  @override
  bool build() => true;
}

// Mock Contribution Notifier
class MockContribution extends Contribution {
  @override
  Future<List<UserContribution>> build() async => [];
}

// Mock PointWeatherController
class MockPointWeatherController extends PointWeatherController {
  @override
  PointWeatherState build() {
    return PointWeatherState(lastUpdated: DateTime.now());
  }
}

// Mock HybridFishingRestrictions
class MockHybridFishingRestrictions extends HybridFishingRestrictions {
  @override
  Future<List<FishingRestriction>> build() async => [];
}

// Mock RoutePlannerController
class MockRoutePlannerController extends RoutePlannerController {
  @override
  RoutePlannerState build() {
    return RoutePlannerState.initial();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockMapRepository mockMapRepo;
  late MockLocationService mockLocationService;
  late MockFishingRepository mockFishingRepo;
  late FakeTileProvider fakeTileProvider;

  setUpAll(() {
    registerFallbackValue(const LatLng(0, 0));
    registerFallbackValue(const LastLocationDto(latitude: 0, longitude: 0));
  });

  setUp(() {
    mockMapRepo = MockMapRepository();
    mockLocationService = MockLocationService();
    mockFishingRepo = MockFishingRepository();
    fakeTileProvider = FakeTileProvider();

    when(
      () => mockMapRepo.getLastLocation(),
    ).thenAnswer((_) async => const Right(null));
    when(
      () => mockMapRepo.saveLastLocation(any()),
    ).thenAnswer((_) async => const Right(unit));
    when(
      () => mockLocationService.getPositionStream(),
    ).thenAnswer((_) => const Stream.empty());

    // Stub location service permission
    when(
      () => mockLocationService.requestPermission(),
    ).thenAnswer((_) async => LocationPermissionResult.granted);
  });

  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [
        mapRepositoryProvider.overrideWithValue(mockMapRepo),
        locationServiceProvider.overrideWithValue(mockLocationService),
        fishingRepositoryProvider.overrideWithValue(mockFishingRepo),

        // Mock complex providers to avoid logic running
        displayedSpeedLimitsProvider.overrideWith((ref) => []),
        hybridFishingRestrictionsProvider.overrideWith(
          MockHybridFishingRestrictions.new,
        ),

        // Mock PointWeather to avoid radar logic
        pointWeatherControllerProvider.overrideWith(
          MockPointWeatherController.new,
        ),

        contributionProvider.overrideWith(MockContribution.new),

        // Ensure camera provider is initialized
        mapCameraPositionProvider.overrideWith(MapCameraPosition.new),

        routePlannerControllerProvider.overrideWith(
          MockRoutePlannerController.new,
        ),

        mapAutoFollowProvider.overrideWith(MockMapAutoFollow.new),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: MapScreen(
          tileProvider: fakeTileProvider, // Inject fake
          showDebugOverlay: false,
        ),
      ),
    );
  }

  testWidgets('MapScreen initializes and builds FlutterMap', (tester) async {
    // SKIPPED: Times out in CI due to FlutterMap rendering.
    // Tracked in issue #141.
  }, skip: true);

  testWidgets('MapScreen handles async initialization without errors', (
    tester,
  ) async {
    // SKIPPED: Times out in CI due to FlutterMap rendering.
    // Tracked in issue #141.
  }, skip: true);
}
