import 'package:latlong2/latlong.dart';
import 'package:riverpod/riverpod.dart' as rp;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/services/geometry_utils.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/fishing/di/fishing_di.dart';
import 'package:sakkoja/features/fishing/domain/entities/fishing_restriction.dart';
import 'package:sakkoja/features/fishing/domain/entities/waterway_feature.dart';
import 'package:sakkoja/features/fishing/domain/usecases/get_fishing_restrictions.dart';
import 'package:sakkoja/features/fishing/domain/usecases/get_waterway_features.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_mode_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/speed_limits/presentation/providers/bbox_fetch_throttle_provider.dart';

part 'fishing_data_providers.g.dart';

/// Narrow watch-point for a fresh boat GPS fix, avoiding full [mapProvider]
/// rebuilds in consumers like [currentLocationRestrictions].
@riverpod
({bool hasLocation, LatLng? userLocation}) currentUserLocation(Ref ref) {
  final mapState = ref.watch(
    mapProvider.select(
      (state) => (
        isLocationFresh: state.isLocationFresh,
        userLocation: state.userLocation,
      ),
    ),
  );
  return (
    hasLocation: mapState.isLocationFresh,
    userLocation: mapState.userLocation,
  );
}

/// Stable API request key for restrictions around the boat.
@riverpod
String? currentBoatSafetyTile(Ref ref) {
  final location = ref.watch(currentUserLocationProvider);
  if (!location.hasLocation || location.userLocation == null) return null;
  return GeometryUtils.getTileId(location.userLocation!);
}

/// Provider for GetFishingRestrictions UseCase
@riverpod
GetFishingRestrictions getFishingRestrictions(Ref ref) =>
    GetFishingRestrictions(ref.watch(fishingRepositoryProvider));

/// Provider for GetWaterwayFeatures UseCase
@riverpod
GetWaterwayFeatures getWaterwayFeatures(Ref ref) =>
    GetWaterwayFeatures(ref.watch(fishingRepositoryProvider));

/// Restriction data around the boat's fresh GPS location.
///
/// This deliberately has no dependency on the map camera, fishing mode, or
/// presentation filters. It drives safety checks, not map rendering.
final boatSafetyFishingRestrictionsProvider =
    rp.FutureProvider<List<FishingRestriction>>((ref) async {
      final tileId = ref.watch(currentBoatSafetyTileProvider);
      if (tileId == null) return const [];

      final tileBBox = GeometryUtils.getTileBBox(tileId);
      const latSize = 0.1;
      const lngSize = 0.2;
      final result = await ref.read(getFishingRestrictionsProvider)(
        minLat: tileBBox.minLat - latSize,
        minLng: tileBBox.minLon - lngSize,
        maxLat: tileBBox.maxLat + latSize,
        maxLng: tileBBox.maxLon + lngSize,
      );

      return result.fold(
        (failure) => throw StateError(
          'BoatSafetyFishingRestrictions: Fetch failed: ${failure.message}',
        ),
        (restrictions) => restrictions,
      );
    });

@riverpod
class HybridFishingRestrictions extends _$HybridFishingRestrictions {
  var _fetchGeneration = 0;

  @override
  Future<List<FishingRestriction>> build() async {
    final fetchGeneration = ++_fetchGeneration;
    final cameraState = ref.watch(debouncedMapCameraPositionProvider);

    if (cameraState.zoom < 9.0) {
      return state.value ?? [];
    }

    final throttle = ref.read(bboxFetchThrottleProvider.notifier);

    // Check throttle FIRST
    if (!throttle.shouldFetch(cameraState.center, key: 'fishing')) {
      return state.value ?? [];
    }

    try {
      final tileId = GeometryUtils.getTileId(cameraState.center);
      final tileBBox = GeometryUtils.getTileBBox(tileId);

      // Grid fetch (3x3)
      const latSize = 0.1;
      const lngSize = 0.2;

      final result = await ref.read(getFishingRestrictionsProvider)(
        minLat: tileBBox.minLat - latSize,
        minLng: tileBBox.minLon - lngSize,
        maxLat: tileBBox.maxLat + latSize,
        maxLng: tileBBox.maxLon + lngSize,
      );

      if (fetchGeneration != _fetchGeneration) return state.value ?? const [];

      return result.fold(
        (failure) => throw StateError(
          'HybridFishingRestrictions: Fetch failed: ${failure.message}',
        ),
        (restrictions) {
          throttle.markFetched(cameraState.center, key: 'fishing');
          Log.d(
            'HybridFishingRestrictions: Fetched ${restrictions.length} items',
          );
          return restrictions;
        },
      );
    } catch (e, s) {
      Log.e('HybridFishingRestrictions: Exception', e, s);
      if (fetchGeneration != _fetchGeneration) return state.value ?? const [];
      rethrow;
    }
  }

