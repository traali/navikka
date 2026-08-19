import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sakkoja/core/constants/navigation_aids_constants.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/core/utils/asset_loader.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/navigation_aids/data/models/fairway_area_dto.dart';
import 'package:sakkoja/features/navigation_aids/data/models/navigation_aid_dto.dart';
import 'package:sakkoja/features/navigation_aids/data/models/navigation_line_dto.dart';

/// Local data source for navigation aids with Drift caching (via CachedFeatures).
abstract class NavigationAidsLocalDataSource {
  // Fairway Areas
  Future<void> saveFairwayAreas(List<FairwayAreaDto> areas);
  Future<List<FairwayAreaDto>?> getFairwayAreas({bool ignoreExpiry = false});
  Future<List<FairwayAreaDto>> loadFairwayAreasFromAssets();

  // Navigation Aids
  Future<void> saveNavigationAids(List<NavigationAidDto> aids);
  Future<List<NavigationAidDto>?> getNavigationAids({
    bool ignoreExpiry = false,
  });
  Future<List<NavigationAidDto>> loadNavigationAidsFromAssets();

  // Navigation Lines
  Future<void> saveNavigationLines(List<NavigationLineDto> lines);
  Future<List<NavigationLineDto>?> getNavigationLines({
    bool ignoreExpiry = false,
  });
  Future<List<NavigationLineDto>> loadNavigationLinesFromAssets();
}

