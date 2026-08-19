import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sakkoja/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Smoke Test: App boots without crashing', (tester) async {
    // 1. Launch the app
    app.main();

    // 2. Wait for the first frame to settle (animations to stop)
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // 3. Simple verification (Verify Map attribution)
    expect(find.text('© OpenStreetMap contributors'), findsOneWidget);
  });
}