  void retry() => ref.invalidateSelf();
}

@riverpod
class HiddenRestrictionTypes extends _$HiddenRestrictionTypes {
  @override
  Set<String> build() => {};

  void toggleType(String type) {
    if (state.contains(type)) {
      state = {...state}..remove(type);
    } else {
      state = {...state, type};
    }
  }
}

@riverpod
Future<List<FishingRestriction>> filteredFishingRestrictions(Ref ref) async {
  final restrictions = await ref.watch(
    hybridFishingRestrictionsProvider.future,
  );

  final fishingModeAsync = ref.watch(fishingModeControllerProvider);
  final fishingMode = fishingModeAsync.value;
  final isFishingMode = fishingMode?.isEnabled ?? false;

  // CRITICAL FIX: If fishing mode is disabled, don't show fishing polygons
  if (!isFishingMode || fishingMode == null) return [];

  if (restrictions.isNotEmpty) {
    Log.i('Filtering ${restrictions.length} restrictions (Fishing Mode: ON)');
    final laajalahti = restrictions.where(
      (r) => r.title.contains('Laajalahti'),
    );
    if (laajalahti.isNotEmpty) {
      Log.i(
        'DEBUG: Found Laajalahti restrictions: ${laajalahti.map((r) => r.id).toList()}',
      );
    }
  }
  final hasSelectedCategoryInRestrictions =
      fishingMode.selectedCategory == null ||
      restrictions.any((r) => r.category == fishingMode.selectedCategory);

  return restrictions.where((r) {
    // 1. Critical Base: Always show Nature Reserves and general bans if Fishing Mode is ON
    // This satisfies the "Maarinlahti must always show" requirement.
    if (r.category == 'Luonnonsuojelualue' || r.category == 'Kalastuskielto') {
      return true;
    }
    // 2. Category Filter
    // If showAllCategories is true, we ignore the selectedCategory filter.
    if (!fishingMode.showAllCategories) {
      if (!hasSelectedCategoryInRestrictions ||
          (fishingMode.selectedCategory != null &&
              r.category != fishingMode.selectedCategory)) {
        return false;
      }
    }

    // 3. Active Status Filter
    // In fishing mode, show all relevant restrictions so users see year-round rules, mesh sizes, and reserves
    if (fishingMode.onlyActive && !fishingMode.showInactive) {
      final validity = r.validity?.toLowerCase() ?? '';
      final isYearRound =
          validity.isEmpty ||
          validity.contains('toistaiseksi') ||
          validity.contains('koko vuosi') ||
          validity.contains('ympäri');
      if (!r.isCurrentlyActive && !isYearRound) {
        return false;
      }
    }

    return true;
  }).toList();
}

@riverpod
Future<List<String>> availableRestrictionTypes(Ref ref) async {
  final restrictions = await ref.watch(
    hybridFishingRestrictionsProvider.future,
  );
  final categories = restrictions.map((r) => r.category).toSet().toList()
    ..sort();
  Log.d(
    'availableRestrictionTypes: ${restrictions.length} items -> ${categories.length} categories: $categories',
  );
  return categories;
}

@riverpod
class HybridWaterwayFeatures extends _$HybridWaterwayFeatures {
  var _fetchGeneration = 0;

