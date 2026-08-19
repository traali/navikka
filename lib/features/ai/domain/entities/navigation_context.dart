import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/vessel/data/tables.dart';

part 'navigation_context.freezed.dart';
part 'navigation_context.g.dart';

@freezed
abstract class NavigationContext with _$NavigationContext {
  const factory NavigationContext({
    required VesselType vesselType,
    double? draftDepth,
    @Default(false) bool hasActiveRoute,
    String? activeRouteName,
    List<LatLng>? routePoints,
    List<String>? detectedHazards,
    @Default(false) bool isNearingCoast, // Future: determine from GIS
  }) = _NavigationContext;

  factory NavigationContext.fromJson(Map<String, dynamic> json) =>
      _$NavigationContextFromJson(json);

  /// Default context for when no vessel or route is selected.
  factory NavigationContext.empty() =>
      const NavigationContext(vesselType: VesselType.openBoat);
}
