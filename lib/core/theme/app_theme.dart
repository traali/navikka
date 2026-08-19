import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';

/// Centralized theme configuration for the "Night Captain" (OLED) aesthetic.
class AppTheme {
  // --- "Night Captain" (OLED) Constants ---
  static const Color kContentColor = AppPalette.canvas;
  static const Color kSurfaceColor = AppPalette.surface;
  static const Color kOnGlass = AppPalette.textPrimary;

  static Color get kBorderColor => AppPalette.glassBorder();
  static const double kBorderWidth = 1;

  // No blur for OLED performance & sharpness
  static const double kBlurSigma = 3;

  static const BorderRadius kBorderRadius = BorderRadius.all(
    Radius.circular(16), // Tighter radius for technical feel
  );

  // --- High Contrast Neon Palette ---
  static const Color kNeonRed = AppPalette.danger;
  static const Color kNeonGreen = AppPalette.success;
  static const Color kNeonBlue = Color(
    0xFF2979FF,
  ); // Keep specific neons if not in palette
  static const Color kNeonCyan = AppPalette.primaryAction;
  static const Color kNeonOrange = AppPalette.warning;

  // --- IALA-A Maritime Colors ---
  static const Color kIalaRed = Color(0xFFE63946); // Vivid Red for Port
  static const Color kIalaGreen = Color(0xFF2A9D8F); // Teal-Green for Starboard
  static const Color kIalaYellow = Color(
    0xFFFFD700,
  ); // Standard Gold for Cardinals

  // --- Vibrant Palette (Used by FishingColors, WeatherAlertBadge, etc.) ---
  static const Color kVibrantRed = AppPalette.danger;
  static const Color kVibrantBlue = Color(0xFF3B82F6); // blue-500
  static const Color kVibrantEmerald = AppPalette.success;
  static const Color kTechCyan = AppPalette.primaryAction;

