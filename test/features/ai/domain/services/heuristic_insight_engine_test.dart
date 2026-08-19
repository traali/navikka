import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';
import 'package:sakkoja/features/ai/domain/services/heuristic_insight_engine.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_forecast.dart';

void main() {
  const engine = HeuristicInsightEngine();
  const thresholds = SkipperThresholds(windOrangeMs: 14, windRedMs: 17);

  group('HeuristicInsightEngine - Predictive Logic', () {
    final now = DateTime.now();
    const loc = LatLng(60.1, 24.9);

    test('should return green when current and forecast are safe', () {
      final weather = WeatherData(
        timestamp: now,
        location: loc,
        windGust: 5,
        stationName: 'Test',
      );
      final forecasts = [
        WeatherForecast(
          timestamp: now.add(const Duration(hours: 1)),
          windGust: 6,
        ),
        WeatherForecast(
          timestamp: now.add(const Duration(hours: 2)),
          windGust: 7,
        ),
      ];

      final result = engine.analyze(
        weather: weather,
        wave: null,
        forecasts: forecasts,
        windowHours: 3,
        thresholds: thresholds,
        now: now,
      );

      expect(result.status, SafetyStatus.green);
      expect(result.advice, contains('safe limits'));
      expect(result.insightId, isNotNull);
      expect(result.insightId, isNotEmpty);
    });

    test('should escalate to RED if forecast is RED within window', () {
      final weather = WeatherData(
        timestamp: now,
        location: loc,
        windGust: 5,
        stationName: 'Test',
      );
      final forecasts = [
        WeatherForecast(
          timestamp: now.add(const Duration(hours: 2)),
          windGust: 20,
        ), // RED
      ];

      final result = engine.analyze(
        weather: weather,
        wave: null,
        forecasts: forecasts,
        windowHours: 3,
        thresholds: thresholds,
        now: now,
      );

      expect(result.status, SafetyStatus.red);
      expect(
        result.advice,
        contains('PREDICTIVE: RED conditions expected in ~2 hours'),
      );
    });

    test('should ignore RED forecast outside of window', () {
      final weather = WeatherData(
        timestamp: now,
        location: loc,
        windGust: 5,
        stationName: 'Test',
      );
      final forecasts = [
        WeatherForecast(
          timestamp: now.add(const Duration(hours: 5)),
          windGust: 20,
        ), // RED but outside 3h window
      ];

      final result = engine.analyze(
        weather: weather,
        wave: null,
        forecasts: forecasts,
        windowHours: 3,
        thresholds: thresholds,
        now: now,
      );

      expect(result.status, SafetyStatus.green);
    });

    test('should return current RED even if forecast is green', () {
      final weather = WeatherData(
        timestamp: now,
        location: loc,
        windGust: 20,
        stationName: 'Test',
      ); // RED
      final forecasts = [
        WeatherForecast(
          timestamp: now.add(const Duration(hours: 1)),
          windGust: 5,
        ), // Green
      ];

      final result = engine.analyze(
        weather: weather,
        wave: null,
        forecasts: forecasts,
        windowHours: 3,
        thresholds: thresholds,
        now: now,
      );

      expect(result.status, SafetyStatus.red);
      expect(result.advice, contains('DANGER: Storm force gusts'));
    });
  });
}
