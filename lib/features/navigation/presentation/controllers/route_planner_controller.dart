import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/models/bbox.dart';
import 'package:sakkoja/core/utils/throttle.dart';
import 'package:sakkoja/features/fishing/domain/entities/fishing_restriction.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_data_providers.dart';
import 'package:sakkoja/features/navigation/domain/entities/waypoint_entity.dart';
import 'package:sakkoja/features/navigation/domain/services/route_service.dart';
import 'package:sakkoja/features/navigation/presentation/providers/navigation_providers.dart';
import 'package:sakkoja/features/vessel/presentation/controllers/vessel_controller.dart';

/// State for the planner: just a list of waypoints and total distance.
class RoutePlannerState {
  const RoutePlannerState({
    required this.waypoints,
    required this.totalDistanceMeters,
    this.totalDurationMinutes = 0,
    this.isSaving = false,
    this.isCheckingRestrictions = false,
    this.restrictionCheckError,
    this.metrics,
    this.conflicts = const [],
  });

  factory RoutePlannerState.initial() {
    return const RoutePlannerState(waypoints: [], totalDistanceMeters: 0);
  }
  final List<WaypointEntity> waypoints;
  final double totalDistanceMeters;
  final int totalDurationMinutes;
  final bool isSaving;
  final bool isCheckingRestrictions;
  final String? restrictionCheckError;
  final RouteStats? metrics;
  final List<FishingRestriction> conflicts;

  RoutePlannerState copyWith({
    List<WaypointEntity>? waypoints,
    double? totalDistanceMeters,
    int? totalDurationMinutes,
    bool? isSaving,
    bool? isCheckingRestrictions,
    String? restrictionCheckError,
    bool clearRestrictionCheckError = false,
    RouteStats? metrics,
    List<FishingRestriction>? conflicts,
  }) {
    return RoutePlannerState(
      waypoints: waypoints ?? this.waypoints,
      totalDistanceMeters: totalDistanceMeters ?? this.totalDistanceMeters,
      totalDurationMinutes: totalDurationMinutes ?? this.totalDurationMinutes,
      isSaving: isSaving ?? this.isSaving,
      isCheckingRestrictions:
          isCheckingRestrictions ?? this.isCheckingRestrictions,
      restrictionCheckError: clearRestrictionCheckError
          ? null
          : restrictionCheckError ?? this.restrictionCheckError,
      metrics: metrics ?? this.metrics,
      conflicts: conflicts ?? this.conflicts,
    );
  }
}

/// Controller to manage adding/removing points and saving route.
class RoutePlannerController extends Notifier<RoutePlannerState> {
  late RouteService _service;
  final _throttle = Throttle(const Duration(milliseconds: 500));
  bool _isDisposed = false;
  int _metricsToken = 0;

  @override
  RoutePlannerState build() {
    _service = ref.watch(routeServiceProvider);

    // Dispose throttle and flag when provider is destroyed
    ref.onDispose(() {
      _isDisposed = true;
      _throttle.dispose();
    });

    return RoutePlannerState.initial();
  }

  Future<void> addWaypoint(double lat, double lon) async {
    // Current points
    final currentList = List<WaypointEntity>.from(state.waypoints);

    // Create new waypoint (temporary ID 0 or negative during creation)
    // orderIndex is simply the next index
    final newWp = WaypointEntity(
      id: 0, // Transient
      routeId: 0, // Transient
      lat: lat,
      lon: lon,
      orderIndex: currentList.length,
      label: 'WP ${currentList.length + 1}',
    );

    currentList.add(newWp);

    // Update waypoints immediately for instant UI feedback
    state = state.copyWith(waypoints: currentList);

    _scheduleMetricsUpdate();
  }

  Future<void> removeWaypoint(int index) async {
    if (index < 0 || index >= state.waypoints.length) return;

    final currentList = List<WaypointEntity>.from(state.waypoints);
    currentList.removeAt(index);

    // Re-index remaining
    for (var i = 0; i < currentList.length; i++) {
      // Must use copyWith because entity is immutable
      currentList[i] = currentList[i].copyWith(orderIndex: i);
    }

    // Update waypoints immediately
    state = state.copyWith(waypoints: currentList);
    _scheduleMetricsUpdate();
  }

  Future<void> reorderWaypoints(int oldIndex, int newIndex) async {
    final currentList = List<WaypointEntity>.from(state.waypoints);
    var adjustedNewIndex = newIndex;
    if (oldIndex < adjustedNewIndex) {
      adjustedNewIndex -= 1;
    }
    final item = currentList.removeAt(oldIndex);
    currentList.insert(adjustedNewIndex, item);

    // Re-index
    for (var i = 0; i < currentList.length; i++) {
      currentList[i] = currentList[i].copyWith(
        orderIndex: i,
        label: 'WP ${i + 1}',
      );
    }

    // Update waypoints immediately
    state = state.copyWith(waypoints: currentList);
    _scheduleMetricsUpdate();
  }

