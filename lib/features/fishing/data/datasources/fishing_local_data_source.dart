import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/core/models/bbox.dart';
import 'package:sakkoja/core/utils/asset_loader.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/fishing/data/models/fishing_restriction_dto.dart';
import 'package:sakkoja/features/fishing/data/models/waterway_feature_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FishingLocalDataSource {
  Future<void> saveFishingMode(bool isEnabled);
  Future<bool> getFishingMode();
  Future<void> saveFishingRestrictions(
    BBox bbox,
    List<FishingRestrictionDto> restrictions,
  );
  Future<List<FishingRestrictionDto>?> getFishingRestrictions({
    required BBox bbox,
    bool ignoreExpiry = false,
  });
  Future<List<FishingRestrictionDto>> loadFromAssets();
  Future<void> saveWaterwayFeatures(
    BBox bbox,
    List<WaterwayFeatureDto> features,
  );
  Future<List<WaterwayFeatureDto>?> getWaterwayFeatures({
    required BBox bbox,
    bool ignoreExpiry = false,
  });
}

class FishingLocalDataSourceImpl implements FishingLocalDataSource {
  FishingLocalDataSourceImpl(this._db);
  final AppDatabase _db;
  static const _keyFishingMode = 'fishing_mode_enabled';

  static const _categoryId = 'fishing_data';
  static const _restrictionCachePrefix = 'fishing_restrictions_v2';
  static const _waterwayCachePrefix = 'waterway_features_v2';
  static const _cacheValidity = Duration(hours: 24);

  @override
  Future<void> saveFishingMode(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyFishingMode, isEnabled);
    Log.d('FishingLocalDS: Saved fishing mode: $isEnabled');
  }

  @override
  Future<bool> getFishingMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyFishingMode) ?? false;
  }

  Future<void> _saveToCache(
    String id,
    List<Map<String, dynamic>> jsonList,
  ) async {
    final jsonStr = await compute(jsonEncode, jsonList);
    await _db
        .into(_db.cachedFeatures)
        .insertOnConflictUpdate(
          CachedFeaturesCompanion.insert(
            id: id,
            category: _categoryId,
            cachedAt: DateTime.now(),
            dataJson: jsonStr,
          ),
        );
  }

  Future<List<Map<String, dynamic>>?> _getFromCache(
    String id,
    Duration? maxAge,
  ) async {
    final row =
        await (_db.select(_db.cachedFeatures)
              ..where((t) => t.id.equals(id))
              ..where((t) => t.category.equals(_categoryId)))
            .getSingleOrNull();

    if (row == null) return null;

    if (maxAge != null && DateTime.now().difference(row.cachedAt) > maxAge) {
      return null;
    }

    return compute(_decodeJsonList, row.dataJson);
  }

  static List<Map<String, dynamic>> _decodeJsonList(String jsonStr) {
    return (jsonDecode(jsonStr) as List).cast<Map<String, dynamic>>();
  }

  @visibleForTesting
  static String restrictionCacheId(BBox bbox) =>
      _cacheId(_restrictionCachePrefix, bbox);

  static String _waterwayCacheId(BBox bbox) =>
      _cacheId(_waterwayCachePrefix, bbox);

  static String _cacheId(String prefix, BBox bbox) {
    return '${prefix}_${bbox.minLat.toStringAsFixed(6)}_'
        '${bbox.minLon.toStringAsFixed(6)}_'
        '${bbox.maxLat.toStringAsFixed(6)}_'
        '${bbox.maxLon.toStringAsFixed(6)}';
  }

  @override
  Future<void> saveFishingRestrictions(
    BBox bbox,
    List<FishingRestrictionDto> restrictions,
  ) async {
    final jsonList = restrictions.map((e) => e.toJson()).toList();
    await _saveToCache(restrictionCacheId(bbox), jsonList);
    Log.d(
      'FishingLocalDS: Saved ${restrictions.length} restrictions for $bbox',
    );
  }

  @override
  Future<List<FishingRestrictionDto>?> getFishingRestrictions({
    required BBox bbox,
    bool ignoreExpiry = false,
  }) async {
    // Deliberately never read the legacy unscoped fishing_restrictions row.
    final rawList = await _getFromCache(
      restrictionCacheId(bbox),
      ignoreExpiry ? null : _cacheValidity,
    );

    if (rawList == null) {
      Log.d('FishingLocalDS: Cache MISS for restrictions in $bbox');
      return null;
    }

    Log.d(
      'FishingLocalDS: Cache HIT for restrictions in $bbox (${rawList.length})',
    );
    return rawList.map(FishingRestrictionDto.fromJson).toList();
  }

  @override
  Future<List<FishingRestrictionDto>> loadFromAssets() async {
    try {
      Log.d('FishingLocalDS: Loading restrictions from assets...');
      final features = await AssetLoader.loadGeoJsonFeatures(
        'assets/data/fishing_restrictions.json.gz',
      );
      return features.expand(FishingRestrictionDto.fromGeoJsonList).toList();
    } catch (e, s) {
      Log.e('FishingLocalDataSource: Failed to load assets', e, s);
      return [];
    }
  }

  @override
  Future<void> saveWaterwayFeatures(
    BBox bbox,
    List<WaterwayFeatureDto> features,
  ) async {
    final jsonList = features.map((e) => e.toJson()).toList();
    await _saveToCache(_waterwayCacheId(bbox), jsonList);
    Log.d('FishingLocalDS: Saved ${features.length} waterways for $bbox');
  }

  @override
  Future<List<WaterwayFeatureDto>?> getWaterwayFeatures({
    required BBox bbox,
    bool ignoreExpiry = false,
  }) async {
    final rawList = await _getFromCache(
      _waterwayCacheId(bbox),
      ignoreExpiry ? null : _cacheValidity,
    );

    if (rawList == null) {
      Log.d('FishingLocalDS: Cache MISS for waterways in $bbox');
      return null;
    }

    Log.d(
      'FishingLocalDS: Cache HIT for waterways in $bbox (${rawList.length})',
    );
    return rawList.map(WaterwayFeatureDto.fromJson).toList();
  }
}
