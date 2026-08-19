import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/models/bbox.dart';

/// Geometry utility functions
class GeometryUtils {
  /// Calculate distance between two points in kilometers
  static double distanceInKm(LatLng point1, LatLng point2) {
    const distance = Distance();
    return distance.as(LengthUnit.Kilometer, point1, point2);
  }

  /// Filter zones within a radius from a center point
  static List<T> filterByDistance<T>({
    required List<T> items,
    required LatLng center,
    required double radiusKm,
    required LatLng Function(T item) getLocation,
  }) {
    return items.where((item) {
      final location = getLocation(item);
      final dist = distanceInKm(center, location);
      return dist <= radiusKm;
    }).toList();
  }

  /// Create bounding box around a center point with radius
  static BBox createBoundingBoxFromRadius(LatLng center, double radiusKm) {
    return BBox.fromCenter(center, radiusKm);
  }

  /// Get a unique ID for the 11km x 11km grid tile containing the point
  /// Format: "lat_lon" (e.g. "60.1_24.8")
  /// 0.1 degree lat ≈ 11.1km
  /// 0.2 degree lon ≈ 11.1km (at 60 deg latitude)
  static String getTileId(LatLng point) {
    final latIndex = (point.latitude * 10).floor();
    final lngIndex = (point.longitude * 5)
        .floor(); // 0.2 degree steps (1/0.2 = 5)
    return '${latIndex}_$lngIndex';
  }

  /// Get the BoundingBox for a given Tile ID
  static BBox getTileBBox(String tileId) {
    final parts = tileId.split('_');
    final latIndex = int.parse(parts[0]);
    final lngIndex = int.parse(parts[1]);

    final minLat = latIndex / 10.0; // Back to degrees
    final minLng = lngIndex / 5.0; // Back to degrees

    // Tile size
    const latSize = 0.1;
    const lngSize = 0.2;

    return BBox(
      minLat: minLat,
      maxLat: minLat + latSize,
      minLon: minLng,
      maxLon: minLng + lngSize,
    );
  }

  /// Determines if a [point] is inside a [polygon].
  ///
  /// Uses the Ray-Casting algorithm.
  /// The polygon is defined by a list of [LatLng] points.
  static bool isPointInPolygon(LatLng point, List<LatLng> polygon) {
    if (polygon.isEmpty) return false;

    var isInside = false;
    var j = polygon.length - 1;

    for (var i = 0; i < polygon.length; i++) {
      if ((polygon[i].latitude > point.latitude) !=
          (polygon[j].latitude > point.latitude)) {
        if (point.longitude <
            (polygon[j].longitude - polygon[i].longitude) *
                    (point.latitude - polygon[i].latitude) /
                    (polygon[j].latitude - polygon[i].latitude) +
                polygon[i].longitude) {
          isInside = !isInside;
        }
      }
      j = i;
    }

    return isInside;
  }
}
