import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';
import 'package:sakkoja/features/ai/domain/services/heuristic_insight_engine.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_forecast.dart';

void main() {
  late HeuristicInsightEngine engine;
  late SkipperThresholds thresholds;

  setUp(() {
    engine = const HeuristicInsightEngine();
    thresholds = const SkipperThresholds(windOrangeMs: 14, windRedMs: 17);
  });

  group('HeuristicInsightEngine Storm Stress Tests', () {
    test('Extreme Wind Gust (30m/s) triggers RED status immediately', () {
      final weather = WeatherData(
        timestamp: DateTime.now(),
        location: const LatLng(60, 24),
        windGust: 30,
        windSpeed: 20,
        temperature: 15,
        pressure: 1000,
        stationName: 'Storm Station',
      );

      final insight = engine.analyze(
        weather: weather,
        wave: null,
        forecasts: [],
        windowHours: 3,
        thresholds: thresholds,
      );

      expect(insight.status, SafetyStatus.red);
      expect(insight.advice, contains('DANGER'));
      expect(insight.advice, contains('30.0m/s'));
    });

    test('High Waves (4.0m) triggers RED status even if wind is low', () {
      final wave = WaveData(
        timestamp: DateTime.now(),
        location: const LatLng(60, 24),
        stationName: 'Wave Station',
        waveHeight: 4,
        wavePeriod: 6,
        waveDirection: 180,
        waterTemperature: null,
      );

      final insight = engine.analyze(
        weather: null,
        wave: wave,
        forecasts: [],
        windowHours: 3,
        thresholds: thresholds,
      );

      expect(insight.status, SafetyStatus.red);
      expect(insight.advice, contains('Extreme waves'));
    });

    test('Predictive Escalation: Upcoming Storm triggers PREDICTIVE RED', () {
      final now = DateTime(2026, 1, 21, 12);
      final weather = WeatherData(
        timestamp: now,
        location: const LatLng(60, 24),
        windGust: 5, // Calm now
        windSpeed: 3,
        temperature: 15,
        pressure: 1013,
        stationName: 'Calm Station',
      );

      final forecasts = [
        WeatherForecast(
          timestamp: now.add(const Duration(hours: 2)),
          windGust: 20, // Storm in 2 hours
          windSpeed: 15,
        ),
      ];

      final insight = engine.analyze(
        weather: weather,
        wave: null,
        forecasts: forecasts,
        windowHours: 6,
        thresholds: thresholds,
        now: now,
      );

      expect(insight.status, SafetyStatus.red);
      expect(insight.advice, contains('PREDICTIVE: RED'));
      expect(insight.advice, contains('in ~2 hours'));
    });

    test(
      'Wave Floor Security Patch: Future calm wind does NOT clear current high waves',
      () {
        final now = DateTime(2026, 1, 21, 12);
        final currentWave = WaveData(
          timestamp: now,
          location: const LatLng(60, 24),
          stationName: 'Deep Station',
          waveHeight: 3, // Red waves now
          wavePeriod: 6,
          waveDirection: 0,
          waterTemperature: null,
        );

        final forecasts = [
          WeatherForecast(
            timestamp: now.add(const Duration(hours: 4)),
            windGust: 2, // Dead calm wind in 4 hours
          ),
        ];

        final insight = engine.analyze(
          weather: null,
          wave: currentWave,
          forecasts: forecasts,
          windowHours: 12,
          thresholds: thresholds,
          now: now,
        );

        // Status should still be RED because the "Security Patch" maintains current waves as a floor.
        expect(insight.status, SafetyStatus.red);
      },
    );
  });
}
