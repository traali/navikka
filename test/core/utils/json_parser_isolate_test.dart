import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/utils/json_parser_isolate.dart';

void main() {
  group('JsonParserIsolate', () {
    test('parseSpeedLimitZones parses valid GeoJSON features', () async {
      final features = [
        {
          'type': 'Feature',
          'id': 'test_1',
          'geometry': {
            'type': 'Polygon',
            'coordinates': [
              [
                [24.9, 60.1],
                [24.91, 60.1],
                [24.91, 60.11],
                [24.9, 60.11],
                [24.9, 60.1],
              ],
            ],
          },
          'properties': {'suuruus': '10', 'rajoitustyyppi': 'Nopeusrajoitus'},
        },
      ];

      final zones = await JsonParserIsolate().parseSpeedLimitZones(features);

      expect(zones.length, 1);
      expect(zones.first.id, 'test_1');
      expect(zones.first.speedLimitKmh, 10);
      expect(zones.first.typeDescription, 'Nopeusrajoitus');
      expect(zones.first.rings.length, 1);
      expect(zones.first.rings.first.length, 5);
    });

    test('parseSpeedLimitZones handles empty list', () async {
      final zones = await JsonParserIsolate().parseSpeedLimitZones([]);
      expect(zones, isEmpty);
    });

    test('parseSpeedLimitZones handles invalid feature gracefully', () async {
      final features = [
        {
          'type': 'Feature',
          // Missing geometry and properties
        },
      ];

      final zones = await JsonParserIsolate().parseSpeedLimitZones(features);
      expect(zones, isEmpty);
    });

    test('parseSpeedLimitZones handles MultiPolygon', () async {
      final features = [
        {
          'type': 'Feature',
          'id': 'multi_1',
          'geometry': {
            'type': 'MultiPolygon',
            'coordinates': [
              [
                [
                  [24.9, 60.1],
                  [24.91, 60.1],
                  [24.91, 60.11],
                  [24.9, 60.11],
                  [24.9, 60.1],
                ],
              ],
              [
                [
                  [25.9, 61.1],
                  [25.91, 61.1],
                  [25.91, 61.11],
                  [25.9, 61.11],
                  [25.9, 61.1],
                ],
              ],
            ],
          },
          'properties': {'suuruus': '5', 'rajoitustyyppi': 'Kielto'},
        },
      ];

      final zones = await JsonParserIsolate().parseSpeedLimitZones(features);

      expect(zones.length, 2);
      expect(zones[0].speedLimitKmh, 5);
      expect(zones[1].speedLimitKmh, 5);
      expect(zones[0].id, 'multi_1_0'); // Assuming ID format from DTO
      expect(zones[1].id, 'multi_1_1');
    });
  });
}
