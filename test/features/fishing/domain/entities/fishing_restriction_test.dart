import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/fishing/domain/entities/fishing_restriction.dart';

void main() {
  group('FishingRestriction Logic', () {
    const mockRings = [
      [LatLng(60, 24), LatLng(60.1, 24), LatLng(60, 24.1)],
    ];

    test('Category: "Verkkokalastus" detected from keyword "verkko"', () {
      final restriction = FishingRestriction.withCalculatedBBox(
        id: '1',
        title: 'Some Lake',
        description: 'Täällä verkko on kielletty.',
        rings: mockRings,
        // isCurrentlyActive is calculated internally
        // category is calculated internally
        // Wait, the factory ignores the passed category and recalculates it.
        // Actually the factory usage in `FishingLocalDataSource` passes results.
        // But `withCalculatedBBox` calls `_computeCategory`.
        // Let's verify the factory in the file.
      );

      // Checking the file content again:
      // factory FishingRestriction.withCalculatedBBox calls `category: _computeCategory(...)`

      expect(restriction.category, 'Verkkokalastus');
    });

    test(
      'Category: "Verkkorajoitukset" detected for specific node interval',
      () {
        final restriction = FishingRestriction.withCalculatedBBox(
          id: '1',
          title: 'Verkkojen solmuväli rajoitus',
          description: 'Alle 50mm kielletty',
          rings: mockRings,
        );
        expect(restriction.category, 'Verkkorajoitukset');
      },
    );

    test('Category: "Kalastuskielto" detected from "kalastus kielletty"', () {
      final restriction = FishingRestriction.withCalculatedBBox(
        id: '1',
        title: 'Total Ban',
        description: 'Alueella kalastus kielletty kokonaan',
        rings: mockRings,
      );
      expect(restriction.category, 'Kalastuskielto');
    });

    test('Category: "Muu" when no keywords match', () {
      final restriction = FishingRestriction.withCalculatedBBox(
        id: '1',
        title: 'Safe Zone',
        description: 'No specific restrictions',
        rings: mockRings,
      );
      expect(restriction.category, 'Muu');
    });

    test('Validity: Active when date range covers today', () {
      // We can't easily mock DateTime.now() inside the static method without a clock injected.
      // But we can test parsing logic if exposed, or infer from result.
      // The class uses DateTime.now() internally.
      // We assume the test won't run at midnight on New Years if we use wide ranges.

      // "1.1-31.12" should always be active.
      final restriction = FishingRestriction.withCalculatedBBox(
        id: '1',
        title: 'Always',
        validity: '1.1-31.12',
        rings: mockRings,
      );
      expect(restriction.isCurrentlyActive, true);
    });

    test('Validity: Active when no validity string', () {
      final restriction = FishingRestriction.withCalculatedBBox(
        id: '1',
        title: 'Always',
        rings: mockRings,
      );
      expect(restriction.isCurrentlyActive, true);
    });

    // To test inactive, we need a date range that definitely doesn't include today.
    // e.g. "validity: 29.2-29.2" - only active on leap day?
    // Or if today is Jan 19, use "1.2-2.2".
    test('Validity: Inactive for past date range (assuming not Feb 1-2)', () {
      final restriction = FishingRestriction.withCalculatedBBox(
        id: '1',
        title: 'Feb Only',
        validity: '1.2-2.2',
        rings: mockRings,
      );
      // This assertion might flake if run on Feb 1 or 2.
      // But for now it validates logic.
      final now = DateTime.now();
      if (now.month == 2 && (now.day == 1 || now.day == 2)) {
        expect(restriction.isCurrentlyActive, true);
      } else {
        expect(restriction.isCurrentlyActive, false);
      }
    });

    group('path intersections', () {
      final restrictionWithHole = FishingRestriction.withCalculatedBBox(
        id: 'with-hole',
        title: 'Restriction with hole',
        rings: const [
          [
            LatLng(0, 0),
            LatLng(0, 1),
            LatLng(1, 1),
            LatLng(1, 0),
          ],
          [
            LatLng(0.4, 0.4),
            LatLng(0.4, 0.6),
            LatLng(0.6, 0.6),
            LatLng(0.6, 0.4),
          ],
        ],
      );

      test(
        'detects a segment crossing a restriction even when its midpoint is outside',
        () {
          expect(
            restrictionWithHole.intersectsPath(const [
              LatLng(0.5, -1),
              LatLng(0.5, 2),
            ]),
            isTrue,
          );
        },
      );

      test('does not flag a route contained entirely in a polygon hole', () {
        expect(
          restrictionWithHole.intersectsPath(const [
            LatLng(0.5, 0.45),
            LatLng(0.5, 0.55),
          ]),
          isFalse,
        );
      });

      test('flags the restricted portions of a route that crosses a hole', () {
        expect(
          restrictionWithHole.intersectsPath(const [
            LatLng(0.5, 0.2),
            LatLng(0.5, 0.8),
          ]),
          isTrue,
        );
      });
    });
  });
}
