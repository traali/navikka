// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skipper_settings_dao.dart';

// ignore_for_file: type=lint
mixin _$SkipperSettingsDaoMixin on DatabaseAccessor<AppDatabase> {
  $SkipperSettingsTableTable get skipperSettingsTable =>
      attachedDatabase.skipperSettingsTable;
  SkipperSettingsDaoManager get managers => SkipperSettingsDaoManager(this);
}

class SkipperSettingsDaoManager {
  final _$SkipperSettingsDaoMixin _db;
  SkipperSettingsDaoManager(this._db);
  $$SkipperSettingsTableTableTableManager get skipperSettingsTable =>
      $$SkipperSettingsTableTableTableManager(
        _db.attachedDatabase,
        _db.skipperSettingsTable,
      );
}
