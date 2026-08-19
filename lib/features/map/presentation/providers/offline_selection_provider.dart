import 'package:flutter_map/flutter_map.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'offline_selection_provider.g.dart';

@riverpod
class OfflineSelectionMode extends _$OfflineSelectionMode {
  @override
  bool build() => false;

  void toggle() => state = !state;
  void enable() => state = true;
  void disable() => state = false;
}

@riverpod
class SelectionBounds extends _$SelectionBounds {
  @override
  LatLngBounds? build() => null;

  void update(LatLngBounds bounds) => state = bounds;
  void clear() => state = null;
}
