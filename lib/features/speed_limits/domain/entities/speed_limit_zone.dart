import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/models/bbox.dart';

class SpeedLimitZone {
  SpeedLimitZone({
    required this.id,
    required this.speedLimitKmh,
    required this.rings,
    this.typeDescription,
    this.typeCode,
  }) {
    // Calculate bounding box from OUTER ring (first ring)
    if (rings.isNotEmpty) {
      boundingBox = BBox.fromPoints(rings.first);
    } else {
      boundingBox = const BBox(minLat: 0, maxLat: 0, minLon: 0, maxLon: 0);
    }
  }
  final String id;
  final int speedLimitKmh;

  // First list is outer ring, subsequent lists are holes (inner rings)
  final List<List<LatLng>> rings;
  final String? typeDescription;
  // Raw type code (e.g. "01", "11") for logic
  final String? typeCode;

  // Cached bounding box for performance optimization
  late final BBox boundingBox;

  /// Get the center point of this zone (for distance calculations)
  LatLng get center => boundingBox.center;

  /// Check if this is a mandatory speed limit (01) or recommendation (11)
  bool get isSpeedRestriction => typeCode == '01' || typeCode == '11';

  @override
  String toString() =>
      'SpeedLimitZone(id: $id, limit: $speedLimitKmh km/h, rings: ${rings.length}, type: $typeCode)';
}
