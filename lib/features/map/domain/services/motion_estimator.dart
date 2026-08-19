import 'dart:math' as math;

import 'package:latlong2/latlong.dart';

/// Motion derived from consecutive browser location samples.
class MotionEstimate {
  const MotionEstimate({required this.speedKmh, required this.heading});

  final double speedKmh;
  final double heading;
}

/// Provides a stable fallback when a web browser omits movement metadata.
///
/// Browser geolocation represents unavailable speed and heading as zero in
/// geolocator. The estimator only accepts movement larger than the reported
/// accuracy (with a 3 m floor), so stationary GPS drift does not rotate or
/// accelerate the navigation UI.
class MotionEstimator {
  static const double defaultMaximumDerivedSpeedKmh = 120;

  MotionEstimator({
    this.minimumDistanceMeters = 3,
    this.maximumDerivedSpeedKmh = defaultMaximumDerivedSpeedKmh,
  }) : assert(
         maximumDerivedSpeedKmh > 0,
         'maximumDerivedSpeedKmh must be positive',
       );

  final double minimumDistanceMeters;

  /// Rejects coordinate-only motion faster than plausible boat travel.
  final double maximumDerivedSpeedKmh;

  LatLng? _referenceLocation;
  DateTime? _referenceTimestamp;
  double _lastHeading = 0;
  var _rejectedDerivedMotion = false;

  MotionEstimate update({
    required LatLng location,
    required DateTime timestamp,
    required double accuracyMeters,
    required double reportedSpeedMps,
    required double reportedHeading,
  }) {
    _rejectedDerivedMotion = false;
    final reportedSpeedKmh = math.max(0, reportedSpeedMps) * 3.6;
    final coordinateMotion = _deriveCoordinateMotion(
      location,
      timestamp,
      accuracyMeters,
    );

    if (reportedSpeedKmh > 0) {
      final useCoordinateHeading =
          reportedHeading == 0 && coordinateMotion != null;
      final rawHeading = useCoordinateHeading
          ? coordinateMotion.heading
          : _normalizeHeading(reportedHeading);
      _lastHeading = _smoothHeading(rawHeading, reportedSpeedKmh);
      if (!_rejectedDerivedMotion &&
          (_referenceLocation == null ||
              reportedHeading != 0 ||
              useCoordinateHeading)) {
        _setReference(location, timestamp);
      }
      return MotionEstimate(speedKmh: reportedSpeedKmh, heading: _lastHeading);
    }

    if (coordinateMotion == null) {
      if (_referenceLocation == null && !_rejectedDerivedMotion) {
        _setReference(location, timestamp);
      }
      return MotionEstimate(speedKmh: 0, heading: _lastHeading);
    }

    _lastHeading = _smoothHeading(
      coordinateMotion.heading,
      coordinateMotion.speedKmh,
    );
    _setReference(location, timestamp);
    return MotionEstimate(
      speedKmh: coordinateMotion.speedKmh,
      heading: _lastHeading,
    );
  }

  /// Applies Exponential Moving Average (EMA) smoothing to circular heading
  /// angles at low speeds (< 3 km/h) to eliminate compass/GPS bearing jitter.
  double _smoothHeading(double newHeading, double speedKmh) {
    if (speedKmh >= 3.0) return newHeading;
    double diff = newHeading - _lastHeading;
    while (diff < -180) {
      diff += 360;
    }
    while (diff > 180) {
      diff -= 360;
    }
    const alpha = 0.25;
    return _normalizeHeading(_lastHeading + alpha * diff);
  }

  MotionEstimate? _deriveCoordinateMotion(
    LatLng location,
    DateTime timestamp,
    double accuracyMeters,
  ) {
    final referenceLocation = _referenceLocation;
    final referenceTimestamp = _referenceTimestamp;
    if (referenceLocation == null || referenceTimestamp == null) return null;

    final elapsedSeconds =
        timestamp.difference(referenceTimestamp).inMilliseconds /
        Duration.millisecondsPerSecond;
    if (elapsedSeconds <= 0) return null;

    final distanceMeters = const Distance().as(
      LengthUnit.Meter,
      referenceLocation,
      location,
    );
    final accuracyThreshold = accuracyMeters.isFinite && accuracyMeters > 0
        ? accuracyMeters.clamp(minimumDistanceMeters, 15.0)
        : minimumDistanceMeters;
    if (distanceMeters < accuracyThreshold) return null;

    final speedKmh = distanceMeters / elapsedSeconds * 3.6;
    if (speedKmh > maximumDerivedSpeedKmh) {
      _clearReference();
      _rejectedDerivedMotion = true;
      return null;
    }

    return MotionEstimate(
      speedKmh: speedKmh,
      heading: _bearing(referenceLocation, location),
    );
  }

  void _clearReference() {
    _referenceLocation = null;
    _referenceTimestamp = null;
  }

  void _setReference(LatLng location, DateTime timestamp) {
    _referenceLocation = location;
    _referenceTimestamp = timestamp;
  }

  double _bearing(LatLng from, LatLng to) {
    final fromLat = _degreesToRadians(from.latitude);
    final toLat = _degreesToRadians(to.latitude);
    final deltaLongitude = _degreesToRadians(to.longitude - from.longitude);
    final y = math.sin(deltaLongitude) * math.cos(toLat);
    final x =
        math.cos(fromLat) * math.sin(toLat) -
        math.sin(fromLat) * math.cos(toLat) * math.cos(deltaLongitude);
    return _normalizeHeading(_radiansToDegrees(math.atan2(y, x)));
  }

  double _normalizeHeading(double heading) =>
      heading.isFinite ? heading % 360 : 0;

  double _degreesToRadians(double degrees) => degrees * math.pi / 180;

  double _radiansToDegrees(double radians) => radians * 180 / math.pi;
}
