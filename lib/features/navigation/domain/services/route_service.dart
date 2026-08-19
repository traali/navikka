import 'dart:math';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/services/geometry_utils.dart';
import 'package:sakkoja/features/fishing/domain/entities/fishing_restriction.dart';
import 'package:sakkoja/features/navigation/domain/entities/waypoint_entity.dart';
import 'package:sakkoja/features/navigation/domain/repositories/navigation_repository.dart';

import 'package:sakkoja/features/speed_limits/domain/repositories/speed_limit_repository.dart';

class RouteService {
  RouteService(this._repository, this._speedLimitRepository);
  final NavigationRepository _repository;
  final SpeedLimitRepository _speedLimitRepository;

  /// Calculate the total distance of a route (in meters) based on waypoints.
  double calculateTotalDistance(List<WaypointEntity> waypoints) {
    if (waypoints.length < 2) return 0;

    var totalDistance = 0.0;
    for (var i = 0; i < waypoints.length - 1; i++) {
      totalDistance +=
          GeometryUtils.distanceInKm(
            LatLng(waypoints[i].lat, waypoints[i].lon),
            LatLng(waypoints[i + 1].lat, waypoints[i + 1].lon),
          ) *
          1000;
    }
    return totalDistance;
  }

  /// Calculate Enhanced Statistics for a route.
  /// This takes into account the vessel's cruising speed and
  /// real-world speed limits.
  Future<RouteStats> calculateEnhancedStats({
    required List<WaypointEntity> waypoints,
    required double cruisingSpeedKmh,
  }) async {
    if (waypoints.length < 2) {
      return const RouteStats(totalDistanceMeters: 0, totalDurationMinutes: 0);
    }

    // 1. Fetch all speed limits for cross-referencing
    final limitsResult = await _speedLimitRepository.getSpeedLimits();
    final allLimits = limitsResult.getOrElse((_) => []);

    // PERFORMANCE: Moving calculation to static method for future compute() usage
    // For now, we call it directly, but the structure is ready.
    return _calculateEnhancedStatsSync(
      waypoints: waypoints,
      cruisingSpeedKmh: cruisingSpeedKmh,
      allLimits: allLimits,
    );
  }

  /// Internal synchronous calculation logic
  static RouteStats _calculateEnhancedStatsSync({
    required List<WaypointEntity> waypoints,
    required double cruisingSpeedKmh,
    required List<dynamic>
    allLimits, // Use dynamic to avoid import complexity in isolate
  }) {
    double totalDistanceMeters = 0;
    double totalDurationSeconds = 0;

    final segments = <RouteSegment>[];

    for (var i = 0; i < waypoints.length - 1; i++) {
      final start = LatLng(waypoints[i].lat, waypoints[i].lon);
      final end = LatLng(waypoints[i + 1].lat, waypoints[i + 1].lon);

      final segmentDistanceKm = GeometryUtils.distanceInKm(start, end);
      final segmentDistanceMeters = segmentDistanceKm * 1000;
      totalDistanceMeters += segmentDistanceMeters;

      final midpoint = LatLng(
        (start.latitude + end.latitude) / 2,
        (start.longitude + end.longitude) / 2,
      );

      var effectiveSpeedKmh = cruisingSpeedKmh;
      int? zoneLimit;

      // FIX #166: Check start, midpoint, and end to catch segments
      // that pass through narrow zones without midpoint touching.
      final checkPoints = [start, midpoint, end];
      for (final zone in allLimits) {
        final ring = zone.rings.first as List<LatLng>;
        for (final point in checkPoints) {
          if (GeometryUtils.isPointInPolygon(point, ring)) {
            final limit = zone.speedLimitKmh as int?;
            if (limit != null) {
              zoneLimit = limit;
              effectiveSpeedKmh = min(cruisingSpeedKmh, limit.toDouble());
            }
            break;
          }
        }
        if (zoneLimit != null) break;
      }

      final isOverSpeed = zoneLimit != null && cruisingSpeedKmh > zoneLimit;

      segments.add(
        RouteSegment(
          points: [start, end],
          isOverSpeed: isOverSpeed,
          speedLimitKmh: zoneLimit,
        ),
      );

      if (effectiveSpeedKmh > 0) {
        final speedMps = effectiveSpeedKmh / 3.6;
        totalDurationSeconds += segmentDistanceMeters / speedMps;
      }
    }

    return RouteStats(
      totalDistanceMeters: totalDistanceMeters,
      totalDurationMinutes: (totalDurationSeconds / 60).round(),
      segments: segments,
    );
  }

  /// Legacy ETA calculation for backward compatibility
  int calculateETA(double distanceMeters, double sogKnots) {
    if (sogKnots <= 0) return 0;
    final speedMps = sogKnots * 0.514444; // Knots to m/s
    final seconds = distanceMeters / speedMps;
    return (seconds / 60).round();
  }

  /// Create a new route, auto-calculating its distance.
  Future<int> createRoute(String name, List<WaypointEntity> waypoints) async {
    final id = await _repository.createRoute(name, waypoints);
    final distance = calculateTotalDistance(waypoints);

    final createdRoute = await _repository.getRouteById(id);
    if (createdRoute != null) {
      await _repository.updateRoute(
        createdRoute.copyWith(totalDistanceMeters: distance),
      );
    }

    return id;
  }
}

/// Parameters for background conflict detection
class ConflictParams {
  ConflictParams({required this.waypoints, required this.restrictions});
  final List<WaypointEntity> waypoints;
  final List<FishingRestriction> restrictions;
}

class RouteStats {
  const RouteStats({
    required this.totalDistanceMeters,
    required this.totalDurationMinutes,
    this.segments = const [],
  });

  final double totalDistanceMeters;
  final int totalDurationMinutes;
  final List<RouteSegment> segments;
}

class RouteSegment {
  const RouteSegment({
    required this.points,
    required this.isOverSpeed,
    required this.speedLimitKmh,
  });

  final List<LatLng> points;
  final bool isOverSpeed;
  final int? speedLimitKmh;
}
