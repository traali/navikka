import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/ais/domain/entities/ais_target.dart';
import 'package:sakkoja/features/ais/domain/usecases/calculate_cpa_warnings_usecase.dart';

void main() {
  group('CalculateCpaWarningsUseCase Safety Matrix', () {
    late CalculateCpaWarningsUseCase useCase;

    setUp(() {
      useCase = CalculateCpaWarningsUseCase();
    });

    test(
      'Head-on collision course within 10 min triggers dangerous warning',
      () {
        const ownPos = LatLng(60.150, 24.900);
        final target = AisTarget(
          mmsi: 123456789,
          name: 'HeadOnVessel',
          position: const LatLng(60.163, 24.900),
          speedKnots: 12.0,
          courseDegrees: 180.0,
          headingDegrees: 180.0,
          category: ShipCategory.cargo,
          isMooredOrAnchored: false,
          lastReported: DateTime.now(),
        );

        final result = useCase.execute(
          ownPos: ownPos,
          ownSogKnots: 12.0,
          ownCogDegrees: 0.0,
          target: target,
        );

        expect(result.isDangerous, isTrue);
        expect(result.cpaNauticalMiles, lessThan(0.1));
        expect(result.tcpaMinutes, greaterThan(0));
        expect(result.tcpaMinutes, lessThan(10));
      },
    );

    test(
      'Parallel course with safe lateral separation (2 NM) is NOT dangerous',
      () {
        const ownPos = LatLng(60.150, 24.900);
        final target = AisTarget(
          mmsi: 987654321,
          name: 'ParallelVessel',
          position: const LatLng(60.150, 24.940),
          speedKnots: 10.0,
          courseDegrees: 0.0,
          headingDegrees: 0.0,
          category: ShipCategory.passenger,
          isMooredOrAnchored: false,
          lastReported: DateTime.now(),
        );

        final result = useCase.execute(
          ownPos: ownPos,
          ownSogKnots: 10.0,
          ownCogDegrees: 0.0,
          target: target,
        );

        expect(result.isDangerous, isFalse);
      },
    );

    test('Diverging course (opening distance) is NOT dangerous', () {
      const ownPos = LatLng(60.150, 24.900);
      final target = AisTarget(
        mmsi: 555555555,
        name: 'DivergingVessel',
        position: const LatLng(60.160, 24.900),
        speedKnots: 10.0,
        courseDegrees: 0.0,
        headingDegrees: 0.0,
        category: ShipCategory.unknown,
        isMooredOrAnchored: false,
        lastReported: DateTime.now(),
      );

      final result = useCase.execute(
        ownPos: ownPos,
        ownSogKnots: 10.0,
        ownCogDegrees: 180.0,
        target: target,
      );

      expect(result.isDangerous, isFalse);
    });

    test(
      'Target inside safety perimeter (≤ 0.5 NM) triggers instant alert',
      () {
        const ownPos = LatLng(60.150, 24.900);
        final target = AisTarget(
          mmsi: 444444444,
          name: 'NearbyVessel',
          position: const LatLng(60.152, 24.900),
          speedKnots: 2.0,
          courseDegrees: 90.0,
          headingDegrees: 90.0,
          category: ShipCategory.pleasure,
          isMooredOrAnchored: false,
          lastReported: DateTime.now(),
        );

        final result = useCase.execute(
          ownPos: ownPos,
          ownSogKnots: 0.0,
          ownCogDegrees: 0.0,
          target: target,
        );

        expect(result.isDangerous, isTrue);
      },
    );
  });
}
