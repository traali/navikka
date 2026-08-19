// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;

/// A simple script to verify the fishing restrictions API is working correctly.
/// Run with: dart run scripts/verify_fishing_api.dart
void main() async {
  print('=== Fishing Restrictions API Verification ===\n');

  // This is the exact URL the app uses:
  const baseUrl = 'http://avoinkara.mmm.fi/geoserver/wfs';

  // Helsinki area bounding box (Lat,Lon order for WFS 2.0)
  const bbox = '60.0,24.5,60.3,25.0,urn:ogc:def:crs:EPSG::4326';

  final uri = Uri.parse(baseUrl).replace(
    queryParameters: {
      'service': 'wfs',
      'version': '2.0.0',
      'request': 'GetFeature',
      'typeName': 'avoin:kalastusrajoitus',
      'outputFormat': 'json',
      'srsName': 'urn:ogc:def:crs:EPSG::4326',
      'bbox': bbox,
      'count': '10', // Limit for testing
    },
  );

  print('Request URL:');
  print(uri);
  print('');

  try {
    final response = await http.get(uri);

    print('Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final features = data['features'] as List? ?? [];
      final featureCount = features.length;

      print('Feature count: $featureCount');

      if (featureCount > 0) {
        print('\n=== SUCCESS: API is returning data! ===\n');

        // Print first feature details
        final first = features.first as Map<String, dynamic>;
        final props = first['properties'] as Map<String, dynamic>? ?? {};
        final geom = first['geometry'] as Map<String, dynamic>? ?? {};

        print('Sample feature:');
        print('  ID: ${first['id']}');
        print('  Title: ${props['nimi'] ?? props['KIELLONNIMI'] ?? 'N/A'}');
        print(
          '  Type: ${props['rajoitustyyppi'] ?? props['KIELLONTYYPIT'] ?? 'N/A'}',
        );
        print('  Geometry: ${geom['type']}');

        // Check for MultiPolygon
        if (geom['type'] == 'MultiPolygon') {
          final coords = geom['coordinates'] as List;
          print('  MultiPolygon parts: ${coords.length}');
        }
      } else {
        print('\n=== WARNING: 0 features returned. Check bbox. ===\n');
      }
    } else {
      print('\n=== FAILED: HTTP ${response.statusCode} ===');
      print('Response body: ${response.body.substring(0, 200)}...');
    }
  } catch (e) {
    print('\n=== ERROR: $e ===');
  }
}
