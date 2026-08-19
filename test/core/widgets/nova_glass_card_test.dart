import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/widgets/nova_glass_card.dart';

/// Widget tests for NovaGlassCard.
///
/// Verifies rendering, padding, child display, and customization.
void main() {
  group('NovaGlassCard', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NovaGlassCard(
              child: Text('Test Content'),
            ),
          ),
        ),
      );

      expect(find.text('Test Content'), findsOneWidget);
    });

    testWidgets('applies default padding', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NovaGlassCard(
              child: SizedBox(width: 100, height: 100),
            ),
          ),
        ),
      );

      final cardContainerFinder = find.descendant(
        of: find.byType(NovaGlassCard),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Container &&
              widget.padding == const EdgeInsets.all(20) &&
              widget.decoration is BoxDecoration &&
              (widget.decoration! as BoxDecoration).border != null,
        ),
      );
      final container = tester.widget<Container>(
        cardContainerFinder,
      );
      expect(container.padding, const EdgeInsets.all(20));
    });

    testWidgets('applies custom padding', (tester) async {
      const customPadding = EdgeInsets.all(32);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NovaGlassCard(
              padding: customPadding,
              child: SizedBox(width: 100, height: 100),
            ),
          ),
        ),
      );

      final cardContainerFinder = find.descendant(
        of: find.byType(NovaGlassCard),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Container &&
              widget.padding == customPadding &&
              widget.decoration is BoxDecoration &&
              (widget.decoration! as BoxDecoration).border != null,
        ),
      );
      final container = tester.widget<Container>(
        cardContainerFinder,
      );
      expect(container.padding, customPadding);
    });

    testWidgets('applies custom borderRadius', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NovaGlassCard(
              borderRadius: 8,
              child: SizedBox(width: 100, height: 100),
            ),
          ),
        ),
      );

      // ClipRRect should have correct borderRadius
      final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
      expect(
        (clipRRect.borderRadius as BorderRadius).topLeft.x,
        8.0,
      );
    });

    testWidgets('renders with all custom parameters', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NovaGlassCard(
              padding: EdgeInsets.all(8),
              borderRadius: 4,
              intensity: 0.15,
              child: Column(
                children: [
                  Text('Title'),
                  Text('Subtitle'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
    });

    testWidgets('BackdropFilter is present (glass effect)', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NovaGlassCard(
              child: Text('Blur me'),
            ),
          ),
        ),
      );

      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('has border decoration', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NovaGlassCard(
              child: Text('Bordered'),
            ),
          ),
        ),
      );

      final cardContainerFinder = find.descendant(
        of: find.byType(NovaGlassCard),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Container &&
              widget.padding != null &&
              widget.decoration is BoxDecoration &&
              (widget.decoration! as BoxDecoration).border != null,
        ),
      );
      final container = tester.widget<Container>(
        cardContainerFinder,
      );
      final decoration = container.decoration! as BoxDecoration;
      expect(decoration.border, isNotNull);
    });

    testWidgets('total widget hierarchy renders without errors', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NovaGlassCard(
              child: Icon(Icons.anchor, size: 48),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.anchor), findsOneWidget);
      // Should have ClipRRect → BackdropFilter → Container → Stack
      expect(
        find.descendant(
          of: find.byType(NovaGlassCard),
          matching: find.byType(Stack),
        ),
        findsOneWidget,
      );
    });
  });
}
