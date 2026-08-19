import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_mode_provider.dart';
import 'package:sakkoja/features/map/domain/entities/map_state.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/tracking/data/repositories/track_repository.dart';
import 'package:sakkoja/features/tracking/presentation/providers/active_track_provider.dart';

class MockTrackRepository extends Mock implements TrackRepository {}

class TestMapNotifier extends MapNotifier {
  @override
  MapState build() => const MapState(userLocation: LatLng(60, 24));

  void emit(MapState value) {
    state = value;
  }
}

class TestFishingModeController extends FishingModeController {
  @override
  FutureOr<FishingModeState> build() =>
      const FishingModeState(isEnabled: false);
}

void main() {
  late MockTrackRepository repository;
  late ProviderContainer container;
  late TestMapNotifier mapNotifier;

  setUp(() {
    repository = MockTrackRepository();
    when(
      () => repository.startTrack(
        name: any(named: 'name'),
        isFishingMode: any(named: 'isFishingMode'),
      ),
    ).thenAnswer((_) async => const Right(42));

    container = ProviderContainer(
      overrides: [
        trackRepositoryProvider.overrideWithValue(repository),
        mapProvider.overrideWith(TestMapNotifier.new),
        fishingModeControllerProvider.overrideWith(
          TestFishingModeController.new,
        ),
      ],
    );
    mapNotifier = container.read(mapProvider.notifier) as TestMapNotifier;
    final subscription = container.listen(activeTrackProvider, (_, _) {});
    addTearDown(subscription.close);
    addTearDown(container.dispose);
  });

  Future<void> waitFor(bool Function() predicate) async {
    final deadline = DateTime.now().add(const Duration(seconds: 2));
    while (!predicate()) {
      if (DateTime.now().isAfter(deadline)) {
        fail('Track state did not reach the expected value.');
      }
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }

  test(
    'serializes writes and coalesces queued GPS samples to the latest',
    () async {
      final firstWrite = Completer<Either<Failure, void>>();
      final recordedLatitudes = <double>[];
      when(
        () => repository.addPoint(
          any(),
          any(),
          any(),
          any(),
          timestamp: any(named: 'timestamp'),
        ),
      ).thenAnswer((invocation) {
        recordedLatitudes.add(invocation.positionalArguments[1] as double);
        if (recordedLatitudes.length == 1) return firstWrite.future;
        return Future.value(const Right(null));
      });

      await container.read(activeTrackProvider.notifier).startRecording();
      final firstAt = DateTime.utc(2026, 7, 27, 12);
      mapNotifier.emit(
        MapState(
          userLocation: const LatLng(60, 24),
          hasLocation: true,
          isLocationFresh: true,
          lastPositionAt: firstAt,
        ),
      );
      await waitFor(() => recordedLatitudes.length == 1);

      mapNotifier
        ..emit(
          MapState(
            userLocation: const LatLng(60.0001, 24),
            hasLocation: true,
            isLocationFresh: true,
            lastPositionAt: firstAt.add(const Duration(seconds: 1)),
          ),
        )
        ..emit(
          MapState(
            userLocation: const LatLng(60.0002, 24),
            hasLocation: true,
            isLocationFresh: true,
            lastPositionAt: firstAt.add(const Duration(seconds: 2)),
          ),
        );

      firstWrite.complete(const Right(null));
      await waitFor(
        () => container.read(activeTrackProvider).points.length == 2,
      );

      expect(recordedLatitudes, [60, 60.0002]);
      expect(
        container.read(activeTrackProvider).points.last.timestamp,
        firstAt.add(const Duration(seconds: 2)),
      );
    },
  );

  test('ignores stale last-known positions', () async {
    when(
      () => repository.addPoint(
        any(),
        any(),
        any(),
        any(),
        timestamp: any(named: 'timestamp'),
      ),
    ).thenAnswer((_) async => const Right(null));
    await container.read(activeTrackProvider.notifier).startRecording();

    mapNotifier.emit(
      const MapState(
        userLocation: LatLng(60.1, 24),
        hasLocation: true,
      ),
    );
    await Future<void>.delayed(const Duration(milliseconds: 20));

    verifyNever(
      () => repository.addPoint(
        any(),
        any(),
        any(),
        any(),
        timestamp: any(named: 'timestamp'),
      ),
    );
  });
}
