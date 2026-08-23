import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/constants/underway_fetch.dart';
import 'package:sakkoja/core/constants/weather_sync_constants.dart';
import 'package:sakkoja/core/network/network_monitor_provider.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/weather/data/weather_providers.dart';
import 'package:sakkoja/features/weather/domain/services/source_sync_tracker.dart';

part 'point_weather_sync_controller.g.dart';

class PointWeatherSyncState {
  const PointWeatherSyncState({
    this.isSyncing = false,
    this.error,
    this.lastSuccessfulSync,
  });
  final bool isSyncing;
  final String? error;
  final DateTime? lastSuccessfulSync;

  PointWeatherSyncState copyWith({
    bool? isSyncing,
    String? error,
    DateTime? lastSuccessfulSync,
  }) {
    return PointWeatherSyncState(
      isSyncing: isSyncing ?? this.isSyncing,
      error: error ?? this.error,
      lastSuccessfulSync: lastSuccessfulSync ?? this.lastSuccessfulSync,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PointWeatherSyncState &&
        other.isSyncing == isSyncing &&
        other.error == error &&
        other.lastSuccessfulSync == lastSuccessfulSync;
  }

  @override
  int get hashCode => Object.hash(
    isSyncing,
    error,
    lastSuccessfulSync,
  );
}

@riverpod
class PointWeatherSyncController extends _$PointWeatherSyncController {
  late final Map<WeatherSource, SourceSyncTracker> _trackers;
  bool _isDisposed = false;
  Timer? _safetyTimer; // 5 min tick for lightning + alerts
  Timer? _forecastTimer; // 30 min tick fallback
  LatLng? _pendingCenter;
  DateTime? _lastAnySyncTime; // Global minimum gap enforcement
  int _inFlightSyncs = 0; // FIX #439: Track concurrent syncs to prevent races

  @override
  PointWeatherSyncState build() {
    _trackers = {
      for (final source in WeatherSource.values)
        source: SourceSyncTracker(name: source.name),
    };

    ref.onDispose(() {
      _isDisposed = true;
      _safetyTimer?.cancel();
      _forecastTimer?.cancel();
    });

    // ── PRIMARY TRIGGER: Boat position (only after a real GPS fix) ──
    ref.listen(mapProvider.select((s) => (s.userLocation, s.hasLocation)), (
      prev,
      next,
    ) {
      if (_isDisposed) return;
      if (!next.$2) return;
      _checkBoatTriggers(next.$1);
    });

    // ── SECONDARY TRIGGER: Camera pan ──
    ref.listen(significantMapCameraPositionProvider, (prev, next) {
      if (_isDisposed) return;
      _checkPanTriggers(next.center);
    });

    // Initial sync only after GPS — Helsinki default pin is not the boat.
    final initialMap = ref.read(mapProvider);
    if (initialMap.hasLocation) {
      Future.microtask(() {
        if (!_isDisposed) {
          _staggeredStartup(initialMap.userLocation);
        }
      });
    }

    ref.listen(isOnlineProvider, (prev, next) {
      if (_isDisposed) return;
      if (prev == false && next) {
        final map = ref.read(mapProvider);
        if (!map.hasLocation) return;
        _syncAllPending(map.userLocation);
      }
    });

    // ── TIMER TRIGGERS ──
    _startTimers();

    return const PointWeatherSyncState(isSyncing: true);
  }

  void _startTimers() {
    _safetyTimer = Timer.periodic(
      WeatherSyncConstants.lightningTtl,
      (_) => _syncSafety(),
    );

    _forecastTimer = Timer.periodic(
      WeatherSyncConstants.forecastTtl,
      (_) {
        if (_isDisposed) return;
        final map = ref.read(mapProvider);
        if (!map.hasLocation) return;
        _checkBoatTriggers(map.userLocation);
      },
    );
  }

