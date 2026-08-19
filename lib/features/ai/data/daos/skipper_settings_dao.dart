import 'package:drift/drift.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/features/ai/data/tables/skipper_settings_table.dart';

part 'skipper_settings_dao.g.dart';

@DriftAccessor(tables: [SkipperSettingsTable])
class SkipperSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SkipperSettingsDaoMixin {
  SkipperSettingsDao(super.db);

  /// Get settings, ensuring default row exists and only one row remains.
  Future<SkipperSettingsEntry> getSettings() async {
    final rows = await select(skipperSettingsTable).get();

    if (rows.isNotEmpty) {
      if (rows.length > 1) {
        // Prune extras to maintain singleton constraint
        final firstId = rows.first.id;
        await (delete(
          skipperSettingsTable,
        )..where((t) => t.id.isNotValue(firstId))).go();
      }
      return rows.first;
    }

    // Seed default row if missing
    await into(skipperSettingsTable).insert(
      const SkipperSettingsTableCompanion(id: Value(1)),
      mode: InsertMode.insertOrIgnore,
    );

    return (select(
      skipperSettingsTable,
    )..where((t) => t.id.equals(1))).getSingle();
  }

  /// Update settings with upsert.
  Future<void> updateSettings(SkipperSettingsTableCompanion companion) {
    return into(
      skipperSettingsTable,
    ).insertOnConflictUpdate(companion.copyWith(id: const Value(1)));
  }

  /// Watch settings for reactive UI.
  Stream<SkipperSettingsEntry> watchSettings() {
    return select(skipperSettingsTable).watch().map((rows) => rows.first);
  }
}
