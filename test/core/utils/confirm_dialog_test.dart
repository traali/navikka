import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/utils/confirm_dialog.dart';

void main() {
  testWidgets('confirmDestructive returns true on confirm tap', (tester) async {
    bool? confirmed;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () async {
              confirmed = await confirmDestructive(
                context: context,
                title: 'Delete Route',
                message: 'Are you sure you want to delete this route?',
              );
            },
            child: const Text('Delete'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(find.text('Delete Route'), findsOneWidget);
    expect(
      find.text('Are you sure you want to delete this route?'),
      findsOneWidget,
    );

    // Tap confirm FilledButton
    await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
    await tester.pumpAndSettle();

    expect(confirmed, isTrue);
  });

  testWidgets('confirmDestructive returns false on cancel tap', (tester) async {
    bool? confirmed;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () async {
              confirmed = await confirmDestructive(
                context: context,
                title: 'Delete Track',
                message: 'Are you sure you want to delete this track?',
              );
            },
            child: const Text('Delete'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
    await tester.pumpAndSettle();

    expect(confirmed, isFalse);
  });

  testWidgets('showUndoSnackBar displays SnackBar with Undo action', (
    tester,
  ) async {
    var undoPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                showUndoSnackBar(
                  context: context,
                  message: 'Track deleted',
                  onUndo: () => undoPressed = true,
                );
              },
              child: const Text('Trigger Undo'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Trigger Undo'));
    await tester.pumpAndSettle();

    expect(find.text('Track deleted'), findsOneWidget);
    expect(find.text('Undo'), findsOneWidget);

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();

    expect(undoPressed, isTrue);
  });
}
