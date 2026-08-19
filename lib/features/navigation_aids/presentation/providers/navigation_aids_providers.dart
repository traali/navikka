import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/constants/navigation_aids_constants.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/app_theme.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/core/utils/performance_tracker.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';
import 'package:sakkoja/features/navigation_aids/di/navigation_aids_di.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/fairway_area.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/navigation_aid.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/navigation_aid_type.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/navigation_line.dart';
import 'package:sakkoja/features/navigation_aids/presentation/mappers/official_sign_mapper.dart';
import 'package:sakkoja/features/navigation_aids/presentation/widgets/navigation_aid_marker.dart';

part 'navigation_aids_providers.g.dart';

// -----------------------------------------------------------------------------
// Repository Provider
// -----------------------------------------------------------------------------

// Repository is imported from DI layer

// -----------------------------------------------------------------------------
// Hybrid Data Providers (Memory Cache + Grid Fetching)
// -----------------------------------------------------------------------------

@riverpod
class HybridFairwayAreas extends _$HybridFairwayAreas {
  @override
  Future<List<FairwayArea>> build() async {
    ref.keepAlive();

    // Offline-First: Just load everything once.
    // Repository handles in-memory initialization.
    final result = await ref
        .read(navigationAidsRepositoryProvider)
        .getFairwayAreas();
    return result.fold((f) {
      Log.e('HybridFairwayAreas: Failed to load: $f');
      throw Exception('Failed to load fairway areas: ${f.message}');
    }, (areas) => areas);
  }
}

@riverpod
class HybridNavigationAids extends _$HybridNavigationAids {
  @override
  Future<List<NavigationAid>> build() async {
    ref.keepAlive();

    // Offline-First: Just load everything once.
    final result = await ref
        .read(navigationAidsRepositoryProvider)
        .getNavigationAids();
    return result.fold((f) {
      Log.e('HybridNavigationAids: Failed to load: $f');
      throw Exception('Failed to load navigation aids: ${f.message}');
    }, (aids) => aids);
  }
}

@riverpod
class HybridNavigationLines extends _$HybridNavigationLines {
  @override
  Future<List<NavigationLine>> build() async {
    ref.keepAlive();
    final result = await ref
        .read(navigationAidsRepositoryProvider)
        .getNavigationLines();
    return result.fold((f) {
      Log.e('HybridNavigationLines: Failed to load: $f');
      throw Exception('Failed to load navigation lines: ${f.message}');
    }, (lines) => lines);
  }
}

// -----------------------------------------------------------------------------
// Display Providers (Sync - viewport filtered, flicker-free)
// -----------------------------------------------------------------------------

@riverpod
List<FairwayArea> displayedFairwayAreas(Ref ref) {
  final hybridAreas = ref.watch(hybridFairwayAreasProvider).value ?? [];
  final cameraState = ref.watch(debouncedMapCameraPositionProvider);

  if (hybridAreas.isEmpty) return [];

  if (cameraState.zoom < NavigationAidsConstants.zoomShowFairwayAreas) {
    return [];
  }

  return _filterFairwayAreasByViewport(
    hybridAreas,
    cameraState,
    bufferKm: NavigationAidsConstants.viewportBufferKm,
  );
}

@riverpod
List<NavigationAid> displayedNavigationAids(Ref ref) {
  final hybridAids = ref.watch(hybridNavigationAidsProvider).value ?? [];
  final cameraState = ref.watch(debouncedMapCameraPositionProvider);
  final zoom = cameraState.zoom;

  if (hybridAids.isEmpty) return [];

  final viewportAids = _filterNavigationAidsByViewport(
    hybridAids,
    cameraState,
    bufferKm: NavigationAidsConstants.viewportBufferKm,
  );

  return viewportAids
      .where((aid) => _shouldShowAtZoom(aid, zoom))
      .toList(
        growable: false,
      );
}

@riverpod
List<NavigationLine> displayedNavigationLines(Ref ref) {
  final hybridLines = ref.watch(hybridNavigationLinesProvider).value ?? [];
  final cameraState = ref.watch(debouncedMapCameraPositionProvider);
  final zoom = cameraState.zoom;

  if (hybridLines.isEmpty) return [];

  // Filter lines based on their class and the current zoom level
  final filteredByZoom = hybridLines.where((line) {
    final fClass = line.fairwayClass;
    // Class 1-2 (Major): zoom >= 9
    if (fClass == '1' || fClass == '2') {
      return zoom >= NavigationAidsConstants.zoomShowLineClass1_2;
    }
    // Class 3-4 (Medium): zoom >= 11
    if (fClass == '3' || fClass == '4') {
      return zoom >= NavigationAidsConstants.zoomShowLineClass3_4;
    }
    // Class 5-6 (Small): zoom >= 13
    if (fClass == '5' || fClass == '6') {
      return zoom >= NavigationAidsConstants.zoomShowLineClass5_6;
    }
    // Default fallback (e.g. unknown class)
    return zoom >= NavigationAidsConstants.zoomShowNavigationLines;
  }).toList();

  if (filteredByZoom.isEmpty) return [];

  return _filterNavigationLinesByViewport(
    filteredByZoom,
    cameraState,
    bufferKm: NavigationAidsConstants.viewportBufferKm,
  );
}

