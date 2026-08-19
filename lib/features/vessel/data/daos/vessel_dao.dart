import 'package:drift/drift.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/features/vessel/data/tables.dart';

part 'vessel_dao.g.dart';

@DriftAccessor(tables: [VesselProfiles])
class VesselDao extends DatabaseAccessor<AppDatabase> with _$VesselDaoMixin {
  VesselDao(super.db);

  /// Get all vessel profiles.
  Future<List<VesselProfile>> getAllProfiles() {
    return select(vesselProfiles).get();
  }

  /// Get the currently selected profile.
  Future<VesselProfile?> getSelectedProfile() {
    return (select(
      vesselProfiles,
    )..where((_) => vesselProfiles.isSelected.equals(true))).getSingleOrNull();
  }

  /// Create a new profile.
  Future<int> createProfile(VesselProfilesCompanion profile) {
    return into(vesselProfiles).insert(profile);
  }

  /// Update a profile.
  Future<bool> updateProfile(VesselProfilesCompanion profile) {
    return update(vesselProfiles).replace(profile);
  }

  /// Delete a profile.
  Future<int> deleteProfile(int id) {
    return (delete(
      vesselProfiles,
    )..where((_) => vesselProfiles.id.equals(id))).go();
  }

  /// Set a profile as selected and deselect others.
  Future<void> setSelectedProfile(int id) async {
    return transaction(() async {
      // Deselect all
      await (update(vesselProfiles)
            ..where((_) => vesselProfiles.isSelected.equals(true)))
          .write(const VesselProfilesCompanion(isSelected: Value(false)));

      // Select target
      await (update(vesselProfiles)..where((_) => vesselProfiles.id.equals(id)))
          .write(const VesselProfilesCompanion(isSelected: Value(true)));
    });
  }
}
