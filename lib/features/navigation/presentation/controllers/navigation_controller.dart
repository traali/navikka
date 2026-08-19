import 'dart:async';

import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/features/map/domain/entities/map_state.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/navigation/domain/entities/navigation_state.dart';
import 'package:sakkoja/features/navigation/domain/entities/waypoint_entity.dart';
import 'package:sakkoja/features/navigation/domain/services/navigation_service.dart';
import 'package:sakkoja/features/navigation/presentation/providers/navigation_providers.dart';

part 'navigation_controller.g.dart';

@riverpod
class NavigationController extends _$NavigationController {
  static const updateInterval = Duration(milliseconds: 500);

  Timer? _pendingUpdate;
  List<WaypointEntity> _waypoints = [];
  List<LatLng> _routePoints = [];
  List<double> _distanceFromWaypointToDestination = [];
  double? _cachedTotalDistance;
  DateTime? _lastCalculationAt;
  bool _isDisposed = false;

  @override
  Future<NavigationState> build() async {
    _isDisposed = false;
    _pendingUpdate?.cancel();
    _cachedTotalDistance = null;
    _lastCalculationAt = null;

    ref.onDispose(() {
      _isDisposed = true;
      _pendingUpdate?.cancel();
    });

    ref.listen(mapProvider, (_, next) {
      if (!next.isLocationFresh) {
        _markPositionStale();
        return;
      }
      _scheduleNavigationUpdate(next);
    });

    final activeRoute = await ref.watch(activeRouteProvider.future);
    if (activeRoute == null) {
      return NavigationState.initial();
    }

    final waypoints = await ref.watch(
      waypointsForRouteProvider(activeRoute.id).future,
    );

    _waypoints = waypoints;
    _routePoints = waypoints.map((w) => LatLng(w.lat, w.lon)).toList();

    if (waypoints.isEmpty) {
      return NavigationState.initial().copyWith(
        isActive: true,
        routeId: activeRoute.id,
        totalLegs: 0,
      );
    }

    _distanceFromWaypointToDestination = _calculateRemainingDistances(
      _routePoints,
    );
    _cachedTotalDistance = _distanceFromWaypointToDestination.first;

    final initial = NavigationState.initial().copyWith(
      isActive: true,
      routeId: activeRoute.id,
      totalLegs: waypoints.length - 1,
      totalDistanceMeters: _cachedTotalDistance,
    );
    final mapState = ref.read(mapProvider);
    if (mapState.isLocationFresh) {
      Timer.run(() => _scheduleNavigationUpdate(mapState, force: true));
    }
    return initial;
  }

  void _scheduleNavigationUpdate(MapState mapState, {bool force = false}) {
    if (_isDisposed || !mapState.isLocationFresh) return;

    final now = DateTime.now();
    final elapsed = _lastCalculationAt == null
        ? updateInterval
        : now.difference(_lastCalculationAt!);
    if (force || elapsed >= updateInterval) {
      _pendingUpdate?.cancel();
      _pendingUpdate = null;
      _updateNavigationState(mapState);
      return;
    }

    _pendingUpdate?.cancel();
    _pendingUpdate = Timer(updateInterval - elapsed, () {
      _pendingUpdate = null;
      if (!_isDisposed) {
        final latest = ref.read(mapProvider);
        if (latest.isLocationFresh) _updateNavigationState(latest);
      }
    });
  }

