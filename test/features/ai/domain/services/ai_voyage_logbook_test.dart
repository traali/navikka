import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/features/ai/domain/services/ai_voyage_logbook_service.dart';

void main() {
  group('AiVoyageLogbookService - Automatic Recap & Fuel Estimation', () {
    test(
      'generates accurate NM distance, duration and fuel for gasoline motorboat',
      () {
        final recap = AiVoyageLogbookService.generateRecap(
          tripName: 'Helsinki - Porvoo',
          totalDistanceMeters: 37040, // 20 NM
          totalDurationSeconds: 3600, // 1 hour
          maxSpeedKmh: 45.0, // ~24.3 kn
          avgSpeedKmh: 37.04, // 20.0 kn
          maxWindSpeedMs: 8.5,
          fuelType: 'Bensiini',
          engineDisplacementLiters: 2.0,
        );

        expect(recap.distanceNm, closeTo(20.0, 0.1));
        expect(recap.durationMinutes, 60);
        expect(recap.avgSpeedKnots, closeTo(20.0, 0.1));
        expect(
          recap.estimatedFuelLiters,
          closeTo(22.0, 0.5),
        ); // 20 NM * 1.1 L/NM
        expect(recap.narrativeRecap, contains('Helsinki - Porvoo'));
        expect(recap.milestones.length, greaterThanOrEqualTo(3));
      },
    );

    test('calculates zero fuel for electric propulsion boat', () {
      final recap = AiVoyageLogbookService.generateRecap(
        tripName: 'Kallavesi saaristoajelu',
        totalDistanceMeters: 9260, // 5 NM
        totalDurationSeconds: 3600,
        maxSpeedKmh: 12.0,
        avgSpeedKmh: 9.26,
        maxWindSpeedMs: 4.0,
        fuelType: 'Sähkö',
        engineDisplacementLiters: null,
      );

      expect(recap.distanceNm, closeTo(5.0, 0.1));
      expect(recap.estimatedFuelLiters, 0.0);
      expect(recap.narrativeRecap, contains('Puhdas sähköajo'));
    });

    test('does not invent 5.0 m/s peak wind when none was recorded', () {
      final recap = AiVoyageLogbookService.generateRecap(
        tripName: 'Lyhyt siirto',
        totalDistanceMeters: 1852,
        totalDurationSeconds: 600,
        maxSpeedKmh: 10.0,
        avgSpeedKmh: 6.0,
        maxWindSpeedMs: null,
        fuelType: 'Bensiini',
        engineDisplacementLiters: null,
      );
      expect(recap.maxWindSpeedMs, isNull);
      expect(recap.narrativeRecap, contains('tuulta ei kirjattu'));
      expect(recap.narrativeRecap.contains('5.0 m/s'), isFalse);
    });
  });
}
