import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/core/utils/asset_loader.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/speed_limits/data/models/speed_limit_dto.dart';
import 'package:sakkoja/features/speed_limits/data/models/speed_limits_mappers.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';

abstract class SpeedLimitLocalDataSource {
  Future<List<SpeedLimitZone>> getLastSpeedLimits();
  Future<void> cacheSpeedLimits(List<SpeedLimitZone> zones);
  Future<List<SpeedLimitZone>> loadFromAssets();
  Future<int?> getAssetVersion();
  Future<void> setAssetVersion(int version);
}

class SpeedLimitLocalDataSourceImpl implements SpeedLimitLocalDataSource {
  SpeedLimitLocalDataSourceImpl(this._db);
  final AppDatabase _db;
  static const String _featureId = 'speed_limits';
  static const String _categoryId = 'static_data';
  static const String _metaId = 'speed_limits_meta';

  @override
  Future<List<SpeedLimitZone>> getLastSpeedLimits() async {
    final row =
        await (_db.select(_db.cachedFeatures)
              ..where((t) => t.id.equals(_featureId))
              ..where((t) => t.category.equals(_categoryId)))
            .getSingleOrNull();

    if (row == null) {
      Log.d('SpeedLimitLocalDataSource: Cache MISS');
      return [];
    }

    Log.d('SpeedLimitLocalDataSource: Cache HIT');
    return compute(_decodeSpeedLimits, row.dataJson);
  }

  static List<SpeedLimitZone> _decodeSpeedLimits(String jsonStr) {
    final rawList = jsonDecode(jsonStr) as List;
    return rawList
        .map(
          (map) =>
              SpeedLimitDto.fromJson(map as Map<String, dynamic>).toEntity(),
        )
        .toList();
  }

  @override
  Future<void> cacheSpeedLimits(List<SpeedLimitZone> zones) async {
    // Transform entries -> DTO -> JSON -> String -> Store
    // Doing this in isolate to avoid jank
    final jsonStr = await compute(_encodeSpeedLimits, zones);

    await _db
        .into(_db.cachedFeatures)
        .insertOnConflictUpdate(
          CachedFeaturesCompanion.insert(
            id: _featureId,
            category: _categoryId,
            cachedAt: DateTime.now(),
            dataJson: jsonStr,
          ),
        );
    Log.d('SpeedLimitLocalDataSource: Cached ${zones.length} zones');
  }

  static String _encodeSpeedLimits(List<SpeedLimitZone> zones) {
    final list = zones.map((z) => z.toDto().toJson()).toList();
    return jsonEncode(list);
  }

  @override
  Future<List<SpeedLimitZone>> loadFromAssets() async {
    try {
      Log.d('SpeedLimitLocalDataSource: Loading from assets...');
      final features = await AssetLoader.loadGeoJsonFeatures(
        'assets/data/speed_limits.geojson.gz',
      );

      final zones = features
          .expand(SpeedLimitDto.fromGeoJsonMultiple)
          .map((dto) => dto.toEntity())
          .toList();

      Log.d('SpeedLimitLocalDataSource: Parsed ${zones.length} valid zones');
      return zones;
    } catch (e, s) {
      Log.e('SpeedLimitLocalDataSource: ERROR loading assets', e, s);
      return [];
    }
  }

  @override
  Future<int?> getAssetVersion() async {
    final row =
        await (_db.select(_db.cachedFeatures)
              ..where((t) => t.id.equals(_metaId))
              ..where((t) => t.category.equals(_categoryId)))
            .getSingleOrNull();

    if (row == null) return null;
    try {
      final map = jsonDecode(row.dataJson) as Map<String, dynamic>;
      return map['version'] as int?;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> setAssetVersion(int version) async {
    final jsonStr = jsonEncode({'version': version});
    await _db
        .into(_db.cachedFeatures)
        .insertOnConflictUpdate(
          CachedFeaturesCompanion.insert(
            id: _metaId,
            category: _categoryId,
            cachedAt: DateTime.now(),
            dataJson: jsonStr,
          ),
        );
  }
}
