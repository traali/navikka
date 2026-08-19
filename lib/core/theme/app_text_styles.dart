import 'package:flutter/material.dart';

/// Centralized typography definitions for the Sakkoja design system.
///
/// Under this dynamic theme architecture, these styles omit hardcoded color
/// constants, allowing them to dynamically inherit their color from the parent
/// Theme (Material's textTheme or default text styles).
abstract class AppTextStyles {
  // Private base style with Inter font
  static const TextStyle _base = TextStyle(
    fontFamily: 'Inter',
  );

  // --- Headings ---
  static final TextStyle h1 = _base.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  static final TextStyle h2 = _base.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.25,
  );

  static final TextStyle h3 = _base.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle h4 = _base.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  // --- Body Text ---
  static final TextStyle body = _base.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static final TextStyle bodySmall = _base.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  static final TextStyle bodyLarge = _base.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  // --- UI Elements ---
  static final TextStyle button = _base.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  static final TextStyle caption = _base.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
  );

  static final TextStyle label = _base.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  // --- Monospace (for data/numerical metrics) ---
  static const TextStyle mono = TextStyle(
    fontFamily: 'JetBrains Mono',
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle monoSmall = TextStyle(
    fontFamily: 'JetBrains Mono',
    fontSize: 11,
    fontWeight: FontWeight.w400,
  );

  // --- Nova Fluid Typography Scale ---
  static final TextStyle nvHero = _base.copyWith(
    fontSize: 58,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.5,
  );
  static final TextStyle nv3xl = _base.copyWith(
    fontSize: 46,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
  );
  static final TextStyle nv2xl = _base.copyWith(
    fontSize: 37,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
  );
  static final TextStyle nvXl = _base.copyWith(
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle nvLg = _base.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle nvBase = _base.copyWith(
    fontSize: 19,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle nvSm = _base.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle nvXs = _base.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}
