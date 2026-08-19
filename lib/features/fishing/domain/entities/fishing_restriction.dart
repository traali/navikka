import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/models/bbox.dart';
import 'package:sakkoja/core/services/geometry_utils.dart';

class FishingRestriction {
  const FishingRestriction({
    required this.id,
    required this.title,
    required this.rings,
    required this.isCurrentlyActive,
    required this.category,
    this.type,
    this.description,
    this.validity,
    this.boundingBox,
  });

  factory FishingRestriction.withCalculatedBBox({
    required String id,
    required String title,
    required List<List<LatLng>> rings,
    String? type,
    String? description,
    String? validity,
  }) {
    if (rings.isEmpty || rings.first.isEmpty) {
      return FishingRestriction(
        id: id,
        title: title,
        rings: rings,
        type: type,
        description: description,
        isCurrentlyActive: _computeIsCurrentlyActive(validity),
        category: _computeCategory(title, description, type),
      );
    }

    var minLat = 90.0;
    var maxLat = -90.0;
    var minLng = 180.0;
    var maxLng = -180.0;

    for (final ring in rings) {
      for (final p in ring) {
        if (p.latitude < minLat) minLat = p.latitude;
        if (p.latitude > maxLat) maxLat = p.latitude;
        if (p.longitude < minLng) minLng = p.longitude;
        if (p.longitude > maxLng) maxLng = p.longitude;
      }
    }

    return FishingRestriction(
      id: id,
      title: title,
      rings: rings,
      type: type,
      description: description,
      validity: validity,
      boundingBox: BBox(
        minLat: minLat,
        maxLat: maxLat,
        minLon: minLng,
        maxLon: maxLng,
      ),
      isCurrentlyActive: _computeIsCurrentlyActive(validity),
      category: _computeCategory(title, description, type),
    );
  }
  final String id;
  final String title;
  final List<List<LatLng>> rings;
  final String? type;
  final String? description;
  final String? validity;

  final bool isCurrentlyActive;
  final String category;

  final BBox? boundingBox;

  /// Extensible category patterns - order matters (more specific first)
  static const Map<String, List<String>> _categoryPatterns = {
    'Luonnonsuojelualue': [
      'luonnonsuojelualue',
      'ls',
      'nature reserve',
      'maarinlahti',
      'laajalahti',
    ],
    'Erityiskalastusalue': [
      'evk',
      'kta',
      'erityiskalastusalue',
    ],
    // Specific net mesh/allowed patterns (check before general verkko)
    'Verkkorajoitukset': ['verkkojen solmuväli', 'verkoissa sallittu'],
    // General categories
    'Verkkokalastus': ['verkko', 'net'],
    'Pyydyskalastus': ['rysä', 'trap', 'katiska'],
    'Kalastuskielto': [
      'kutualue',
      'spawn',
      'kalastusrajoitus',
      'kalastus kielletty',
      'kieltoalue',
    ],
    'Veneilyrajoitus': ['moottori', 'motor', 'nopeus'],
  };

  static String _computeCategory(
    String title,
    String? description,
    String? type,
  ) {
    // Combine all text fields for searching
    final searchText = [
      title,
      description,
      type,
    ].whereType<String>().join(' ').toLowerCase();

    // Check patterns in order (more specific first)
    for (final entry in _categoryPatterns.entries) {
      if (entry.value.any(searchText.contains)) {
        return entry.key;
      }
    }
    return 'Muu';
  }

  /// Parse Finnish date range like "15.5-15.6" or "voimassa: 15.5.-15.6."
  /// Returns null if parsing fails or no validity field
  static ({int startDay, int startMonth, int endDay, int endMonth})?
  _parseValidityDateRange(String? validity) {
    if (validity == null) return null;

    // Regex for patterns like "15.5-15.6", "15.5.-15.6.", "1.4-31.5"
    final regex = RegExp(
      r'(\d{1,2})\.(\d{1,2})\.?\s*[-–]\s*(\d{1,2})\.(\d{1,2})',
    );
    final match = regex.firstMatch(validity);
    if (match == null) return null;

    return (
      startDay: int.parse(match.group(1)!),
      startMonth: int.parse(match.group(2)!),
      endDay: int.parse(match.group(3)!),
      endMonth: int.parse(match.group(4)!),
    );
  }

  /// Check if restriction is currently active based on validity dates
  /// Returns true if no validity date (always active) or within date range
  static DateTime _safeDate(int year, int month, int day) {
    final first = DateTime(year, month);
    if (day == 1) return first;
    if (day > 1) return first.add(Duration(days: day - 1));
    return first;
  }

  static bool _computeIsCurrentlyActive(String? validity) {
    final range = _parseValidityDateRange(validity);
    if (range == null) return true; // No date = always active

    final now = DateTime.now();
    final thisYear = now.year;

    final start = _safeDate(thisYear, range.startMonth, range.startDay);
    final end = _safeDate(thisYear, range.endMonth, range.endDay);

    // Handle year wrap (e.g., Nov 1 - Feb 28)
    if (end.isBefore(start)) {
      // Active if after start OR before end
      return now.isAfter(start.subtract(const Duration(days: 1))) ||
          now.isBefore(end.add(const Duration(days: 1)));
    }

    // Normal case: start before end in same year
    return now.isAfter(start.subtract(const Duration(days: 1))) &&
        now.isBefore(end.add(const Duration(days: 1)));
  }