  void _scheduleMetricsUpdate() {
    // Invalidate in-flight isolate work before waiting for the trailing call.
    final token = ++_metricsToken;
    final waypoints = List<WaypointEntity>.unmodifiable(state.waypoints);
    final cruisingSpeed =
        ref.read(vesselSettingsControllerProvider).value?.cruisingSpeedKmh ??
        15.0;
    state = state.copyWith(
      isCheckingRestrictions: waypoints.length >= 2,
      clearRestrictionCheckError: true,
    );

    _throttle.call(
      () => unawaited(
        _updateStateMetrics(
          waypoints,
          cruisingSpeed: cruisingSpeed,
          token: token,
        ),
      ),
    );
  }

  Future<void> _updateStateMetrics(
    List<WaypointEntity> waypoints, {
    required double cruisingSpeed,
    required int token,
  }) async {
    if (token != _metricsToken) return;

    // PERFORMANCE: Using compute() to offload calculation to an isolate
    // We pass ONLY raw data (list of coords) to avoid main-thread fallback on Web
    final waypointsData = waypoints
        .map((w) => {'lat': w.lat, 'lon': w.lon})
        .toList();

    final stats = await compute(_calculateStatsInIsolate, {
      'waypoints': waypointsData,
      'cruisingSpeed': cruisingSpeed,
    });

    final pathPoints = waypoints
        .map((waypoint) => LatLng(waypoint.lat, waypoint.lon))
        .toList(growable: false);

    if (pathPoints.length < 2) {
      if (_isDisposed || token != _metricsToken) return;
      state = state.copyWith(
        waypoints: waypoints,
        totalDistanceMeters: stats.totalDistanceMeters,
        totalDurationMinutes: stats.totalDurationMinutes,
        metrics: stats,
        conflicts: const [],
        isCheckingRestrictions: false,
        clearRestrictionCheckError: true,
      );
      return;
    }

    final pathBBox = _expandedRouteBBox(pathPoints);
    final result = await ref.read(getFishingRestrictionsProvider)(
      minLat: pathBBox.minLat,
      minLng: pathBBox.minLon,
      maxLat: pathBBox.maxLat,
      maxLng: pathBBox.maxLon,
    );

    String? restrictionCheckError;
    final restrictions = result.fold(
      (failure) {
        restrictionCheckError = failure.message;
        return const <FishingRestriction>[];
      },
      (value) => value,
    );

    final filteredRestrictions = restrictions.where((r) {
      final bb = r.boundingBox;
      return bb != null && bb.intersects(pathBBox);
    }).toList();

    final conflicts = filteredRestrictions
        .where((restriction) => restriction.intersectsPath(pathPoints))
        .toList(growable: false);

    if (_isDisposed || token != _metricsToken) return;

    state = state.copyWith(
      waypoints: waypoints,
      totalDistanceMeters: stats.totalDistanceMeters,
      totalDurationMinutes: stats.totalDurationMinutes,
      metrics: stats,
      conflicts: conflicts,
      isCheckingRestrictions: false,
      restrictionCheckError: restrictionCheckError,
      clearRestrictionCheckError: restrictionCheckError == null,
    );
  }

  static BBox _expandedRouteBBox(List<LatLng> pathPoints) {
    const corridorKm = 2.0;
    const kilometresPerLatitudeDegree = 111.0;
    final bbox = BBox.fromPoints(pathPoints);
    const latitudeOffset = corridorKm / kilometresPerLatitudeDegree;
    final latitudeRadians = bbox.center.latitude * math.pi / 180;
    final longitudeScale = math.max(0.1, math.cos(latitudeRadians).abs());
    final longitudeOffset =
        corridorKm / (kilometresPerLatitudeDegree * longitudeScale);

    return BBox(
      minLon: math.max(-180, bbox.minLon - longitudeOffset),
      minLat: math.max(-90, bbox.minLat - latitudeOffset),
      maxLon: math.min(180, bbox.maxLon + longitudeOffset),
      maxLat: math.min(90, bbox.maxLat + latitudeOffset),
    );
  }

  /// Isolate-ready stat calculation (Static & Raw Data Only)
  static Future<RouteStats> _calculateStatsInIsolate(
    Map<String, dynamic> params,
  ) async {
    final waypointsData = List<Map<String, double>>.from(
      params['waypoints'] as List,
    );
    final cruisingSpeed = params['cruisingSpeed'] as double;

    if (cruisingSpeed <= 0) {
      return const RouteStats(
        totalDistanceMeters: 0,
        totalDurationMinutes: 0,
      );
    }

    // Use a static-only calculation to ensure true multi-threading
    double distance = 0;
    const distanceCalc = Distance();

    for (var i = 0; i < waypointsData.length - 1; i++) {
      distance += distanceCalc.as(
        LengthUnit.Meter,
        LatLng(waypointsData[i]['lat']!, waypointsData[i]['lon']!),
        LatLng(waypointsData[i + 1]['lat']!, waypointsData[i + 1]['lon']!),
      );
    }

    final durationMinutes = (distance / 1000 / cruisingSpeed * 60).round();

    return RouteStats(
      totalDistanceMeters: distance,
      totalDurationMinutes: durationMinutes,
    );
  }

  Future<void> saveRoute(String name) async {
    if (state.waypoints.isEmpty) return;

    state = state.copyWith(isSaving: true);
    try {
      await _service.createRoute(name, state.waypoints);
      // Reset after save
      ++_metricsToken;
      state = RoutePlannerState.initial();
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }

  void clear() {
    ++_metricsToken;
    state = RoutePlannerState.initial();
  }
}
