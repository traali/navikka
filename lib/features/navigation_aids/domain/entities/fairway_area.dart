import 'package:flutter_map/flutter_map.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'fairway_area.freezed.dart';

/// Represents a fairway area (navigable channel) in Finnish waters.
///
/// Fairway areas are polygonal regions that indicate safe navigation routes.
/// They include depth information and quality classifications from Väylävirasto.
@freezed
abstract class FairwayArea with _$FairwayArea {
  const factory FairwayArea({
    /// Unique identifier from Väylävirasto.
    required String id,

    /// Polygon rings defining the fairway area geometry.
    /// First ring is exterior, subsequent rings are holes.
    required List<List<LatLng>> rings,

    /// Human-readable name of the fairway.
    String? name,

    /// Navigation depth in meters (kulkusyvyys).
    double? navigationDepth,

    /// Verified swept depth in meters (haraussyvyys).
    double? sweptDepth,

    /// Quality class of the depth data.
    String? qualityClass,

    /// Fairway type classification.
    String? fairwayType,

    /// Current status (e.g., active, planned).
    String? status,

    /// Buoyage system used (IALA A/B).
    String? buoyageSystem,

    /// Bounding box of the fairway area for fast viewport filtering.
    LatLngBounds? bounds,
  }) = _FairwayArea;
}
