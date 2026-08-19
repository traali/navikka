import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/db/daos/tile_dao.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/core/utils/logger.dart';

part 'tile_download_manager.g.dart';

enum DownloadState { idle, downloading, paused, error, success }

class TileEnumerationException implements Exception {
  const TileEnumerationException(this.message);
  final String message;

  @override
  String toString() => message;
}

@riverpod
class TileDownloadManager extends _$TileDownloadManager {
  /// Number of concurrent tile fetches per network burst.
  /// Kept conservative (8) based on field testing to avoid API throttling
  /// and memory spikes while preserving acceptable throughput.
  static const int _downloadChunkSize = 8;

  /// Buffered tiles written to DB in one batch transaction.
  /// 100 tiles offers good throughput without large memory retention.
  static const int _dbFlushBatchSize = 100;

  /// Prevents a large selection from materializing an unbounded tile list.
  static const int maxOfflineTileCount = 100000;

  @override
  DownloadState build() => DownloadState.idle;

  @visibleForTesting
  static String sourceIdForTemplate(String template) => template;

  /// Generate a list of all tile coordinates within a bounding box for zoom range
  static List<TileCoordinates> getTilesInBounds(
    fm.LatLngBounds bounds,
    int minZoom,
    int maxZoom,
  ) {
    if (minZoom < 0 || maxZoom < minZoom) {
      throw const TileEnumerationException('Invalid offline zoom range');
    }

    var tileCount = 0;
    for (var z = minZoom; z <= maxZoom; z++) {
      final p1 = _latLonToTile(bounds.southWest, z);
      final p2 = _latLonToTile(bounds.northEast, z);
      final width = max(p1.x, p2.x).floor() - min(p1.x, p2.x).floor() + 1;
      final height = max(p1.y, p2.y).floor() - min(p1.y, p2.y).floor() + 1;
      final countAtZoom = width * height;
      if (countAtZoom < 0 || tileCount > maxOfflineTileCount - countAtZoom) {
        throw const TileEnumerationException(
          'Selected area contains more than 100000 tiles',
        );
      }
      tileCount += countAtZoom;
    }

    final tiles = <TileCoordinates>[];
    for (var z = minZoom; z <= maxZoom; z++) {
      final p1 = _latLonToTile(bounds.southWest, z);
      final p2 = _latLonToTile(bounds.northEast, z);

      final minX = min(p1.x, p2.x).toInt();
      final maxX = max(p1.x, p2.x).toInt();
      final minY = min(p1.y, p2.y).toInt();
      final maxY = max(p1.y, p2.y).toInt();

      for (var x = minX; x <= maxX; x++) {
        for (var y = minY; y <= maxY; y++) {
          tiles.add(TileCoordinates(z, x, y));
        }
      }
    }
    return tiles;
  }

  static Point<double> _latLonToTile(LatLng loc, int zoom) {
    final x = (loc.longitude + 180) / 360 * pow(2, zoom);
    final y =
        (1 -
            log(
                  tan(loc.latitude * pi / 180) +
                      1 / cos(loc.latitude * pi / 180),
                ) /
                pi) /
        2 *
        pow(2, zoom);
    return Point(x, y);
  }

  /// Download a list of tiles for a specific region
  ///
  /// [urlTemplate] usually contains {z}, {x}, {y} placeholders.
  Future<void> downloadRegion({
    required int regionId,
    required List<TileCoordinates> tiles,
    required String urlTemplate,
  }) async {
    if (state == DownloadState.downloading) return;
    if (tiles.length > maxOfflineTileCount) {
      state = DownloadState.error;
      Log.e(
        'Region download rejected: more than $maxOfflineTileCount tiles',
      );
      return;
    }

    state = DownloadState.downloading;

    final dio = ref.read(dioProvider);
    final dao = ref.read(appDatabaseProvider).tileDao;

    final template = urlTemplate;
    final sourceId = sourceIdForTemplate(template);
    final cancelToken = CancelToken();
    _activeCancelToken = cancelToken;

    Log.i('Starting download for region $regionId (${tiles.length} tiles)');

    try {
      var successful = 0;
      final buffer = <TileItem>[];

      for (var i = 0; i < tiles.length; i += _downloadChunkSize) {
        if (state == DownloadState.paused) break;

        final chunk = tiles.skip(i).take(_downloadChunkSize).toList();
        final responses = await Future.wait(
          chunk.map((tile) async {
            try {
              final url = template
                  .replaceAll('{z}', tile.z.toString())
                  .replaceAll('{x}', tile.x.toString())
                  .replaceAll('{y}', tile.y.toString());

              final response = await dio.get<Uint8List>(
                url,
                options: Options(
                  responseType: ResponseType.bytes,
                  headers: {
                    if (!kIsWeb)
                      'User-Agent': 'Sakkoja-App/1.1 (Offline Areas)',
                  },
                ),
                cancelToken: cancelToken,
              );

              if (response.statusCode == 200 && response.data != null) {
                return TileItem(
                  z: tile.z,
                  x: tile.x,
                  y: tile.y,
                  sourceId: sourceId,
                  data: response.data!,
                );
              }
            } catch (e, s) {
              if (e is DioException && CancelToken.isCancel(e)) return null;
              // 404 is ignored (empty sea/land area)
              if (e is DioException && e.response?.statusCode != 404) {
                Log.w(
                  'Failed tile download ${tile.z}/${tile.x}/${tile.y}',
                  e,
                  s,
                );
              }
            }
            return null;
          }),
        );

        for (final item in responses) {
          if (item == null) continue;
          buffer.add(item);
          successful++;
        }

        if (buffer.length >= _dbFlushBatchSize) {
          await dao.batchSaveTiles(regionId, List<TileItem>.from(buffer));
          buffer.clear();
        }
      }

      if (buffer.isNotEmpty) {
        await dao.batchSaveTiles(regionId, buffer);
      }

      if (state != DownloadState.paused) {
        if (successful == tiles.length && tiles.isNotEmpty) {
          state = DownloadState.success;
          await dao.updateRegionStatus(regionId, 2); // 2 = Success
        } else if (successful > 0) {
          state = DownloadState.error;
          await dao.updateRegionStatus(regionId, 3); // 3 = Partial/Failed
        } else {
          state = DownloadState.idle;
          await dao.updateRegionStatus(regionId, 3); // 3 = Failed
        }
      }
      Log.i(
        'Finished download for region $regionId. Success: $successful/${tiles.length}',
      );
    } catch (e, s) {
      if (!(e is DioException && CancelToken.isCancel(e))) {
        state = DownloadState.error;
        await dao.updateRegionStatus(regionId, 3); // 3 = Failed
        Log.e('Region download failed', e, s);
      }
    } finally {
      if (identical(_activeCancelToken, cancelToken)) {
        _activeCancelToken = null;
      }
    }
  }

  void pause() {
    state = DownloadState.paused;
    _activeCancelToken?.cancel('Offline tile download paused');
  }

  CancelToken? _activeCancelToken;

  void reset() {
    state = DownloadState.idle;
  }
}

class TileCoordinates {
  TileCoordinates(this.z, this.x, this.y);
  final int z;
  final int x;
  final int y;
}
