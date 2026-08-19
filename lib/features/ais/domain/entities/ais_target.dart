import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

enum ShipCategory {
  passenger,
  cargo,
  tanker,
  tug,
  sailing,
  pleasure,
  fishing,
  unknown,
}

class AisTarget extends Equatable {
  final int mmsi;
  final String name;
  final LatLng position;
  final double speedKnots;
  final double courseDegrees;
  final double? headingDegrees;
  final ShipCategory category;
  final bool isMooredOrAnchored;
  final DateTime lastReported;
  final String? destination;

  const AisTarget({
    required this.mmsi,
    required this.name,
    required this.position,
    required this.speedKnots,
    required this.courseDegrees,
    required this.category,
    required this.isMooredOrAnchored,
    required this.lastReported,
    this.headingDegrees,
    this.destination,
  });

  /// Effective rotation direction in degrees true.
  /// Falls back to [courseDegrees] if [headingDegrees] is null or invalid (e.g. 511).
  double get effectiveHeading =>
      (headingDegrees != null && headingDegrees! < 360.0)
      ? headingDegrees!
      : courseDegrees;

  /// Human-readable compass cardinal direction (e.g., "SW (Lounas)")
  String get compassDirection {
    final deg = effectiveHeading % 360;
    if (deg >= 337.5 || deg < 22.5) return 'N (Pohjoinen)';
    if (deg >= 22.5 && deg < 67.5) return 'NE (Koillinen)';
    if (deg >= 67.5 && deg < 112.5) return 'E (Itä)';
    if (deg >= 112.5 && deg < 157.5) return 'SE (Kaakko)';
    if (deg >= 157.5 && deg < 202.5) return 'S (Etelä)';
    if (deg >= 202.5 && deg < 247.5) return 'SW (Lounas)';
    if (deg >= 247.5 && deg < 292.5) return 'W (Länsi)';
    return 'NW (Luode)';
  }

  @override
  List<Object?> get props => [
    mmsi,
    name,
    position,
    speedKnots,
    courseDegrees,
    headingDegrees,
    category,
    isMooredOrAnchored,
    lastReported,
    destination,
  ];
}
