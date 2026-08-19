// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  const url = 'http://avoinkara.mmm.fi/geoserver/wfs';
  const outputFile = 'assets/data/fishing_restrictions.json';

  // WFS Request for all Finland (Lon,Lat order for CRS:84)
  const bbox = '19.0,59.0,32.0,70.5,CRS:84';

  print('Fetching fishing restrictions (Top 5000) with pagination...');

  final allFeatures = <dynamic>[];
  var startIndex = 0;
  const maxTotalFeatures = 5000;
  const countPerPage = 1000;
  var hasMore = true;

  try {
    while (hasMore && allFeatures.length < maxTotalFeatures) {
      final currentBatchCount = (maxTotalFeatures - allFeatures.length).clamp(
        0,
        countPerPage,
      );
      if (currentBatchCount == 0) break;

      print(
        'Fetching features $startIndex to ${startIndex + currentBatchCount}...',
      );
      final response = await dio.get<dynamic>(
        url,
        queryParameters: {
          'service': 'wfs',
          'version': '2.0.0',
          'request': 'GetFeature',
          'typeName': 'avoin:kalastusrajoitus',
          'outputFormat': 'json',
          'srsName': 'CRS:84',
          'bbox': bbox,
          'count': currentBatchCount,
          'startIndex': startIndex,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final features = data['features'] as List;
        allFeatures.addAll(features);
        print(
          'Batch received: ${features.length} features. Total so far: ${allFeatures.length}',
        );

        if (features.length < currentBatchCount) {
          hasMore = false;
        } else {
          startIndex += currentBatchCount;
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
        exit(1);
      }
    }

    print(
      'Complete! Successfully fetched ${allFeatures.length} features in total.',
    );

    final file = File(outputFile);
    if (!file.parent.existsSync()) {
      file.parent.createSync(recursive: true);
    }

    // Wrap in standard GeoJSON FeatureCollection structure
    final fullData = {'type': 'FeatureCollection', 'features': allFeatures};

    // Use compact JSON (no indent) to save space
    final jsonStr = jsonEncode(fullData);
    final gzipBytes = GZipCodec().encode(utf8.encode(jsonStr));

    // ATOMIC WRITE: Write to .tmp first, then rename.
    // This prevents inconsistent state if the script is interrupted.
    final gzTmpFile = File('$outputFile.gz.tmp');
    final gzFinalFile = File('$outputFile.gz');

    await gzTmpFile.writeAsBytes(gzipBytes);
    if (await gzFinalFile.exists()) {
      await gzFinalFile.delete();
    }
    await gzTmpFile.rename(gzFinalFile.path);

    print('Saved ${allFeatures.length} features to ${gzFinalFile.path}');

    final sizeMb = gzFinalFile.lengthSync() / (1024 * 1024);
    print('Compressed file size: ${sizeMb.toStringAsFixed(2)} MB');

    // Clean up raw JSON only AFTER the .gz is safely moved
    if (file.existsSync()) {
      file.deleteSync();
      print('Deleted raw file: $outputFile');
    }
  } catch (e) {
    print('Error: $e');
    exit(1);
  }
}
