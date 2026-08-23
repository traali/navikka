import 'package:battery_plus/battery_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/features/ai/domain/entities/navigation_context.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_discrepancy.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';
import 'package:sakkoja/features/ai/domain/repositories/skipper_settings_repository.dart';
import 'package:sakkoja/features/ai/domain/services/heuristic_insight_engine.dart';
import 'package:sakkoja/features/ai/domain/services/hybrid_insight_engine.dart';
import 'package:sakkoja/features/ai/domain/services/weather_ai_edge_service.dart';
import 'package:sakkoja/features/ai/domain/services/weather_auditor.dart';
import 'package:sakkoja/features/vessel/data/tables.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_forecast.dart';

class MockHeuristicEngine extends Mock implements HeuristicInsightEngine {}

class MockAIService extends Mock implements WeatherAIEdgeService {}

class MockWeatherAuditor extends Mock implements WeatherAuditor {}

class MockSettingsRepo extends Mock implements SkipperSettingsRepository {}

class MockBattery extends Mock implements Battery {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late HybridInsightEngine hybridEngine;
  late MockHeuristicEngine heuristicEngine;
  late MockAIService aiService;
  late MockWeatherAuditor auditor;
  late MockSettingsRepo settingsRepo;
  late MockBattery battery;

  setUpAll(() {
    registerFallbackValue(SafetyStatus.green);
    registerFallbackValue(NavigationContext.empty());
    registerFallbackValue(const SkipperThresholds());
    registerFallbackValue(
      WeatherData(
        timestamp: DateTime.now(),
        location: const LatLng(0, 0),
        stationName: 'Test',
      ),
    );
    registerFallbackValue(<WeatherForecast>[]);
  });

  setUp(() {
    heuristicEngine = MockHeuristicEngine();
    aiService = MockAIService();
    auditor = MockWeatherAuditor();
    settingsRepo = MockSettingsRepo();
    battery = MockBattery();
    hybridEngine = HybridInsightEngine(
      heuristicEngine,
      aiService,
      auditor,
      settingsRepo,
      battery: battery,
    );

    // Default settings: AI enabled
    when(
      () => settingsRepo.getSettings(),
    ).thenAnswer((_) async => right(const SkipperSettings()));
    // Default battery: OK
    when(() => battery.batteryLevel).thenAnswer((_) async => 80);

    // Default audit: Green
    when(
      () => auditor.audit(
        observation: any(named: 'observation'),
        forecast: any(named: 'forecast'),
        wave: any(named: 'wave'),
        thresholds: any(named: 'thresholds'),
      ),
    ).thenReturn(
      WeatherDiscrepancy(
        status: SafetyStatus.green,
        message: 'Tracking',
        windDeltaMs: 0,
        waveDeltaM: 0,
        pressureDeltaHpa: 0,
        timestamp: DateTime.now(),
      ),
    );

    // Default AI Advice
    when(
      () => aiService.getAdvice(
        weather: any(named: 'weather'),
        wave: any(named: 'wave'),
        forecasts: any(named: 'forecasts'),
        status: any(named: 'status'),
        context: any(named: 'context'),
      ),
    ).thenAnswer((_) async => 'Mock AI Advice');
  });

  test('should escalate status if auditor finds discrepancy', () async {
    // Arrange
    final weather = WeatherData(
      timestamp: DateTime.now(),
      location: const LatLng(0, 0),
      stationName: 'Test',
    );
    final heuristicInsight = WeatherInsight(
      status: SafetyStatus.green,
      advice: 'Heuristic fine',
      timestamp: DateTime.now(),
    );

    when(
      () => heuristicEngine.analyze(
        weather: any(named: 'weather'),
        wave: any(named: 'wave'),
        forecasts: any(named: 'forecasts'),
        windowHours: any(named: 'windowHours'),
        thresholds: any(named: 'thresholds'),
      ),
    ).thenReturn(heuristicInsight);

    when(
      () => auditor.audit(
        observation: any(named: 'observation'),
        forecast: any(named: 'forecast'),
        wave: any(named: 'wave'),
        thresholds: any(named: 'thresholds'),
      ),
    ).thenReturn(
      WeatherDiscrepancy(
        status: SafetyStatus.red, // ESCALATION
        message: 'ALARM: Large wind delta',
        windDeltaMs: 6,
        waveDeltaM: 0,
        pressureDeltaHpa: 0,
        timestamp: DateTime.now(),
      ),
    );

    // Act
    final result = await hybridEngine.getInsight(
      weather: weather,
      wave: null,
      forecasts: [],
      navContext: NavigationContext.empty(),
    );

    // Assert
    expect(result.status, SafetyStatus.red);
    expect(result.advice, contains('ALARM: Large wind delta'));
  });

