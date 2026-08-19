import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/map/presentation/widgets/traffic_sign_marker.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/traffic_sign.dart';

// Helper to create test widgets
Widget makeTestableWidget(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  testWidgets('TrafficSignMarker renders speed limit correctly', (
    tester,
  ) async {
    const sign = TrafficSign(
      id: '1',
      typeName: 'nopeusrajoitus',
      position: LatLng(60, 25),
      value: 50,
    );

    await tester.pumpWidget(
      makeTestableWidget(const TrafficSignMarker(sign: sign)),
    );
    await tester.pumpAndSettle();

    // Should find SVG picture of the frame
    expect(find.byType(SvgPicture), findsOneWidget);
    // Should find text '50'
    expect(find.text('50'), findsOneWidget);
  });

  testWidgets('TrafficSignMarker renders height restriction correctly', (
    tester,
  ) async {
    const sign = TrafficSign(
      id: '2',
      typeName: 'alikulkukorkeus',
      position: LatLng(60, 25),
      value: 4.5,
    );

    await tester.pumpWidget(
      makeTestableWidget(const TrafficSignMarker(sign: sign)),
    );
    await tester.pumpAndSettle();

    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.text('4.5'), findsOneWidget);
  });

  testWidgets(
    'TrafficSignMarker renders no-wake sign correctly (static icon)',
    (tester) async {
      const sign = TrafficSign(
        id: '3',
        typeName: 'aallokon aiheuttamisen kielto',
        position: LatLng(60, 25),
      );

      await tester.pumpWidget(
        makeTestableWidget(const TrafficSignMarker(sign: sign)),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SvgPicture), findsOneWidget);
      // No value text
      expect(find.byType(Text), findsNothing);
    },
  );
}
