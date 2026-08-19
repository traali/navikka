import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/theme/app_theme.dart';
import 'package:sakkoja/core/theme/zone_colors.dart';
import 'package:sakkoja/features/navigation/presentation/providers/navigation_providers.dart';
import 'package:sakkoja/features/speed_limits/presentation/providers/displayed_speed_limits_provider.dart';

part 'map_layers_provider.g.dart';

@riverpod
List<Polygon> memoizedSpeedLimitPolygons(Ref ref) {
  final zones = ref.watch(displayedSpeedLimitsProvider);
  if (zones.isEmpty) return [];

  return zones.map((zone) {
    return Polygon(
      points: zone.rings.isNotEmpty ? zone.rings.first : [],
      holePointsList: zone.rings.length > 1 ? zone.rings.sublist(1) : null,
      color: ZoneColors.getZoneColor(zone),
      borderColor: ZoneColors.getZoneBorderColor(zone),
      borderStrokeWidth: 3,
      label: zone.speedLimitKmh > 0 ? '${zone.speedLimitKmh}' : null,
      labelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
        fontSize: 18,
        letterSpacing: 0.5,
        shadows: [
          Shadow(blurRadius: 4, offset: Offset(1, 1)),
          Shadow(blurRadius: 4, offset: Offset(-1, -1)),
        ],
      ),
    );
  }).toList();
}

@riverpod
List<Polyline> memoizedRoutePolylines(Ref ref) {
  final plannerState = ref.watch(routePlannerControllerProvider);
  if (plannerState.waypoints.length < 2) return [];

  if (plannerState.metrics?.segments.isNotEmpty ?? false) {
    return plannerState.metrics!.segments.map((s) {
      return Polyline(
        points: s.points,
        strokeWidth: 5,
        color: ZoneColors.getRouteSegmentColor(
          speedLimitKmh: s.speedLimitKmh,
          isOverSpeed: s.isOverSpeed,
        ),
      );
    }).toList();
  } else {
    return [
      Polyline(
        points: plannerState.waypoints
            .map((w) => LatLng(w.lat, w.lon))
            .toList(),
        strokeWidth: 5,
        color: AppTheme.kNeonCyan,
      ),
    ];
  }
}

/// Active route polyline for navigation mode.
///
/// Renders the active route when navigation is in progress
/// and the route planner is not being used.
@riverpod
List<Polyline> memoizedActiveRoutePolylines(Ref ref) {
  final activeRoute = ref.watch(activeRouteProvider);
  return activeRoute.when(
    data: (route) {
      if (route == null) return [];

      final waypointsAsync = ref.watch(waypointsForRouteProvider(route.id));
      return waypointsAsync.when(
        data: (waypoints) {
          if (waypoints.length < 2) return [];
          return [
            Polyline(
              points: waypoints.map((w) => LatLng(w.lat, w.lon)).toList(),
              strokeWidth: 5,
              color: AppTheme.kNeonCyan,
            ),
          ];
        },
        loading: () => [],
        error: (error, stack) => [],
      );
    },
    loading: () => [],
    error: (error, stack) => [],
  );
}
