import 'package:flutter/material.dart';

/// The authoritative color palette for the Sakkoja "Night Captain" Design System.
///
/// This class maps abstract design tokens (e.g., "Primary Action", "Surface")
/// to concrete color values, ensuring consistency across the app.
///
/// See `DESIGN_PATTERNS.md` for the full specification.
abstract class AppPalette {
  // --- Core Surfaces (OLED Optimized) ---

  /// The infinite sea. True black for maximum OLED power saving.
  /// HSL: (0, 0%, 0%)
  static const Color canvas = Color(0xFF000000);

  /// Floating panels (Safe harbor). Used for cards, sheets, and dialogs.
  /// Deep Slate-900. HSL: (222, 47%, 11%)
  static const Color surface = Color(0xFF0F172A);

  /// Highlighted surface or subtle separation.
  /// Slate-800. HSL: (217, 33%, 17%)
  static const Color surfaceHighlight = Color(0xFF1E293B);

  // --- Navikka Marine MFD Palette ---

  /// Navikka deep sea MFD background (Deep Midnight Slate).
  static const Color navikkaCanvas = Color(0xFF070D1B);

  /// Navikka MFD translucent glass panel.
  static const Color navikkaSurface = Color(0xFF0F172A);

  /// Navikka electric cyan active glow accent.
  static const Color navikkaCyanGlow = Color(0xFF00F2FE);

  // --- Semantic Roles (Curated HSL) ---

  /// Primary Action / Active State.
  /// High visibility Cyan-400. HSL: (187, 82%, 54%)
  static const Color primaryAction = Color(0xFF00F2FE);

  /// Secondary Information / text.
  /// Slate-400. HSL: (215, 14%, 64%)
  static const Color textSecondary = Color(0xFF94A3B8);

  /// Primary Text.
  /// Slate-100. HSL: (210, 40%, 96%)
  static const Color textPrimary = Color(0xFFF1F5F9);

  /// Critical Alerts / Danger.
  /// Red-500. HSL: (0, 84%, 60%)
  static const Color danger = Color(0xFFEF4444);

  /// Success / Safe.
  /// Emerald-500. HSL: (158, 84%, 39%)
  static const Color success = Color(0xFF10B981);

  /// Warning / Caution.
  /// Amber-400. HSL: (43, 96%, 56%)
  static const Color warning = Color(0xFFFBBF24);

  // --- Maritime Safety Zone Tokens ---

  /// Mandatory speed limit zones (red, high alert).
  static const Color zoneSpeedLimit = Color(0xFFDC2626);

  /// Very low speed limit (5 km/h) — darker red.
  static const Color zoneSpeedLimitLow = Color(0xFF7F1D1D);

  /// Speed recommendation zones (blue, informational).
  static const Color zoneRecommendation = Color(0xFF3B82F6);

  /// No-wake zones (cyan, calm waters).
  static const Color zoneNoWake = Color(0xFF06B6D4);

  /// Prohibited / restricted zones (amber, caution).
  static const Color zoneProhibited = Color(0xFFF59E0B);

  /// Nature / environmental zones (green).
  static const Color zoneNature = Color(0xFF22C55E);

  /// Traffic rule zones (purple).
  static const Color zoneTraffic = Color(0xFFA855F7);

  /// Strict combined restriction (no-wake + speed limit, deep purple).
  static const Color zoneStrict = Color(0xFF6B21A8);

  /// Default fallback for unmapped zones (orange).
  static const Color zoneDefault = Color(0xFFF97316);

  /// Zone border: low speed (1-10 km/h), high alert.
  static const Color zoneBorderLow = Color(0xFFD32F2F);

  /// Zone border: medium-high speed (11-20 km/h).
  static const Color zoneBorderMediumHigh = Color(0xFFFF5722);

  /// Zone border: medium speed (21-40 km/h).
  static const Color zoneBorderMedium = Color(0xFFFF9800);

  /// Zone border: highway / low restriction (>40 km/h).
  static const Color zoneBorderHighway = Color(0xFFFFC107);

  // --- Red Watch Tokens (IMO/IEC 62288 Low-Luminance Red Night Mode) ---

  /// Red Watch canvas: Pitch black.
  static const Color redCanvas = Color(0xFF000000);

  /// Red Watch surface: Deep red tint.
  static const Color redSurface = Color(0xFF140000);

  /// Red Watch highlighted surface.
  static const Color redSurfaceHighlight = Color(0xFF280000);

  /// Red Watch primary action: Bright night-vision red.
  static const Color redPrimaryAction = Color(0xFFEF4444);

  /// Red Watch primary text: Low-luminance red.
  static const Color redTextPrimary = Color(0xFFFF4444);

  /// Red Watch secondary text: Darker red tint.
  static const Color redTextSecondary = Color(0xFF993333);

  /// Red Watch border tint.
  static const Color redBorder = Color(0x33FF0000);

  // --- Aesthetic Helpers ---

  /// Generates a HSL-based glass border with dynamic opacity.
  static Color glassBorder({double alpha = 0.12}) =>
      Colors.white.withValues(alpha: alpha);

  /// Liquid Glassmorphism: Deeply translucent background.
  static Color glassBackground({double opacity = 0.08}) =>
      const Color(0xFF0F172A).withValues(alpha: opacity);

  /// Tactile Highlight: For subtle rim lighting on cards.
  static const Color glassHighlight = Color(0x1AFFFFFF);

  /// Returns a curated HSL color based on hue, saturation, and lightness.
  /// Ensures all new UI colors follow the project's premium aesthetic logic.
  static Color fromHsl(double h, double s, double l, [double a = 1.0]) {
    return HSLColor.fromAHSL(a, h, s / 100, l / 100).toColor();
  }
}
