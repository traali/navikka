import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';
import 'package:sakkoja/features/weather/presentation/widgets/offline_banner.dart';
import 'package:sakkoja/features/weather/presentation/widgets/weather_detail_sheet.dart';

// Reuse Mock from Hud Test or simpler one
class MockPointWeatherController extends PointWeatherController {
  MockPointWeatherController({this.initialState});
  final PointWeatherState? initialState;
  @override
  PointWeatherState build() {
    return initialState ?? PointWeatherState(lastUpdated: DateTime.now());
  }
}

void main() {
  group('WeatherDetailSheet', () {
    testWidgets('shows Last Updated timestamp', (tester) async {
      final time = DateTime(2026, 1, 16, 14, 30);
      final state = PointWeatherState(
        weather: WeatherData(
          stationName: 'Test Station',
          timestamp: time,
          location: const LatLng(60, 25),
          temperature: 10,
          windSpeed: 5,
        ),
        lastUpdated: time,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            pointWeatherControllerProvider.overrideWith(
              () => MockPointWeatherController(initialState: state),
            ),
          ],
          child: const MaterialApp(home: Scaffold(body: WeatherDetailSheet())),
        ),
      );
      await tester.pumpAndSettle();

      // "Updated: 14:30"
      expect(find.text('Updated: 14:30'), findsOneWidget);
    });

    testWidgets('shows OfflineBanner on sync error', (tester) async {
      final state = PointWeatherState(
        weather: WeatherData(
          stationName: 'Test Station',
          timestamp: DateTime.now(),
          location: const LatLng(60, 25),
          temperature: 10,
          windSpeed: 5,
        ),
        lastUpdated: DateTime.now(),
        syncError: 'Network Error',
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            pointWeatherControllerProvider.overrideWith(
              () => MockPointWeatherController(initialState: state),
            ),
          ],
          child: const MaterialApp(home: Scaffold(body: WeatherDetailSheet())),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(OfflineBanner), findsOneWidget);
      expect(find.text('Network Error'), findsOneWidget);
    });

    testWidgets('shows loading spinner when isSyncing is true', (tester) async {
      final state = PointWeatherState(
        weather: WeatherData(
          stationName: 'Test Station',
          timestamp: DateTime.now(),
          location: const LatLng(60, 25),
          temperature: 10,
          windSpeed: 5,
        ),
        lastUpdated: DateTime.now(),
        isSyncing: true,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            pointWeatherControllerProvider.overrideWith(
              () => MockPointWeatherController(initialState: state),
            ),
          ],
          child: const MaterialApp(home: Scaffold(body: WeatherDetailSheet())),
        ),
      );

      // Don't pumpAndSettle because progress indicator is infinite animation
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
