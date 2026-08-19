import 'dart:convert';
import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/core/utils/performance_tracker.dart';

/// Centralized utility for loading compressed JSON assets.
/// Eliminates duplication across NavigationAids, SpeedLimits, Fishing data sources.
class AssetLoader {
  /// Loads a gzipped JSON file from assets and returns the decoded Map.
  /// Runs decompression and parsing in an isolate to avoid UI jank.
  static Future<Map<String, dynamic>> loadGzippedJson(String assetPath) async {
    return PerformanceTracker.traceAsync(
      'NavAids.AssetLoader.loadGzippedJson',
      () async {
        try {
          Log.d('AssetLoader: Loading $assetPath');
          final byteData = await rootBundle.load(assetPath);

          if (byteData.lengthInBytes == 0) {
            Log.w('AssetLoader: $assetPath is empty');
            return {};
          }

          final bytes = byteData.buffer.asUint8List(
            byteData.offsetInBytes,
            byteData.lengthInBytes,
          );

          if (kIsWeb) {
            return _decodeGzippedBytes(bytes);
          } else {
            return await compute(_decodeGzippedBytes, bytes);
          }
        } catch (e, s) {
          Log.e('AssetLoader: Failed to load $assetPath', e, s);
          return {};
        }
      },
    );
  }

  /// Loads a gzipped GeoJSON file and extracts the 'features' array.
  static Future<List<Map<String, dynamic>>> loadGeoJsonFeatures(
    String assetPath,
  ) async {
    final json = await loadGzippedJson(assetPath);
    final features = json['features'];
    if (features is List) {
      return features.cast<Map<String, dynamic>>();
    }
    return [];
  }

  // Isolate-safe decompression function
  static Map<String, dynamic> _decodeGzippedBytes(Uint8List bytes) {
    final decompressedBytes = const GZipDecoder().decodeBytes(bytes);
    final jsonString = utf8.decode(decompressedBytes);
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }
}
