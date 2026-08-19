import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_palette.dart';

/// Standardized interaction states and motion constants.
abstract class AppInteraction {
  // --- Motion & Animation ---

  /// Standard duration for micro-interactions (hover, press).
  static const Duration kShort = Duration(milliseconds: 150);

  /// Standard duration for layout transitions (expand/collapse).
  static const Duration kMedium = Duration(milliseconds: 300);

  /// Standard duration for screen transitions.
  static const Duration kLong = Duration(milliseconds: 500);

  /// Standard curve for entering elements (decelerate).
  static const Curve kCurveEnter = Curves.easeOutQuart;

  /// Standard curve for exiting elements (accelerate).
  static const Curve kCurveExit = Curves.easeInQuad;

  /// Standard curve for persistent motion (pulsing).
  static const Curve kCurvePulse = Curves.easeInOutSine;

  // --- Interaction Colors & Alphas ---

  /// Opacity for disabled elements.
  static const double kDisabledOpacity = 0.38;

  /// Opacity for hover overlay.
  static const double kHoverAlpha = 0.08;

  /// Opacity for focus overlay.
  static const double kFocusAlpha = 0.12;

  /// Opacity for pressed overlay.
  static const double kPressedAlpha = 0.16;

  /// Returns a button style with standardized interaction states.
  static ButtonStyle glassButtonStyle({Color? foregroundColor}) {
    return ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return (foregroundColor ?? AppPalette.textPrimary).withValues(
            alpha: kDisabledOpacity,
          );
        }
        return foregroundColor ?? AppPalette.textPrimary;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        final color = foregroundColor ?? AppPalette.textPrimary;
        if (states.contains(WidgetState.pressed)) {
          return color.withValues(alpha: kPressedAlpha);
        }
        if (states.contains(WidgetState.hovered)) {
          return color.withValues(alpha: kHoverAlpha);
        }
        if (states.contains(WidgetState.focused)) {
          return color.withValues(alpha: kFocusAlpha);
        }
        return null;
      }),
      splashFactory: InkRipple.splashFactory,
      animationDuration: kShort,
    );
  }
}
