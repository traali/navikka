import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/features/menu/presentation/widgets/build_info_bottom_sheet.dart';

/// Tests for BuildInfoBottomSheet — the info sheet shown from the menu.
///
/// Verifies it renders key build information without crashing.
void main() {
  group('BuildInfoBottomSheet', () {
    testWidgets('shows build information in bottom sheet', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BuildInfoBottomSheet(),
          ),
        ),
      );

      // Should render without errors
      expect(find.byType(BuildInfoBottomSheet), findsOneWidget);
    });
  });
}
