import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/services/geometry_utils.dart';

part 'bbox_fetch_throttle_provider.g.dart';

/// Throttle state for API fetch decisions
class BboxFetchState {
  const BboxFetchState({this.lastFetchedTiles = const {}});

  /// Map of 'key' (data type) -> 'tileId' (last fetched tile)
  final Map<String, String> lastFetchedTiles;

  BboxFetchState copyWith({Map<String, String>? lastFetchedTiles}) {
    return BboxFetchState(
      lastFetchedTiles: lastFetchedTiles ?? this.lastFetchedTiles,
    );
  }
}

/// Provider to manage fetch throttling for bbox API queries.
///
/// Implements "Smart Grid" strategy checking grid tiles.
/// Supports multiple data types via 'key' parameter.
@Riverpod(keepAlive: true)
class BboxFetchThrottle extends _$BboxFetchThrottle {
  @override
  BboxFetchState build() => const BboxFetchState();

  /// Returns true if the user has moved to a new tile for the given key.
  /// Default key is 'default' for backward compatibility if needed.
  bool shouldFetch(LatLng? currentLocation, {String key = 'default'}) {
    if (currentLocation == null) return false;

    final currentTileId = GeometryUtils.getTileId(currentLocation);
    final lastFetched = state.lastFetchedTiles[key];

    // If tile changed (or never fetched), we need data for this new area
    return currentTileId != lastFetched;
  }

  /// Mark that a fetch was performed for the given location (Tile) and key.
  void markFetched(LatLng currentLocation, {String key = 'default'}) {
    final tileId = GeometryUtils.getTileId(currentLocation);
    final newMap = Map<String, String>.from(state.lastFetchedTiles);
    newMap[key] = tileId;
    state = BboxFetchState(lastFetchedTiles: newMap);
  }

  /// Returns true if the projected location along heading vector is in a new tile.
  /// Used in Navigation Mode when speed > 5 knots (9.26 km/h).
  bool shouldFetchPredictive(
    LatLng? currentLocation,
    double heading,
    double speedKmh, {
    String key = 'default',
  }) {
    if (currentLocation == null || speedKmh < 9.26) return false;

    final projected = const Distance().offset(currentLocation, 1000, heading);
    final projectedTileId = GeometryUtils.getTileId(projected);
    final lastFetched = state.lastFetchedTiles['${key}_pred'];

    return projectedTileId != lastFetched;
  }

  /// Mark predictive tile fetched
  void markPredictiveFetched(
    LatLng currentLocation,
    double heading, {
    String key = 'default',
  }) {
    final projected = const Distance().offset(currentLocation, 1000, heading);
    final projectedTileId = GeometryUtils.getTileId(projected);
    final newMap = Map<String, String>.from(state.lastFetchedTiles);
    newMap['${key}_pred'] = projectedTileId;
    state = BboxFetchState(lastFetchedTiles: newMap);
  }

  /// Reset throttle state
  void reset() {
    state = const BboxFetchState();
  }
}
