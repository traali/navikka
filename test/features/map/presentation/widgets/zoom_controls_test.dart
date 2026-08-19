import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/features/map/presentation/widgets/zoom_controls.dart';

void main() {
  testWidgets('ZoomControls renders and triggers callbacks', (tester) async {
    var zoomedIn = false;
    var zoomedOut = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark().copyWith(
          extensions: [
            AppThemeColors.fallbackColors,
          ],
        ),
        home: Scaffold(
          body: ZoomControls(
            onZoomIn: () => zoomedIn = true,
            onZoomOut: () => zoomedOut = true,
          ),
        ),
      ),
    );

    // active glassmorphism check (just existence of widgets)
    expect(find.byType(ZoomControls), findsOneWidget);
    expect(find.byIcon(Icons.add_rounded), findsOneWidget);
    expect(find.byIcon(Icons.remove_rounded), findsOneWidget);

    // Tap zoom in
    await tester.tap(find.byIcon(Icons.add_rounded));
    expect(zoomedIn, isTrue);

    // Tap zoom out
    await tester.tap(find.byIcon(Icons.remove_rounded));
    expect(zoomedOut, isTrue);
  });
}
