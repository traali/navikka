import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';
import 'package:sakkoja/features/speed_limits/domain/usecases/get_speed_limits.dart';
import 'package:sakkoja/features/speed_limits/presentation/providers/displayed_speed_limits_provider.dart';
import 'package:sakkoja/features/speed_limits/presentation/providers/speed_limit_provider.dart';

class MockGetSpeedLimits extends Mock implements GetSpeedLimits {}

void main() {
  const helsinki = LatLng(60.155, 24.89);
  const camera = MapCameraState(center: helsinki, zoom: 14);

  final zoneIn = SpeedLimitZone(
    id: 'in',
    speedLimitKmh: 50,
    rings: [
      [
        const LatLng(60.15, 24.88),
        const LatLng(60.16, 24.88),
        const LatLng(60.16, 24.9),
        const LatLng(60.15, 24.9),
        const LatLng(60.15, 24.88),
      ],
    ],
  );
  final zoneWithinViewport = SpeedLimitZone(
    id: 'within-viewport',
    speedLimitKmh: 50,
    rings: [
      [
        const LatLng(60.35, 24.88),
        const LatLng(60.36, 24.88),
        const LatLng(60.36, 24.9),
        const LatLng(60.35, 24.9),
        const LatLng(60.35, 24.88),
      ],
    ],
  );
  final zoneOut = SpeedLimitZone(
    id: 'out',
    speedLimitKmh: 50,
    rings: [
      [
        const LatLng(61, 25),
        const LatLng(61.01, 25),
        const LatLng(61.01, 25.01),
        const LatLng(61, 25.01),
        const LatLng(61, 25),
      ],
    ],
  );

  test(
    'speedLimitsProvider fetches and returns bundled speed limits',
    () async {
      final getSpeedLimits = MockGetSpeedLimits();
      when(() => getSpeedLimits()).thenAnswer((_) async => Right([zoneIn]));
      final container = ProviderContainer(
        overrides: [
          getSpeedLimitsUseCaseProvider.overrideWithValue(getSpeedLimits),
        ],
      );
      addTearDown(container.dispose);

      expect(await container.read(speedLimitsProvider.future), [zoneIn]);
    },
  );

  test('displayed speed limits cull the complete bundled dataset', () async {
    final container = ProviderContainer(
      overrides: [
        speedLimitsProvider.overrideWith(
          (ref) async => [zoneIn, zoneWithinViewport, zoneOut],
        ),
        debouncedMapCameraPositionProvider.overrideWithValue(camera),
      ],
    );
    addTearDown(container.dispose);

    await container.read(speedLimitsProvider.future);
    final displayed = container.read(displayedSpeedLimitsProvider);

    expect(
      displayed.map((zone) => zone.id),
      containsAll(['in', 'within-viewport']),
    );
    expect(displayed.map((zone) => zone.id), isNot(contains('out')));
  });

  test(
    'displayed speed limits return no zones below the zoom threshold',
    () async {
      final container = ProviderContainer(
        overrides: [
          speedLimitsProvider.overrideWith((ref) async => [zoneIn]),
          debouncedMapCameraPositionProvider.overrideWithValue(
            const MapCameraState(center: helsinki, zoom: 8),
          ),
        ],
      );
      addTearDown(container.dispose);

      await container.read(speedLimitsProvider.future);
      expect(container.read(displayedSpeedLimitsProvider), isEmpty);
    },
  );
}