  /// Check if a path (list of points) intersects this restriction.
  /// Uses a BBox broad-phase check for performance.
  bool intersectsPath(List<LatLng> pathPoints) {
    if (pathPoints.length < 2) return false;

    // 1. Broad phase: Check if the path's bounding box intersects our bounding box
    final pathBBox = BBox.fromPoints(pathPoints);
    if (boundingBox != null && !boundingBox!.intersects(pathBBox)) return false;

    // 2. Narrow phase: split each route segment at every polygon boundary.
    // Testing the resulting open intervals handles narrow crossings and holes.
    for (var i = 0; i < pathPoints.length - 1; i++) {
      final start = pathPoints[i];
      final end = pathPoints[i + 1];
      if (_segmentTouchesRestriction(start, end)) return true;
    }

    return false;
  }

  bool _segmentTouchesRestriction(LatLng start, LatLng end) {
    final intersections = <double>[0, 1];

    for (final ring in rings) {
      if (ring.length < 2) continue;
      for (var i = 0; i < ring.length; i++) {
        final edgeStart = ring[i];
        final edgeEnd = ring[(i + 1) % ring.length];
        intersections.addAll(
          _segmentIntersectionParameters(start, end, edgeStart, edgeEnd),
        );
      }
    }

    intersections.sort();
    final uniqueIntersections = <double>[];
    for (final value in intersections) {
      if (uniqueIntersections.isEmpty ||
          (value - uniqueIntersections.last).abs() > _geometryEpsilon) {
        uniqueIntersections.add(value);
      }
    }

    for (var i = 0; i < uniqueIntersections.length - 1; i++) {
      final midpoint =
          (uniqueIntersections[i] + uniqueIntersections[i + 1]) / 2;
      if (_isPointInRestriction(_pointAlong(start, end, midpoint))) {
        return true;
      }
    }

    return false;
  }

  static const _geometryEpsilon = 1e-10;

  static LatLng _pointAlong(LatLng start, LatLng end, double t) => LatLng(
    start.latitude + (end.latitude - start.latitude) * t,
    start.longitude + (end.longitude - start.longitude) * t,
  );

  static List<double> _segmentIntersectionParameters(
    LatLng start,
    LatLng end,
    LatLng edgeStart,
    LatLng edgeEnd,
  ) {
    final routeLat = end.latitude - start.latitude;
    final routeLon = end.longitude - start.longitude;
    final edgeLat = edgeEnd.latitude - edgeStart.latitude;
    final edgeLon = edgeEnd.longitude - edgeStart.longitude;
    final denominator = _cross(routeLat, routeLon, edgeLat, edgeLon);
    final startToEdgeLat = edgeStart.latitude - start.latitude;
    final startToEdgeLon = edgeStart.longitude - start.longitude;

    if (denominator.abs() <= _geometryEpsilon) {
      if (_cross(startToEdgeLat, startToEdgeLon, routeLat, routeLon).abs() >
          _geometryEpsilon) {
        return const [];
      }

      final routeLengthSquared = routeLat * routeLat + routeLon * routeLon;
      if (routeLengthSquared <= _geometryEpsilon) return const [];
      return [
        _clampUnit(
          (startToEdgeLat * routeLat + startToEdgeLon * routeLon) /
              routeLengthSquared,
        ),
        _clampUnit(
          ((edgeEnd.latitude - start.latitude) * routeLat +
                  (edgeEnd.longitude - start.longitude) * routeLon) /
              routeLengthSquared,
        ),
      ];
    }

    final routeT =
        _cross(startToEdgeLat, startToEdgeLon, edgeLat, edgeLon) / denominator;
    final edgeT =
        _cross(startToEdgeLat, startToEdgeLon, routeLat, routeLon) /
        denominator;
    if (routeT < -_geometryEpsilon ||
        routeT > 1 + _geometryEpsilon ||
        edgeT < -_geometryEpsilon ||
        edgeT > 1 + _geometryEpsilon) {
      return const [];
    }
    return [_clampUnit(routeT)];
  }

  static double _cross(
    double firstLat,
    double firstLon,
    double secondLat,
    double secondLon,
  ) => firstLat * secondLon - firstLon * secondLat;

  static double _clampUnit(double value) => value.clamp(0, 1).toDouble();

  bool _isPointInRestriction(LatLng point) {
    if (rings.isEmpty) return false;
    if (!_isPointInRing(point, rings.first)) return false;
    return !rings.skip(1).any((hole) => _isPointInRing(point, hole));
  }

  static bool _isPointInRing(LatLng point, List<LatLng> ring) {
    return GeometryUtils.isPointInPolygon(point, ring);
  }
}