  @override
  Future<List<WaterwayFeature>> build() async {
    final fetchGeneration = ++_fetchGeneration;
    final cameraState = ref.watch(debouncedMapCameraPositionProvider);

    if (cameraState.zoom < 11.0) {
      return state.value ?? [];
    }

    final throttle = ref.read(bboxFetchThrottleProvider.notifier);

    // Check throttle FIRST
    if (!throttle.shouldFetch(cameraState.center, key: 'waterway')) {
      return state.value ?? [];
    }

    try {
      final tileId = GeometryUtils.getTileId(cameraState.center);
      final tileBBox = GeometryUtils.getTileBBox(tileId);

      // Grid fetch (3x3)
      const latSize = 0.1;
      const lngSize = 0.2;

      final result = await ref.read(getWaterwayFeaturesProvider)(
        minLat: tileBBox.minLat - latSize,
        minLng: tileBBox.minLon - lngSize,
        maxLat: tileBBox.maxLat + latSize,
        maxLng: tileBBox.maxLon + lngSize,
      );

      if (fetchGeneration != _fetchGeneration) return state.value ?? const [];

      return result.fold(
        (failure) => throw StateError(
          'HybridWaterwayFeatures: Fetch failed: ${failure.message}',
        ),
        (features) {
          throttle.markFetched(cameraState.center, key: 'waterway');
          Log.d('HybridWaterwayFeatures: Fetched ${features.length} features');
          return features;
        },
      );
    } catch (e, s) {
      Log.e('HybridWaterwayFeatures: Exception', e, s);
      if (fetchGeneration != _fetchGeneration) return state.value ?? const [];
      rethrow;
    }
  }

  void retry() => ref.invalidateSelf();
}

/// Synchronous provider for waterway features (fairways, beacons, buoys)
/// to eliminate UI flicker during map panning.
@riverpod
List<WaterwayFeature> displayedWaterwayFeatures(Ref ref) {
  // Watch the async provider but only use the data (value)
  // This ensures the UI always has the last known good data even during refreshes
  final features = ref.watch(hybridWaterwayFeaturesProvider).value ?? [];

  // Currently we render all features in the 3x3 grid around camera
  // GPU handles culling, so no complex logic needed here yet.
  return features;
}

/// Synchronous provider for fishing restrictions ready for display.
///
/// This replaces the async [visibleFishingRestrictionsProvider] to eliminate
/// UI flicker during map camera movements.
@riverpod
List<FishingRestriction> displayedFishingRestrictions(Ref ref) {
  // Get filtered restrictions synchronously from cache
  // The .value will be null only on very first frame, which is acceptable
  final restrictions =
      ref.watch(filteredFishingRestrictionsProvider).value ?? [];

  // Watch camera for viewport-aware culling
  // PERFORMANCE: Only watch significant moves to prevent hammering
  final camera = ref.watch(debouncedMapCameraPositionProvider);

  // Calculate viewport bounding box with LARGER buffer (30km)
  // This prevents "pop-in" at screen edges during panning
  final viewportBBox = GeometryUtils.createBoundingBoxFromRadius(
    camera.center,
    30, // Increased from 15km to 30km for smoother UX
  );

  // Sync BBox filter - very fast for 2000 items with pre-computed BBox
  final visible = restrictions.where((r) {
    if (r.boundingBox == null) return true;
    return r.boundingBox!.overlaps(viewportBBox);
  }).toList();

  return visible;
}

/// Provider that returns restrictions covering the current user location.
@riverpod
List<FishingRestriction> currentLocationRestrictions(Ref ref) {
  final restrictions =
      ref.watch(boatSafetyFishingRestrictionsProvider).value ?? const [];
  final location = ref.watch(currentUserLocationProvider);

  final hasLocation = location.hasLocation;
  if (!hasLocation) return [];

  final userLoc = location.userLocation!;
  final hits = <FishingRestriction>[];

  for (final restriction in restrictions) {
    if (restriction.boundingBox != null &&
        !restriction.boundingBox!.contains(
          lat: userLoc.latitude,
          lon: userLoc.longitude,
        )) {
      continue;
    }

    for (final ring in restriction.rings) {
      if (GeometryUtils.isPointInPolygon(userLoc, ring)) {
        hits.add(restriction);
        break;
      }
    }
  }

  return hits;
}
