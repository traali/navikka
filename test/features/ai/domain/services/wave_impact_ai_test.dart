import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/features/ai/domain/services/wave_impact_ai_service.dart';

void main() {
  group('WaveImpactAiService - Severity & Thresholding', () {
    test('classifies smooth sea state under 1.6g', () {
      expect(WaveImpactAiService.classifySeverity(1.1), SlamSeverity.smooth);
      expect(WaveImpactAiService.classifySeverity(1.5), SlamSeverity.smooth);
    });

    test('classifies moderate wave slam between 1.6g and 2.5g', () {
      expect(WaveImpactAiService.classifySeverity(1.8), SlamSeverity.moderate);
      expect(WaveImpactAiService.classifySeverity(2.4), SlamSeverity.moderate);
    });

    test('classifies hard hull slam between 2.5g and 4.0g', () {
      expect(WaveImpactAiService.classifySeverity(2.8), SlamSeverity.hard);
      expect(WaveImpactAiService.classifySeverity(3.6), SlamSeverity.hard);
    });

    test('classifies severe/extreme shock above 4.0g', () {
      expect(WaveImpactAiService.classifySeverity(4.2), SlamSeverity.severe);
    });
  });

  group('WaveImpactAiService - Wave Attack Direction', () {
    test('detects head seas when pitch rate dominates roll rate', () {
      final direction = WaveImpactAiService.estimateWaveDirection(
        pitchRates: [0.45, 0.50, 0.42, 0.48],
        rollRates: [0.10, 0.12, 0.08, 0.11],
        hitsPerMinute: 12,
      );
      expect(direction, WaveAttackDirection.headSeas);
      expect(direction.label, contains('Vasta-aallokko'));
    });

    test('detects beam seas when roll rate dominates pitch rate', () {
      final direction = WaveImpactAiService.estimateWaveDirection(
        pitchRates: [0.08, 0.10, 0.09],
        rollRates: [0.55, 0.62, 0.48],
        hitsPerMinute: 8,
      );
      expect(direction, WaveAttackDirection.beamSeas);
      expect(direction.label, contains('Sivuaallokko'));
    });

    test('detects calm sea when motion is minimal', () {
      final direction = WaveImpactAiService.estimateWaveDirection(
        pitchRates: [0.01, 0.02],
        rollRates: [0.01, 0.02],
        hitsPerMinute: 0,
      );
      expect(direction, WaveAttackDirection.calm);
    });
  });

  group('WaveImpactAiService - Outlier Wave & Sea Roughness Estimator', () {
    test('detects outlier bigger wave when spike exceeds baseline mean', () {
      final service = WaveImpactAiService();
      final now = DateTime.now();

      // Seed 10 moderate hits around 1.8g
      for (int i = 0; i < 10; i++) {
        service.processSensorReading(
          gForce: 1.8,
          pitchRates: [0.3],
          rollRates: [0.1],
          now: now.add(Duration(seconds: i * 3)),
        );
      }

      // Outlier rogue wave impact at 3.6g
      final outlierState = service.processSensorReading(
        gForce: 3.6,
        pitchRates: [0.5],
        rollRates: [0.1],
        now: now.add(const Duration(seconds: 35)),
      );

      expect(outlierState.isOutlierWave, isTrue);
      expect(
        outlierState.skipperAdvice,
        contains('Yksittäinen poikkeuksellisen korkea aalto'),
      );
    });

    test(
      'calculates estimated wave height Hs based on G-force and hit rate',
      () {
        final hs = WaveImpactAiService.calculateEstimatedWaveHeight(
          peakG: 2.8,
          hitsPerMinute: 16,
          boatSpeedKnots: 15.0,
        );
        expect(hs, greaterThanOrEqualTo(0.8));
        expect(hs, lessThanOrEqualTo(2.5));
      },
    );
  });

  group('WaveImpactAiService - sensor honesty', () {
    test('initial state is not a fake 1.0g measurement', () {
      final initial = WaveImpactState.initial();
      expect(initial.hasSensorSamples, isFalse);
    });

    test('first processSensorReading marks live samples', () {
      final service = WaveImpactAiService();
      final state = service.processSensorReading(
        gForce: 1.05,
        pitchRates: const [],
        rollRates: const [],
        now: DateTime.now(),
      );
      expect(state.hasSensorSamples, isTrue);
    });
  });
}
