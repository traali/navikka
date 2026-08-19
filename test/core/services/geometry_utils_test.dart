import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/services/geometry_utils.dart';

/// Unit tests for GeometryUtils.isPointInPolygon
///
/// These tests verify the ray-casting algorithm used to determine
/// if a boat's position is within a speed limit zone.
///
/// SAFETY CRITICAL: This logic determines whether speed limit warnings
/// are displayed to the user. False negatives could lead to speeding tickets.
void main() {
  group('GeometryUtils.isPointInPolygon', () {
    // Square polygon around Lauttasaari waters (speed limit zone area)
    // Lauttasaari center: 60.1575, 24.8775
    final squarePolygon = [
      const LatLng(60.15, 24.85), // SW corner
      const LatLng(60.15, 24.90), // SE corner
      const LatLng(60.17, 24.90), // NE corner
      const LatLng(60.17, 24.85), // NW corner
    ];

    test('U-GEO-001: returns true when point is clearly inside polygon', () {
      // Point in the center of the Lauttasaari square
      const insidePoint = LatLng(
        60.16,
        24.875,
      ); // Center of Lauttasaari polygon

      final result = GeometryUtils.isPointInPolygon(insidePoint, squarePolygon);

      expect(result, isTrue, reason: 'Point at center should be inside');
    });

    test('U-GEO-002: returns false when point is clearly outside polygon', () {
      // Point far north of the polygon
      const outsidePoint = LatLng(61, 25);

      final result = GeometryUtils.isPointInPolygon(
        outsidePoint,
        squarePolygon,
      );

      expect(result, isFalse, reason: 'Point 80km north should be outside');
    });

    test('U-GEO-006: returns false for empty polygon (graceful guard)', () {
      const anyPoint = LatLng(60.16, 24.875); // Lauttasaari center

      final result = GeometryUtils.isPointInPolygon(anyPoint, []);

      expect(result, isFalse, reason: 'Empty polygon should return false');
    });

    test('U-GEO-003: handles point on polygon edge (documents behavior)', () {
      // Point exactly on the southern edge of Lauttasaari polygon
      const edgePoint = LatLng(60.15, 24.875); // On south edge

      // Ray-casting algorithm behavior on edges is implementation-defined
      // This test documents the current behavior rather than asserting correctness
      final result = GeometryUtils.isPointInPolygon(edgePoint, squarePolygon);

      // We just verify it returns a boolean without throwing
      expect(
        result,
        isA<bool>(),
        reason: 'Should handle edge case without exception',
      );
    });

    test('U-GEO-004: handles point on polygon vertex (documents behavior)', () {
      // Point exactly on the SW corner of Lauttasaari polygon
      const vertexPoint = LatLng(60.15, 24.85); // SW vertex

      final result = GeometryUtils.isPointInPolygon(vertexPoint, squarePolygon);

      expect(
        result,
        isA<bool>(),
        reason: 'Should handle vertex case without exception',
      );
    });

    test('U-GEO-005: correctly handles concave (L-shaped) polygon', () {
      // L-shaped polygon near Lauttasaari (like a harbor with a dock)
      //   ┌───┐
      //   │   │
      //   │ X │ ← X is in the "notch", should be OUTSIDE
      // ┌─┘   │
      // │     │
      // └─────┘
      final lPolygon = [
        const LatLng(60.15, 24.85), // Bottom-left
        const LatLng(60.15, 24.90), // Bottom-right
        const LatLng(60.16, 24.90), // Right step-in
        const LatLng(60.16, 24.87), // Inner corner
        const LatLng(60.17, 24.87), // Top of notch
        const LatLng(60.17, 24.85), // Top-left
      ];

      // Point in the "notch" of L (should be OUTSIDE the polygon)
      const notchPoint = LatLng(60.165, 24.88);
      expect(
        GeometryUtils.isPointInPolygon(notchPoint, lPolygon),
        isFalse,
        reason: 'Point in concave notch should be outside',
      );

      // Point inside the actual L shape (should be INSIDE)
      const insideL = LatLng(60.155, 24.86);
      expect(
        GeometryUtils.isPointInPolygon(insideL, lPolygon),
        isTrue,
        reason: 'Point in L body should be inside',
      );
    });

    test('U-GEO-007: handles single-point polygon gracefully', () {
      final singlePoint = [
        const LatLng(60.1575, 24.8775),
      ]; // Lauttasaari center
      const testPoint = LatLng(60.1575, 24.8775);

      // Should not throw, even if result is undefined
      expect(
        () => GeometryUtils.isPointInPolygon(testPoint, singlePoint),
        returnsNormally,
      );
    });

    test('U-GEO-008: handles very small polygon (precision test)', () {
      // Very small polygon ~10 meters across
      final tinyPolygon = [
        const LatLng(60.150000, 24.900000),
        const LatLng(60.150000, 24.900100),
        const LatLng(60.150100, 24.900100),
        const LatLng(60.150100, 24.900000),
      ];

      const centerPoint = LatLng(60.150050, 24.900050);

      expect(GeometryUtils.isPointInPolygon(centerPoint, tinyPolygon), isTrue);
    });
  });

  // Legacy tests preserved for backward compatibility
  group('GeometryUtils Legacy Tests', () {
    test('Point inside simple square (origin-based)', () {
      final polygon = [
        const LatLng(0, 0),
        const LatLng(0, 10),
        const LatLng(10, 10),
        const LatLng(10, 0),
      ];
      const point = LatLng(5, 5);
      expect(GeometryUtils.isPointInPolygon(point, polygon), isTrue);
    });

    test('Point outside simple square (origin-based)', () {
      final polygon = [
        const LatLng(0, 0),
        const LatLng(0, 10),
        const LatLng(10, 10),
        const LatLng(10, 0),
      ];
      const point = LatLng(15, 5);
      expect(GeometryUtils.isPointInPolygon(point, polygon), isFalse);
    });

    test('Helsinki Coordinate Test (Real World Scale)', () {
      // Approximate square around Senate Square
      final polygon = [
        const LatLng(60.169, 24.952),
        const LatLng(60.169, 24.954),
        const LatLng(60.168, 24.954),
        const LatLng(60.168, 24.952),
      ];
      const inside = LatLng(60.1685, 24.953);
      const outside = LatLng(60.170, 24.953);

      expect(GeometryUtils.isPointInPolygon(inside, polygon), isTrue);
      expect(GeometryUtils.isPointInPolygon(outside, polygon), isFalse);
    });
  });
}
