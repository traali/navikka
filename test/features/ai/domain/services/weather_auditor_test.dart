import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';
import 'package:sakkoja/features/ai/domain/services/weather_auditor.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_forecast.dart';

void main() {
  const auditor = WeatherAuditor();
  const thresholds = SkipperThresholds();

  group('WeatherAuditor - Discrepancy Detection', () {
    final now = DateTime.now();
    const loc = LatLng(60.1, 24.9);

    test('should return GREEN when observation matches forecast', () {
      final weather = WeatherData(
        timestamp: now,
        location: loc,
        windGust: 5,
        stationName: 'Test',
      );
      final forecast = WeatherForecast(timestamp: now, windGust: 5);

      final result = auditor.audit(
        observation: weather,
        forecast: forecast,
        wave: null,
        thresholds: thresholds,
      );

      expect(result.status, SafetyStatus.green);
      expect(result.windDeltaMs, 0.0);
    });

    test('should return RED when wind is >5m/s over forecast', () {
      final weather = WeatherData(
        timestamp: now,
        location: loc,
        windGust: 15,
        stationName: 'Test',
      );
      final forecast = WeatherForecast(timestamp: now, windGust: 9);

      final result = auditor.audit(
        observation: weather,
        forecast: forecast,
        wave: null,
        thresholds: thresholds,
      );

      expect(result.status, SafetyStatus.red);
      expect(result.message, contains('significantly higher than forecasted'));
      expect(result.windDeltaMs, 6.0);
    });

    test('should return ORANGE when wind is 3-5m/s over forecast', () {
      final weather = WeatherData(
        timestamp: now,
        location: loc,
        windGust: 12,
        stationName: 'Test',
      );
      final forecast = WeatherForecast(timestamp: now, windGust: 8.5);

      final result = auditor.audit(
        observation: weather,
        forecast: forecast,
        wave: null,
        thresholds: thresholds,
      );

      expect(result.status, SafetyStatus.orange);
      expect(result.windDeltaMs, 3.5);
    });

    test(
      'should return RED when pressure is significantly lower than forecast',
      () {
        final weather = WeatherData(
          timestamp: now,
          location: loc,
          windGust: 5,
          pressure: 1005,
          stationName: 'Test',
        );
        final forecast = WeatherForecast(
          timestamp: now,
          windGust: 5,
          pressure: 1010,
        );

        final result = auditor.audit(
          observation: weather,
          forecast: forecast,
          wave: null,
          thresholds: thresholds,
        );

        expect(result.status, SafetyStatus.red);
        expect(result.message, contains('SQUALL RISK'));
        expect(result.pressureDeltaHpa, -5.0);
      },
    );

    test('should return RED on dense fog when visibility <= 500m', () {
      final weather = WeatherData(
        timestamp: now,
        location: loc,
        windGust: 3,
        visibility: 350,
        stationName: 'Harmaja',
      );
      final forecast = WeatherForecast(timestamp: now, windGust: 3);

      final result = auditor.audit(
        observation: weather,
        forecast: forecast,
        wave: null,
        thresholds: thresholds,
      );

      expect(result.status, SafetyStatus.red);
      expect(result.message, contains('SUMUHÄLYTYS'));
      expect(result.message, contains('350 m'));
    });

    test('should return ORANGE on fog when visibility is 500-1000m', () {
      final weather = WeatherData(
        timestamp: now,
        location: loc,
        windGust: 3,
        visibility: 850,
        stationName: 'Harmaja',
      );
      final forecast = WeatherForecast(timestamp: now, windGust: 3);

      final result = auditor.audit(
        observation: weather,
        forecast: forecast,
        wave: null,
        thresholds: thresholds,
      );

      expect(result.status, SafetyStatus.orange);
      expect(result.message, contains('SUMUVAROITUS'));
      expect(result.message, contains('850 m'));
    });

    test(
      'should return ORANGE on sea fog condensation risk when temp matches dewPoint and humidity >= 90%',
      () {
        final weather = WeatherData(
          timestamp: now,
          location: loc,
          windGust: 2,
          temperature: 14.2,
          dewPoint: 13.8,
          humidity: 96,
          stationName: 'Suomenlinna',
        );
        final forecast = WeatherForecast(timestamp: now, windGust: 2);

        final result = auditor.audit(
          observation: weather,
          forecast: forecast,
          wave: null,
          thresholds: thresholds,
        );

        expect(result.status, SafetyStatus.orange);
        expect(result.message, contains('SUMUN TIIVISTYMISRISKI'));
      },
    );
  });
}