  Future<void> _staggeredStartup(LatLng boatPos) async {
    final isOnline = ref.read(isOnlineProvider);
    if (!isOnline) {
      if (_isDisposed) return;
      state = const PointWeatherSyncState(
        error: 'Offline - showing cached data',
      );
      return;
    }

    state = PointWeatherSyncState(
      isSyncing: true,
      lastSuccessfulSync: state.lastSuccessfulSync,
    );

    try {
      final repo = ref.read(weatherRepositoryProvider);

      // T+0s: Safety first
      await Future.wait([
        _syncSource(WeatherSource.alerts, repo.syncActiveAlerts, boatPos),
        _syncSource(WeatherSource.lightning, repo.syncRecentLightning, boatPos),
      ]);

      if (_isDisposed) return;
      await Future<void>.delayed(WeatherSyncConstants.startupDelayObservations);

      // T+2s: Core weather
      await Future.wait([
        _syncSource(
          WeatherSource.observations,
          () =>
              repo.syncWeatherObservations(boatPos.latitude, boatPos.longitude),
          boatPos,
        ),
        _syncSource(
          WeatherSource.forecast,
          () => repo.syncWeatherForecast(boatPos.latitude, boatPos.longitude),
          boatPos,
        ),
      ]);

      if (_isDisposed) return;
      await Future<void>.delayed(
        WeatherSyncConstants.startupDelaySupplementary -
            WeatherSyncConstants.startupDelayObservations,
      );

      // T+5s: Supplementary
      await Future.wait([
        _syncSource(WeatherSource.seaLevel, repo.syncSeaLevel, boatPos),
        _syncSource(
          WeatherSource.waves,
          () => repo.syncWaveObservations(
            lat: boatPos.latitude,
            lon: boatPos.longitude,
          ),
          boatPos,
        ),
      ]);

      if (_isDisposed) return;
      await Future<void>.delayed(
        WeatherSyncConstants.startupDelayEnvironment -
            WeatherSyncConstants.startupDelaySupplementary,
      );

      // T+10s: Environment
      await Future.wait([
        _syncSource(
          WeatherSource.waterQuality,
          () => repo.syncWaterQuality(boatPos.latitude, boatPos.longitude),
          boatPos,
        ),
        _syncSource(
          WeatherSource.algae,
          () => repo.syncAlgaeReports(boatPos.latitude, boatPos.longitude),
          boatPos,
        ),
      ]);

      if (_isDisposed) return;
      if (state.error == null) {
        state = PointWeatherSyncState(
          lastSuccessfulSync: DateTime.now(),
        );
      } else {
        state = state.copyWith(isSyncing: false);
      }
    } catch (e, s) {
      Log.e('PointWeatherSync: Staggered startup failed', e, s);
      if (_isDisposed) return;
      state = state.copyWith(isSyncing: false, error: sanitizeNetworkError(e));
    }
  }

  void _syncAllPending(LatLng boatPos) {
    _staggeredStartup(boatPos);
  }

