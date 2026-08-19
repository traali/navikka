import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/map/domain/entities/map_state.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/weather/data/weather_providers.dart';
import 'package:sakkoja/features/weather/domain/entities/lightning_strike.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_lightning_provider.dart';

class _TestMapNotifier extends MapNotifier {
  _TestMapNotifier(this._location, {required this.isLocationFresh});

  final LatLng _location;
  final bool isLocationFresh;

  @override
  MapState build() => MapState(
    userLocation: _location,
    hasLocation: true,
    isLocationFresh: isLocationFresh,
    lastPositionAt: DateTime.now(),
  );

  void setLocation(LatLng location) {
    state = state.copyWith(
      userLocation: location,
      lastPositionAt: DateTime.now(),
    );
  }
}

void main() {
  const boat = LatLng(60, 25);
  const pannedCamera = LatLng(61, 25);
  final strike = LightningStrike(
    time: DateTime.now(),
    location: const LatLng(60, 25.1),
    peakCurrent: 12,
  );

  ProviderContainer buildContainer({required bool isLocationFresh}) {
    return ProviderContainer(
      overrides: [
        mapProvider.overrideWith(
          () => _TestMapNotifier(boat, isLocationFresh: isLocationFresh),
        ),
        debouncedMapCameraPositionProvider.overrideWithValue(
          const MapCameraState(center: pannedCamera, zoom: 10),
        ),
        safetyLightningStreamProvider.overrideWith(
          (ref) => Stream.value([strike]),
        ),
      ],
    );
  }

  test(
    'uses fresh boat GPS instead of a panned camera for proximity',
    () async {
      final container = buildContainer(isLocationFresh: true);
      addTearDown(container.dispose);

      final distanceCompleter = Completer<double>();
      final subscription = container.listen<AsyncValue<double?>>(
        lightningProximityProvider,
        (_, next) {
          final distance = next.asData?.value;
          if (distance != null && !distanceCompleter.isCompleted) {
            distanceCompleter.complete(distance);
          }
        },
        fireImmediately: true,
      );
      addTearDown(subscription.close);

      final distance = await distanceCompleter.future.timeout(
        const Duration(seconds: 5),
      );

      // The strike is roughly 5.6 km from the boat and over 100 km from camera.
      expect(distance, closeTo(5560, 250));
    },
  );

  test('suppresses proximity when the boat GPS is stale', () async {
    final container = buildContainer(isLocationFresh: false);
    addTearDown(container.dispose);

    expect(await container.read(lightningProximityProvider.future), isNull);
  });

  test('ignores sub-grid GPS jitter for weather safety calculations', () {
    final container = buildContainer(isLocationFresh: true);
    addTearDown(container.dispose);

    final initial = container.read(safetyBoatPositionProvider);
    (container.read(mapProvider.notifier) as _TestMapNotifier).setLocation(
      const LatLng(60.00001, 25.00001),
    );

    expect(container.read(safetyBoatPositionProvider), initial);
  });
}
