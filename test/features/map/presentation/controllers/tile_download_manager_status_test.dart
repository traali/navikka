import 'package:drift/drift.dart' hide equals, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/core/db/daos/tile_dao.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late TileDao tileDao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    tileDao = db.tileDao;
  });

  tearDown(() async {
    await db.close();
  });

  group('TileDao Region Status Integrity', () {
    test(
      'updateRegionStatus accurately persists status codes to SQLite',
      () async {
        final regionId = await tileDao.createRegion(
          OfflineRegionsCompanion.insert(
            name: 'Pellinki Outer Archipelago',
            minLat: 60.1000,
            maxLat: 60.2000,
            minLon: 25.8000,
            maxLon: 25.9000,
            totalTiles: 45,
            downloadStatus: const Value(1), // 1 = Downloading
          ),
        );

        var regions = await tileDao.getAllRegions();
        expect(regions.first.downloadStatus, equals(1));

        // Update status to Partial/Failed (3)
        await tileDao.updateRegionStatus(regionId, 3);
        regions = await tileDao.getAllRegions();
        expect(regions.first.downloadStatus, equals(3));

        // Update status to Success (2)
        await tileDao.updateRegionStatus(regionId, 2);
        regions = await tileDao.getAllRegions();
        expect(regions.first.downloadStatus, equals(2));
      },
    );
  });
}
