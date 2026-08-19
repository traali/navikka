import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/services/location_service.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/map/data/services/zone_spatial_service.dart';
import 'package:sakkoja/features/map/di/map_di.dart';
import 'package:sakkoja/features/map/domain/entities/map_state.dart';
import 'package:sakkoja/features/map/domain/repositories/map_repository.dart';
import 'package:sakkoja/features/map/domain/services/motion_estimator.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';
import 'package:sakkoja/features/speed_limits/presentation/providers/speed_limit_provider.dart';

export 'package:sakkoja/core/services/location_service.dart'
    show LocationPermissionResult;

part 'map_provider.g.dart';

@riverpod
class MapNotifier extends _$MapNotifier {
  static const _spatialDistanceMeters = 10.0;
  static const _spatialMaxInterval = Duration(seconds: 1);
  static const _projectedCenterMinimumSpeedKmh = 1.0;
  static const locationStaleAfter = Duration(seconds: 15);
  static const _persistenceDistanceMeters = 100.0;
  static const _persistenceMinInterval = Duration(minutes: 1);

  late final LocationService _locationService;
  late final MapRepository _repository;
  late final ZoneSpatialService _zoneSpatialService;
  final MotionEstimator _motionEstimator = MotionEstimator();

  // ignore: cancel_subscriptions
  StreamSubscription<Position>? _locationSubscription;
  Timer? _staleLocationTimer;
  var _locationSampleGeneration = 0;
  LatLng? _lastSpatialLocation;
  DateTime? _lastSpatialAt;
  LatLng? _lastPersistedLocation;
  DateTime? _lastPersistedAt;
  LatLng? _pendingPersistenceLocation;
  DateTime? _pendingPersistenceAt;
  var _isPersisting = false;
  var _spatialGeneration = 0;

  @override
  MapState build() {
    _repository = ref.watch(mapRepositoryProvider);
    _locationService = ref.read(locationServiceProvider);
    _zoneSpatialService = ref.read(zoneSpatialServiceProvider);

    ref.listen<AsyncValue<List<SpeedLimitZone>>>(speedLimitsProvider, (
      previous,
      next,
    ) {
      if (!state.hasLocation) return;
      _scheduleSpatialUpdate(
        state.userLocation,
        next.value ?? const [],
        DateTime.now(),
        force: true,
      );
    });

    ref.onDispose(() {
      _spatialGeneration++;
      _locationSampleGeneration++;
      _staleLocationTimer?.cancel();
      _staleLocationTimer = null;
      final subscription = _locationSubscription;
      _locationSubscription = null;
      if (subscription != null) {
        unawaited(subscription.cancel());
      }
    });

    _loadLastLocation();
    _initLocation();

    return const MapState(userLocation: LatLng(60.155, 24.89));
  }

  Future<void> _loadLastLocation() async {
    final result = await _repository.getLastLocation();
    if (!ref.mounted) return;

    result.fold(
      (failure) => Log.e('Failed to load last location: ${failure.message}'),
      (location) {
        if (location != null && !state.hasLocation) {
          state = state.copyWith(userLocation: location);
        }
      },
    );
  }

  Future<void> _initLocation() async {
    if (_locationSubscription != null) return;

    try {
      final permissionResult = await _locationService.requestPermission();
      if (!ref.mounted) return;

      if (permissionResult != LocationPermissionResult.granted) {
        Log.w('MapNotifier: Location permission denied. Using default.');
        state = state.copyWith(
          locationPermissionStatus: _mapPermissionResult(permissionResult),
        );
        return;
      }

      state = state.copyWith(
        locationPermissionStatus: LocationPermissionStatus.granted,
      );
      // ignore: cancel_subscriptions
      _locationSubscription = _locationService.getPositionStream().listen(
        _onLocationChanged,
        onError: (Object error) {
          Log.e('MapNotifier: Location error (using default): $error');
        },
        cancelOnError: false,
      );
    } catch (error, stackTrace) {
      Log.e(
        'MapNotifier: Location init failed (using default)',
        error,
        stackTrace,
      );
    }
  }

  /// Manually re-trigger browser/OS location permission request and subscription.
  Future<void> requestLocation() async {
    final subscription = _locationSubscription;
    _locationSubscription = null;
    if (subscription != null) {
      unawaited(subscription.cancel());
    }
    await _initLocation();
  }

  LocationPermissionStatus _mapPermissionResult(
    LocationPermissionResult result,
  ) {
    switch (result) {
      case LocationPermissionResult.granted:
        return LocationPermissionStatus.granted;
      case LocationPermissionResult.denied:
        return LocationPermissionStatus.denied;
      case LocationPermissionResult.deniedForever:
        return LocationPermissionStatus.deniedForever;
      case LocationPermissionResult.serviceDisabled:
        return LocationPermissionStatus.serviceDisabled;
    }
  }

