import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_auto_follow_provider.g.dart';

enum MapNavigationMode {
  /// Standard overview mode: North-Up, boat centered
  northUp,

  /// Active boating mode: Heading-Up, boat positioned in lower 30% of viewport
  boatingHeadingUp,
}

@riverpod
class MapAutoFollow extends _$MapAutoFollow {
  @override
  bool build() => true;

  void setAutoFollow(bool enabled) {
    if (state != enabled) {
      state = enabled;
    }
  }

  void enable() => setAutoFollow(true);
  void disable() => setAutoFollow(false);
}

@riverpod
class MapNavigationModeNotifier extends _$MapNavigationModeNotifier {
  @override
  MapNavigationMode build() => MapNavigationMode.boatingHeadingUp;

  void setMode(MapNavigationMode mode) {
    if (state != mode) {
      state = mode;
    }
  }

  void toggle() {
    state = state == MapNavigationMode.boatingHeadingUp
        ? MapNavigationMode.northUp
        : MapNavigationMode.boatingHeadingUp;
  }
}

@riverpod
class Map3dTiltNotifier extends _$Map3dTiltNotifier {
  @override
  bool build() => true; // Enabled by default in Boating Mode

  void setTilt(bool enabled) {
    if (state != enabled) {
      state = enabled;
      ref
          .read(mapNavigationModeProvider.notifier)
          .setMode(
            enabled
                ? MapNavigationMode.boatingHeadingUp
                : MapNavigationMode.northUp,
          );
    }
  }

  void toggle() {
    setTilt(!state);
  }
}
