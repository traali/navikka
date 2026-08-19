import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sakkoja/main.dart' as app;

// This test is specifically designed to run on the Web platform.
// It verifies that the app can start up and execute logic without crashing due to:
// 1. Missing CanvasKit (if configured wrong).
// 2. CORS issues (if providers are called early).
// 3. User-Agent header blocks.
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  testWidgets('Web Verification: App starts and renders Map without crash', (
    tester,
  ) async {
    // 1. Launch App
    app.main();

    // 2. Wait for startup logic (awaiting initialization)
    // Map init often takes time to fetch tiles/verify location permissions
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // 3. Verify typical "Grey Screen" indicators are absent
    // If an error occurred, the red screen of death would be caught by flutter_test
    // but explicit checks help.

    // Check if MapScreen is visible
    expect(
      find.text('© OpenStreetMap contributors'),
      findsOneWidget,
    ); // Attribution check

    // 4. Verify no "Error" widgets
    expect(find.text('Error'), findsNothing);
    expect(find.byType(ErrorWidget), findsNothing);

    // 5. Verify Network calls didn't crash the UI (indirectly via ErrorWidget check)
    // Ideally we'd spy on the network tab, but in integration_test we verify the result.
  });
}
