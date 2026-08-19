import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/settings/presentation/providers/unit_preferences_provider.dart';
import 'package:sakkoja/core/theme/app_theme.dart';
import 'package:sakkoja/features/map/presentation/widgets/precision_marine_compass.dart';
import 'package:sakkoja/features/map/presentation/widgets/radial_knotmeter_gauge.dart';

void main() {
  group('RadialKnotmeterGauge Widget Tests', () {
    testWidgets('Renders speed and default knots unit', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const Scaffold(
              body: RadialKnotmeterGauge(
                speedKmh: 18.52, // 10 kn
                speedLimitKmh: 20,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('10.0'), findsOneWidget);
      expect(find.text('kn'), findsOneWidget);
    });

    testWidgets('Updates unit display when speed unit changes to km/h', (
      tester,
    ) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const Scaffold(
              body: RadialKnotmeterGauge(
                speedKmh: 25.0,
                speedLimitKmh: 30,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('13.5'), findsOneWidget); // 25 km/h = 13.5 kn
      expect(find.text('kn'), findsOneWidget);

      container
          .read(unitPreferencesProvider.notifier)
          .setSpeedUnit(SpeedUnit.kmh);
      await tester.pumpAndSettle();

      expect(find.text('25.0'), findsOneWidget);
      expect(find.text('km/h'), findsOneWidget);
    });
  });

  group('PrecisionMarineCompass Widget Tests', () {
    testWidgets('Renders heading and cardinal direction', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const Scaffold(
              body: PrecisionMarineCompass(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(PrecisionMarineCompass), findsOneWidget);
      expect(find.byIcon(Icons.explore), findsOneWidget);
    });
  });
}
