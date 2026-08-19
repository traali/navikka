import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/contribution/domain/entities/user_contribution.dart';
import 'package:sakkoja/features/contribution/domain/repositories/contribution_repository.dart';

class DriftContributionRepository implements ContributionRepository {
  DriftContributionRepository(this._db);
  final AppDatabase _db;
  static const _featureId = 'pending_contributions';
  static const _categoryId = 'user_data';

  @override
  Future<Either<Failure, Unit>> saveContribution(
    UserContribution contribution,
  ) async {
    try {
      await _db
          .into(_db.userContributions)
          .insertOnConflictUpdate(
            UserContributionsCompanion.insert(
              id: contribution.id,
              type: contribution.type,
              latitude: contribution.location.latitude,
              longitude: contribution.location.longitude,
              value: contribution.value,
              createdAt: contribution.createdAt,
              isSynced: Value(contribution.isSynced),
            ),
          );
      return right(unit);
    } catch (e, s) {
      Log.w('[Contribution] save failed', e, s);
      return left(GeneralFailure('Failed to save contribution: $e'));
    }
  }

  @override
  Future<Either<Failure, List<UserContribution>>> getAllContributions() async {
    try {
      // 1. One-time Migration from legacy JSON blob
      await _migrateLegacyData();

      // 2. Load from dedicated table
      final rows = await (_db.select(
        _db.userContributions,
      )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();

      return right(
        rows
            .map(
              (row) => UserContribution(
                id: row.id,
                type: row.type,
                location: LatLng(row.latitude, row.longitude),
                value: row.value,
                createdAt: row.createdAt,
                isSynced: row.isSynced,
              ),
            )
            .toList(),
      );
    } catch (e, s) {
      Log.w('[Contribution] load failed', e, s);
      return left(GeneralFailure('Failed to load contributions: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteContribution(String id) async {
    try {
      await (_db.delete(
        _db.userContributions,
      )..where((t) => t.id.equals(id))).go();
      return right(unit);
    } catch (e, s) {
      Log.w('[Contribution] delete failed', e, s);
      return left(GeneralFailure('Failed to delete contribution: $e'));
    }
  }

  /// Migrates data from legacy CachedFeatures JSON blob to UserContributions table
  Future<void> _migrateLegacyData() async {
    try {
      final legacyRow =
          await (_db.select(_db.cachedFeatures)
                ..where((t) => t.id.equals(_featureId))
                ..where((t) => t.category.equals(_categoryId)))
              .getSingleOrNull();

      if (legacyRow == null) return;

      Log.i('DriftContributionRepo: Found legacy JSON data, migrating...');
      final list = (jsonDecode(legacyRow.dataJson) as List)
          .map((e) => UserContribution.fromJson(e as Map<String, dynamic>))
          .toList();

      for (final contribution in list) {
        await saveContribution(contribution);
      }

      // Cleanup legacy data
      await (_db.delete(_db.cachedFeatures)
            ..where((t) => t.id.equals(_featureId))
            ..where((t) => t.category.equals(_categoryId)))
          .go();

      Log.i(
        'DriftContributionRepo: Migration complete for ${list.length} items',
      );
    } catch (e, s) {
      Log.w('DriftContributionRepo: Migration failed (skipping)', e, s);
    }
  }
}
