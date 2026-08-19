import 'package:latlong2/latlong.dart';

/// Represents a bounding box for spatial queries
class BBox {
  const BBox({
    required this.minLon,
    required this.minLat,
    required this.maxLon,
    required this.maxLat,
  });

  /// Creates a bounding box from a center point and radius in kilometers
  ///
  /// At ~60° latitude (Finland):
  /// - 1 degree latitude ≈ 111 km
  /// - 1 degree longitude ≈ 55.5 km
  factory BBox.fromCenter(LatLng center, double radiusKm) {
    const latDegreeKm = 111.0;
    const lonDegreeKm = 55.5; // Approximate at 60° latitude

    final latOffset = radiusKm / latDegreeKm;
    final lonOffset = radiusKm / lonDegreeKm;

    return BBox(
      minLon: center.longitude - lonOffset,
      minLat: center.latitude - latOffset,
      maxLon: center.longitude + lonOffset,
      maxLat: center.latitude + latOffset,
    );
  }

  /// Creates a bounding box from a list of points
  factory BBox.fromPoints(List<LatLng> points) {
    if (points.isEmpty) {
      return const BBox(minLon: 0, minLat: 0, maxLon: 0, maxLat: 0);
    }

    var minLon = points.first.longitude;
    var maxLon = points.first.longitude;
    var minLat = points.first.latitude;
    var maxLat = points.first.latitude;

    for (final point in points) {
      if (point.longitude < minLon) minLon = point.longitude;
      if (point.longitude > maxLon) maxLon = point.longitude;
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
    }

    return BBox(minLon: minLon, minLat: minLat, maxLon: maxLon, maxLat: maxLat);
  }
  final double minLon;
  final double minLat;
  final double maxLon;
  final double maxLat;

  bool contains({required double lat, required double lon}) {
    return lat >= minLat && lat <= maxLat && lon >= minLon && lon <= maxLon;
  }

  /// Checks if this bounding box overlaps with another bounding box.
  ///
  /// Used for viewport culling - returns true if any part of this bbox
  /// is visible within the other bbox (viewport).
  bool overlaps(BBox other) {
    // Two boxes overlap if they don't NOT overlap.
    // They don't overlap if one is entirely to the left, right, above, or below the other.
    return !(maxLon < other.minLon ||
        minLon > other.maxLon ||
        maxLat < other.minLat ||
        minLat > other.maxLat);
  }

  /// Returns the center point of this bounding box
  LatLng get center => LatLng((minLat + maxLat) / 2, (minLon + maxLon) / 2);

  /// Checks if this bounding box intersects with another (Alias for overlaps)
  bool intersects(BBox other) => overlaps(other);

  /// Converts to WFS bbox parameter format
  ///
  /// CRITICAL: In WFS 1.1.0/2.0.0 with EPSG:4326, the axis order is (Lat, Lon).
  /// However, some servers (like Väylävirasto) still expect (Lon, Lat).
  /// Use [forceLonLat] = true to override the standard behavior.
  /// Format: minLat,minLon,maxLat,maxLon,EPSG:4326 (Default)
  /// Format: minLon,minLat,maxLon,maxLat,EPSG:4326 (forceLonLat: true)
  String toWfsParam({int? precision, bool forceLonLat = false}) {
    final min1 = forceLonLat ? minLon : minLat;
    final min2 = forceLonLat ? minLat : minLon;
    final max1 = forceLonLat ? maxLon : maxLat;
    final max2 = forceLonLat ? maxLat : maxLon;

    if (precision != null) {
      return '${min1.toStringAsFixed(precision)},'
          '${min2.toStringAsFixed(precision)},'
          '${max1.toStringAsFixed(precision)},'
          '${max2.toStringAsFixed(precision)},'
          'EPSG:4326';
    }
    return '$min1,$min2,$max1,$max2,EPSG:4326';
  }

  @override
  String toString() =>
      'BBox(minLon: $minLon, minLat: $minLat, maxLon: $maxLon, maxLat: $maxLat)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BBox &&
          runtimeType == other.runtimeType &&
          minLon == other.minLon &&
          minLat == other.minLat &&
          maxLon == other.maxLon &&
          maxLat == other.maxLat;

  @override
  int get hashCode =>
      minLon.hashCode ^ minLat.hashCode ^ maxLon.hashCode ^ maxLat.hashCode;
}
