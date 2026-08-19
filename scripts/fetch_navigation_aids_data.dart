// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

// Unified script to fetch and GZip all 5 navigation layers from Väylävirasto.
void main() async {
  final dio = Dio();
  const baseUrl = 'https://avoinapi.vaylapilvi.fi/vaylatiedot/wfs';
  const outDir = 'assets/data/navigation_aids';

  if (!Directory(outDir).existsSync()) {
    Directory(outDir).createSync(recursive: true);
  }

  final layers = {
    'fairway_areas': 'vesivaylatiedot:vaylaalueet_uusi',
    'navigation_lines': 'vesivaylatiedot:navigointilinjat_uusi',
    'traffic_signs': 'vesivaylatiedot:vesiliikennemerkit_uusi',
    'safety_equipment': 'vesivaylatiedot:turvalaitteet_uusi',
    'lighthouses': 'vesivaylatiedot:loistot_uusi',
  };

  // Finland BBox for filtering (Southern Finland focus for initial bundle)
  // [minLat, minLon, maxLat, maxLon]
  const bbox = '59.5,22.0,60.5,27.0,urn:ogc:def:crs:EPSG::4326';

  for (final entry in layers.entries) {
    final fileName = entry.key;
    final typeName = entry.value;

    print('\n🚀 Fetching $fileName ($typeName)...');

    try {
      final response = await dio.get<dynamic>(
        baseUrl,
        queryParameters: {
          'service': 'wfs',
          'version': '2.0.0',
          'request': 'GetFeature',
          'typeName': typeName,
          'outputFormat': 'json',
          'srsName': 'urn:ogc:def:crs:EPSG::4326',
          'bbox': bbox,
          'count':
              25000, // Increased limit to avoid truncation in dense areas (e.g. Helsinki)
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final features = data['features'] as List;
        print('✅ Fetched ${features.length} features.');

        final jsonStr = jsonEncode(data);
        final gzipBytes = GZipCodec().encode(utf8.encode(jsonStr));

        final outFile = File('$outDir/$fileName.json.gz');
        await outFile.writeAsBytes(gzipBytes);

        final sizeKb = outFile.lengthSync() / 1024;
        print('📦 Saved to ${outFile.path} (${sizeKb.toStringAsFixed(1)} KB)');
      } else {
        print('❌ Failed to fetch $fileName: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error fetching $fileName: $e');
    }
  }

  print('\n🎯 Navigation Aids bundling complete!');
}
