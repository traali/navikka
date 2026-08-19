import 'dart:async';
import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sakkoja/core/constants/map_constants.dart';
import 'package:sakkoja/core/db/daos/tile_dao.dart';

class TileBatchQueue<T> {
  TileBatchQueue({required this.delay, required this.onFlush});

  final Duration delay;
  final Future<void> Function(Map<String, T> batch) onFlush;
  final Map<String, T> _pending = {};
  Timer? _timer;
  Future<void>? _flushFuture;

  void add(String key, T value) {
    _pending[key] = value;
    _schedule();
  }

  Future<void> flush() {
    final activeFlush = _flushFuture;
    if (activeFlush != null) return activeFlush;

    _timer?.cancel();
    _timer = null;
    final flushFuture = _drain();
    _flushFuture = flushFuture;
    unawaited(
      flushFuture.then<void>(
        (_) {
          _finishFlush();
        },
        onError: (Object error, StackTrace stackTrace) {
          _finishFlush();
        },
      ),
    );
    return flushFuture;
  }

  Future<void> _drain() async {
    while (_pending.isNotEmpty) {
      final batch = Map<String, T>.from(_pending);
      _pending.clear();
      await onFlush(batch);
    }
  }

  void _schedule() {
    if (_timer != null || _flushFuture != null) return;
    _timer = Timer(delay, () {
      _timer = null;
      unawaited(flush());
    });
  }

  void _finishFlush() {
    _flushFuture = null;
    _schedule();
  }
}

/// A TileProvider that fetches tiles from the Drift database.
///
/// If a tile is not found, it throws an exception which flutter_map
/// can handle (by showing nothing or a grey grid).
class DriftTileProvider extends TileProvider {
  DriftTileProvider({required this.tileDao, required this.dio, this.userAgent});
  final TileDao tileDao;
  final Dio dio;
  final String? userAgent;

  @override
  ImageProvider getImage(TileCoordinates coordinates, TileLayer options) {
    return DriftImageProvider(
      tileDao: tileDao,
      dio: dio,
      coordinates: coordinates,
      urlTemplate: options.urlTemplate,
      fallbackUserAgent: userAgent,
    );
  }
}

class DriftImageProvider extends ImageProvider<DriftImageProvider> {
  DriftImageProvider({
    required this.tileDao,
    required this.dio,
    required this.coordinates,
    required this.urlTemplate,
    this.fallbackUserAgent,
  });
  final TileDao tileDao;
  final Dio dio;
  final TileCoordinates coordinates;
  final String? urlTemplate;
  final String? fallbackUserAgent;
  static final TileBatchQueue<_PendingTileUpsert> _pendingUpserts =
      TileBatchQueue<_PendingTileUpsert>(
        delay: const Duration(milliseconds: 500),
        onFlush: _flushUpsertBatch,
      );
  static final TileBatchQueue<_PendingAccessUpdate> _pendingAccessUpdates =
      TileBatchQueue<_PendingAccessUpdate>(
        delay: const Duration(seconds: 5),
        onFlush: _flushAccessBatch,
      );

  @override
  Future<DriftImageProvider> obtainKey(ImageConfiguration configuration) {
    return Future.value(this);
  }

