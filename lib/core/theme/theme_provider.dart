import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/core/utils/logger.dart';

part 'theme_provider.g.dart';

/// The supported boating theme modes.
enum AppThemeMode {
  /// True Black OLED Night Mode (Default)
  nightCaptain,

  /// Sunlight High-Contrast Light Mode
  solarFlare,

  /// Premium Nautical Navy Dashboard Mode
  deepSea,

  /// Boreal Aurora: Inspired by Orca glass cockpit and Finland's northern lights
  borealAurora,

  /// Red Watch: IMO/IEC 62288 compliant low-luminance Red OLED Night Mode
  redWatch,
}

/// A specialized theme extension to cleanly bind custom marine colors to ThemeData.
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  const AppThemeColors({
    required this.canvas,
    required this.surface,
    required this.surfaceHighlight,
    required this.primaryAction,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.danger,
    required this.success,
    required this.warning,
    required this.glassBorder,
    required this.glassBackground,
    required this.ialaRed,
    required this.ialaGreen,
    required this.ialaYellow,
    required this.routeSpeedLow,
    required this.routeSpeedMedium,
    required this.routeSpeedHigh,
    required this.cardBackground,
    required this.cardBorder,
  });

  static const fallbackColors = AppThemeColors(
    canvas: Color(0xFF000000),
    surface: Color(0xFF0F172A),
    surfaceHighlight: Color(0xFF1E293B),
    primaryAction: Color(0xFF22D3EE),
    textPrimary: Color(0xFFF1F5F9),
    textSecondary: Color(0xFF94A3B8),
    border: Color(0x1EFFFFFF),
    danger: Color(0xFFEF4444),
    success: Color(0xFF10B981),
    warning: Color(0xFFFBBF24),
    glassBorder: Color(0x1EFFFFFF),
    glassBackground: Color(0xE60F172A),
    ialaRed: Color(0xFFE63946),
    ialaGreen: Color(0xFF2A9D8F),
    ialaYellow: Color(0xFFFFD700),
    routeSpeedLow: Color(0xFFDC2626),
    routeSpeedMedium: Color(0xFFF59E0B),
    routeSpeedHigh: Color(0xFF22C55E),
    cardBackground: Color(0xFF0F172A),
    cardBorder: Color(0x1EFFFFFF),
  );

  final Color canvas;
  final Color surface;
  final Color surfaceHighlight;
  final Color primaryAction;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final Color danger;
  final Color success;
  final Color warning;
  final Color glassBorder;
  final Color glassBackground;
  final Color ialaRed;
  final Color ialaGreen;
  final Color ialaYellow;
  final Color routeSpeedLow;
  final Color routeSpeedMedium;
  final Color routeSpeedHigh;
  final Color cardBackground;
  final Color cardBorder;

  @override
  AppThemeColors copyWith({
    Color? canvas,
    Color? surface,
    Color? surfaceHighlight,
    Color? primaryAction,
    Color? textPrimary,
    Color? textSecondary,
    Color? border,
    Color? danger,
    Color? success,
    Color? warning,
    Color? glassBorder,
    Color? glassBackground,
    Color? ialaRed,
    Color? ialaGreen,
    Color? ialaYellow,
    Color? routeSpeedLow,
    Color? routeSpeedMedium,
    Color? routeSpeedHigh,
    Color? cardBackground,
    Color? cardBorder,
  }) {
    return AppThemeColors(
      canvas: canvas ?? this.canvas,
      surface: surface ?? this.surface,
      surfaceHighlight: surfaceHighlight ?? this.surfaceHighlight,
      primaryAction: primaryAction ?? this.primaryAction,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      border: border ?? this.border,
      danger: danger ?? this.danger,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      glassBorder: glassBorder ?? this.glassBorder,
      glassBackground: glassBackground ?? this.glassBackground,
      ialaRed: ialaRed ?? this.ialaRed,
      ialaGreen: ialaGreen ?? this.ialaGreen,
      ialaYellow: ialaYellow ?? this.ialaYellow,
      routeSpeedLow: routeSpeedLow ?? this.routeSpeedLow,
      routeSpeedMedium: routeSpeedMedium ?? this.routeSpeedMedium,
      routeSpeedHigh: routeSpeedHigh ?? this.routeSpeedHigh,
      cardBackground: cardBackground ?? this.cardBackground,
      cardBorder: cardBorder ?? this.cardBorder,
    );
  }

  @override
  AppThemeColors lerp(ThemeExtension<AppThemeColors>? other, double t) {
    if (other is! AppThemeColors) return this;
    return AppThemeColors(
      canvas: Color.lerp(canvas, other.canvas, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceHighlight: Color.lerp(
        surfaceHighlight,
        other.surfaceHighlight,
        t,
      )!,
      primaryAction: Color.lerp(primaryAction, other.primaryAction, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      border: Color.lerp(border, other.border, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      glassBorder: Color.lerp(glassBorder, other.glassBorder, t)!,
      glassBackground: Color.lerp(glassBackground, other.glassBackground, t)!,
      ialaRed: Color.lerp(ialaRed, other.ialaRed, t)!,
      ialaGreen: Color.lerp(ialaGreen, other.ialaGreen, t)!,
      ialaYellow: Color.lerp(ialaYellow, other.ialaYellow, t)!,
      routeSpeedLow: Color.lerp(routeSpeedLow, other.routeSpeedLow, t)!,
      routeSpeedMedium: Color.lerp(
        routeSpeedMedium,
        other.routeSpeedMedium,
        t,
      )!,
      routeSpeedHigh: Color.lerp(routeSpeedHigh, other.routeSpeedHigh, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t)!,
    );
  }
}

/// Dynamic theme lookup extensions on [BuildContext] for crisp styling references.
extension AppThemeContext on BuildContext {
  AppThemeColors get colors {
    return Theme.of(this).extension<AppThemeColors>() ??
        AppThemeColors.fallbackColors;
  }

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

/// Riverpod Controller to read, write, and persist the theme selections in SharedPreferences.
@riverpod
class AppThemeController extends _$AppThemeController {
  static const _themePrefKey = 'sakkoja_app_theme_mode';

  @override
  FutureOr<AppThemeMode> build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final themeStr = prefs.getString(_themePrefKey);
    if (themeStr == null) {
      return AppThemeMode.nightCaptain;
    }
    return AppThemeMode.values.firstWhere(
      (e) => e.name == themeStr,
      orElse: () => AppThemeMode.nightCaptain,
    );
  }

  /// Sets the active theme and persists it to local storage.
  Future<void> setTheme(AppThemeMode mode) async {
    Log.i('[Ulkoasu/Teema] User changed visual theme mode to: ${mode.name}');
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.read(sharedPreferencesProvider);
      await prefs.setString(_themePrefKey, mode.name);
      return mode;
    });
  }
}
