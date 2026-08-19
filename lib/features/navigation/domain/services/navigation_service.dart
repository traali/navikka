import 'dart:math' as math;

import 'package:latlong2/latlong.dart';

/// Service for geodesic navigation calculations.
///
/// All methods are pure functions with no side effects,
/// making them suitable for use in isolates via `compute()`.
class NavigationService {
  const NavigationService();

  /// Earth's radius in meters.
  static const double _earthRadius = 6371000;

  /// Calculates the initial bearing from start to end point.
  ///
  /// Returns bearing in degrees (0-359).
  /// 0 = North, 90 = East, 180 = South, 270 = West.
  static double calculateBearing(LatLng from, LatLng to) {
    final lat1 = from.latitude * math.pi / 180;
    final lat2 = to.latitude * math.pi / 180;
    final dLon = (to.longitude - from.longitude) * math.pi / 180;

    final y = math.sin(dLon) * math.cos(lat2);
    final x =
        math.cos(lat1) * math.sin(lat2) -
        math.sin(lat1) * math.cos(lat2) * math.cos(dLon);

    final bearing = math.atan2(y, x) * 180 / math.pi;
    return (bearing + 360) % 360;
  }

  /// Calculates the great-circle distance between two points (meters).
  static double calculateDistance(LatLng from, LatLng to) {
    const distance = Distance();
    return distance.as(LengthUnit.Meter, from, to);
  }

  /// Calculates cross-track error: perpendicular distance from a point
  /// to the great-circle path between start and end.
  ///
  /// Returns distance in meters.
  /// Positive = point is to the right of the path.
  /// Negative = point is to the left of the path.
  static double calculateCrossTrackError(
    LatLng pathStart,
    LatLng pathEnd,
    LatLng point,
  ) {
    final lat1 = pathStart.latitude * math.pi / 180;
    final lat2 = pathEnd.latitude * math.pi / 180;
    final lat3 = point.latitude * math.pi / 180;

    final dLon13 = (point.longitude - pathStart.longitude) * math.pi / 180;
    final dLon12 = (pathEnd.longitude - pathStart.longitude) * math.pi / 180;

    // Angular distance from pathStart to point
    final delta13 = _angularDistance(pathStart, point);

    // Initial bearing from pathStart to point
    final bearing13 = math.atan2(
      math.sin(dLon13) * math.cos(lat3),
      math.cos(lat1) * math.sin(lat3) -
          math.sin(lat1) * math.cos(lat3) * math.cos(dLon13),
    );

    // Initial bearing from pathStart to pathEnd
    final bearing12 = math.atan2(
      math.sin(dLon12) * math.cos(lat2),
      math.cos(lat1) * math.sin(lat2) -
          math.sin(lat1) * math.cos(lat2) * math.cos(dLon12),
    );

    // Cross-track angular distance
    final xTrack = math.asin(
      math.sin(delta13) * math.sin(bearing13 - bearing12),
    );

    // Determine sign using bearing difference (standard navigation convention)
    // Positive = right of course (clockwise from path bearing)
    // Negative = left of course (counter-clockwise from path bearing)
    final sign = math.sin(bearing13 - bearing12) >= 0 ? 1.0 : -1.0;

    return xTrack.abs() * _earthRadius * sign;
  }