// ---------------------------------------------------------------------------
// Pre-built Layer Object Providers (eliminate .map().toList() in widget build)
// ---------------------------------------------------------------------------

@riverpod
List<Polygon> fairwayAreaPolygons(Ref ref) {
  final areas = ref.watch(displayedFairwayAreasProvider);
  if (areas.isEmpty) return const [];

  return areas
      .where((a) => a.rings.isNotEmpty)
      .map(
        (area) => Polygon(
          points: area.rings.first,
          color: AppTheme.kVibrantBlue.withValues(alpha: 0.05),
          borderColor: AppTheme.kVibrantBlue.withValues(alpha: 0.35),
          borderStrokeWidth: 1.5,
          label: area.navigationDepth != null
              ? '${area.navigationDepth!.toStringAsFixed(1)}m'
              : null,
          labelStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
            letterSpacing: 0.5,
            shadows: [
              Shadow(blurRadius: 3, offset: Offset(1, 1)),
              Shadow(blurRadius: 3, offset: Offset(-1, -1)),
            ],
          ),
        ),
      )
      .toList(growable: false);
}

@riverpod
List<NavigationAid> displayedSafetyEquipment(Ref ref) {
  final aids = ref.watch(displayedNavigationAidsProvider);
  return aids
      .where((a) => a.type == NavigationAidType.safetyEquipment)
      .toList(growable: false);
}

@riverpod
List<Marker> navigationAidMarkers(Ref ref, {required bool isFishingMode}) {
  final aids = isFishingMode
      ? ref.watch(displayedSafetyEquipmentProvider)
      : ref.watch(displayedNavigationAidsProvider);
  if (aids.isEmpty) return const [];

  return aids
      .where(_hasVisibleMarker)
      .map((aid) {
        return Marker(
          point: aid.position,
          width: 44,
          height: 44,
          child: NavigationAidMarker(aid: aid),
        );
      })
      .toList(growable: false);
}

bool _hasVisibleMarker(NavigationAid aid) {
  if (aid.type == NavigationAidType.trafficSign) {
    return OfficialSignMapper.getAssetPath(aid.signTypeCode) != null;
  }
  return true;
}

@riverpod
List<Polyline> navigationLinePolylines(Ref ref) {
  final lines = ref.watch(displayedNavigationLinesProvider);
  if (lines.isEmpty) return const [];

  return lines
      .map((line) {
        final fClass = line.fairwayClass;
        var strokeWidth = 1.0;
        var opacity = 0.5;
        var pattern = const StrokePattern.solid();

        if (fClass == '1' || fClass == '2') {
          strokeWidth = 1.8;
          opacity = 0.7;
        } else if (fClass == '5' || fClass == '6') {
          strokeWidth = 0.6;
          opacity = 0.3;
          pattern = const StrokePattern.dotted();
        }

        return Polyline(
          points: line.points,
          color: AppTheme.kVibrantBlue.withValues(alpha: opacity),
          strokeWidth: strokeWidth,
          borderStrokeWidth: 0.5,
          borderColor: Colors.black12,
          pattern: pattern,
        );
      })
      .toList(growable: false);
}

@riverpod
List<Marker> navigationLineDepthLabels(Ref ref) {
  final lines = ref.watch(displayedNavigationLinesProvider);
  final cameraState = ref.watch(debouncedMapCameraPositionProvider);
  final zoom = cameraState.zoom;

  if (lines.isEmpty) return const [];

  return lines
      .where((l) {
        if (l.navigationDepth == null || l.points.length < 2) return false;
        final fClass = l.fairwayClass;
        if (fClass == '1' || fClass == '2' || fClass == '3' || fClass == '4') {
          return zoom >= NavigationAidsConstants.zoomShowLineLabelsMajor;
        }
        return zoom >= NavigationAidsConstants.zoomShowLineLabelsMinor;
      })
      .map((line) {
        final midIndex = (line.points.length / 2).floor();
        final midpoint = line.points[midIndex];

        return Marker(
          point: midpoint,
          width: 52,
          height: 26,
          rotate: false,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppPalette.navikkaCanvas.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: AppPalette.navikkaCyanGlow.withValues(alpha: 0.8),
                  width: 1.2,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black87,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                '${line.navigationDepth!.toStringAsFixed(1)}m',
                style: const TextStyle(
                  color: AppPalette.navikkaCyanGlow,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ),
        );
      })
      .toList(growable: false);
}

