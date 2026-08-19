import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/models/bbox.dart';
import 'package:sakkoja/features/fishing/domain/entities/fishing_restriction.dart';

/// Tests for viewport culling functionality.
///
/// Verifies that fishing restrictions are correctly filtered based on
/// whether their bounding box overlaps with the visible map viewport.
void main() {
  group('Viewport Culling', () {
    // Create test restrictions with known bounding boxes
    final restrictionInView = FishingRestriction.withCalculatedBBox(
      id: 'in_view',
      title: 'Kalastuskielto A',
      type: 'Verkkokalastus',
      rings: [
        [
          const LatLng(60, 24),
          const LatLng(60, 24.1),
          const LatLng(60.1, 24.1),
          const LatLng(60.1, 24),
        ],
      ],
    );

    final restrictionOutOfView = FishingRestriction.withCalculatedBBox(
      id: 'out_of_view',
      title: 'Kalastuskielto B',
      type: 'Verkkokalastus',
      rings: [
        [
          const LatLng(65, 30),
          const LatLng(65, 30.1),
          const LatLng(65.1, 30.1),
          const LatLng(65.1, 30),
        ],
      ],
    );

    const restrictionNoBBox = FishingRestriction(
      id: 'no_bbox',
      title: 'Kalastuskielto C',
      type: 'Verkkokalastus',
      rings: [
        [
          LatLng(60.05, 24.05),
          LatLng(60.05, 24.06),
          LatLng(60.06, 24.06),
          LatLng(60.06, 24.05),
        ],
      ],
      isCurrentlyActive: true,
      category: 'Verkkokalastus',
    );

    test('FishingRestriction calculates bounding box correctly', () {
      expect(restrictionInView.boundingBox, isNotNull);
      expect(restrictionInView.boundingBox!.minLat, equals(60.0));
      expect(restrictionInView.boundingBox!.maxLat, equals(60.1));
      expect(restrictionInView.boundingBox!.minLon, equals(24.0));
      expect(restrictionInView.boundingBox!.maxLon, equals(24.1));
    });

    test('BBox.overlaps correctly detects overlap', () {
      const viewport = BBox(
        minLat: 59.9,
        maxLat: 60.2,
        minLon: 23.9,
        maxLon: 24.2,
      );

      expect(
        restrictionInView.boundingBox!.overlaps(viewport),
        isTrue,
        reason: 'Restriction in view should overlap viewport',
      );

      expect(
        restrictionOutOfView.boundingBox!.overlaps(viewport),
        isFalse,
        reason: 'Restriction out of view should not overlap viewport',
      );
    });

    test('Viewport culling filters restrictions correctly', () {
      final allRestrictions = [
        restrictionInView,
        restrictionOutOfView,
        restrictionNoBBox,
      ];

      const viewport = BBox(
        minLat: 59.9,
        maxLat: 60.2,
        minLon: 23.9,
        maxLon: 24.2,
      );

      // Simulate viewport culling logic
      final visibleRestrictions = allRestrictions.where((r) {
        if (r.boundingBox == null) return true; // No bbox = always show
        return r.boundingBox!.overlaps(viewport);
      }).toList();

      expect(visibleRestrictions.length, equals(2));
      expect(visibleRestrictions.map((r) => r.id), contains('in_view'));
      expect(visibleRestrictions.map((r) => r.id), contains('no_bbox'));
      expect(
        visibleRestrictions.map((r) => r.id),
        isNot(contains('out_of_view')),
      );
    });

    test('Viewport culling performance with 500 restrictions', () {
      // Create 500 restrictions - some in view, most out
      final restrictions = <FishingRestriction>[];

      // 50 restrictions in viewport area
      for (var i = 0; i < 50; i++) {
        restrictions.add(
          FishingRestriction.withCalculatedBBox(
            id: 'in_$i',
            title: 'In View $i',
            type: 'Verkkokalastus',
            rings: [
              [
                LatLng(60.0 + i * 0.001, 24.0 + i * 0.001),
                LatLng(60.0 + i * 0.001, 24.01 + i * 0.001),
                LatLng(60.01 + i * 0.001, 24.01 + i * 0.001),
                LatLng(60.01 + i * 0.001, 24.0 + i * 0.001),
              ],
            ],
          ),
        );
      }

      // 450 restrictions far away
      for (var i = 0; i < 450; i++) {
        restrictions.add(
          FishingRestriction.withCalculatedBBox(
            id: 'out_$i',
            title: 'Out of View $i',
            type: 'Verkkokalastus',
            rings: [
              [
                LatLng(70.0 + i * 0.1, 30.0 + i * 0.1),
                LatLng(70.0 + i * 0.1, 30.1 + i * 0.1),
                LatLng(70.1 + i * 0.1, 30.1 + i * 0.1),
                LatLng(70.1 + i * 0.1, 30.0 + i * 0.1),
              ],
            ],
          ),
        );
      }

      const viewport = BBox(
        minLat: 59.9,
        maxLat: 60.2,
        minLon: 23.9,
        maxLon: 24.2,
      );

      // Time the culling
      final stopwatch = Stopwatch()..start();
      final visibleRestrictions = restrictions.where((r) {
        if (r.boundingBox == null) return true;
        return r.boundingBox!.overlaps(viewport);
      }).toList();
      stopwatch.stop();

      // Assert performance
      expect(
        stopwatch.elapsedMilliseconds,
        lessThan(10),
        reason:
            'Viewport culling 500 restrictions took ${stopwatch.elapsedMilliseconds}ms, expected < 10ms',
      );

      // Assert correctness
      expect(visibleRestrictions.length, equals(50));
    });
  });
}
