import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/services/geometry_utils.dart';
import 'package:sakkoja/features/map/presentation/providers/layer_filter_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';
import 'package:sakkoja/features/speed_limits/presentation/providers/speed_limit_provider.dart';

part 'displayed_speed_limits_provider.g.dart';

/// efficiently filters speed limits for the current map viewport
@riverpod
List<SpeedLimitZone> displayedSpeedLimits(Ref ref) {
  // Bundled data is the source of truth for speed-limit rendering. Do not
  // replace it with a per-GPS bbox subset while the camera may show a wider
  // viewport.
  final zonesAsync = ref.watch(speedLimitsProvider);

  // Propagate error if underlying provider failed
  if (zonesAsync.hasError) {
    throw zonesAsync.error!;
  }

  // Return empty while loading
  if (!zonesAsync.hasValue) return [];
  final allZones = zonesAsync.value;
  if (allZones == null) return [];

  // 2. Watch camera position (center & zoom)
  // PERFORMANCE: Only watch significant moves to prevent hammering
  final cameraParams = ref.watch(debouncedMapCameraPositionProvider);

  // OPTIMIZATION: Hide details at low zoom levels to save performance and prevent map clutter
  if (cameraParams.zoom < 12.0) {
    return [];
  }

  // 3. Create Viewport BBox with buffer
  // 30km buffer ensures smooth panning without pop-in
  final viewportBBox = GeometryUtils.createBoundingBoxFromRadius(
    cameraParams.center,
    30,
  );

  // 4. Watch layer filter
  final layerFilterAsync = ref.watch(layerFilterProvider);
  final layerFilter = layerFilterAsync.value ?? LayerFilterState.initial();

  // 5. Filter List
  return allZones.where((zone) {
    // Spatial Check: Fast AABB overlap
    // Spatial Check: Fast AABB overlap
    if (!zone.boundingBox.overlaps(viewportBBox)) {
      return false;
    }

    // Layer Visibility Check
    var isVisible = layerFilter.isVisible(zone.typeDescription);

    // Hybrid Filtering Rule (legacy support)
    if (!isVisible &&
        zone.speedLimitKmh > 0 &&
        layerFilter.isVisible('Nopeusrajoitus')) {
      isVisible = true;
    }

    return isVisible;
  }).toList();
}
