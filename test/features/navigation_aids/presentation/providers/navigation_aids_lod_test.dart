import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sakkoja/core/constants/navigation_aids_constants.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';
import 'package:sakkoja/features/navigation_aids/di/navigation_aids_di.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/navigation_aid.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/navigation_aid_type.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/navigation_line.dart';
import 'package:sakkoja/features/navigation_aids/domain/repositories/navigation_aids_repository.dart';
import 'package:sakkoja/features/navigation_aids/presentation/providers/navigation_aids_providers.dart';

class MockNavigationAidsRepository extends Mock
    implements NavigationAidsRepository {}

void main() {
  group('Navigation Aids LOD Filtering', () {
    const lighthouse = NavigationAid(
      id: 'lighthouse-1',
      type: NavigationAidType.lighthouse,
      name: 'Test Lighthouse',
      position: LatLng(60, 24),
    );

    const trafficSign = NavigationAid(
      id: 'traffic-1',
      type: NavigationAidType.trafficSign,
      name: 'Speed Limit 10',
      position: LatLng(60, 24),
      signTypeCode: '01',
      restrictionValue: 10,
    );

    const cardinalBuoy = NavigationAid(
      id: 'cardinal-1',
      type: NavigationAidType.safetyEquipment,
      name: 'North Cardinal',
      position: LatLng(60, 24),
      ialaCode: '3',
    );

    const lateralBuoy = NavigationAid(
      id: 'lateral-1',
      type: NavigationAidType.safetyEquipment,
      name: 'Port Mark',
      position: LatLng(60, 24),
      ialaCode: '1',
    );

    const specialMark = NavigationAid(
      id: 'special-1',
      type: NavigationAidType.safetyEquipment,
      name: 'Special Mark',
      position: LatLng(60, 24),
      ialaCode: '9',
    );

    group('Zoom Thresholds', () {
      test('zoomShowLighthouses is 9.0', () {
        expect(NavigationAidsConstants.zoomShowLighthouses, 9.0);
      });

      test('zoomShowTrafficSigns is 12.5', () {
        expect(NavigationAidsConstants.zoomShowTrafficSigns, 12.5);
      });

      test('zoomShowMajorBuoys is 10.5', () {
        expect(NavigationAidsConstants.zoomShowMajorBuoys, 10.5);
      });

      test('zoomShowAllEquipment is 11.5', () {
        expect(NavigationAidsConstants.zoomShowAllEquipment, 11.5);
      });
    });

    group('shouldShowAtZoom logic', () {
      bool shouldShowAtZoom(NavigationAid aid, double zoom) {
        switch (aid.type) {
          case NavigationAidType.lighthouse:
            return zoom >= NavigationAidsConstants.zoomShowLighthouses;
          case NavigationAidType.trafficSign:
            return zoom >= NavigationAidsConstants.zoomShowTrafficSigns;
          case NavigationAidType.safetyEquipment:
            if (NavigationAidsConstants.majorBuoyCodes.contains(aid.ialaCode)) {
              return zoom >= NavigationAidsConstants.zoomShowMajorBuoys;
            }
            return zoom >= NavigationAidsConstants.zoomShowAllEquipment;
        }
      }

      test('lighthouse visible at zoom 9', () {
        expect(shouldShowAtZoom(lighthouse, 9), isTrue);
      });

      test('lighthouse NOT visible at zoom 8', () {
        expect(shouldShowAtZoom(lighthouse, 8), isFalse);
      });

      test('traffic sign visible at zoom 12.5', () {
        expect(shouldShowAtZoom(trafficSign, 12.5), isTrue);
      });

      test('traffic sign NOT visible at zoom 12', () {
        expect(shouldShowAtZoom(trafficSign, 12), isFalse);
      });

      test('cardinal buoy visible at zoom 10.5', () {
        expect(shouldShowAtZoom(cardinalBuoy, 10.5), isTrue);
      });

      test('cardinal buoy NOT visible at zoom 10.0', () {
        expect(shouldShowAtZoom(cardinalBuoy, 10.0), isFalse);
      });

      test('lateral buoy visible at zoom 10.5', () {
        expect(shouldShowAtZoom(lateralBuoy, 10.5), isTrue);
      });

      test('special mark visible at zoom 11.5', () {
        expect(shouldShowAtZoom(specialMark, 11.5), isTrue);
      });

      test('special mark NOT visible at zoom 11.0', () {
        expect(shouldShowAtZoom(specialMark, 11.0), isFalse);
      });
    });
  });

  test('displayed navigation aids cull with the debounced camera', () async {
    const remoteLighthouse = NavigationAid(
      id: 'remote-lighthouse',
      type: NavigationAidType.lighthouse,
      name: 'Remote Lighthouse',
      position: LatLng(64, 28),
      lightRangeNm: 12,
    );
    final repository = MockNavigationAidsRepository();
    when(
      () => repository.getNavigationAids(),
    ).thenAnswer((_) async => const Right([remoteLighthouse]));
    final container = ProviderContainer(
      overrides: [
        navigationAidsRepositoryProvider.overrideWithValue(repository),
        debouncedMapCameraPositionProvider.overrideWithValue(
          const MapCameraState(center: LatLng(64, 28), zoom: 14),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(hybridNavigationAidsProvider.future);
    expect(
      container.read(displayedNavigationAidsProvider).map((aid) => aid.id),
      ['remote-lighthouse'],
    );
  });

  test('keeps a navigation line whose segment crosses the viewport', () async {
    final crossingLine = NavigationLine(
      id: 'crossing-line',
      points: const [LatLng(60, 23.7), LatLng(60, 24.3)],
      bounds: LatLngBounds(
        const LatLng(60, 23.7),
        const LatLng(60, 24.3),
      ),
      fairwayClass: '1',
    );
    final repository = MockNavigationAidsRepository();
    when(
      () => repository.getNavigationLines(),
    ).thenAnswer((_) async => Right([crossingLine]));
    final container = ProviderContainer(
      overrides: [
        navigationAidsRepositoryProvider.overrideWithValue(repository),
        debouncedMapCameraPositionProvider.overrideWithValue(
          const MapCameraState(center: LatLng(60, 24), zoom: 14),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(hybridNavigationLinesProvider.future);

    expect(
      container.read(displayedNavigationLinesProvider).map((line) => line.id),
      ['crossing-line'],
    );
  });
}
