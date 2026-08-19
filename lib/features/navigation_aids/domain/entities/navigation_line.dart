import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// Represents a navigation line (centerline or boating route).
class NavigationLine {
  const NavigationLine({
    required this.id,
    required this.points,
    this.bounds,
    this.name,
    this.navigationDepth,
    this.sweptDepth,
    this.fairwayClass,
    this.isBoatingRoute = false,
  });

  final String id;
  final List<LatLng> points;
  final LatLngBounds? bounds;
  final String? name;
  final double? navigationDepth;
  final double? sweptDepth;
  final String? fairwayClass;
  final bool isBoatingRoute;
}
