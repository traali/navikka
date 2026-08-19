import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/settings/presentation/providers/unit_preferences_provider.dart';

void main() {
  group('SpeedUnit Tests', () {
    test('converts km/h to knots correctly', () {
      const speedKmh = 18.52; // 10 knots
      final knots = SpeedUnit.knots.convertFromKmh(speedKmh);
      expect(knots, closeTo(10.0, 0.1));
      expect(SpeedUnit.knots.format(speedKmh), '10.0 kn');
    });

    test('converts km/h to mph correctly', () {
      const speedKmh = 100.0;
      final mph = SpeedUnit.mph.convertFromKmh(speedKmh);
      expect(mph, closeTo(62.1, 0.2));
      expect(SpeedUnit.mph.format(speedKmh), '62.1 mph');
    });
  });

  group('WindSpeedUnit Tests', () {
    test('converts m/s to knots correctly', () {
      const windMs = 10.0;
      final knots = WindSpeedUnit.knots.convertFromMs(windMs);
      expect(knots, closeTo(19.4, 0.1));
      expect(WindSpeedUnit.knots.format(windMs), '19.4 kn');
    });

    test('converts m/s to Beaufort scale correctly', () {
      expect(WindSpeedUnit.beaufort.convertFromMs(0.2), 0);
      expect(WindSpeedUnit.beaufort.convertFromMs(2.5), 2);
      expect(WindSpeedUnit.beaufort.convertFromMs(9.0), 5);
      expect(WindSpeedUnit.beaufort.convertFromMs(22.0), 9);
      expect(WindSpeedUnit.beaufort.convertFromMs(35.0), 12);
      expect(WindSpeedUnit.beaufort.format(9.0), '5 Bft');
    });
  });

  group('DepthUnit Tests', () {
    test('converts meters to feet correctly', () {
      const depthMeters = 10.0;
      final feet = DepthUnit.feet.convertFromMeters(depthMeters);
      expect(feet, closeTo(32.8, 0.1));
      expect(DepthUnit.feet.format(depthMeters), '32.8 ft');
    });
  });
}
