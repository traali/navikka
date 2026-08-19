// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vessel_dao.dart';

// ignore_for_file: type=lint
mixin _$VesselDaoMixin on DatabaseAccessor<AppDatabase> {
  $VesselProfilesTable get vesselProfiles => attachedDatabase.vesselProfiles;
  VesselDaoManager get managers => VesselDaoManager(this);
}

class VesselDaoManager {
  final _$VesselDaoMixin _db;
  VesselDaoManager(this._db);
  $$VesselProfilesTableTableManager get vesselProfiles =>
      $$VesselProfilesTableTableManager(
        _db.attachedDatabase,
        _db.vesselProfiles,
      );
}
