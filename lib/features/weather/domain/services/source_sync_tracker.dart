import 'package:latlong2/latlong.dart';

/// Tracks the last sync state for a single data source.
///
/// Determines whether a new sync is needed based on:
/// - Time since last sync (TTL expiry)
/// - Distance the boat has moved since last sync
/// - Distance the camera has panned since last pan-fetch
class SourceSyncTracker {
  SourceSyncTracker({
    required this.name,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  final String name;
  final DateTime Function() _now;

  DateTime _lastSyncTime = DateTime.fromMillisecondsSinceEpoch(0);
  LatLng? _lastSyncBoatPosition;
  DateTime _lastPanSyncTime = DateTime.fromMillisecondsSinceEpoch(0);
  LatLng? _lastPanPosition;
  DateTime? _lastAttemptTime;
  bool _hasSynced = false;
  bool _isSyncing = false;

  /// Whether this source has ever completed a sync.
  bool get hasSynced => _hasSynced;

  /// Whether a sync request for this source is currently in flight.
  bool get isSyncing => _isSyncing;

  /// Starts sync in-flight tracking.
  void startSync() {
    _isSyncing = true;
    _lastAttemptTime = _now();
  }

  /// Ends sync in-flight tracking.
  void endSync() {
    _isSyncing = false;
  }

  bool shouldSyncForBoat({
    required Duration ttl,
    required double distanceThresholdKm,
    required LatLng boatPosition,
  }) {
    if (_isSyncing) return false;
    final now = _now();
    final timeExpired = now.difference(_lastSyncTime) >= ttl;

    if (!_hasSynced) {
      if (_lastAttemptTime != null &&
          now.difference(_lastAttemptTime!) < const Duration(seconds: 60)) {
        return false;
      }
      return true;
    }


    if (_lastSyncBoatPosition == null) return timeExpired;

    final boatMoved =
        const Distance().as(
          LengthUnit.Kilometer,
          _lastSyncBoatPosition!,
          boatPosition,
        ) >=
        distanceThresholdKm;

    return timeExpired || boatMoved;
  }

  /// Check if a sync is needed based on camera pan + time.
  bool shouldSyncForPan({
    required double panDistanceKm,
    required Duration panCooldown,
    required LatLng cameraPosition,
  }) {
    if (_isSyncing) return false;
    final now = _now();

    // Enforce cooldown
    if (now.difference(_lastPanSyncTime) < panCooldown) return false;

    if (_lastPanPosition == null && _lastSyncBoatPosition == null) return true;

    final reference = _lastPanPosition ?? _lastSyncBoatPosition!;
    final cameraMoved =
        const Distance().as(
          LengthUnit.Kilometer,
          reference,
          cameraPosition,
        ) >=
        panDistanceKm;

    return cameraMoved;
  }

  /// Mark this source as synced at the given boat position.
  void markSynced(LatLng boatPosition) {
    _lastSyncTime = _now();
    _lastSyncBoatPosition = boatPosition;
    _hasSynced = true;
  }

  /// Mark this source as synced via camera pan.
  void markPanSynced(LatLng cameraPosition) {
    _lastPanSyncTime = _now();
    _lastPanPosition = cameraPosition;
  }

  /// Reset all tracking (e.g. after cache clear).
  void reset() {
    _lastSyncTime = DateTime.fromMillisecondsSinceEpoch(0);
    _lastSyncBoatPosition = null;
    _lastPanSyncTime = DateTime.fromMillisecondsSinceEpoch(0);
    _lastPanPosition = null;
    _lastAttemptTime = null;
    _hasSynced = false;
    _isSyncing = false;
  }
}

/// Enum for the 8 data source types.
enum WeatherSource {
  lightning,
  alerts,
  observations,
  forecast,
  seaLevel,
  waves,
  waterQuality,
  algae,
}