const Set<String> _kMajorSeaLighthouses = {
  'harmaja',
  'porkkala',
  'bengtskär',
  'utö',
  'russarö',
  'söderskär',
  'isokari',
  'märket',
  'bogskär',
  'helsinki',
  'rönnskär',
  'tankar',
  'norrskär',
  'strömmingsbådan',
  'säppi',
  'yttergrund',
  'kylmäpihlaja',
  'marjaniemi',
  'ulkokalla',
  'tauvo',
  'valassaaret',
  'kallo',
  'suomenlinna',
  'jussarö',
  'gustavsvärn',
  'tiiskeri',
  'kalbådagrund',
  'roddargrund',
  'seivästö',
  'orrengrund',
  'glosholm',
  'kallbådan',
  'hailuoto',
  'nyhamn',
};

/// Determines if a navigation aid should be visible at the given zoom level.
bool _shouldShowAtZoom(NavigationAid aid, double zoom) {
  switch (aid.type) {
    case NavigationAidType.lighthouse:
      final name = aid.name?.toLowerCase() ?? '';
      // Overview / Regional scale (< 12.0, e.g. 12km bar): show ONLY major sea lighthouses
      if (zoom < 12.0) {
        return _kMajorSeaLighthouses.any(name.contains);
      }
      // Approach scale (12.0 - 13.4): show primary harbor and channel lights
      if (zoom < 13.5) {
        final isMinorOrLeading =
            name.contains('linja') || aid.signTypeCode != null;
        return !isMinorOrLeading;
      }
      // Tactical / Harbor scale (>= 13.5): show all lights
      return true;

    case NavigationAidType.trafficSign:
      // Tactical traffic signs (speed limits, anchor prohibitions) show only at tactical harbor zoom >= 13.5
      return zoom >= 13.5;

    case NavigationAidType.safetyEquipment:
      return zoom >= 14.0;
  }
}

// -----------------------------------------------------------------------------
// Viewport Filtering Helpers
// -----------------------------------------------------------------------------

List<FairwayArea> _filterFairwayAreasByViewport(
  List<FairwayArea> areas,
  MapCameraState camera, {
  required double bufferKm,
}) {
  final viewportBounds = _getBoundsFromCamera(camera, bufferKm);

  return areas.where((area) {
    // Optimized: Check bounding box overlap first
    if (area.bounds != null) {
      return viewportBounds.isOverlapping(area.bounds!);
    }

    // Fallback: Check if any point of the polygon intersects with bounds
    for (final ring in area.rings) {
      for (final point in ring) {
        if (viewportBounds.contains(point)) {
          return true;
        }
      }
    }
    return false;
  }).toList();
}

List<NavigationLine> _filterNavigationLinesByViewport(
  List<NavigationLine> lines,
  MapCameraState camera, {
  required double bufferKm,
}) {
  final viewport = _getBoundsFromCamera(camera, bufferKm);
  return lines.where((line) {
    if (line.points.isEmpty) return false;
    if (line.bounds != null) {
      return viewport.isOverlapping(line.bounds!);
    }
    return line.points.any(viewport.contains);
  }).toList();
}

List<NavigationAid> _filterNavigationAidsByViewport(
  List<NavigationAid> aids,
  MapCameraState camera, {
  required double bufferKm,
}) {
  return PerformanceTracker.traceSync('NavAids.displayed.filterViewport', () {
    final bounds = _getBoundsFromCamera(camera, bufferKm);
    return aids.where((aid) => bounds.contains(aid.position)).toList();
  });
}

/// Computes approximate visible bounds from camera center and zoom.
LatLngBounds _getBoundsFromCamera(MapCameraState camera, double bufferKm) {
  final center = camera.center;
  final zoom = camera.zoom;

  // Approximate view radius in km based on zoom level
  // At zoom 14, roughly 2km visible; at zoom 10, roughly 30km visible
  final viewRadiusKm = 40000.0 / math.pow(2, zoom);

  // Add buffer
  final totalRadiusKm = viewRadiusKm + bufferKm;

  // Convert km to degrees
  const degreesPerKmLat = 1 / 111.0;
  final degreesPerKmLon =
      1 /
      (111.0 * math.cos(center.latitude * math.pi / 180).abs().clamp(0.1, 1.0));

  final latDelta = totalRadiusKm * degreesPerKmLat;
  final lonDelta = totalRadiusKm * degreesPerKmLon;

  return LatLngBounds(
    LatLng(center.latitude - latDelta, center.longitude - lonDelta),
    LatLng(center.latitude + latDelta, center.longitude + lonDelta),
  );
}
