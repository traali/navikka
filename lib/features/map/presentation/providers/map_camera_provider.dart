import 'dart:async';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_camera_provider.g.dart';

class MapCameraState {
  const MapCameraState({required this.center, required this.zoom});
  final LatLng center;
  final double zoom;

  MapCameraState copyWith({LatLng? center, double? zoom}) {
    return MapCameraState(
      center: center ?? this.center,
      zoom: zoom ?? this.zoom,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapCameraState && center == other.center && zoom == other.zoom;

  @override
  int get hashCode => Object.hash(center, zoom);
}

@riverpod
class MapCameraPosition extends _$MapCameraPosition {
  @override
  MapCameraState build() {
    return const MapCameraState(center: LatLng(60.155, 24.89), zoom: 14);
  }

  void update(LatLng center, double zoom) {
    if (state.center.latitude != center.latitude ||
        state.center.longitude != center.longitude ||
        state.zoom != zoom) {
      state = state.copyWith(center: center, zoom: zoom);
    }
  }
}

@Riverpod(keepAlive: true)
class DebouncedMapCameraPosition extends _$DebouncedMapCameraPosition {
  static const updateInterval = Duration(milliseconds: 500);

  Timer? _publishTimer;
  MapCameraState? _pending;
  DateTime? _lastPublishedAt;

  @override
  MapCameraState build() {
    ref.onDispose(() => _publishTimer?.cancel());

    ref.listen(mapCameraPositionProvider, (_, next) {
      _pending = next;
      final elapsed = _lastPublishedAt == null
          ? updateInterval
          : DateTime.now().difference(_lastPublishedAt!);
      if (elapsed >= updateInterval) {
        _publishPending();
        return;
      }

      _publishTimer ??= Timer(updateInterval - elapsed, _publishPending);
    });

    _lastPublishedAt = DateTime.now();
    return ref.read(mapCameraPositionProvider);
  }

  void _publishPending() {
    _publishTimer?.cancel();
    _publishTimer = null;
    final next = _pending;
    _pending = null;
    if (next == null || !ref.mounted) return;
    state = next;
    _lastPublishedAt = DateTime.now();
  }
}

/// A provider that only updates when the camera has moved significantly
/// (e.g. > 2km or zoom > 0.5 change) to prevent hammering spatial filters.
@riverpod
class SignificantMapCameraPosition extends _$SignificantMapCameraPosition {
  MapCameraState? _lastReported;

  @override
  MapCameraState build() {
    final current = ref.watch(mapCameraPositionProvider);

    if (_lastReported == null) {
      _lastReported = current;
      return current;
    }

    const distance = Distance();
    final moveDist = distance.as(
      LengthUnit.Kilometer,
      _lastReported!.center,
      current.center,
    );
    final zoomDiff = (_lastReported!.zoom - current.zoom).abs();

    if (moveDist > 2.0 || zoomDiff > 0.5) {
      _lastReported = current;
      return current;
    }

    return _lastReported!;
  }
}
