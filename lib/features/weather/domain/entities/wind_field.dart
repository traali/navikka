import 'dart:math' as math;
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

/// Single grid point sample in a spatial wind field.
class WindPoint extends Equatable {
  const WindPoint({
    required this.position,
    required this.speedKnots,
    required this.directionDegrees,
  });

  final LatLng position;
  final double speedKnots;
  final double directionDegrees;

  /// U component (Eastward velocity in knots)
  double get u => speedKnots * math.sin(directionDegrees * (math.pi / 180.0));

  /// V component (Northward velocity in knots)
  double get v => speedKnots * math.cos(directionDegrees * (math.pi / 180.0));

  @override
  List<Object?> get props => [position, speedKnots, directionDegrees];
}

/// Grid representation of a spatial wind field for a specific timestamp.
class WindField extends Equatable {
  const WindField({
    required this.validTime,
    required this.southWest,
    required this.northEast,
    required this.points,
  });

  final DateTime validTime;
  final LatLng southWest;
  final LatLng northEast;
  final List<WindPoint> points;

  @override
  List<Object?> get props => [validTime, southWest, northEast, points];
}
