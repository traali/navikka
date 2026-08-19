import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/ais/domain/entities/ais_target.dart';
import 'package:sakkoja/features/ais/domain/usecases/calculate_cpa_warnings_usecase.dart';

void main() {
  late CalculateCpaWarningsUseCase useCase;

  setUp(() {
    useCase = CalculateCpaWarningsUseCase();
  });

  group('CalculateCpaWarningsUseCase 7-Point Geometry Test Suite', () {
    test(
      'Case 1: Head-on collision (Reciprocal courses, 10 kn each, 2 NM apart)',
      () {
        final ownPos = const LatLng(60.0, 25.0);
        final ownSog = 10.0;
        final ownCog = 0.0; // Heading North

        // Target is 2 NM North (60.03333° N), heading South (180°) at 10 kn
        final targetPos = const LatLng(60.033333, 25.0);
        final target = AisTarget(
          mmsi: 123456789,
          name: 'HeadOn Ship',
          position: targetPos,
          speedKnots: 10.0,
          courseDegrees: 180.0,
          category: ShipCategory.cargo,
          isMooredOrAnchored: false,
          lastReported: DateTime.now(),
        );

        final result = useCase.execute(
          ownPos: ownPos,
          ownSogKnots: ownSog,
          ownCogDegrees: ownCog,
          target: target,
        );

        expect(result.cpaNauticalMiles, closeTo(0.0, 0.05));
        expect(
          result.tcpaMinutes,
          closeTo(6.0, 0.5),
        ); // 2 NM at 20 kn closing speed = 6 mins
        expect(result.isDangerous, isTrue);
      },
    );

    test(
      'Case 2: Stationary target (Own boat 15 kn towards anchored vessel 1 NM away)',
      () {
        final ownPos = const LatLng(60.0, 25.0);
        final ownSog = 15.0;
        final ownCog = 90.0; // Heading East

        // Target is ~1 NM East (25.0333° E at lat 60 = ~1 NM), stationary (0 kn)
        final targetPos = const LatLng(60.0, 25.033333);
        final target = AisTarget(
          mmsi: 987654321,
          name: 'Anchored Tanker',
          position: targetPos,
          speedKnots: 0.0,
          courseDegrees: 0.0,
          category: ShipCategory.tanker,
          isMooredOrAnchored: true,
          lastReported: DateTime.now(),
        );

        final result = useCase.execute(
          ownPos: ownPos,
          ownSogKnots: ownSog,
          ownCogDegrees: ownCog,
          target: target,
        );

        expect(result.cpaNauticalMiles, closeTo(0.0, 0.05));
        expect(result.tcpaMinutes, closeTo(4.0, 0.5)); // 1 NM at 15 kn = 4 mins
        expect(result.isDangerous, isTrue);
      },
    );

    test(
      'Case 3: Diverging courses (Target and own boat moving away from each other)',
      () {
        final ownPos = const LatLng(60.0, 25.0);
        final ownSog = 10.0;
        final ownCog = 180.0; // Heading South

        // Target is 1 NM North, heading North (0°) away
        final targetPos = const LatLng(60.016667, 25.0);
        final target = AisTarget(
          mmsi: 111222333,
          name: 'Diverging Ferry',
          position: targetPos,
          speedKnots: 10.0,
          courseDegrees: 0.0,
          category: ShipCategory.passenger,
          isMooredOrAnchored: false,
          lastReported: DateTime.now(),
        );

        final result = useCase.execute(
          ownPos: ownPos,
          ownSogKnots: ownSog,
          ownCogDegrees: ownCog,
          target: target,
        );

        expect(result.tcpaMinutes, lessThan(0.0));
        expect(result.isDangerous, isFalse);
      },
    );

    test(
      'Case 4: 90° Crossing (Target 1 NM East, 1 NM North crossing West at 10 kn)',
      () {
        final ownPos = const LatLng(60.0, 25.0);
        final ownSog = 10.0;
        final ownCog = 0.0; // Heading North at 10 kn

        // Target at 1 NM East, 1 NM North (60.016667, 25.033333), heading West (270°) at 10 kn
        // Both reach (60.016667, 25.0) in exactly 6 minutes -> Exact CPA = 0.0 NM
        final targetPos = const LatLng(60.016667, 25.033333);
        final target = AisTarget(
          mmsi: 444555666,
          name: 'Crossing Tug',
          position: targetPos,
          speedKnots: 10.0,
          courseDegrees: 270.0,
          category: ShipCategory.tug,
          isMooredOrAnchored: false,
          lastReported: DateTime.now(),
        );

        final result = useCase.execute(
          ownPos: ownPos,
          ownSogKnots: ownSog,
          ownCogDegrees: ownCog,
          target: target,
        );

        expect(result.tcpaMinutes, closeTo(6.0, 0.5));
        expect(result.cpaNauticalMiles, closeTo(0.0, 0.05));
        expect(result.isDangerous, isTrue);
      },
    );

    test(
      'Case 5: Overtaking (Same course, own boat 15 kn behind target 5 kn)',
      () {
        final ownPos = const LatLng(60.0, 25.0);
        final ownSog = 15.0;
        final ownCog = 0.0; // Heading North

        // Target is 1 NM North, heading North at 5 kn (Closing speed = 10 kn)
        final targetPos = const LatLng(60.016667, 25.0);
        final target = AisTarget(
          mmsi: 777888999,
          name: 'Slow Barge',
          position: targetPos,
          speedKnots: 5.0,
          courseDegrees: 0.0,
          category: ShipCategory.cargo,
          isMooredOrAnchored: false,
          lastReported: DateTime.now(),
        );

        final result = useCase.execute(
          ownPos: ownPos,
          ownSogKnots: ownSog,
          ownCogDegrees: ownCog,
          target: target,
        );

        expect(result.cpaNauticalMiles, closeTo(0.0, 0.05));
        expect(
          result.tcpaMinutes,
          closeTo(6.0, 0.5),
        ); // 1 NM at 10 kn closing = 6 mins
        expect(result.isDangerous, isTrue);
      },
    );

    test('Case 6: Parallel safe pass (1.5 NM separation)', () {
      final ownPos = const LatLng(60.0, 25.0);
      final ownSog = 10.0;
      final ownCog = 0.0; // Heading North

      // Target is 1.5 NM East (0.05° E at lat 60°), heading North (0°) at 10 kn
      final targetPos = const LatLng(60.0, 25.05);
      final target = AisTarget(
        mmsi: 121212121,
        name: 'Parallel Ship',
        position: targetPos,
        speedKnots: 10.0,
        courseDegrees: 0.0,
        category: ShipCategory.cargo,
        isMooredOrAnchored: false,
        lastReported: DateTime.now(),
      );

      final result = useCase.execute(
        ownPos: ownPos,
        ownSogKnots: ownSog,
        ownCogDegrees: ownCog,
        target: target,
      );

      expect(result.cpaNauticalMiles, closeTo(1.5, 0.1));
      expect(result.isDangerous, isFalse);
    });

    test(
      'Case 7: Immediate proximity (Target 0.2 NM alongside, TCPA <= 0)',
      () {
        final ownPos = const LatLng(60.0, 25.0);
        final ownSog = 0.0;
        final ownCog = 0.0;

        // Target is 0.2 NM East (0.00666° E), stationary
        final targetPos = const LatLng(60.0, 25.006667);
        final target = AisTarget(
          mmsi: 999000111,
          name: 'Nearby Vessel',
          position: targetPos,
          speedKnots: 0.0,
          courseDegrees: 0.0,
          category: ShipCategory.pleasure,
          isMooredOrAnchored: true,
          lastReported: DateTime.now(),
        );

        final result = useCase.execute(
          ownPos: ownPos,
          ownSogKnots: ownSog,
          ownCogDegrees: ownCog,
          target: target,
        );

        expect(result.cpaNauticalMiles, closeTo(0.2, 0.05));
        expect(result.isDangerous, isTrue);
      },
    );
  });
}
