import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/features/ais/domain/utils/colregs_helper.dart';

void main() {
  group('ColregsHelper Tests', () {
    test(
      'identifies Give-Way vessel when target is on starboard bow (45°)',
      () {
        final role = ColregsHelper.getCrossingRole(45.0);
        expect(role, contains('GIVE-WAY'));
      },
    );

    test('identifies Stand-On vessel when target is on port bow (300°)', () {
      final role = ColregsHelper.getCrossingRole(300.0);
      expect(role, contains('STAND-ON'));
    });

    test('identifies Head-On situation when target is directly ahead (0°)', () {
      final role = ColregsHelper.getCrossingRole(0.0);
      expect(role, contains('HEAD-ON'));
    });

    test('validates 9-digit MMSI strings correctly', () {
      expect(
        ColregsHelper.isValidMmsi('230123456'),
        isTrue,
      ); // Finnish MMSI MID 230
      expect(ColregsHelper.isValidMmsi(230123456), isTrue);
      expect(ColregsHelper.isValidMmsi('12345'), isFalse);
      expect(ColregsHelper.isValidMmsi('ABCDEFGHI'), isFalse);
    });
  });
}
