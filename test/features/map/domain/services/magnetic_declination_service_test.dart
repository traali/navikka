import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/features/map/domain/services/magnetic_declination_service.dart';

void main() {
  group('MagneticDeclinationService Tests', () {
    test('calculates correct declination range for Helsinki region', () {
      final declination = MagneticDeclinationService.calculateDeclination(
        60.1699,
        24.9384,
      );
      expect(declination, greaterThanOrEqualTo(7.5));
      expect(declination, lessThanOrEqualTo(9.5));
    });

    test('calculates correct declination range for Åland (Western Baltic)', () {
      final declination = MagneticDeclinationService.calculateDeclination(
        60.0999,
        19.9384,
      );
      expect(declination, greaterThanOrEqualTo(4.5));
      expect(declination, lessThanOrEqualTo(8.5));
    });

    test('converts true heading to magnetic heading correctly', () {
      const trueHeading = 180.0;
      const declination = 8.5; // 8.5° East
      final magnetic = MagneticDeclinationService.trueToMagnetic(
        trueHeading,
        declination,
      );
      expect(magnetic, closeTo(171.5, 0.01));
    });

    test('converts magnetic heading to true heading correctly', () {
      const magneticHeading = 171.5;
      const declination = 8.5;
      final trueHeading = MagneticDeclinationService.magneticToTrue(
        magneticHeading,
        declination,
      );
      expect(trueHeading, closeTo(180.0, 0.01));
    });
  });
}