  /// Public attemptSync used for manual syncs (e.g., Pull-to-Refresh)
  /// It forces sync of all resources immediately by ignoring thresholds
  Future<void> attemptSync(LatLng center) async {
    if (_isDisposed) return;

    if (state.isSyncing) {
      _pendingCenter = center;
      Log.d('PointWeatherSync: Skipping sync, already in progress.');
      return;
    }

    final isOnline = ref.read(isOnlineProvider);
    if (!isOnline) {
      if (_isDisposed) return;
      state = const PointWeatherSyncState(
        error: 'Offline - showing cached data',
      );
      return;
    }

    state = PointWeatherSyncState(
      isSyncing: true,
      lastSuccessfulSync: state.lastSuccessfulSync,
    );

    try {
      final repo = ref.read(weatherRepositoryProvider);

      // Manual / Force refresh syncs all 8 sources concurrently
      await Future.wait([
        repo.syncActiveAlerts(),
        repo.syncRecentLightning(),
        repo.syncWeatherObservations(center.latitude, center.longitude),
        repo.syncWeatherForecast(center.latitude, center.longitude),
        repo.syncSeaLevel(),
        repo.syncWaveObservations(lat: center.latitude, lon: center.longitude),
        repo.syncWaterQuality(center.latitude, center.longitude),
        repo.syncAlgaeReports(center.latitude, center.longitude),
      ]);

      // Mark all trackers as synced at this position
      for (final source in WeatherSource.values) {
        _trackers[source]!.markSynced(center);
      }

      state = PointWeatherSyncState(
        lastSuccessfulSync: DateTime.now(),
      );
    } catch (e, s) {
      Log.e('PointWeatherSync: Manual sync failed', e, s);
      if (_isDisposed) return;
      state = state.copyWith(isSyncing: false, error: sanitizeNetworkError(e));
    } finally {
      final pending = _pendingCenter;
      _pendingCenter = null;
      if (pending != null && !_isDisposed) {
        unawaited(
          attemptSync(pending).catchError((Object error, StackTrace stack) {
            Log.e('PointWeatherSync: Pending sync failed', error, stack);
          }),
        );
      }
    }
  }

  void _checkBoatTriggers(LatLng boatPos) {
    if (_inFlightSyncs > 0 || state.isSyncing) return;
    final now = DateTime.now();
    if (_lastAnySyncTime != null &&
        now.difference(_lastAnySyncTime!) <
            WeatherSyncConstants.globalMinSyncGap) {
      return;
    }
    final repo = ref.read(weatherRepositoryProvider);

    // Observations
    if (_trackers[WeatherSource.observations]!.shouldSyncForBoat(
      ttl: WeatherSyncConstants.observationsTtl,
      distanceThresholdKm: WeatherSyncConstants.observationsBoatDistanceKm,
      boatPosition: boatPos,
    )) {
      _syncSource(
        WeatherSource.observations,
        () => repo.syncWeatherObservations(boatPos.latitude, boatPos.longitude),
        boatPos,
      );
    }

    // Forecast
    if (_trackers[WeatherSource.forecast]!.shouldSyncForBoat(
      ttl: WeatherSyncConstants.forecastTtl,
      distanceThresholdKm: WeatherSyncConstants.forecastBoatDistanceKm,
      boatPosition: boatPos,
    )) {
      _syncSource(
        WeatherSource.forecast,
        () => repo.syncWeatherForecast(boatPos.latitude, boatPos.longitude),
        boatPos,
      );
    }

    // Sea level
    if (_trackers[WeatherSource.seaLevel]!.shouldSyncForBoat(
      ttl: WeatherSyncConstants.seaLevelTtl,
      distanceThresholdKm: WeatherSyncConstants.seaLevelBoatDistanceKm,
      boatPosition: boatPos,
    )) {
      _syncSource(
        WeatherSource.seaLevel,
        repo.syncSeaLevel,
        boatPos,
      );
    }

    // Waves
    if (_trackers[WeatherSource.waves]!.shouldSyncForBoat(
      ttl: WeatherSyncConstants.wavesTtl,
      distanceThresholdKm: WeatherSyncConstants.wavesBoatDistanceKm,
      boatPosition: boatPos,
    )) {
      _syncSource(
        WeatherSource.waves,
        () => repo.syncWaveObservations(
          lat: boatPos.latitude,
          lon: boatPos.longitude,
        ),
        boatPos,
      );
    }
  }

