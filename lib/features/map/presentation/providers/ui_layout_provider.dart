import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'ui_layout_provider.g.dart';

enum UiLayout {
  /// The original bulky glass dashboard layout.
  classic,

  /// Ultra-minimalist Navionics-style layout.
  ghost,

  /// Consolidated top-bar layout.
  commandBar,

  /// Omni layout: combines CommandBar's top-bar HUD with floating layers FAB
  /// for quick one-tap layer access. Same controls as CommandBar but with
  /// diamond FAB (bottom-right) for unified overlay panel.
  omni,

  /// Vortex layout: 5th UI with adaptive HUD, thumb-arc navigation,
  /// and safety-edge pulsing. Optimized for one-handed operation.
  vortex,

  /// Horizon 3D layout: Designed specifically for 3D Perspective Tilt Mode.
  /// Keeps top center horizon 100% clear, puts telemetry in floating side wings,
  /// and provides 48px tactile marine touch targets.
  horizon3D,
}

@riverpod
class UiLayoutController extends _$UiLayoutController {
  static const _storageKey = 'ui_layout_style';

  @override
  UiLayout build() {
    // Default to ghost as per the redesign goal, but load from storage if exists.
    _loadLayout();
    return UiLayout.ghost;
  }

  Future<void> _loadLayout() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_storageKey);
    if (saved != null) {
      state = UiLayout.values.firstWhere(
        (e) => e.name == saved,
        orElse: () => UiLayout.ghost,
      );
    }
  }

  Future<void> setLayout(UiLayout layout) async {
    Log.i('[Ulkoasu] User changed UI layout style to: ${layout.name}');
    state = layout;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, layout.name);
  }
}

/// Glove & Rough Sea Mode state notifier: forces 64x64dp touch targets and 16dp spacing
@riverpod
class RoughSeaModeController extends _$RoughSeaModeController {
  static const _storageKey = 'rough_sea_mode';

  @override
  bool build() {
    _loadState();
    return false;
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(_storageKey) ?? false;
  }

  Future<void> toggle() async {
    state = !state;
    Log.i('[Ulkoasu] User toggled Rough Sea Mode to: $state');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_storageKey, state);
  }
}
