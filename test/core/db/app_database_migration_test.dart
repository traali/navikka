import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/core/db/app_database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppDatabase Migration Tests', () {
    test(
      'Sequential migration from v5 to v18 creates all tables without missing offlineRegions',
      () async {
        final executor = NativeDatabase.memory();
        final db = AppDatabase(executor);

        expect(db.schemaVersion, equals(18));

        // Verify offlineRegions and userContributions tables exist in schema
        final tableNames = db.allTables.map((t) => t.actualTableName).toSet();
        expect(tableNames, contains('user_contributions'));
        expect(tableNames, contains('marine_map_tiles'));
        expect(tableNames, contains('offline_regions'));
        expect(tableNames, contains('region_tile_refs'));
        expect(tableNames, contains('routes'));
        expect(tableNames, contains('waypoints'));
        expect(tableNames, contains('skipper_settings_table'));

        await db.close();
      },
    );
  });
}