  test('should pass NavigationContext to AIService', () async {
    // Arrange
    final weather = WeatherData(
      timestamp: DateTime.now(),
      location: const LatLng(0, 0),
      stationName: 'Test',
    );
    const navContext = NavigationContext(
      vesselType: VesselType.sailboat,
      draftDepth: 2.1,
      hasActiveRoute: true,
      activeRouteName: 'Archipelago Run',
    );

    final heuristicInsight = WeatherInsight(
      status: SafetyStatus.yellow,
      advice: 'Heuristic caution',
      timestamp: DateTime.now(),
    );

    when(
      () => heuristicEngine.analyze(
        weather: any(named: 'weather'),
        wave: any(named: 'wave'),
        forecasts: any(named: 'forecasts'),
        windowHours: any(named: 'windowHours'),
        thresholds: any(named: 'thresholds'),
      ),
    ).thenReturn(heuristicInsight);

    when(
      () => aiService.getAdvice(
        weather: any(named: 'weather'),
        wave: any(named: 'wave'),
        forecasts: any(named: 'forecasts'),
        status: any(named: 'status'),
        context: any(named: 'context'),
      ),
    ).thenAnswer((_) async => 'AI enhanced advice');

    // Act
    await hybridEngine.getInsight(
      weather: weather,
      wave: null,
      forecasts: [],
      navContext: navContext,
    );

    // Assert
    verify(
      () => aiService.getAdvice(
        weather: weather,
        wave: null,
        forecasts: [],
        status: SafetyStatus.yellow,
        context: navContext,
      ),
    ).called(1);
  });

  test(
    'battery 0 (iOS Chrome / unsupported API) does not disable AI',
    () async {
      when(() => battery.batteryLevel).thenAnswer((_) async => 0);
      final weather = WeatherData(
        timestamp: DateTime.now(),
        location: const LatLng(0, 0),
        stationName: 'Test',
      );
      when(
        () => heuristicEngine.analyze(
          weather: any(named: 'weather'),
          wave: any(named: 'wave'),
          forecasts: any(named: 'forecasts'),
          windowHours: any(named: 'windowHours'),
          thresholds: any(named: 'thresholds'),
        ),
      ).thenReturn(
        WeatherInsight(
          status: SafetyStatus.green,
          advice: 'Heuristic fine',
          timestamp: DateTime.now(),
        ),
      );

      final result = await hybridEngine.getInsight(
        weather: weather,
        wave: null,
        forecasts: [],
        navContext: NavigationContext.empty(),
      );

      expect(result.advice.contains('Low Battery'), isFalse);
      verify(
        () => aiService.getAdvice(
          weather: weather,
          wave: null,
          forecasts: [],
          status: SafetyStatus.green,
          context: any(named: 'context'),
        ),
      ).called(1);
    },
  );

  test('battery 12 percent disables cloud/edge AI', () async {
    when(() => battery.batteryLevel).thenAnswer((_) async => 12);
    when(
      () => heuristicEngine.analyze(
        weather: any(named: 'weather'),
        wave: any(named: 'wave'),
        forecasts: any(named: 'forecasts'),
        windowHours: any(named: 'windowHours'),
        thresholds: any(named: 'thresholds'),
      ),
    ).thenReturn(
      WeatherInsight(
        status: SafetyStatus.green,
        advice: 'Heuristic fine',
        timestamp: DateTime.now(),
      ),
    );

    final result = await hybridEngine.getInsight(
      weather: WeatherData(
        timestamp: DateTime.now(),
        location: const LatLng(0, 0),
        stationName: 'Test',
      ),
      wave: null,
      forecasts: [],
      navContext: NavigationContext.empty(),
    );

    expect(result.advice, contains('Low Battery'));
    verifyNever(
      () => aiService.getAdvice(
        weather: any(named: 'weather'),
        wave: any(named: 'wave'),
        forecasts: any(named: 'forecasts'),
        status: any(named: 'status'),
        context: any(named: 'context'),
      ),
    );
  });

  test('edge template advice is not stamped as AI inference', () async {
    when(
      () => heuristicEngine.analyze(
        weather: any(named: 'weather'),
        wave: any(named: 'wave'),
        forecasts: any(named: 'forecasts'),
        windowHours: any(named: 'windowHours'),
        thresholds: any(named: 'thresholds'),
      ),
    ).thenReturn(
      WeatherInsight(
        status: SafetyStatus.green,
        advice: 'Heuristic fine',
        timestamp: DateTime.now(),
      ),
    );

    final result = await hybridEngine.getInsight(
      weather: WeatherData(
        timestamp: DateTime.now(),
        location: const LatLng(0, 0),
        stationName: 'Test',
      ),
      wave: null,
      forecasts: [],
      navContext: NavigationContext.empty(),
    );

    expect(result.isAIInference, isFalse);
    expect(result.advice, 'Mock AI Advice');
  });
}
