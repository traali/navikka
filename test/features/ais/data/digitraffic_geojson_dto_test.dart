import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/features/ais/data/models/digitraffic_geojson_dto.dart';

void main() {
  group('DigitrafficGeoJsonDto Test Suite', () {
    test('Parses standard Digitraffic GeoJSON FeatureCollection response', () {
      final jsonRaw = '''
      {
        "type": "FeatureCollection",
        "features": [
          {
            "type": "Feature",
            "geometry": {
              "type": "Point",
              "coordinates": [24.945833, 60.165556]
            },
            "properties": {
              "mmsi": 230123456,
              "sog": 12.4,
              "cog": 185.2,
              "heading": 184.0,
              "navStat": 0,
              "timestampExternal": 1716300000000,
              "name": "FINLANDIA",
              "shipType": 60
            }
          }
        ]
      }
      ''';

      final map = jsonDecode(jsonRaw) as Map<String, dynamic>;
      final featureCollection = DigitrafficFeatureCollectionDto.fromJson(map);

      expect(featureCollection.type, equals('FeatureCollection'));
      expect(featureCollection.features.length, equals(1));

      final feature = featureCollection.features.first;
      expect(feature.geometry.longitude, equals(24.945833));
      expect(feature.geometry.latitude, equals(60.165556));

      final props = feature.properties;
      expect(props.mmsi, equals(230123456));
      expect(props.sog, equals(12.4));
      expect(props.cog, equals(185.2));
      expect(props.heading, equals(184.0));
      expect(props.navStatus, equals(0));
      expect(props.name, equals('FINLANDIA'));
      expect(props.shipType, equals(60));
    });
  });
}
