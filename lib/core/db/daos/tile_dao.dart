import 'package:drift/drift.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/core/db/tile_tables.dart';

part 'tile_dao.g.dart';

@DriftAccessor(tables: [MarineMapTiles, OfflineRegions, RegionTileRefs])
class TileDao extends DatabaseAccessor<AppDatabase> with _$TileDaoMixin {
  TileDao(super.db);

  /// Soft cap for cached tiles (roughly ~500MB assuming ~50KB raster tiles,
  /// typical zoom range 8-12 and 256x256 PNG/JPEG payloads).
  /// Keeps passive cache from growing unbounded on long-running installs.
  static const int maxTileCacheSize = 10000;

  /// Number of least-recently-used passive tiles to evict when over the cap.
  /// Extra headroom avoids frequent tiny eviction cycles under active map use.
  static const int _evictionBatchSize = 1000;

  /// Get a single tile from storage
  Future<MarineMapTile?> getTile(int z, int x, int y, String sourceId) {
    return (select(marineMapTiles)..where(
          (t) =>
              t.zoom.equals(z) &
              t.x.equals(x) &
              t.y.equals(y) &
              t.sourceId.equals(sourceId),
        ))
        .getSingleOrNull();
  }

  /// Update the last accessed time for a tile
  Future<void> updateLastAccessed(int z, int x, int y, String sourceId) {
    return (update(marineMapTiles)..where(
          (t) =>
              t.zoom.equals(z) &
              t.x.equals(x) &
              t.y.equals(y) &
              t.sourceId.equals(sourceId),
        ))
        .write(MarineMapTilesCompanion(lastAccessed: Value(DateTime.now())));
  }

  /// Update access timestamps for a group of cached tiles in one DB batch.
  Future<void> batchUpdateLastAccessed(
    List<({int z, int x, int y, String sourceId})> tiles,
  ) async {
    if (tiles.isEmpty) return;
    await batch((b) {
      for (final tile in tiles) {
        b.update(
          marineMapTiles,
          MarineMapTilesCompanion(lastAccessed: Value(DateTime.now())),
          where: (t) =>
              t.zoom.equals(tile.z) &
              t.x.equals(tile.x) &
              t.y.equals(tile.y) &
              t.sourceId.equals(tile.sourceId),
        );
      }
    });
  }

  /// Passively cache a tile downloaded from the network
  Future<void> upsertTile(
    int z,
    int x,
    int y,
    String sourceId,
    Uint8List data,
  ) async {
    await into(marineMapTiles).insert(
      MarineMapTilesCompanion.insert(
        zoom: z,
        x: x,
        y: y,
        sourceId: sourceId,
        tileData: data,
        refCount: const Value(
          0,
        ), // 0 means it's passively cached, can be purged
      ),
      onConflict: DoUpdate(
        (old) => MarineMapTilesCompanion.custom(
          tileData: Variable(data),
          lastAccessed: Constant(DateTime.now()),
        ),
      ),
    );
  }

  /// Batch upsert tiles in a single transaction.
  /// Replaces the N individual [upsertTile] calls in a flush cycle with
  /// a single batch insert, reducing DB round-trips by ~N-1.
  Future<void> batchUpsertTiles(
    List<({int z, int x, int y, String sourceId, Uint8List data})> tiles,
  ) async {
    await batch((b) {
      for (final tile in tiles) {
        b.insert(
          marineMapTiles,
          MarineMapTilesCompanion.insert(
            zoom: tile.z,
            x: tile.x,
            y: tile.y,
            sourceId: tile.sourceId,
            tileData: tile.data,
            refCount: const Value(0),
          ),
          onConflict: DoUpdate(
            (_) => MarineMapTilesCompanion.custom(
              tileData: Variable(tile.data),
              lastAccessed: Constant(DateTime.now()),
            ),
          ),
        );
      }
    });
    await _evictIfNeeded();
  }

  /// Generic method to save a tile and link it to a region
  ///
  /// Manages ref-counting to ensure shared tiles across regions are not duplicated or
  /// deleted prematurely.
  Future<void> saveTile({
    required int regionId,
    required int z,
    required int x,
    required int y,
    required String sourceId,
    required Uint8List data,
    String? md5Hash,
  }) async {
    await transaction(() async {
      // 1. Ensure tile exists (Upsert data, keep refCount)
      await into(marineMapTiles).insert(
        MarineMapTilesCompanion.insert(
          zoom: z,
          x: x,
          y: y,
          sourceId: sourceId,
          tileData: data,
          md5Hash: Value(md5Hash),
          refCount: const Value(0),
        ),
        onConflict: DoUpdate(
          (old) => MarineMapTilesCompanion.custom(
            tileData: Variable(data),
            lastAccessed: Constant(DateTime.now()),
            md5Hash: Variable(md5Hash),
          ),
        ),
      );

      // 2. Link tile to region if not already linked
      final existingRef =
          await (select(regionTileRefs)..where(
                (r) =>
                    r.regionId.equals(regionId) &
                    r.zoom.equals(z) &
                    r.x.equals(x) &
                    r.y.equals(y) &
                    r.sourceId.equals(sourceId),
              ))
              .getSingleOrNull();

      if (existingRef == null) {
        // Increment refCount
        await customStatement(
          'UPDATE marine_map_tiles SET ref_count = ref_count + 1 WHERE zoom = ? AND x = ? AND y = ? AND source_id = ?',
          [z, x, y, sourceId],
        );

        // Record the link
        await into(regionTileRefs).insert(
          RegionTileRefsCompanion.insert(
            regionId: regionId,
            zoom: z,
            x: x,
            y: y,
            sourceId: sourceId,
          ),
        );
      }
    });
    await _evictIfNeeded();
  }

