import 'package:latlong2/latlong.dart';

class _Sentinel {
  const _Sentinel();
}

const _sentinel = _Sentinel();

class NavigationState {
  const NavigationState({
    required this.isActive,
    required this.currentLegIndex,
    required this.totalLegs,
    required this.isOffCourse,
    required this.isPositionFresh,
    required this.offCourseThresholdMeters,
    this.routeId,
    this.currentPosition,
    this.bearingToNextWp,
    this.distanceToNextWpMeters,
    this.etaNextWp,
    this.etaDestination,
    this.crossTrackErrorMeters,
    this.distanceRemainingMeters,
    this.totalDistanceMeters,
    this.progressFraction,
    this.lastUpdate,
  });

  final bool isActive;
  final int? routeId;
  final int currentLegIndex;
  final int totalLegs;
  final LatLng? currentPosition;
  final double? bearingToNextWp;
  final double? distanceToNextWpMeters;
  final DateTime? etaNextWp;
  final DateTime? etaDestination;
  final double? crossTrackErrorMeters;
  final double? distanceRemainingMeters;
  final double? totalDistanceMeters;
  final double? progressFraction;
  final bool isOffCourse;
  final bool isPositionFresh;
  final double offCourseThresholdMeters;
  final DateTime? lastUpdate;

  factory NavigationState.initial() {
    return const NavigationState(
      isActive: false,
      currentLegIndex: 0,
      totalLegs: 0,
      isOffCourse: false,
      isPositionFresh: false,
      offCourseThresholdMeters: 100,
    );
  }

  NavigationState copyWith({
    bool? isActive,
    int? currentLegIndex,
    int? totalLegs,
    bool? isOffCourse,
    bool? isPositionFresh,
    double? offCourseThresholdMeters,
    Object? routeId = _sentinel,
    Object? currentPosition = _sentinel,
    Object? bearingToNextWp = _sentinel,
    Object? distanceToNextWpMeters = _sentinel,
    Object? etaNextWp = _sentinel,
    Object? etaDestination = _sentinel,
    Object? crossTrackErrorMeters = _sentinel,
    Object? distanceRemainingMeters = _sentinel,
    Object? totalDistanceMeters = _sentinel,
    Object? progressFraction = _sentinel,
    Object? lastUpdate = _sentinel,
  }) {
    return NavigationState(
      isActive: isActive ?? this.isActive,
      currentLegIndex: currentLegIndex ?? this.currentLegIndex,
      totalLegs: totalLegs ?? this.totalLegs,
      isOffCourse: isOffCourse ?? this.isOffCourse,
      isPositionFresh: isPositionFresh ?? this.isPositionFresh,
      offCourseThresholdMeters:
          offCourseThresholdMeters ?? this.offCourseThresholdMeters,
      routeId: routeId == _sentinel ? this.routeId : routeId as int?,
      currentPosition: currentPosition == _sentinel
          ? this.currentPosition
          : currentPosition as LatLng?,
      bearingToNextWp: bearingToNextWp == _sentinel
          ? this.bearingToNextWp
          : bearingToNextWp as double?,
      distanceToNextWpMeters: distanceToNextWpMeters == _sentinel
          ? this.distanceToNextWpMeters
          : distanceToNextWpMeters as double?,
      etaNextWp: etaNextWp == _sentinel
          ? this.etaNextWp
          : etaNextWp as DateTime?,
      etaDestination: etaDestination == _sentinel
          ? this.etaDestination
          : etaDestination as DateTime?,
      crossTrackErrorMeters: crossTrackErrorMeters == _sentinel
          ? this.crossTrackErrorMeters
          : crossTrackErrorMeters as double?,
      distanceRemainingMeters: distanceRemainingMeters == _sentinel
          ? this.distanceRemainingMeters
          : distanceRemainingMeters as double?,
      totalDistanceMeters: totalDistanceMeters == _sentinel
          ? this.totalDistanceMeters
          : totalDistanceMeters as double?,
      progressFraction: progressFraction == _sentinel
          ? this.progressFraction
          : progressFraction as double?,
      lastUpdate: lastUpdate == _sentinel
          ? this.lastUpdate
          : lastUpdate as DateTime?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NavigationState &&
        other.isActive == isActive &&
        other.routeId == routeId &&
        other.currentLegIndex == currentLegIndex &&
        other.totalLegs == totalLegs &&
        other.currentPosition == currentPosition &&
        other.bearingToNextWp == bearingToNextWp &&
        other.distanceToNextWpMeters == distanceToNextWpMeters &&
        other.etaNextWp == etaNextWp &&
        other.etaDestination == etaDestination &&
        other.crossTrackErrorMeters == crossTrackErrorMeters &&
        other.distanceRemainingMeters == distanceRemainingMeters &&
        other.totalDistanceMeters == totalDistanceMeters &&
        other.progressFraction == progressFraction &&
        other.isOffCourse == isOffCourse &&
        other.isPositionFresh == isPositionFresh &&
        other.offCourseThresholdMeters == offCourseThresholdMeters &&
        other.lastUpdate == lastUpdate;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      isActive,
      routeId,
      currentLegIndex,
      totalLegs,
      currentPosition,
      bearingToNextWp,
      distanceToNextWpMeters,
      etaNextWp,
      etaDestination,
      crossTrackErrorMeters,
      distanceRemainingMeters,
      totalDistanceMeters,
      progressFraction,
      isOffCourse,
      isPositionFresh,
      offCourseThresholdMeters,
      lastUpdate,
    ]);
  }
}