class NavigationAidsLocalDataSourceImpl
    implements NavigationAidsLocalDataSource {
  NavigationAidsLocalDataSourceImpl(this._db);
  final AppDatabase _db;

  // ---------------------------------------------------------------------------
  // Generic Helpers (Drift)
  // ---------------------------------------------------------------------------

  Future<void> _saveToCache(
    String id,
    String category,
    List<Map<String, dynamic>> jsonList,
  ) async {
    final jsonStr = await compute(jsonEncode, jsonList);
    await _db
        .into(_db.cachedFeatures)
        .insertOnConflictUpdate(
          CachedFeaturesCompanion.insert(
            id: id,
            category: category,
            cachedAt: DateTime.now(),
            dataJson: jsonStr,
          ),
        );
  }

  Future<List<Map<String, dynamic>>?> _getFromCache(
    String id,
    String category,
    Duration? maxAge,
  ) async {
    final row =
        await (_db.select(_db.cachedFeatures)
              ..where((t) => t.id.equals(id))
              ..where((t) => t.category.equals(category)))
            .getSingleOrNull();

    if (row == null) return null;

    if (maxAge != null) {
      final now = DateTime.now();
      if (now.difference(row.cachedAt) > maxAge) {
        return null; // Expired
      }
    }

    return compute(_decodeJsonList, row.dataJson);
  }

  static List<Map<String, dynamic>> _decodeJsonList(String jsonStr) {
    return (jsonDecode(jsonStr) as List).cast<Map<String, dynamic>>();
  }

  // ---------------------------------------------------------------------------
  // Fairway Areas
  // ---------------------------------------------------------------------------

  @override
  Future<void> saveFairwayAreas(List<FairwayAreaDto> areas) async {
    final jsonList = areas.map((e) => e.toJson()).toList();
    await _saveToCache('fairway_areas', 'navigation_aids', jsonList);
    Log.d('NavAidsLocalDS: Saved ${areas.length} fairway areas');
  }

  @override
  Future<List<FairwayAreaDto>?> getFairwayAreas({
    bool ignoreExpiry = false,
  }) async {
    final rawList = await _getFromCache(
      'fairway_areas',
      'navigation_aids',
      ignoreExpiry ? null : NavigationAidsConstants.cacheValidity,
    );

    if (rawList == null) {
      Log.d('NavAidsLocalDS: Cache MISS for fairway areas');
      return null;
    }

    Log.d('NavAidsLocalDS: Cache HIT for fairway areas (${rawList.length})');
    return rawList.map(FairwayAreaDto.fromJson).toList();
  }

  @override
  Future<List<FairwayAreaDto>> loadFairwayAreasFromAssets() async {
    try {
      Log.d('NavAidsLocalDS: Loading fairway areas from assets...');
      final features = await AssetLoader.loadGeoJsonFeatures(
        'assets/data/navigation_aids/fairway_areas.json.gz',
      );
      return features.map(FairwayAreaDto.fromGeoJson).toList();
    } catch (e, s) {
      Log.w('NavigationAidsLocalDataSource: No bundled fairway areas', e, s);
      return [];
    }
  }

  // ---------------------------------------------------------------------------
  // Navigation Aids
  // ---------------------------------------------------------------------------

  @override
  Future<void> saveNavigationAids(List<NavigationAidDto> aids) async {
    final trafficSigns = aids
        .where((a) => a.type.name == 'trafficSign')
        .toList();
    final safetyEquipment = aids
        .where((a) => a.type.name == 'safetyEquipment')
        .toList();
    final lighthouses = aids.where((a) => a.type.name == 'lighthouse').toList();

    await _saveToCache(
      NavigationAidsConstants.storeTrafficSigns,
      'navigation_aids',
      trafficSigns.map((e) => e.toJson()).toList(),
    );
    await _saveToCache(
      NavigationAidsConstants.storeSafetyEquipment,
      'navigation_aids',
      safetyEquipment.map((e) => e.toJson()).toList(),
    );
    await _saveToCache(
      NavigationAidsConstants.storeLighthouses,
      'navigation_aids',
      lighthouses.map((e) => e.toJson()).toList(),
    );

    Log.d('NavAidsLocalDS: Saved ${aids.length} navigation aids');
  }

  @override
  Future<List<NavigationAidDto>?> getNavigationAids({
    bool ignoreExpiry = false,
  }) async {
    final allAids = <NavigationAidDto>[];
    final storeNames = [
      NavigationAidsConstants.storeTrafficSigns,
      NavigationAidsConstants.storeSafetyEquipment,
      NavigationAidsConstants.storeLighthouses,
    ];

    for (final storeName in storeNames) {
      final rawList = await _getFromCache(
        storeName,
        'navigation_aids',
        ignoreExpiry ? null : NavigationAidsConstants.cacheValidity,
      );

      if (rawList != null) {
        allAids.addAll(rawList.map(NavigationAidDto.fromJson));
      }
    }

    if (allAids.isNotEmpty) {
      Log.d('NavAidsLocalDS: Cache HIT for nav aids (${allAids.length})');
      return allAids;
    } else {
      Log.d('NavAidsLocalDS: Cache MISS for nav aids');
      return null;
    }
  }

  @override
  Future<List<NavigationAidDto>> loadNavigationAidsFromAssets() async {
    Log.d('NavAidsLocalDS: Loading navigation aids from assets...');
    final allAids = <NavigationAidDto>[];

    final assetConfigs = [
      ('assets/data/navigation_aids/traffic_signs.json.gz', 'trafficSign'),
      (
        'assets/data/navigation_aids/safety_equipment.json.gz',
        'safetyEquipment',
      ),
      ('assets/data/navigation_aids/lighthouses.json.gz', 'lighthouse'),
    ];

    for (final (assetPath, typeName) in assetConfigs) {
      try {
        final features = await AssetLoader.loadGeoJsonFeatures(assetPath);
        final aids = features.map((f) {
          switch (typeName) {
            case 'trafficSign':
              return NavigationAidDto.fromTrafficSignGeoJson(f);
            case 'lighthouse':
              return NavigationAidDto.fromLighthouseGeoJson(f);
            default:
              return NavigationAidDto.fromSafetyEquipmentGeoJson(f);
          }
        });
        allAids.addAll(aids);
      } catch (e) {
        // Expected during dev if files missing
      }
    }

    return allAids;
  }

  // ---------------------------------------------------------------------------
  // Navigation Lines
  // ---------------------------------------------------------------------------

  @override
  Future<void> saveNavigationLines(List<NavigationLineDto> lines) async {
    final jsonList = lines.map((e) => e.toJson()).toList();
    await _saveToCache(
      NavigationAidsConstants.storeNavigationLines,
      'navigation_aids',
      jsonList,
    );
    Log.d('NavAidsLocalDS: Saved ${lines.length} navigation lines');
  }

  @override
  Future<List<NavigationLineDto>?> getNavigationLines({
    bool ignoreExpiry = false,
  }) async {
    final rawList = await _getFromCache(
      NavigationAidsConstants.storeNavigationLines,
      'navigation_aids',
      ignoreExpiry ? null : NavigationAidsConstants.cacheValidity,
    );

    if (rawList == null) {
      Log.d('NavAidsLocalDS: Cache MISS for navigation lines');
      return null;
    }

    Log.d('NavAidsLocalDS: Cache HIT for navigation lines (${rawList.length})');
    return rawList.map(NavigationLineDto.fromJson).toList();
  }

  @override
  Future<List<NavigationLineDto>> loadNavigationLinesFromAssets() async {
    try {
      Log.d('NavAidsLocalDS: Loading navigation lines from assets...');
      final features = await AssetLoader.loadGeoJsonFeatures(
        'assets/data/navigation_aids/navigation_lines.json.gz',
      );
      return features.map(NavigationLineDto.fromGeoJson).toList();
    } catch (e, s) {
      Log.w('NavigationAidsLocalDataSource: No bundled navigation lines', e, s);
      return [];
    }
  }
}
