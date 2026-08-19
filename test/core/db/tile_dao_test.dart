import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/core/db/daos/tile_dao.dart';

void main() {
  late AppDatabase db;
  late TileDao dao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    dao = db.tileDao;
  });

  tearDown(() async {
    await db.close();
  });

  test('batch updates access timestamps for multiple cached tiles', () async {
    await dao.batchUpsertTiles([
      (z: 10, x: 1, y: 2, sourceId: 'source', data: Uint8List.fromList([1])),
      (z: 10, x: 2, y: 2, sourceId: 'source', data: Uint8List.fromList([2])),
    ]);

    await dao.batchUpdateLastAccessed([
      (z: 10, x: 1, y: 2, sourceId: 'source'),
      (z: 10, x: 2, y: 2, sourceId: 'source'),
    ]);

    final tiles = await db.select(db.marineMapTiles).get();
    expect(tiles, hasLength(2));
    expect(tiles.every((tile) => tile.lastAccessed != null), isTrue);
  });

  test('passive batch upsert preserves an offline tile refCount', () async {
    final regionId = await dao.createRegion(
      OfflineRegionsCompanion.insert(
        name: 'Test region',
        minLat: 60,
        maxLat: 61,
        minLon: 24,
        maxLon: 25,
        totalTiles: 1,
      ),
    );

    await dao.saveTile(
      regionId: regionId,
      z: 10,
      x: 1,
      y: 2,
      sourceId: 'source',
      data: Uint8List.fromList([1]),
    );
    await dao.batchUpsertTiles([
      (
        z: 10,
        x: 1,
        y: 2,
        sourceId: 'source',
        data: Uint8List.fromList([2]),
      ),
    ]);

    final tile = await dao.getTile(10, 1, 2, 'source');
    expect(tile?.refCount, 1);
    expect(tile?.tileData, Uint8List.fromList([2]));
  });

  test(
    'passive batch upsert enforces the cache capacity once per batch',
    () async {
      final tiles = List.generate(
        TileDao.maxTileCacheSize + 1,
        (index) => (
          z: 10,
          x: index,
          y: 0,
          sourceId: 'source',
          data: Uint8List.fromList([index % 255]),
        ),
      );

      await dao.batchUpsertTiles(tiles);

      final storedTiles = await db.select(db.marineMapTiles).get();
      expect(storedTiles.length, lessThanOrEqualTo(TileDao.maxTileCacheSize));
    },
  );
}