  void _checkPanTriggers(LatLng cameraPos) {
    if (_inFlightSyncs > 0 || state.isSyncing) return;
    final repo = ref.read(weatherRepositoryProvider);

    // Observations
    if (_trackers[WeatherSource.observations]!.shouldSyncForPan(
      panDistanceKm: WeatherSyncConstants.observationsPanDistanceKm,
      panCooldown: WeatherSyncConstants.observationsPanCooldown,
      cameraPosition: cameraPos,
    )) {
      _syncSourceForPan(
        WeatherSource.observations,
        () => repo.syncWeatherObservations(
          cameraPos.latitude,
          cameraPos.longitude,
        ),
        cameraPos,
      );
    }

    // Forecast
    if (_trackers[WeatherSource.forecast]!.shouldSyncForPan(
      panDistanceKm: WeatherSyncConstants.forecastPanDistanceKm,
      panCooldown: WeatherSyncConstants.forecastPanCooldown,
      cameraPosition: cameraPos,
    )) {
      _syncSourceForPan(
        WeatherSource.forecast,
        () => repo.syncWeatherForecast(cameraPos.latitude, cameraPos.longitude),
        cameraPos,
      );
    }

    // Sea Level
    if (_trackers[WeatherSource.seaLevel]!.shouldSyncForPan(
      panDistanceKm: WeatherSyncConstants.seaLevelPanDistanceKm,
      panCooldown: WeatherSyncConstants.seaLevelPanCooldown,
      cameraPosition: cameraPos,
    )) {
      _syncSourceForPan(
        WeatherSource.seaLevel,
        repo.syncSeaLevel,
        cameraPos,
      );
    }

    // Waves
    if (_trackers[WeatherSource.waves]!.shouldSyncForPan(
      panDistanceKm: WeatherSyncConstants.wavesPanDistanceKm,
      panCooldown: WeatherSyncConstants.wavesPanCooldown,
      cameraPosition: cameraPos,
    )) {
      _syncSourceForPan(
        WeatherSource.waves,
        () => repo.syncWaveObservations(
          lat: cameraPos.latitude,
          lon: cameraPos.longitude,
        ),
        cameraPos,
      );
    }
  }

  void _syncSafety() {
    if (_isDisposed) return;
    final isOnline = ref.read(isOnlineProvider);
    if (!isOnline) return;

    final repo = ref.read(weatherRepositoryProvider);
    final boatPos = ref.read(mapProvider).userLocation;

    _syncSource(WeatherSource.lightning, repo.syncRecentLightning, boatPos);
    _syncSource(WeatherSource.alerts, repo.syncActiveAlerts, boatPos);
  }

  Future<void> _syncSource(
    WeatherSource source,
    Future<void> Function() syncFn,
    LatLng boatPos,
  ) async {
    if (_isDisposed) return;
    _inFlightSyncs++;
    _trackers[source]!.startSync();
    try {
      await syncFn();
      if (!_isDisposed) {
        _trackers[source]!.markSynced(boatPos);
        _lastAnySyncTime = DateTime.now();
      }
    } catch (e, s) {
      Log.e('Sync failed for ${source.name}', e, s);
      if (!_isDisposed) {
        state = state.copyWith(error: sanitizeNetworkError(e));
      }
    } finally {
      _inFlightSyncs--;
      if (!_isDisposed) _trackers[source]!.endSync();
    }
  }

  Future<void> _syncSourceForPan(
    WeatherSource source,
    Future<void> Function() syncFn,
    LatLng cameraPos,
  ) async {
    if (_isDisposed) return;
    _inFlightSyncs++;
    _trackers[source]!.startSync();
    try {
      await syncFn();
      if (!_isDisposed) _trackers[source]!.markPanSynced(cameraPos);
    } catch (e, s) {
      Log.e('Pan sync failed for ${source.name}', e, s);
      if (!_isDisposed) {
        state = state.copyWith(error: sanitizeNetworkError(e));
      }
    } finally {
      _inFlightSyncs--;
      if (!_isDisposed) _trackers[source]!.endSync();
    }
  }

  Future<void> clearCache() async {
    if (_isDisposed) return;
    try {
      await ref.read(weatherRepositoryProvider).clearCache();
      for (final tracker in _trackers.values) {
        tracker.reset();
      }
      state = const PointWeatherSyncState();
    } catch (e, s) {
      Log.w('PointWeatherSync: clearCache failed', e, s);
    }
  }
}
