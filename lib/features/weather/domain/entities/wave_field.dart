import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

/// Single grid point sample for significant wave height ($H_s$).
class WavePoint extends Equatable {
  const WavePoint({
    required this.position,
    required this.waveHeightMeters,
  });

  final LatLng position;
  final double waveHeightMeters;

  @override
  List<Object?> get props => [position, waveHeightMeters];
}

/// Grid representation of a spatial wave height field for a specific timestamp.
class WaveField extends Equatable {
  const WaveField({
    required this.validTime,
    required this.southWest,
    required this.northEast,
    required this.points,
  });

  final DateTime validTime;
  final LatLng southWest;
  final LatLng northEast;
  final List<WavePoint> points;

  @override
  List<Object?> get props => [validTime, southWest, northEast, points];
}