  /// Primary Gradient (Subtle Technical Glow)
  static const Gradient kSurfaceGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppPalette.surfaceHighlight, AppPalette.canvas],
  );

  /// OLED styles don't use shadows for elevation, they use borders and glows.
  static final List<BoxShadow> kElevationShadows = [
    const BoxShadow(blurRadius: 10, offset: Offset(0, 4)),
  ];

  /// Active Element Glow
  static List<BoxShadow> kNeonGlow(Color color) => [
    BoxShadow(
      color: color.withValues(alpha: 0.4),
      blurRadius: 12,
      spreadRadius: 1,
    ),
  ];

  /// Typography - High Contrast Technical
  /// Uses Inter for UI elements as per DESIGN_PATTERNS.md
  static const TextStyle kHeading = TextStyle(
    fontFamily: 'Inter',
    color: AppPalette.textPrimary,
    fontSize: 18, // Bumped from 13
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
    height: 1.2,
  );

  static const TextStyle kBody = TextStyle(
    fontFamily: 'Inter',
    color: AppPalette.textPrimary,
    fontSize: 14, // Bumped from 13
    fontWeight: FontWeight.w500,
  );

  static const TextStyle kCaption = TextStyle(
    fontFamily: 'Inter',
    color: AppPalette.textSecondary,
    fontSize: 12, // Bumped from 11
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static const TextStyle kData = TextStyle(
    fontFamily: 'JetBrains Mono',
    color: AppPalette.textPrimary,
    fontWeight: FontWeight.w700,
  );

  // --- Legacy Glass Aliases (Backwards Compatibility) ---
  static const double kGlassBlurSigma = kBlurSigma;
  static const BorderRadius kGlassBorderRadius = kBorderRadius;
  static const Color kGlassColor = kSurfaceColor;
  static Color get kGlassBorderColor => kBorderColor;
  static const Gradient kGlassGradient = kSurfaceGradient;
  static final List<BoxShadow> kGlassShadows = kElevationShadows;
  static const TextStyle kGlassHeading = kHeading;
  static const TextStyle kGlassSubtext = kCaption;

  /// Returns a Material ThemeData for OLED-optimized Dark Mode ("Night Captain").
  static ThemeData dark() => nightCaptain();

  /// Returns a Material ThemeData for Light Mode.
  static ThemeData light() => solarFlare();

  /// OLED-optimized Dark Mode ("Night Captain").
  static ThemeData nightCaptain() {
    const colors = AppThemeColors.fallbackColors;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: colors.canvas,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.primaryAction,
        brightness: Brightness.dark,
        surface: colors.surface,
        onSurface: colors.textPrimary,
        primary: colors.primaryAction,
        onPrimary: Colors.black,
        error: colors.danger,
      ),
      textTheme: const TextTheme(
        bodyMedium: kBody,
        titleMedium: kHeading,
        labelSmall: kCaption,
      ),
      fontFamily: 'Inter',
      cardTheme: const CardThemeData(
        color: AppPalette.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppPalette.canvas,
        foregroundColor: AppPalette.textPrimary,
        elevation: 0,
      ),
      extensions: const [colors],
    );
  }

  /// Sunlight High-Contrast Light Mode ("Solar Flare").
  static ThemeData solarFlare() {
    const colors = AppThemeColors(
      canvas: Color(0xFFFFFFFF),
      surface: Color(0xFFF8FAFC),
      surfaceHighlight: Color(0xFFF1F5F9),
      primaryAction: Color(0xFF0284C7),
      textPrimary: Color(0xFF0F172A),
      textSecondary: Color(0xFF475569),
      border: Color(0xFFE2E8F0),
      danger: Color(0xFFDC2626),
      success: Color(0xFF16A34A),
      warning: Color(0xFFD97706),
      glassBorder: Color(0xFFCBD5E1),
      glassBackground: Color(0xF2FFFFFF), // 95% opacity
      ialaRed: Color(0xFFDC2626),
      ialaGreen: Color(0xFF059669),
      ialaYellow: Color(0xFFD97706),
      routeSpeedLow: Color(0xFFB91C1C),
      routeSpeedMedium: Color(0xFFD97706),
      routeSpeedHigh: Color(0xFF15803D),
      cardBackground: Color(0xFFF8FAFC),
      cardBorder: Color(0xFFE2E8F0),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: colors.canvas,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.primaryAction,
        surface: colors.surface,
        onSurface: colors.textPrimary,
        primary: colors.primaryAction,
        onPrimary: Colors.white,
        error: colors.danger,
      ),
      textTheme: TextTheme(
        bodyMedium: kBody.copyWith(color: colors.textPrimary),
        titleMedium: kHeading.copyWith(color: colors.textPrimary),
        labelSmall: kCaption.copyWith(color: colors.textSecondary),
      ),
      fontFamily: 'Inter',
      cardTheme: const CardThemeData(
        color: Color(0xFFF8FAFC),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFFFFFF),
        foregroundColor: Color(0xFF0F172A),
        elevation: 0,
      ),
      extensions: const [colors],
    );
  }

  /// Premium Nautical Navy Dashboard Mode ("Deep Sea").
  static ThemeData deepSea() {
    const colors = AppThemeColors(
      canvas: Color(0xFF060913),
      surface: Color(0xFF0E1626),
      surfaceHighlight: Color(0xFF1E293B),
      primaryAction: Color(0xFF0EA5E9),
      textPrimary: Color(0xFFE0F2FE),
      textSecondary: Color(0xFF64748B),
      border: Color(0x260EA5E9), // 15% opacity
      danger: Color(0xFFEF4444),
      success: Color(0xFF10B981),
      warning: Color(0xFFF59E0B),
      glassBorder: Color(0x330EA5E9), // 20% opacity
      glassBackground: Color(0xD90E1626), // 85% opacity
      ialaRed: Color(0xFFF43F5E),
      ialaGreen: Color(0xFF10B981),
      ialaYellow: Color(0xFFFBBF24),
      routeSpeedLow: Color(0xFFEF4444),
      routeSpeedMedium: Color(0xFFF59E0B),
      routeSpeedHigh: Color(0xFF10B981),
      cardBackground: Color(0xFF0E1626),
      cardBorder: Color(0x260EA5E9),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: colors.canvas,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.primaryAction,
        brightness: Brightness.dark,
        surface: colors.surface,
        onSurface: colors.textPrimary,
        primary: colors.primaryAction,
        onPrimary: Colors.black,
        error: colors.danger,
      ),
      textTheme: TextTheme(
        bodyMedium: kBody.copyWith(color: colors.textPrimary),
        titleMedium: kHeading.copyWith(color: colors.textPrimary),
        labelSmall: kCaption.copyWith(color: colors.textSecondary),
      ),
      fontFamily: 'Inter',
      cardTheme: const CardThemeData(
        color: Color(0xFF0E1626),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF060913),
        foregroundColor: Color(0xFFE0F2FE),
        elevation: 0,
      ),
      extensions: const [colors],
    );
  }

  /// Modern Glass Cockpit Aurora Mode ("Boreal Aurora").
  static ThemeData borealAurora() {
    const colors = AppThemeColors(
      canvas: Color(0xFF080E17),
      surface: Color(0xFF111C2B),
      surfaceHighlight: Color(0xFF1B2A3D),
      primaryAction: Color(0xFF10B981),
      textPrimary: Color(0xFFECFDF5),
      textSecondary: Color(0xFF829AB1),
      border: Color(0x2610B981),
      danger: Color(0xFFFF4666),
      success: Color(0xFF34D399),
      warning: Color(0xFFFBBF24),
      glassBorder: Color(0x3310B981),
      glassBackground: Color(0xE6111C2B),
      ialaRed: Color(0xFFFF4666),
      ialaGreen: Color(0xFF34D399),
      ialaYellow: Color(0xFFFBBF24),
      routeSpeedLow: Color(0xFFFF4666),
      routeSpeedMedium: Color(0xFFFBBF24),
      routeSpeedHigh: Color(0xFF34D399),
      cardBackground: Color(0xFF111C2B),
      cardBorder: Color(0x2610B981),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: colors.canvas,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.primaryAction,
        brightness: Brightness.dark,
        surface: colors.surface,
        onSurface: colors.textPrimary,
        primary: colors.primaryAction,
        onPrimary: Colors.black,
        error: colors.danger,
      ),
      textTheme: TextTheme(
        bodyMedium: kBody.copyWith(color: colors.textPrimary),
        titleMedium: kHeading.copyWith(color: colors.textPrimary),
        labelSmall: kCaption.copyWith(color: colors.textSecondary),
      ),
      fontFamily: 'Inter',
      cardTheme: const CardThemeData(
        color: Color(0xFF111C2B),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF080E17),
        foregroundColor: Color(0xFFECFDF5),
        elevation: 0,
      ),
      extensions: const [colors],
    );
  }

  /// Low-Luminance Red OLED Night Mode ("Red Watch", IMO/IEC 62288 compliant).
  static ThemeData redWatch() {
    const colors = AppThemeColors(
      canvas: AppPalette.redCanvas,
      surface: AppPalette.redSurface,
      surfaceHighlight: AppPalette.redSurfaceHighlight,
      primaryAction: AppPalette.redPrimaryAction,
      textPrimary: AppPalette.redTextPrimary,
      textSecondary: AppPalette.redTextSecondary,
      border: AppPalette.redBorder,
      danger: AppPalette.redPrimaryAction,
      success: Color(0xFFCC0000),
      warning: Color(0xFFFF6600),
      glassBorder: AppPalette.redBorder,
      glassBackground: AppPalette.redSurface,
      ialaRed: Color(0xFFFF0000),
      ialaGreen: Color(0xFF990000),
      ialaYellow: Color(0xFFFF6600),
      routeSpeedLow: Color(0xFFFF0000),
      routeSpeedMedium: Color(0xFFFF6600),
      routeSpeedHigh: Color(0xFF990000),
      cardBackground: AppPalette.redSurface,
      cardBorder: AppPalette.redBorder,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: colors.canvas,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.primaryAction,
        brightness: Brightness.dark,
        surface: colors.surface,
        onSurface: colors.textPrimary,
        primary: colors.primaryAction,
        onPrimary: Colors.black,
        error: colors.danger,
      ),
      textTheme: TextTheme(
        bodyMedium: kBody.copyWith(color: colors.textPrimary),
        titleMedium: kHeading.copyWith(color: colors.textPrimary),
        labelSmall: kCaption.copyWith(color: colors.textSecondary),
      ),
      fontFamily: 'Inter',
      cardTheme: const CardThemeData(
        color: AppPalette.redSurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppPalette.redCanvas,
        foregroundColor: AppPalette.redTextPrimary,
        elevation: 0,
      ),
      extensions: const [colors],
    );
  }
}
