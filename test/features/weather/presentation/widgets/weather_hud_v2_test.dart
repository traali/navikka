import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/theme/app_theme.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';
import 'package:sakkoja/features/ai/presentation/providers/ai_providers.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';
import 'package:sakkoja/features/weather/presentation/widgets/weather_hud_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mock State for the Controller
class MockPointWeatherController extends PointWeatherController {
  MockPointWeatherController({this.initialState, this.error});
  final PointWeatherState? initialState;
  final Object? error;

  @override
  PointWeatherState build() {
    return initialState ?? PointWeatherState(lastUpdated: DateTime.now());
  }
}

// Mock Insight State
final mockInsightProvider = Provider<WeatherInsight>((ref) {
  return WeatherInsight(
    advice: 'Test Advice',
    status: SafetyStatus.green,
    timestamp: DateTime.now(),
  );
});

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('WeatherHudV2', () {
    testWidgets('renders nothing when data is empty', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            pointWeatherControllerProvider.overrideWith(
              MockPointWeatherController.new,
            ),
            skipperInsightProvider.overrideWith(
              (ref) => ref.watch(mockInsightProvider),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const Scaffold(body: WeatherHudV2()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('Odota säätietoja...'),
        findsOneWidget,
      ); // Empty state shown when no data
    });
  });
}