  @override
  ImageStreamCompleter loadImage(
    DriftImageProvider key,
    ImageDecoderCallback decode,
  ) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(decode),
      scale: 1,
      debugLabel:
          'DriftTile(${coordinates.z}/${coordinates.x}/${coordinates.y})',
    );
  }

  static bool _isValidImage(Uint8List data) {
    if (data.length < 4) return false;
    final h3 = data[0] << 16 | data[1] << 8 | data[2];
    if (h3 == 0x89504E) return true; // PNG
    if (h3 == 0xFFD8FF) return true; // JPEG (any APPn marker)
    if (data.length >= 12 &&
        data[0] == 0x52 &&
        data[1] == 0x49 &&
        data[2] == 0x46 &&
        data[3] == 0x46 &&
        data[8] == 0x57 &&
        data[9] == 0x45 &&
        data[10] == 0x42 &&
        data[11] == 0x50) {
      return true; // WebP (RIFF....WEBP)
    }
    if (h3 == 0x474946) return true; // GIF
    return false;
  }

  Future<ui.Codec> _loadAsync(ImageDecoderCallback decode) async {
    try {
      final tile = await tileDao.getTile(
        coordinates.z,
        coordinates.x,
        coordinates.y,
        urlTemplate ?? '',
      );
      if (tile != null) {
        _queueUpdateLastAccessed();
        if (_isValidImage(tile.tileData)) {
          return decode(await ui.ImmutableBuffer.fromUint8List(tile.tileData));
        }
      }
    } catch (e) {
      // Fall through to network
    }

    // Network Fallback
    try {
      final url =
          urlTemplate
              ?.replaceAll('{z}', coordinates.z.toString())
              .replaceAll('{x}', coordinates.x.toString())
              .replaceAll('{y}', coordinates.y.toString()) ??
          '';

      if (url.isEmpty) {
        throw Exception('URL template is missing');
      }

      final response = await dio.get<Uint8List>(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            if (fallbackUserAgent != null && !kIsWeb)
              'User-Agent': fallbackUserAgent,
          },
        ),
      );

      if (response.data != null && _isValidImage(response.data!)) {
        _queueTileUpsert(response.data!);
        return decode(await ui.ImmutableBuffer.fromUint8List(response.data!));
      }
    } catch (e) {
      // Fall through to transparent
    }

    // Return transparent tile so other layers can show through
    return decode(
      await ui.ImmutableBuffer.fromUint8List(MapConstants.transparentTile),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriftImageProvider &&
          coordinates.x == other.coordinates.x &&
          coordinates.y == other.coordinates.y &&
          coordinates.z == other.coordinates.z &&
          urlTemplate == other.urlTemplate;

  @override
  int get hashCode =>
      Object.hash(coordinates.x, coordinates.y, coordinates.z, urlTemplate);

  String _tileKey() =>
      '${coordinates.z}/${coordinates.x}/${coordinates.y}/${urlTemplate ?? ''}';

  void _queueTileUpsert(Uint8List data) {
    _pendingUpserts.add(
      _tileKey(),
      _PendingTileUpsert(
        tileDao: tileDao,
        z: coordinates.z,
        x: coordinates.x,
        y: coordinates.y,
        sourceId: urlTemplate ?? '',
        data: data,
      ),
    );
  }

  static Future<void> _flushUpsertBatch(
    Map<String, _PendingTileUpsert> pending,
  ) async {
    // Group by tileDao for batch insert.
    final byDao =
        <
          TileDao,
          List<({int z, int x, int y, String sourceId, Uint8List data})>
        >{};
    for (final item in pending.values) {
      byDao.putIfAbsent(item.tileDao, () => []).add((
        z: item.z,
        x: item.x,
        y: item.y,
        sourceId: item.sourceId,
        data: item.data,
      ));
    }
    for (final entry in byDao.entries) {
      try {
        await entry.key.batchUpsertTiles(entry.value);
      } catch (_) {
        // Best-effort background cache write.
      }
    }
  }

  void _queueUpdateLastAccessed() {
    _pendingAccessUpdates.add(
      _tileKey(),
      _PendingAccessUpdate(
        tileDao: tileDao,
        z: coordinates.z,
        x: coordinates.x,
        y: coordinates.y,
        sourceId: urlTemplate ?? '',
      ),
    );
  }

  static Future<void> _flushAccessBatch(
    Map<String, _PendingAccessUpdate> pending,
  ) async {
    final byDao = <TileDao, List<({int z, int x, int y, String sourceId})>>{};
    for (final item in pending.values) {
      byDao.putIfAbsent(item.tileDao, () => []).add((
        z: item.z,
        x: item.x,
        y: item.y,
        sourceId: item.sourceId,
      ));
    }
    for (final entry in byDao.entries) {
      try {
        await entry.key.batchUpdateLastAccessed(entry.value);
      } catch (_) {
        // Best-effort background access tracking.
      }
    }
  }
}

class _PendingAccessUpdate {
  _PendingAccessUpdate({
    required this.tileDao,
    required this.z,
    required this.x,
    required this.y,
    required this.sourceId,
  });

  final TileDao tileDao;
  final int z;
  final int x;
  final int y;
  final String sourceId;
}

class _PendingTileUpsert {
  _PendingTileUpsert({
    required this.tileDao,
    required this.z,
    required this.x,
    required this.y,
    required this.sourceId,
    required this.data,
  });

  final TileDao tileDao;
  final int z;
  final int x;
  final int y;
  final String sourceId;
  final Uint8List data;
}
