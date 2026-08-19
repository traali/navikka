import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

import 'package:sakkoja/features/navigation_aids/domain/entities/navigation_aid_type.dart';

part 'navigation_aid.freezed.dart';

/// Represents a navigation aid (beacon, buoy, sign, or lighthouse) in Finnish waters.
///
/// This is a unified entity covering traffic signs, safety equipment, and lighthouses
/// from the Väylävirasto waterway registry.
@freezed
abstract class NavigationAid with _$NavigationAid {
  const factory NavigationAid({
    /// Unique identifier from Väylävirasto.
    required String id,

    /// Type of navigation aid.
    required NavigationAidType type,

    /// Geographic position.
    required LatLng position,

    /// Human-readable name or designation.
    String? name,

    /// Physical mounting type (floating or fixed).
    NavigationAidMounting? mounting,

    /// IALA color/shape code (e.g., "RED", "GREEN", "CARDINAL_N").
    String? ialaCode,

    /// Light characteristics for illuminated aids (e.g., "Fl(2) 6s").
    String? lightCharacteristics,

    /// Light range in nautical miles.
    double? lightRangeNm,

    /// Sign type code for traffic signs.
    String? signTypeCode,

    /// Sign type description in Finnish.
    String? signTypeDescription,

    /// Restriction value (e.g., speed limit in km/h).
    double? restrictionValue,

    /// Owner or maintainer organization.
    String? owner,
  }) = _NavigationAid;

  const NavigationAid._();

  /// Whether this aid has a light (for rendering decisions).
  bool get hasLight =>
      lightCharacteristics != null || type == NavigationAidType.lighthouse;

  /// Whether this is a speed-related sign.
  bool get isSpeedSign =>
      signTypeCode == '01' || // Speed limit
      signTypeCode == '11'; // Speed recommendation
}
