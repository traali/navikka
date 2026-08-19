import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/features/navigation/domain/entities/navigation_state.dart';
import 'package:sakkoja/features/navigation/presentation/controllers/navigation_controller.dart';
import 'package:sakkoja/features/navigation/presentation/widgets/navigation_guidance_hud.dart';

class TestNavigationController extends NavigationController {
  TestNavigationController(this.initial);

  final NavigationState initial;

  @override
  Future<NavigationState> build() async => initial;
}

void main() {
  Widget appWith(NavigationState state) {
    return ProviderScope(
      overrides: [
        navigationControllerProvider.overrideWith(
          () => TestNavigationController(state),
        ),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 320,
            child: NavigationGuidanceHud(),
          ),
        ),
      ),
    );
  }

  testWidgets(
    'shows live course, waypoint distance, and ETA without overflow',
    (
      tester,
    ) async {
      final state = NavigationState.initial().copyWith(
        isActive: true,
        isPositionFresh: true,
        bearingToNextWp: 92.0,
        distanceToNextWpMeters: 1852.0,
        etaDestination: DateTime(2026, 7, 27, 14, 5),
      );

      await tester.pumpWidget(appWith(state));
      await tester.pump();

      expect(find.text('092°'), findsOneWidget);
      expect(find.text('1.0 NM'), findsOneWidget);
      expect(find.text('14:05'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('shows a safety warning instead of stale guidance', (
    tester,
  ) async {
    final state = NavigationState.initial().copyWith(
      isActive: true,
      isPositionFresh: false,
      bearingToNextWp: 92.0,
      distanceToNextWpMeters: 500.0,
    );

    await tester.pumpWidget(appWith(state));
    await tester.pump();

    expect(find.text('GPS signal lost - guidance paused'), findsOneWidget);
    expect(find.text('COURSE'), findsNothing);
  });
}
