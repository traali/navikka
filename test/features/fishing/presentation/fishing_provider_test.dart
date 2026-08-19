import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/fishing/domain/entities/fishing_restriction.dart';
import 'package:sakkoja/features/fishing/domain/entities/waterway_feature.dart';
import 'package:sakkoja/features/fishing/domain/usecases/get_fishing_restrictions.dart';
import 'package:sakkoja/features/fishing/domain/usecases/get_waterway_features.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_data_providers.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';
import 'package:sakkoja/features/speed_limits/presentation/providers/bbox_fetch_throttle_provider.dart';

class MockGetFishingRestrictions extends Mock
    implements GetFishingRestrictions {}

class MockGetWaterwayFeatures extends Mock implements GetWaterwayFeatures {}

void main() {
  const camera = MapCameraState(center: LatLng(60, 24), zoom: 14);

  ProviderContainer containerWith({
    required GetFishingRestrictions fishing,
    required GetWaterwayFeatures waterways,
  }) {
    final container = ProviderContainer(
      overrides: [
        debouncedMapCameraPositionProvider.overrideWithValue(camera),
        getFishingRestrictionsProvider.overrideWithValue(fishing),
        getWaterwayFeaturesProvider.overrideWithValue(waterways),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('restriction fetches use the debounced camera position', () async {
    final fishing = MockGetFishingRestrictions();
    final waterways = MockGetWaterwayFeatures();
    when(
      () => fishing(
        minLat: any(named: 'minLat'),
        minLng: any(named: 'minLng'),
        maxLat: any(named: 'maxLat'),
        maxLng: any(named: 'maxLng'),
      ),
    ).thenAnswer(
      (_) async => const Right([
        FishingRestriction(
          id: 'test',
          title: 'Test',
          rings: [],
          category: 'test',
          isCurrentlyActive: true,
        ),
      ]),
    );
    when(
      () => waterways(
        minLat: any(named: 'minLat'),
        minLng: any(named: 'minLng'),
        maxLat: any(named: 'maxLat'),
        maxLng: any(named: 'maxLng'),
      ),
    ).thenAnswer((_) async => const Right([]));

    final container = containerWith(fishing: fishing, waterways: waterways);

    final result = await container.read(
      hybridFishingRestrictionsProvider.future,
    );

    expect(result.single.id, 'test');
    verify(
      () => fishing(
        minLat: any(named: 'minLat'),
        minLng: any(named: 'minLng'),
        maxLat: any(named: 'maxLat'),
        maxLng: any(named: 'maxLng'),
      ),
    ).called(1);
  });

  test(
    'restriction failures remain retryable and empty successes mark the tile',
    () async {
      final fishing = MockGetFishingRestrictions();
      final waterways = MockGetWaterwayFeatures();
      Either<Failure, List<FishingRestriction>> result = const Left(
        ServerFailure('offline'),
      );
      when(
        () => fishing(
          minLat: any(named: 'minLat'),
          minLng: any(named: 'minLng'),
          maxLat: any(named: 'maxLat'),
          maxLng: any(named: 'maxLng'),
        ),
      ).thenAnswer((_) async => result);
      when(
        () => waterways(
          minLat: any(named: 'minLat'),
          minLng: any(named: 'minLng'),
          maxLat: any(named: 'maxLat'),
          maxLng: any(named: 'maxLng'),
        ),
      ).thenAnswer((_) async => const Right([]));

      final container = containerWith(fishing: fishing, waterways: waterways);
      final subscription = container.listen(
        hybridFishingRestrictionsProvider,
        (_, _) {},
      );
      addTearDown(subscription.close);

      await expectLater(
        container.read(hybridFishingRestrictionsProvider.future),
        throwsA(isA<StateError>()),
      );
      final throttle = container.read(bboxFetchThrottleProvider.notifier);
      expect(throttle.shouldFetch(camera.center, key: 'fishing'), isTrue);

      result = const Right([]);
      container.read(hybridFishingRestrictionsProvider.notifier).retry();

      expect(
        await container.read(hybridFishingRestrictionsProvider.future),
        isEmpty,
      );
      expect(throttle.shouldFetch(camera.center, key: 'fishing'), isFalse);
      verify(
        () => fishing(
          minLat: any(named: 'minLat'),
          minLng: any(named: 'minLng'),
          maxLat: any(named: 'maxLat'),
          maxLng: any(named: 'maxLng'),
        ),
      ).called(2);
    },
  );

  test(
    'waterway failures remain retryable and empty successes mark the tile',
    () async {
      final fishing = MockGetFishingRestrictions();
      final waterways = MockGetWaterwayFeatures();
      Either<Failure, List<WaterwayFeature>> result = const Left(
        ServerFailure('offline'),
      );
      when(
        () => fishing(
          minLat: any(named: 'minLat'),
          minLng: any(named: 'minLng'),
          maxLat: any(named: 'maxLat'),
          maxLng: any(named: 'maxLng'),
        ),
      ).thenAnswer((_) async => const Right([]));
      when(
        () => waterways(
          minLat: any(named: 'minLat'),
          minLng: any(named: 'minLng'),
          maxLat: any(named: 'maxLat'),
          maxLng: any(named: 'maxLng'),
        ),
      ).thenAnswer((_) async => result);

      final container = containerWith(fishing: fishing, waterways: waterways);
      final subscription = container.listen(
        hybridWaterwayFeaturesProvider,
        (_, _) {},
      );
      addTearDown(subscription.close);

      await expectLater(
        container.read(hybridWaterwayFeaturesProvider.future),
        throwsA(isA<StateError>()),
      );
      final throttle = container.read(bboxFetchThrottleProvider.notifier);
      expect(throttle.shouldFetch(camera.center, key: 'waterway'), isTrue);

      result = const Right([]);
      container.read(hybridWaterwayFeaturesProvider.notifier).retry();

      expect(
        await container.read(hybridWaterwayFeaturesProvider.future),
        isEmpty,
      );
      expect(throttle.shouldFetch(camera.center, key: 'waterway'), isFalse);
    },
  );

  group('displayedFishingRestrictionsProvider', () {
    test('culls using the debounced camera position', () async {
      final container = ProviderContainer(
        overrides: [
          filteredFishingRestrictionsProvider.overrideWith((ref) async {
            return [
              FishingRestriction.withCalculatedBBox(
                id: 'visible',
                title: 'Visible',
                type: 'type',
                rings: [
                  [
                    const LatLng(60, 24),
                    const LatLng(60.01, 24.01),
                    const LatLng(60.01, 24),
                  ],
                ],
              ),
              FishingRestriction.withCalculatedBBox(
                id: 'hidden',
                title: 'Hidden',
                type: 'type',
                rings: [
                  [
                    const LatLng(70, 30),
                    const LatLng(70.01, 30.01),
                    const LatLng(70.01, 30),
                  ],
                ],
              ),
            ];
          }),
          debouncedMapCameraPositionProvider.overrideWithValue(camera),
        ],
      );
      addTearDown(container.dispose);

      await container.read(filteredFishingRestrictionsProvider.future);

      final displayed = container.read(displayedFishingRestrictionsProvider);
      expect(displayed.map((restriction) => restriction.id), ['visible']);
    });
  });
}