  void _updateNavigationState(MapState mapState) {
    if (!mapState.isLocationFresh) return;

    final currentPosition = mapState.userLocation;
    final currentSpeedKmh = mapState.currentSpeedKmh;
    final currentState = state.value;
    if (currentState == null || !currentState.isActive) return;

    var currentLegIndex = currentState.currentLegIndex;
    if (currentLegIndex >= _waypoints.length - 1) {
      _markComplete();
      return;
    }

    var currentWp = _routePoints[currentLegIndex];
    var nextWp = _routePoints[currentLegIndex + 1];

    if (NavigationService.isPassedWaypoint(
      current: currentPosition,
      target: nextWp,
      previous: currentWp,
    )) {
      currentLegIndex++;
      if (currentLegIndex >= _waypoints.length - 1) {
        _markComplete();
        return;
      }
      currentWp = _routePoints[currentLegIndex];
      nextWp = _routePoints[currentLegIndex + 1];
    }

    final bearingToNextWp = NavigationService.calculateBearing(
      currentPosition,
      nextWp,
    );

    final distanceToNextWp = NavigationService.calculateDistance(
      currentPosition,
      nextWp,
    );

    final etaNextWp = NavigationService.calculateETA(
      distanceMeters: distanceToNextWp,
      speedKmh: currentSpeedKmh,
    );

    final xte = NavigationService.calculateCrossTrackError(
      currentWp,
      nextWp,
      currentPosition,
    );

    final distanceRemaining =
        distanceToNextWp +
        _distanceFromWaypointToDestination[currentLegIndex + 1];

    final totalDistance =
        _cachedTotalDistance ?? _calculateTotalDistance(_waypoints);
    final progressFraction = totalDistance <= 0
        ? 0.0
        : ((totalDistance - distanceRemaining) / totalDistance).clamp(0.0, 1.0);

    final etaDestination = NavigationService.calculateETA(
      distanceMeters: distanceRemaining,
      speedKmh: currentSpeedKmh,
    );

    final offCourseThreshold = currentState.offCourseThresholdMeters;
    final isOffCourse = xte.abs() > offCourseThreshold;

    state = AsyncValue.data(
      currentState.copyWith(
        currentLegIndex: currentLegIndex,
        currentPosition: currentPosition,
        bearingToNextWp: bearingToNextWp,
        distanceToNextWpMeters: distanceToNextWp,
        etaNextWp: etaNextWp,
        etaDestination: etaDestination,
        crossTrackErrorMeters: xte,
        distanceRemainingMeters: distanceRemaining,
        totalDistanceMeters: totalDistance,
        progressFraction: progressFraction,
        isOffCourse: isOffCourse,
        isPositionFresh: true,
        lastUpdate: mapState.lastPositionAt,
      ),
    );
    _lastCalculationAt = DateTime.now();
  }

  void _markPositionStale() {
    _pendingUpdate?.cancel();
    _pendingUpdate = null;
    final currentState = state.value;
    if (currentState == null || !currentState.isActive) return;
    state = AsyncValue.data(
      currentState.copyWith(
        isPositionFresh: false,
        etaNextWp: null,
        etaDestination: null,
      ),
    );
  }

  void _markComplete() {
    _pendingUpdate?.cancel();
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(
      currentState.copyWith(
        isActive: false,
        isPositionFresh: false,
        currentLegIndex: _waypoints.length - 1,
        lastUpdate: DateTime.now(),
      ),
    );
  }

  double _calculateTotalDistance(List<WaypointEntity> waypoints) {
    double total = 0;
    for (var i = 0; i < waypoints.length - 1; i++) {
      total += NavigationService.calculateDistance(
        LatLng(waypoints[i].lat, waypoints[i].lon),
        LatLng(waypoints[i + 1].lat, waypoints[i + 1].lon),
      );
    }
    return total;
  }

  List<double> _calculateRemainingDistances(List<LatLng> points) {
    final remaining = List<double>.filled(points.length, 0);
    for (var i = points.length - 2; i >= 0; i--) {
      remaining[i] =
          remaining[i + 1] +
          NavigationService.calculateDistance(points[i], points[i + 1]);
    }
    return remaining;
  }

  void skipToNextWaypoint() {
    final currentState = state.value;
    if (currentState == null || !currentState.isActive) return;

    final nextLeg = currentState.currentLegIndex + 1;
    if (nextLeg >= currentState.totalLegs) {
      _markComplete();
      return;
    }

    state = AsyncValue.data(
      currentState.copyWith(
        currentLegIndex: nextLeg,
        lastUpdate: DateTime.now(),
      ),
    );
  }

  void cancelNavigation() {
    _pendingUpdate?.cancel();
    state = AsyncValue.data(NavigationState.initial());
  }
}