  /// Create a new region metadata entry
  Future<int> createRegion(OfflineRegionsCompanion region) {
    return into(offlineRegions).insert(region);
  }

  /// Update the status of an offline region (0=Idle, 1=Downloading, 2=Success, 3=Failed, 4=Paused)
  Future<void> updateRegionStatus(int regionId, int status) {
    return (update(offlineRegions)..where((r) => r.id.equals(regionId))).write(
      OfflineRegionsCompanion(downloadStatus: Value(status)),
    );
  }

  /// Get all regions
  Future<List<OfflineRegion>> getAllRegions() => select(offlineRegions).get();

  /// Watch regions for UI updates
  Stream<List<OfflineRegion>> watchAllRegions() =>
      select(offlineRegions).watch();

  /// Delete a region and cleanup tiles with 0 references
  Future<void> deleteRegion(int regionId) async {
    await transaction(() async {
      // 1. Get tiles used by this region to decrement their ref_count
      final refs = await (select(
        regionTileRefs,
      )..where((r) => r.regionId.equals(regionId))).get();

      for (final ref in refs) {
        await customStatement(
          'UPDATE marine_map_tiles SET ref_count = ref_count - 1 WHERE zoom = ? AND x = ? AND y = ? AND source_id = ?',
          [ref.zoom, ref.x, ref.y, ref.sourceId],
        );
      }

      // 2. Delete the region (Cascade will handle RegionTileRefs table)
      await (delete(offlineRegions)..where((r) => r.id.equals(regionId))).go();

      // 3. Purge orphaned tiles
      await (delete(
        marineMapTiles,
      )..where((t) => t.refCount.isSmallerOrEqualValue(0))).go();
    });
  }

  /// Batch save tiles for a region
  Future<void> batchSaveTiles(int regionId, List<TileItem> tiles) async {
    if (tiles.isEmpty) return;

    await transaction(() async {
      await batch((b) {
        for (final tile in tiles) {
          b.insert(
            marineMapTiles,
            MarineMapTilesCompanion.insert(
              zoom: tile.z,
              x: tile.x,
              y: tile.y,
              sourceId: tile.sourceId,
              tileData: tile.data,
              md5Hash: Value(tile.md5Hash),
              refCount: const Value(0),
            ),
            mode: InsertMode.insertOrReplace,
          );

          b.insert(
            regionTileRefs,
            RegionTileRefsCompanion.insert(
              regionId: regionId,
              zoom: tile.z,
              x: tile.x,
              y: tile.y,
              sourceId: tile.sourceId,
            ),
            mode: InsertMode.insertOrIgnore,
          );
        }
      });

      await customStatement(
        '''
        UPDATE marine_map_tiles
        SET ref_count = (
          SELECT COUNT(*)
          FROM region_tile_refs r
          WHERE r.zoom = marine_map_tiles.zoom
            AND r.x = marine_map_tiles.x
            AND r.y = marine_map_tiles.y
            AND r.source_id = marine_map_tiles.source_id
        )
        WHERE (zoom, x, y, source_id) IN (
          SELECT zoom, x, y, source_id
          FROM region_tile_refs
          WHERE region_id = ?
        )
        ''',
        [regionId],
      );
    });
    await _evictIfNeeded();
  }

  /// Efficiently count how many tiles are already downloaded for a region
  Future<int> getDownloadedTileCount(int regionId) async {
    final result = await customSelect(
      'SELECT COUNT(*) AS c FROM region_tile_refs WHERE region_id = ?',
      variables: [Variable.withInt(regionId)],
    ).getSingle();
    return result.read<int>('c');
  }

  /// Watch progress for a specific region
  Stream<int> watchDownloadedTileCount(int regionId) {
    return customSelect(
      'SELECT COUNT(*) AS c FROM region_tile_refs WHERE region_id = ?',
      variables: [Variable.withInt(regionId)],
      readsFrom: {regionTileRefs},
    ).watch().map((rows) => rows.single.read<int>('c'));
  }

  Future<void> _evictIfNeeded() async {
    final countRow = await customSelect(
      'SELECT COUNT(*) AS c FROM marine_map_tiles',
    ).getSingle();
    final count = countRow.read<int>('c');
    if (count <= maxTileCacheSize) return;

    final toEvict = (count - maxTileCacheSize) + _evictionBatchSize;
    await customStatement(
      '''
      DELETE FROM marine_map_tiles
      WHERE rowid IN (
        SELECT rowid
        FROM marine_map_tiles
        WHERE ref_count <= 0
        ORDER BY last_accessed ASC
        LIMIT ?
      )
      ''',
      [toEvict],
    );
  }
}

class TileItem {
  TileItem({
    required this.z,
    required this.x,
    required this.y,
    required this.sourceId,
    required this.data,
    this.md5Hash,
  });
  final int z;
  final int x;
  final int y;
  final String sourceId;
  final Uint8List data;
  final String? md5Hash;
}
