import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/theme/app_theme.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';
import 'package:sakkoja/features/ai/presentation/providers/ai_providers.dart';
import 'package:sakkoja/features/ai/presentation/widgets/skipper_insight_banner.dart';

void main() {
  group('SkipperInsightBanner', () {
    Widget buildBanner(WeatherInsight insight) {
      return ProviderScope(
        overrides: [
          skipperInsightProvider.overrideWith((ref) async => insight),
        ],
        child: MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(body: SkipperInsightBanner()),
        ),
      );
    }

    testWidgets('renders advice text for yellow status', (tester) async {
      final insight = WeatherInsight(
        status: SafetyStatus.yellow,
        advice: 'CAUTION: Moderate waves. Keep an eye on conditions.',
        timestamp: DateTime.now(),
        insightId: 'test_yellow_1',
      );

      await tester.pumpWidget(buildBanner(insight));
      await tester.pumpAndSettle();

      expect(
        find.text('CAUTION: Moderate waves. Keep an eye on conditions.'),
        findsOneWidget,
      );
      expect(find.text('VIRTUAL SKIPPER'), findsOneWidget);
    });

    testWidgets('shows acknowledge button for non-green status', (
      tester,
    ) async {
      final insight = WeatherInsight(
        status: SafetyStatus.orange,
        advice: 'WARNING: High waves.',
        timestamp: DateTime.now(),
        insightId: 'test_orange_1',
      );

      await tester.pumpWidget(buildBanner(insight));
      await tester.pump();

      expect(
        find.byKey(const ValueKey('skipperInsightAckButton')),
        findsOneWidget,
      );
    });

    testWidgets('does not show acknowledge button for green status', (
      tester,
    ) async {
      final insight = WeatherInsight(
        status: SafetyStatus.green,
        advice: 'Conditions are within safe limits.',
        timestamp: DateTime.now(),
        insightId: 'test_green_1',
      );

      await tester.pumpWidget(buildBanner(insight));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey('skipperInsightAckButton')),
        findsNothing,
      );
    });

    testWidgets('acknowledge button hidden after tapping', (tester) async {
      final insight = WeatherInsight(
        status: SafetyStatus.red,
        advice: 'DANGER: Storm force gusts.',
        timestamp: DateTime.now(),
        insightId: 'test_red_1',
      );

      await tester.pumpWidget(buildBanner(insight));
      await tester.pump();

      expect(
        find.byKey(const ValueKey('skipperInsightAckButton')),
        findsOneWidget,
      );

      await tester.tap(find.byKey(const ValueKey('skipperInsightAckButton')));
      await tester.pump();

      expect(
        find.byKey(const ValueKey('skipperInsightAckButton')),
        findsNothing,
      );
    });

    testWidgets('yellow status does not block pumpAndSettle', (tester) async {
      final insight = WeatherInsight(
        status: SafetyStatus.yellow,
        advice: 'CAUTION: Variable conditions.',
        timestamp: DateTime.now(),
        insightId: 'test_yellow_pulse',
      );

      await tester.pumpWidget(buildBanner(insight));
      // pumpAndSettle should complete because yellow has no repeating animation
      await tester.pumpAndSettle();

      expect(find.text('CAUTION: Variable conditions.'), findsOneWidget);
    });

    testWidgets('orange status renders without error', (tester) async {
      final insight = WeatherInsight(
        status: SafetyStatus.orange,
        advice: 'WARNING: Strong wind gusts.',
        timestamp: DateTime.now(),
        insightId: 'test_orange_pulse',
      );

      await tester.pumpWidget(buildBanner(insight));
      await tester.pump();

      expect(find.text('WARNING: Strong wind gusts.'), findsOneWidget);
      expect(
        find.byKey(const ValueKey('skipperInsightAckButton')),
        findsOneWidget,
      );
    });

    testWidgets('orange status ack button hides after tap', (tester) async {
      final insight = WeatherInsight(
        status: SafetyStatus.orange,
        advice: 'WARNING: Strong wind gusts.',
        timestamp: DateTime.now(),
        insightId: 'test_orange_ack',
      );

      await tester.pumpWidget(buildBanner(insight));
      await tester.pump();

      expect(
        find.byKey(const ValueKey('skipperInsightAckButton')),
        findsOneWidget,
      );

      await tester.tap(find.byKey(const ValueKey('skipperInsightAckButton')));
      await tester.pump();

      expect(
        find.byKey(const ValueKey('skipperInsightAckButton')),
        findsNothing,
      );
    });
  });
}
