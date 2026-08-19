import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/ai/domain/entities/explanation_payload.dart';
import 'package:sakkoja/features/ai/domain/entities/navigation_context.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';
import 'package:sakkoja/features/ai/domain/services/explanation_prompt_builder.dart';
import 'package:sakkoja/features/vessel/data/tables.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_forecast.dart';

void main() {
  const builder = ExplanationPromptBuilder();
  final now = DateTime.utc(2026, 5, 15, 12, 0, 0);

  group('ExplanationPromptBuilder', () {
    test('builds payload with all observation fields', () {
      final insight = WeatherInsight(
        status: SafetyStatus.yellow,
        advice: 'CAUTION: test',
        timestamp: now,
        insightId: 'test_1',
      );
      final weather = WeatherData(
        timestamp: now,
        location: const LatLng(60.1, 24.9),
        windSpeed: 10.5,
        windGust: 13.2,
        windDirection: 180,
        pressure: 1012,
        visibility: 8000,
        temperature: 8,
        precipitation: 0.5,
        cloudCover: 60,
        humidity: 85,
        stationName: 'Test',
      );
      final wave = WaveData(
        timestamp: now,
        location: const LatLng(60.1, 24.9),
        stationName: 'Buoy',
        waveHeight: 1.2,
        wavePeriod: 5,
        waveDirection: 90,
        waterTemperature: 7,
      );
      final thresholds = SkipperThresholds(
        windYellowMs: 10,
        windOrangeMs: 12,
        windRedMs: 14,
      );
      final navContext = NavigationContext(
        vesselType: VesselType.sailboat,
        hasActiveRoute: true,
      );

      final payload = builder.build(
        insight: insight,
        weather: weather,
        wave: wave,
        forecasts: [],
        thresholds: thresholds,
        navContext: navContext,
        language: 'fi',
      );

      expect(payload.meta.language, 'fi');
      expect(payload.meta.vesselType, 'sailboat');
      expect(payload.meta.hasActiveRoute, true);
      expect(payload.status, 'yellow');

      expect(payload.observation.windSpeed, 10.5);
      expect(payload.observation.windGust, 13.2);
      expect(payload.observation.waveHeight, 1.2);
      expect(payload.observation.pressure, 1012);
      expect(payload.observation.visibility, 8000);
    });

    test('handles null weather and wave gracefully', () {
      final insight = WeatherInsight(
        status: SafetyStatus.green,
        advice: 'Safe',
        timestamp: now,
        insightId: 'test_2',
      );
      final thresholds = const SkipperThresholds();
      final navContext = NavigationContext.empty();

      final payload = builder.build(
        insight: insight,
        weather: null,
        wave: null,
        forecasts: [],
        thresholds: thresholds,
        navContext: navContext,
        language: 'en',
      );

      expect(payload.observation.windSpeed, isNull);
      expect(payload.observation.waveHeight, isNull);
      expect(payload.status, 'green');
      expect(payload.forecast, isNull);
    });

    test('limits forecast points to maxForecastPoints', () {
      final insight = WeatherInsight(
        status: SafetyStatus.red,
        advice: 'Danger',
        timestamp: now,
        insightId: 'test_3',
      );
      final forecasts = List.generate(
        10,
        (i) => WeatherForecast(
          timestamp: now.add(Duration(hours: i)),
          windGust: 15.0 + i,
        ),
      );
      final thresholds = const SkipperThresholds();
      final navContext = NavigationContext.empty();

      final payload = builder.build(
        insight: insight,
        weather: null,
        wave: null,
        forecasts: forecasts,
        thresholds: thresholds,
        navContext: navContext,
        language: 'en',
        maxForecastPoints: 3,
      );

      expect(payload.forecast, isNotNull);
      expect(payload.forecast!.length, 3);
      expect(payload.forecast![0].windGust, 15.0);
      expect(payload.forecast![2].windGust, 17.0);
    });

    test('toJsonString produces valid JSON', () {
      final insight = WeatherInsight(
        status: SafetyStatus.orange,
        advice: 'Warning',
        timestamp: now,
        insightId: 'test_4',
      );
      final thresholds = const SkipperThresholds();
      final navContext = NavigationContext.empty();

      final payload = builder.build(
        insight: insight,
        weather: null,
        wave: null,
        forecasts: [],
        thresholds: thresholds,
        navContext: navContext,
        language: 'sv',
      );

      final jsonString = builder.toJsonString(payload);
      final decoded = jsonDecode(jsonString) as Map<String, dynamic>;

      expect(decoded['status'], 'orange');
      expect(decoded['meta']['language'], 'sv');
      expect(decoded['thresholds']['windYellowMs'], 10.0);
    });

    test('buildPrompt contains system prompt and language directive', () {
      final insight = WeatherInsight(
        status: SafetyStatus.yellow,
        advice: 'Caution',
        timestamp: now,
        insightId: 'test_5',
      );
      final thresholds = const SkipperThresholds();
      final navContext = NavigationContext.empty();

      final payload = builder.build(
        insight: insight,
        weather: null,
        wave: null,
        forecasts: [],
        thresholds: thresholds,
        navContext: navContext,
        language: 'fi',
      );

      final prompt = builder.buildPrompt(payload);

      expect(prompt, contains(ExplanationPromptBuilder.systemPrompt));
      expect(prompt, contains('Respond in language: fi'));
      expect(prompt, contains('--- PAYLOAD ---'));
      expect(prompt, contains('--- END PAYLOAD ---'));
    });

    test('forecast list is null when no forecasts provided', () {
      final insight = WeatherInsight(
        status: SafetyStatus.green,
        advice: 'Safe',
        timestamp: now,
        insightId: 'test_6',
      );
      final thresholds = const SkipperThresholds();
      final navContext = NavigationContext.empty();

      final payload = builder.build(
        insight: insight,
        weather: null,
        wave: null,
        forecasts: [],
        thresholds: thresholds,
        navContext: navContext,
        language: 'en',
      );

      expect(payload.forecast, isNull);
    });
  });
}
