import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/models/bbox.dart';

void main() {
  group('BBox Math', () {
    test('contains point logic', () {
      const bbox = BBox(minLon: 10, minLat: 10, maxLon: 20, maxLat: 20);

      // Center
      expect(bbox.contains(lat: 15, lon: 15), isTrue);
      // Edges
      expect(bbox.contains(lat: 10, lon: 10), isTrue);
      expect(bbox.contains(lat: 20, lon: 20), isTrue);
      // Outside
      expect(bbox.contains(lat: 9, lon: 15), isFalse);
      expect(bbox.contains(lat: 21, lon: 15), isFalse);
    });

    test('overlaps logic - disjoint', () {
      const box1 = BBox(minLon: 0, minLat: 0, maxLon: 10, maxLat: 10);
      const box2 = BBox(minLon: 20, minLat: 0, maxLon: 30, maxLat: 10);
      expect(box1.overlaps(box2), isFalse);
    });

    test('overlaps logic - intersecting', () {
      const box1 = BBox(minLon: 0, minLat: 0, maxLon: 10, maxLat: 10);
      const box2 = BBox(minLon: 5, minLat: 5, maxLon: 15, maxLat: 15);
      expect(box1.overlaps(box2), isTrue);
    });

    test('overlaps logic - one inside another', () {
      const outer = BBox(minLon: 0, minLat: 0, maxLon: 10, maxLat: 10);
      const inner = BBox(minLon: 2, minLat: 2, maxLon: 8, maxLat: 8);
      expect(outer.overlaps(inner), isTrue);
      expect(inner.overlaps(outer), isTrue);
    });

    test('overlaps logic - touching edges', () {
      const left = BBox(minLon: 0, minLat: 0, maxLon: 10, maxLat: 10);
      const right = BBox(minLon: 10, minLat: 0, maxLon: 20, maxLat: 10);
      // Depending on implementation, touching might be considered overlap (<= vs <)
      // Current implementation uses strict inequality < for disjoint check?
      // Logic: return !(maxLon < other.minLon || ...)
      // 10 < 10 is false. So it DOES overlap.
      expect(left.overlaps(right), isTrue);
    });

    test('fromCenter calculation', () {
      const center = LatLng(60, 24);
      final bbox = BBox.fromCenter(center, 111); // 1 degree lat radius = 111km

      // minLat should be 60 - 1 = 59
      // maxLat should be 60 + 1 = 61
      expect(bbox.minLat, closeTo(59.0, 0.1));
      expect(bbox.maxLat, closeTo(61.0, 0.1));
    });
  });
}
