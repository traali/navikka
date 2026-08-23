import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/ai/domain/entities/navigation_context.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';
import 'package:sakkoja/features/ai/domain/services/weather_ai_edge_service.dart';
import 'package:sakkoja/features/navigation/domain/entities/waypoint_entity.dart';
import 'package:sakkoja/features/vessel/data/tables.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_forecast.dart';

void main() {
  group('Local Marine Reasoner AI Tests', () {
    late WeatherAIEdgeService service;

    setUp(() {
      service = WeatherAIEdgeService(getModelPath: () async => null);
    });

    test('synthesizes favorable advice for calm cruising conditions', () async {
      final weather = WeatherData(
        timestamp: DateTime.now(),
        location: const LatLng(60.15, 24.95),
        stationName: 'Harmaja',
        windSpeed: 4.5,
        windGust: 5.5,
        windDirection: 180,
      );
      final wave = WaveData(
        timestamp: DateTime.now(),
        location: const LatLng(60.15, 24.95),
        stationName: 'Helsinki aaltopoiju',
        waveHeight: 0.3,
        wavePeriod: 3.5,
        waveDirection: 180,
        waterTemperature: 15.0,
      );
      const context = NavigationContext(
        vesselType: VesselType.cabinBoat,
      );

      final advice = await service.getAdvice(
        weather: weather,
        wave: wave,
        forecasts: [],
        status: SafetyStatus.green,
        context: context,
      );

      expect(advice, contains('Merisää on erinomainen'));
      expect(advice, contains('COLREG-säännön 5'));
    });

    test('missing wave is not excellent 0.0 m seas', () async {
      final weather = WeatherData(
        timestamp: DateTime.now(),
        location: const LatLng(60.15, 24.95),
        stationName: 'Harmaja',
        windSpeed: 4.5,
        windGust: 5.5,
        windDirection: 180,
      );
      const context = NavigationContext(
        vesselType: VesselType.cabinBoat,
      );

      final advice = await service.getAdvice(
        weather: weather,
        wave: null,
        forecasts: [],
        status: SafetyStatus.green,
        context: context,
      );

      expect(advice, isNot(contains('aallokko 0.0')));
      expect(advice, contains('älä oleta tyyntä'));
    });

    test('missing wind is not excellent 0.0 m/s', () async {
      const context = NavigationContext(
        vesselType: VesselType.cabinBoat,
      );

      final advice = await service.getAdvice(
        weather: null,
        wave: null,
        forecasts: [],
        status: SafetyStatus.green,
        context: context,
      );

      expect(advice, isNot(contains('0.0 m/s')));
      expect(advice, isNot(contains('erinomainen')));
      expect(advice, contains('älä oleta tyyntä'));
    });

    test('fresh breeze without waves is not 0.0 m seas', () async {
      final weather = WeatherData(
        timestamp: DateTime.now(),
        location: const LatLng(60.15, 24.95),
        stationName: 'Harmaja',
        windSpeed: 8.0,
        windGust: 10.0,
        windDirection: 180,
      );
      const context = NavigationContext(
        vesselType: VesselType.cabinBoat,
      );

      final advice = await service.getAdvice(
        weather: weather,
        wave: null,
        forecasts: [],
        status: SafetyStatus.green,
        context: context,
      );

      expect(advice, isNot(contains('aallokko 0.0')));
      expect(advice, contains('älä oleta tyyntä'));
    });

    test('detects high gust factor squalls', () async {
      final weather = WeatherData(
        timestamp: DateTime.now(),
        location: const LatLng(60.15, 24.95),
        stationName: 'Harmaja',
        windSpeed: 6.0,
        windGust: 11.0, // Gust factor = 1.83x
        windDirection: 180,
      );
      final wave = WaveData(
        timestamp: DateTime.now(),
        location: const LatLng(60.15, 24.95),
        stationName: 'Helsinki aaltopoiju',
        waveHeight: 0.5,
        wavePeriod: 3.0,
        waveDirection: 180,
        waterTemperature: 15.0,
      );
      const context = NavigationContext(
        vesselType: VesselType.cabinBoat,
      );

      final advice = await service.getAdvice(
        weather: weather,
        wave: wave,
        forecasts: [],
        status: SafetyStatus.yellow,
        context: context,
      );

      expect(advice, contains('Puuskainen merisää'));
      expect(advice, contains('puuskakerroin'));
    });

    test('warns when wave height exceeds threshold', () async {
      final weather = WeatherData(
        timestamp: DateTime.now(),
        location: const LatLng(60.15, 24.95),
        stationName: 'Harmaja',
        windSpeed: 9.0,
        windGust: 11.0,
        windDirection: 180,
      );
      final wave = WaveData(
        timestamp: DateTime.now(),
        location: const LatLng(60.15, 24.95),
        stationName: 'Helsinki aaltopoiju',
        waveHeight: 1.5,
        wavePeriod: 4.2,
        waveDirection: 180,
        waterTemperature: 14.0,
      );
      const context = NavigationContext(
        vesselType: VesselType.cabinBoat,
      );

      final advice = await service.getAdvice(
        weather: weather,
        wave: wave,
        forecasts: [],
        status: SafetyStatus.orange,
        context: context,
      );

      expect(advice, contains('Voimakas aallokko'));
      expect(advice, contains('saaristoväylät'));
    });

    test('issues emergency danger warning for gale winds', () async {
      final weather = WeatherData(
        timestamp: DateTime.now(),
        location: const LatLng(60.15, 24.95),
        stationName: 'Harmaja',
        windSpeed: 15.5,
        windGust: 21.0,
        windDirection: 220,
      );
      final wave = WaveData(
        timestamp: DateTime.now(),
        location: const LatLng(60.15, 24.95),
        stationName: 'Helsinki aaltopoiju',
        waveHeight: 2.2,
        wavePeriod: 5.5,
        waveDirection: 220,
        waterTemperature: 13.0,
      );
      const context = NavigationContext(
        vesselType: VesselType.cabinBoat,
      );

      final advice = await service.getAdvice(
        weather: weather,
        wave: wave,
        forecasts: [],
        status: SafetyStatus.red,
        context: context,
      );

      expect(advice, contains('Varoitus: Kova tuuli'));
      expect(advice, contains('Hakeudu suojaisaan satamaan'));
    });

    test('provides berthing advice in harbor mode', () async {
      final weather = WeatherData(
        timestamp: DateTime.now(),
        location: const LatLng(60.15, 24.95),
        stationName: 'Harmaja',
        windSpeed: 7.5,
        windGust: 9.0,
        windDirection: 270,
      );
      final wave = WaveData(
        timestamp: DateTime.now(),
        location: const LatLng(60.15, 24.95),
        stationName: 'Helsinki aaltopoiju',
        waveHeight: 0.2,
        wavePeriod: 2.0,
        waveDirection: 270,
        waterTemperature: 16.0,
      );
      const context = NavigationContext(
        vesselType: VesselType.cabinBoat,
        isNearingCoast: true,
      );

      final advice = await service.getAdvice(
        weather: weather,
        wave: wave,
        forecasts: [],
        status: SafetyStatus.green,
        context: context,
      );

      expect(advice, contains('Satamalähestyminen / Kiinnitys'));
      expect(advice, contains('lepuuttajat'));
    });

    test('analyzes route and provides weather-routing recommendations', () {
      final waypoints = [
        WaypointEntity(
          id: 1,
          routeId: 1,
          lat: 60.15,
          lon: 24.95,
          orderIndex: 0,
        ),
        WaypointEntity(
          id: 2,
          routeId: 1,
          lat: 60.20,
          lon: 25.10,
          orderIndex: 1,
        ),
      ];

      final weather = WeatherData(
        timestamp: DateTime.now(),
        location: const LatLng(60.15, 24.95),
        stationName: 'Harmaja',
        windSpeed: 4.5,
        windGust: 6.0,
        windDirection: 180,
      );

      final calmBriefing = WeatherAIEdgeService.analyzeRoute(
        waypoints: waypoints,
        totalDistanceMeters: 12000,
        totalDurationMinutes: 35,
        weather: weather,
        wave: null,
      );

      expect(calmBriefing, contains('Reitti'));
      expect(calmBriefing, contains('älä oleta tyyntä'));
      expect(calmBriefing, isNot(contains('turvallinen')));

      final highWave = WaveData(
        timestamp: DateTime.now(),
        location: const LatLng(60.15, 24.95),
        stationName: 'Helsinki aaltopoiju',
        waveHeight: 1.6,
        wavePeriod: 4.5,
        waveDirection: 180,
        waterTemperature: 12.0,
      );

      final roughBriefing = WeatherAIEdgeService.analyzeRoute(
        waypoints: waypoints,
        totalDistanceMeters: 12000,
        totalDurationMinutes: 35,
        weather: weather,
        wave: highWave,
      );

      expect(roughBriefing, contains('saariston suojaisempien väylien kautta'));
    });

    test(
      'flags multi-provider forecast contradiction when models diverge',
      () async {
        final weather = WeatherData(
          timestamp: DateTime.now(),
          location: const LatLng(60.15, 24.95),
          stationName: 'Harmaja',
          windSpeed: 5.0,
          windGust: 6.0,
          windDirection: 180,
        );
        final wave = WaveData(
          timestamp: DateTime.now(),
          location: const LatLng(60.15, 24.95),
          stationName: 'Helsinki aaltopoiju',
          waveHeight: 0.3,
          wavePeriod: 3.0,
          waveDirection: 180,
          waterTemperature: 15.0,
        );

        final forecasts = [
          WeatherForecast(
            timestamp: DateTime.now().add(const Duration(hours: 2)),
            providerId: 1, // FMI
            windSpeed: 5.5,
            windDirection: 180,
          ),
          WeatherForecast(
            timestamp: DateTime.now().add(const Duration(hours: 2)),
            providerId: 3, // MET Norway
            windSpeed: 10.5, // 5.0 m/s divergence!
            windDirection: 200,
          ),
        ];

        final advice = await service.getAdvice(
          weather: weather,
          wave: wave,
          forecasts: forecasts,
          status: SafetyStatus.yellow,
          context: const NavigationContext(vesselType: VesselType.cabinBoat),
        );

        expect(advice, contains('Ennustemallien ristiriita'));
        expect(advice, contains('epävarmuus'));
      },
    );

    test(
      'detects rapid forecast wind intensification in coming hours',
      () async {
        final weather = WeatherData(
          timestamp: DateTime.now(),
          location: const LatLng(60.15, 24.95),
          stationName: 'Harmaja',
          windSpeed: 4.0,
          windGust: 5.0,
          windDirection: 180,
        );
        final wave = WaveData(
          timestamp: DateTime.now(),
          location: const LatLng(60.15, 24.95),
          stationName: 'Helsinki aaltopoiju',
          waveHeight: 0.3,
          wavePeriod: 3.0,
          waveDirection: 180,
          waterTemperature: 15.0,
        );

        final forecasts = [
          WeatherForecast(
            timestamp: DateTime.now().add(const Duration(hours: 2)),
            providerId: 1,
            windSpeed: 9.0, // +5.0 m/s jump
            windDirection: 180,
          ),
        ];

        final advice = await service.getAdvice(
          weather: weather,
          wave: wave,
          forecasts: forecasts,
          status: SafetyStatus.yellow,
          context: const NavigationContext(vesselType: VesselType.cabinBoat),
        );

        expect(advice, contains('Ennustettu tuulen voimistuminen'));
        expect(advice, contains('4.0 m/s -> 9.0 m/s'));
      },
    );
  });
}