  void _onLocationChanged(Position position) {
    if (!ref.mounted) return;

    final sampleTime = position.timestamp;

    // Filter out-of-order timestamps and implausibly low-accuracy GPS fixes
    // On web, desktop browsers use Wi-Fi/IP location which can report 1000m-10000m accuracy.
    const maxAccuracy = kIsWeb ? 50000.0 : 150.0;
    if (position.accuracy > maxAccuracy) {
      Log.w(
        'MapNotifier: Rejected low-accuracy GPS fix (${position.accuracy.toStringAsFixed(1)}m)',
      );
      return;
    }
    if (state.lastPositionAt != null &&
        sampleTime.isBefore(state.lastPositionAt!)) {
      Log.w(
        'MapNotifier: Rejected out-of-order GPS fix timestamp ($sampleTime < ${state.lastPositionAt})',
      );
      return;
    }

    final point = LatLng(position.latitude, position.longitude);
    final motion = _motionEstimator.update(
      location: point,
      timestamp: sampleTime,
      accuracyMeters: position.accuracy,
      reportedSpeedMps: position.speed,
      reportedHeading: position.heading,
    );
    final projectedCenter = motion.speedKmh >= _projectedCenterMinimumSpeedKmh
        ? const Distance().offset(point, 1000, motion.heading)
        : point;

    if (!state.hasLocation) {
      SafeHaptics.medium(isUserTriggered: false);
    }

    // Navigation values must reflect each browser sample. Spatial work and
    // persistence below are intentionally independent from this update.
    state = state.copyWith(
      userLocation: point,
      lastPositionAt: sampleTime,
      isLocationFresh: true,
      currentSpeedKmh: motion.speedKmh,
      heading: motion.heading,
      projectedCenter: projectedCenter,
      hasLocation: true,
    );

    _armStaleLocationTimer();

    final zones = ref.read(speedLimitsProvider).value ?? const [];
    if (_shouldRunSpatialUpdate(point, sampleTime)) {
      _scheduleSpatialUpdate(point, zones, sampleTime);
    }
    _persistLocationIfDue(point, sampleTime);
  }

  void _armStaleLocationTimer() {
    _staleLocationTimer?.cancel();
    final generation = ++_locationSampleGeneration;
    _staleLocationTimer = Timer(locationStaleAfter, () {
      if (!ref.mounted || generation != _locationSampleGeneration) return;

      _lastSpatialLocation = null;
      _lastSpatialAt = null;
      state = state.copyWith(
        isLocationFresh: false,
        currentSpeedKmh: 0,
        projectedCenter: state.userLocation,
        currentZone: null,
      );
    });
  }

  bool _shouldRunSpatialUpdate(LatLng point, DateTime sampleTime) {
    final previousLocation = _lastSpatialLocation;
    final previousTime = _lastSpatialAt;
    if (previousLocation == null || previousTime == null) return true;

    final distanceMeters = const Distance().as(
      LengthUnit.Meter,
      previousLocation,
      point,
    );
    return distanceMeters >= _spatialDistanceMeters ||
        sampleTime.difference(previousTime) >= _spatialMaxInterval;
  }

  void _scheduleSpatialUpdate(
    LatLng point,
    List<SpeedLimitZone> zones,
    DateTime sampleTime, {
    bool force = false,
  }) {
    if (!ref.mounted) return;
    if (!force && !_shouldRunSpatialUpdate(point, sampleTime)) return;

    _lastSpatialLocation = point;
    _lastSpatialAt = sampleTime;
    final generation = ++_spatialGeneration;
    unawaited(_calculateSpatialUpdate(generation, point, zones));
  }

  Future<void> _calculateSpatialUpdate(
    int generation,
    LatLng point,
    List<SpeedLimitZone> zones,
  ) async {
    try {
      final spatialResult = await _zoneSpatialService.calculateOptimized(
        userLocation: point,
        allZones: zones,
      );
      if (!ref.mounted || generation != _spatialGeneration) return;

      state = state.copyWith(
        currentZone: spatialResult.activeZone,
        visibleZones: spatialResult.visibleZones,
      );
    } catch (error, stackTrace) {
      Log.e('MapNotifier: Zone calculation failed', error, stackTrace);
    }
  }

  void _persistLocationIfDue(LatLng point, DateTime sampleTime) {
    final previousLocation = _lastPersistedLocation;
    final previousTime = _lastPersistedAt;
    final shouldPersist =
        previousLocation == null ||
        previousTime == null ||
        const Distance().as(LengthUnit.Meter, previousLocation, point) >=
            _persistenceDistanceMeters ||
        sampleTime.difference(previousTime) >= _persistenceMinInterval;
    if (!shouldPersist) return;

    _pendingPersistenceLocation = point;
    _pendingPersistenceAt = sampleTime;
    if (!_isPersisting) {
      unawaited(_flushPendingPersistence());
    }
  }

  Future<void> _flushPendingPersistence() async {
    if (_isPersisting) return;
    _isPersisting = true;

    while (_pendingPersistenceLocation != null &&
        _pendingPersistenceAt != null) {
      final location = _pendingPersistenceLocation!;
      final timestamp = _pendingPersistenceAt!;
      _pendingPersistenceLocation = null;
      _pendingPersistenceAt = null;

      try {
        final result = await _repository.saveLastLocation(location);
        result.fold(
          (failure) =>
              Log.e('Failed to save last location: ${failure.message}'),
          (_) {
            _lastPersistedLocation = location;
            _lastPersistedAt = timestamp;
          },
        );
      } catch (error, stackTrace) {
        Log.e('Failed to save last location', error, stackTrace);
      }
    }

    _isPersisting = false;
  }
}
