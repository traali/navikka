import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/constants/map_constants.dart';
import 'package:sakkoja/core/models/bbox.dart';
import 'package:sakkoja/core/services/geometry_utils.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';

class SpatialResult {
  const SpatialResult({required this.visibleZones, this.activeZone});

  const SpatialResult.empty() : activeZone = null, visibleZones = const [];
  final SpeedLimitZone? activeZone;
  final List<SpeedLimitZone> visibleZones;
}

class ZoneSpatialService {
  ZoneSpatialService();

  /// Standard synchronous calculation (heavy).
  /// Used inside Isolate on Native.
  SpatialResult calculateSpatialState({
    required LatLng userLocation,
    required List<SpeedLimitZone> allZones,
    double visibleRadiusKm = 5.0,
  }) {
    if (allZones.isEmpty) {
      return const SpatialResult.empty();
    }

    // 1. Filter zones within visible/collision BBox bounds (broad phase)
    final visibleZones = <SpeedLimitZone>[];
    final nearbyForActiveCheck = <SpeedLimitZone>[];

    const collisionRadiusKm = MapConstants.collisionCheckRadiusKm;
    final visibleBBox = BBox.fromCenter(userLocation, visibleRadiusKm);
    final collisionBBox = BBox.fromCenter(userLocation, collisionRadiusKm);

    for (final zone in allZones) {
      if (zone.boundingBox.overlaps(visibleBBox)) {
        visibleZones.add(zone);
      }

      if (zone.boundingBox.overlaps(collisionBBox)) {
        nearbyForActiveCheck.add(zone);
      }
    }

    // 2. Find active zone (narrow phase - point in polygon)
    final activeZone = _findActiveZone(userLocation, nearbyForActiveCheck);

    return SpatialResult(activeZone: activeZone, visibleZones: visibleZones);
  }

  /// Optimized calculation that switches strategy based on platform.
  /// - Native: Spawns an Isolate via compute().
  /// - Web: Runs on main thread but chunked (time-sliced) to avoid blocking.
  Future<SpatialResult> calculateOptimized({
    required LatLng userLocation,
    required List<SpeedLimitZone> allZones,
    double visibleRadiusKm = 5.0,
  }) async {
    if (allZones.isEmpty) return const SpatialResult.empty();

    if (kIsWeb) {
      // WEB: Run chunked on main thread
      return _calculateChunked(
        userLocation: userLocation,
        allZones: allZones,
        visibleRadiusKm: visibleRadiusKm,
      );
    } else {
      // NATIVE: Run in background isolate
      return compute(
        _isolateEntryPoint,
        _IsolateData(userLocation, allZones, visibleRadiusKm),
      );
    }
  }

  /// Chunked implementation for Web to prevent UI freeze
  Future<SpatialResult> _calculateChunked({
    required LatLng userLocation,
    required List<SpeedLimitZone> allZones,
    required double visibleRadiusKm,
  }) async {
    final visibleZones = <SpeedLimitZone>[];
    final nearbyForActiveCheck = <SpeedLimitZone>[];
    const collisionRadiusKm = MapConstants.collisionCheckRadiusKm;
    final visibleBBox = BBox.fromCenter(userLocation, visibleRadiusKm);
    final collisionBBox = BBox.fromCenter(userLocation, collisionRadiusKm);
    const chunkSize = 500;

    // Process in chunks
    for (var i = 0; i < allZones.length; i += chunkSize) {
      final end = (i + chunkSize < allZones.length)
          ? i + chunkSize
          : allZones.length;
      final chunk = allZones.sublist(i, end);

      for (final zone in chunk) {
        if (zone.boundingBox.overlaps(visibleBBox)) {
          visibleZones.add(zone);
        }

        if (zone.boundingBox.overlaps(collisionBBox)) {
          nearbyForActiveCheck.add(zone);
        }
      }

      // Yield to event loop to allow UI updates
      if (allZones.length > chunkSize) {
        await Future<void>.delayed(const Duration(milliseconds: 50));
      }
    }

    // Narrow phase (usually fast enough to run sync as 'nearby' count is low)
    final activeZone = _findActiveZone(userLocation, nearbyForActiveCheck);

    return SpatialResult(activeZone: activeZone, visibleZones: visibleZones);
  }

  SpeedLimitZone? _findActiveZone(
    LatLng userLocation,
    List<SpeedLimitZone> nearbyZones,
  ) {
    if (nearbyZones.isEmpty) return null;

    final matchingZones = <SpeedLimitZone>[];

    for (final zone in nearbyZones) {
      // Check outer ring
      if (zone.rings.isNotEmpty &&
          GeometryUtils.isPointInPolygon(userLocation, zone.rings.first)) {
        // Check holes
        var inHole = false;
        if (zone.rings.length > 1) {
          for (var i = 1; i < zone.rings.length; i++) {
            if (GeometryUtils.isPointInPolygon(userLocation, zone.rings[i])) {
              inHole = true;
              break;
            }
          }
        }

        if (!inHole) {
          matchingZones.add(zone);
        }
      }
    }

    if (matchingZones.isNotEmpty) {
      try {
        return matchingZones.firstWhere((z) => z.speedLimitKmh > 0);
      } catch (_) {
        return matchingZones.first;
      }
    }
    return null;
  }
}

// === Isolate Helpers ===

class _IsolateData {
  _IsolateData(this.userLocation, this.zones, this.visibleRadiusKm);
  final LatLng userLocation;
  final List<SpeedLimitZone> zones;
  final double visibleRadiusKm;
}

SpatialResult _isolateEntryPoint(_IsolateData data) {
  // Re-instantiate service inside isolate (must be stateless/pure dependencies)
  final service = ZoneSpatialService();
  return service.calculateSpatialState(
    userLocation: data.userLocation,
    allZones: data.zones,
    visibleRadiusKm: data.visibleRadiusKm,
  );
}
