// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tile_dao.dart';

// ignore_for_file: type=lint
mixin _$TileDaoMixin on DatabaseAccessor<AppDatabase> {
  $MarineMapTilesTable get marineMapTiles => attachedDatabase.marineMapTiles;
  $OfflineRegionsTable get offlineRegions => attachedDatabase.offlineRegions;
  $RegionTileRefsTable get regionTileRefs => attachedDatabase.regionTileRefs;
  TileDaoManager get managers => TileDaoManager(this);
}

class TileDaoManager {
  final _$TileDaoMixin _db;
  TileDaoManager(this._db);
  $$MarineMapTilesTableTableManager get marineMapTiles =>
      $$MarineMapTilesTableTableManager(
        _db.attachedDatabase,
        _db.marineMapTiles,
      );
  $$OfflineRegionsTableTableManager get offlineRegions =>
      $$OfflineRegionsTableTableManager(
        _db.attachedDatabase,
        _db.offlineRegions,
      );
  $$RegionTileRefsTableTableManager get regionTileRefs =>
      $$RegionTileRefsTableTableManager(
        _db.attachedDatabase,
        _db.regionTileRefs,
      );
}