  /// Calculates the angular distance between two points (radians).
  static double _angularDistance(LatLng from, LatLng to) {
    final lat1 = from.latitude * math.pi / 180;
    final lat2 = to.latitude * math.pi / 180;
    final dLat = (to.latitude - from.latitude) * math.pi / 180;
    final dLon = (to.longitude - from.longitude) * math.pi / 180;

    final a =
        math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1) *
            math.cos(lat2) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    return 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  }

  /// Calculates ETA given distance and speed.
  ///
  /// Returns null if speed is 0 or negative.
  static DateTime? calculateETA({
    required double distanceMeters,
    required double speedKmh,
    DateTime? fromTime,
  }) {
    if (speedKmh < 0.1) return null;

    final distanceKm = distanceMeters / 1000;
    final hoursRemaining = distanceKm / speedKmh;
    if (hoursRemaining > 720) return null; // Cap at 30 days max ETA

    final duration = Duration(
      microseconds: (hoursRemaining * Duration.microsecondsPerHour).round(),
    );

    return (fromTime ?? DateTime.now()).add(duration);
  }

  /// Checks if a point is within arrival distance of a target.
  static bool isWithinArrivalDistance({
    required LatLng current,
    required LatLng target,
    double thresholdMeters = 50,
  }) {
    return calculateDistance(current, target) <= thresholdMeters;
  }

  /// Checks if a vessel has passed a waypoint by checking arrival or leg vector projection.
  static bool isPassedWaypoint({
    required LatLng current,
    required LatLng target,
    required LatLng previous,
    double arrivalThresholdMeters = 50,
  }) {
    if (isWithinArrivalDistance(
      current: current,
      target: target,
      thresholdMeters: arrivalThresholdMeters,
    )) {
      return true;
    }

    final legDx = target.longitude - previous.longitude;
    final legDy = target.latitude - previous.latitude;
    final posDx = current.longitude - target.longitude;
    final posDy = current.latitude - target.latitude;

    final dotProduct = (legDx * posDx) + (legDy * posDy);
    final distanceToTarget = calculateDistance(current, target);
    return dotProduct > 0 && distanceToTarget < 200;
  }

  /// Calculates the closest point on a line segment to a given point.
  ///
  /// Returns the closest point on the segment [start]-[end] to [point].
  /// Uses a planar approximation (sufficient for short distances).
  static LatLng closestPointOnSegment(
    LatLng start,
    LatLng end,
    LatLng point,
  ) {
    // Convert to approximate planar coordinates
    final midLat = (start.latitude + end.latitude) / 2 * math.pi / 180;
    final cosLat = math.cos(midLat);

    final sx = start.longitude * cosLat;
    final sy = start.latitude;
    final ex = end.longitude * cosLat;
    final ey = end.latitude;
    final px = point.longitude * cosLat;
    final py = point.latitude;

    // Vector from start to end
    final dx = ex - sx;
    final dy = ey - sy;

    // Length squared
    final lengthSq = dx * dx + dy * dy;
    if (lengthSq == 0) return start;

    // Projection factor (clamped to [0, 1])
    final t = ((px - sx) * dx + (py - sy) * dy) / lengthSq;
    final tClamped = t.clamp(0.0, 1.0);

    // Closest point
    final closestLat = sy + tClamped * dy;
    final closestLon = (sx + tClamped * dx) / cosLat;

    return LatLng(closestLat, closestLon);
  }

  /// Calculates progress fraction along a route given current position.
  ///
  /// Returns a value between 0.0 (start) and 1.0 (destination).
  /// Uses the closest point on the route to estimate progress.
  static double calculateProgressFraction({
    required List<LatLng> waypoints,
    required LatLng currentPosition,
  }) {
    if (waypoints.length < 2) return 0;

    // Find the closest segment and point on route
    double minDistance = double.infinity;
    int closestSegmentIndex = 0;
    double closestSegmentProgress = 0;

    double totalDistance = 0;
    double distanceTraveled = 0;

    for (var i = 0; i < waypoints.length - 1; i++) {
      final start = waypoints[i];
      final end = waypoints[i + 1];
      final segmentLength = calculateDistance(start, end);
      totalDistance += segmentLength;

      final closest = closestPointOnSegment(start, end, currentPosition);
      final distToSegment = calculateDistance(currentPosition, closest);

      if (distToSegment < minDistance) {
        minDistance = distToSegment;
        closestSegmentIndex = i;

        // Progress along this segment
        final segmentProgress = segmentLength > 0
            ? calculateDistance(start, closest) / segmentLength
            : 0.0;
        closestSegmentProgress = segmentProgress;
      }
    }

    // Calculate distance traveled up to closest segment
    for (var i = 0; i < closestSegmentIndex; i++) {
      distanceTraveled += calculateDistance(waypoints[i], waypoints[i + 1]);
    }

    // Add progress along current segment
    final currentSegmentLength = calculateDistance(
      waypoints[closestSegmentIndex],
      waypoints[closestSegmentIndex + 1],
    );
    distanceTraveled += currentSegmentLength * closestSegmentProgress;

    return totalDistance > 0 ? distanceTraveled / totalDistance : 0;
  }
}
