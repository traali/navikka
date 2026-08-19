import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/theme/app_theme.dart';
import 'package:sakkoja/features/weather/domain/entities/algae_data.dart';
import 'package:sakkoja/features/weather/domain/entities/water_quality_data.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';
import 'package:sakkoja/features/weather/presentation/widgets/algae_marker_layer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockPointWeatherController extends PointWeatherController {
  MockPointWeatherController(this.customState);
  final PointWeatherState customState;

  @override
  PointWeatherState build() => customState;
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('AlgaeMarkerLayer', () {
    testWidgets('renders nothing when not visible', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: AlgaeMarkerLayer(visible: false),
          ),
        ),
      );
      expect(find.byType(FlutterMap), findsNothing);
    });

    testWidgets(
      'renders MarkerLayer with SYKE water quality and algae pins when visible',
      (tester) async {
        final sampleState = PointWeatherState(
          lastUpdated: DateTime.now(),
          waterQuality: WaterQualityData(
            sampleDate: DateTime.now(),
            location: const LatLng(60.16, 24.94),
            stationName: 'Helsinki Harmaja',
            temperature: 18.5,
            chlorophyllA: 12.4,
            turbidity: 2.1,
            algaeStatus: 'Moderate',
            dissolvedOxygen: 9.2,
            ph: 7.8,
          ),
          algae: AlgaeData(
            observationTime: DateTime.now(),
            location: const LatLng(60.17, 24.95),
            riskLevel: AlgaeRiskLevel.moderate,
          ),
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              pointWeatherControllerProvider.overrideWith(
                () => MockPointWeatherController(sampleState),
              ),
            ],
            child: MaterialApp(
              theme: AppTheme.dark(),
              home: Scaffold(
                body: FlutterMap(
                  options: const MapOptions(
                    initialCenter: LatLng(60.16, 24.94),
                    initialZoom: 12,
                  ),
                  children: const [
                    AlgaeMarkerLayer(visible: true),
                  ],
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(MarkerLayer), findsOneWidget);
        expect(find.byType(GestureDetector), findsWidgets);
      },
    );
  });
}
