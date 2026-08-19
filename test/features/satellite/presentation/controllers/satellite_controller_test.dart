import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/map/domain/entities/map_state.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/satellite/domain/entities/satellite_state.dart';
import 'package:sakkoja/features/satellite/presentation/providers/satellite_providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SatelliteController Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test(
      'initial state defaults to Sentinel-2 true color with generated timestamps',
      () {
        final state = container.read(satelliteControllerProvider);
        expect(state.mode, SatelliteMode.sentinel2);
        expect(state.sentinelPreset, SentinelPreset.trueColor);
        expect(state.eumetsatPreset, EumetsatPreset.dayNatural);
        expect(state.showNauticalOverlay, isTrue);
        expect(state.availableTimestamps.length, 24);
        expect(state.isPlaying, isFalse);
      },
    );

    test('setMode updates satellite mode', () {
      final notifier = container.read(satelliteControllerProvider.notifier);
      notifier.setMode(SatelliteMode.eumetsat);

      final state = container.read(satelliteControllerProvider);
      expect(state.mode, SatelliteMode.eumetsat);
    });

    test('setSentinelPreset updates optical preset', () {
      final notifier = container.read(satelliteControllerProvider.notifier);
      notifier.setSentinelPreset(SentinelPreset.waterIndex);

      final state = container.read(satelliteControllerProvider);
      expect(state.sentinelPreset, SentinelPreset.waterIndex);
    });

    test('setEumetsatPreset updates weather preset', () {
      final notifier = container.read(satelliteControllerProvider.notifier);
      notifier.setEumetsatPreset(EumetsatPreset.fogDetection);

      final state = container.read(satelliteControllerProvider);
      expect(state.eumetsatPreset, EumetsatPreset.fogDetection);
    });

    test('toggleNauticalOverlay flips boolean flag', () {
      final notifier = container.read(satelliteControllerProvider.notifier);
      notifier.toggleNauticalOverlay();

      expect(
        container.read(satelliteControllerProvider).showNauticalOverlay,
        isFalse,
      );

      notifier.toggleNauticalOverlay();
      expect(
        container.read(satelliteControllerProvider).showNauticalOverlay,
        isTrue,
      );
    });

    test('setNauticalOverlayOpacity clamps between 0.1 and 1.0', () {
      final notifier = container.read(satelliteControllerProvider.notifier);
      notifier.setNauticalOverlayOpacity(0.5);
      expect(
        container.read(satelliteControllerProvider).nauticalOverlayOpacity,
        0.5,
      );

      notifier.setNauticalOverlayOpacity(1.5);
      expect(
        container.read(satelliteControllerProvider).nauticalOverlayOpacity,
        1.0,
      );

      notifier.setNauticalOverlayOpacity(0.01);
      expect(
        container.read(satelliteControllerProvider).nauticalOverlayOpacity,
        0.1,
      );
    });

    test('setTimestampIndex updates within valid bounds', () {
      final notifier = container.read(satelliteControllerProvider.notifier);
      notifier.setTimestampIndex(5);

      expect(
        container.read(satelliteControllerProvider).currentTimestampIndex,
        5,
      );
      expect(
        container.read(satelliteControllerProvider).currentTimestamp,
        isNotNull,
      );
    });

    test(
      'satelliteInitialLocationProvider returns user location when available',
      () {
        final mockContainer = ProviderContainer(
          overrides: [
            mapProvider.overrideWith(
              () => _MockMapNotifier(
                const MapState(
                  userLocation: LatLng(60.20, 25.10),
                  hasLocation: true,
                ),
              ),
            ),
          ],
        );

        final loc = mockContainer.read(satelliteInitialLocationProvider);
        expect(loc.latitude, 60.20);
        expect(loc.longitude, 25.10);

        mockContainer.dispose();
      },
    );

    test(
      'satelliteInitialLocationProvider returns fallback location when GPS unavailable',
      () {
        final loc = container.read(satelliteInitialLocationProvider);
        expect(loc.latitude, 60.15);
        expect(loc.longitude, 24.90);
      },
    );
  });
}

class _MockMapNotifier extends MapNotifier {
  _MockMapNotifier(this._initial);
  final MapState _initial;

  @override
  MapState build() => _initial;
}
