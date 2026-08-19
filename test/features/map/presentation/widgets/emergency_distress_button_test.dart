import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/map/presentation/widgets/emergency_distress_button.dart';

void main() {
  group('EmergencyDistressDialog Widget Tests', () {
    testWidgets('renders MRCC phone number and formatted coordinates', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmergencyDistressDialog(
              currentLocation: LatLng(60.1699, 24.9384),
            ),
          ),
        ),
      );

      expect(find.text('MRCC TURKU DISTRESS'), findsOneWidget);
      expect(find.textContaining('0294 1000'), findsOneWidget);
      expect(find.textContaining('60° 10.194\' N'), findsOneWidget);
      expect(find.textContaining('VHF Ch 16'), findsOneWidget);
    });

    testWidgets('displays fallback text when GPS is null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmergencyDistressDialog(
              currentLocation: null,
            ),
          ),
        ),
      );

      expect(find.textContaining('NO GPS FIX'), findsOneWidget);
    });
  });
}
