import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/app_theme.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';

/// Maritime safety zone colors using semantic AppPalette tokens.
///
/// All colors are derived from the "Night Captain" design system tokens
/// rather than raw Material Colors.xxx references.
class ZoneColors {
  static final Color _colorSpeedLimit = AppPalette.zoneSpeedLimit.withValues(
    alpha: 0.10,
  );
  static final Color _colorRecommendation = AppPalette.zoneRecommendation
      .withValues(alpha: 0.08);
  static final Color _colorNoWake = AppPalette.zoneNoWake.withValues(
    alpha: 0.12,
  );
  static final Color _colorProhibited = AppPalette.zoneProhibited.withValues(
    alpha: 0.12,
  );
  static final Color _colorNature = AppPalette.zoneNature.withValues(
    alpha: 0.08,
  );
  static final Color _colorTraffic = AppPalette.zoneTraffic.withValues(
    alpha: 0.08,
  );

  static Color getZoneColor(SpeedLimitZone zone) {
    final desc = zone.typeDescription?.toLowerCase() ?? '';
    final isNoWake = desc.contains('aallokon');

    if (isNoWake) {
      if (zone.speedLimitKmh > 0) {
        return AppPalette.zoneStrict.withValues(alpha: 0.14);
      }
      return _colorNoWake;
    }

    if (zone.speedLimitKmh == 5) {
      return AppPalette.zoneSpeedLimitLow.withValues(alpha: 0.14);
    }
    if (zone.speedLimitKmh == 10) {
      return AppPalette.zoneSpeedLimit.withValues(alpha: 0.10);
    }
    if (zone.speedLimitKmh > 0 && zone.speedLimitKmh < 10) {
      return AppPalette.zoneSpeedLimit.withValues(alpha: 0.10);
    }

    final code = zone.typeCode;

    if (code == '01') return _colorSpeedLimit;
    if (code == '11') return _colorRecommendation;

    if (desc.contains('moottori') || desc.contains('vesiskootteri')) {
      return _colorNature;
    }
    if (desc.contains('ankkuri') ||
        desc.contains('pysäköinti') ||
        desc.contains('kiinnittyminen')) {
      return _colorProhibited;
    }
    if (desc.contains('ohittamiskielto') || desc.contains('kohtaamiskielto')) {
      return _colorTraffic;
    }

    return AppPalette.zoneDefault.withValues(alpha: 0.08);
  }

  static Color getZoneBorderColor(SpeedLimitZone zone) {
    final desc = zone.typeDescription?.toLowerCase() ?? '';
    final isNoWake = desc.contains('aallokon');

    if (isNoWake) {
      if (zone.speedLimitKmh > 0) return AppPalette.zoneStrict;
      return AppPalette.zoneNoWake;
    }

    final limit = zone.speedLimitKmh;

    if (limit > 0 && limit <= 10) {
      return AppPalette.zoneBorderLow;
    }

    if (limit > 10 && limit <= 20) {
      return AppPalette.zoneBorderMediumHigh;
    }

    if (limit > 20 && limit <= 40) {
      return AppPalette.zoneBorderMedium;
    }

    if (limit > 40) {
      return AppPalette.zoneBorderHighway;
    }

    if (zone.typeCode == '01') return AppPalette.zoneSpeedLimit;
    if (zone.typeCode == '11') return AppPalette.zoneRecommendation;

    if (desc.contains('moottori') || desc.contains('vesiskootteri')) {
      return AppPalette.zoneNature;
    }
    if (desc.contains('ankkuri') ||
        desc.contains('pysäköinti') ||
        desc.contains('kiinnittyminen')) {
      return AppPalette.zoneProhibited;
    }
    if (desc.contains('ohittamiskielto') || desc.contains('kohtaamiskielto')) {
      return AppPalette.zoneTraffic;
    }

    return AppPalette.zoneDefault;
  }

  static Color getRouteSegmentColor({
    required int? speedLimitKmh,
    required bool isOverSpeed,
    AppThemeColors? themeColors,
  }) {
    final activeActionColor = themeColors?.primaryAction ?? AppTheme.kNeonCyan;
    final activeWarningColor = themeColors?.warning ?? AppTheme.kNeonOrange;

    if (speedLimitKmh == null || speedLimitKmh == 0) {
      return activeActionColor;
    }

    if (isOverSpeed) {
      return activeWarningColor;
    }

    final List<(int, Color)> stops;
    if (themeColors != null) {
      stops = [
        (5, themeColors.routeSpeedLow),
        (
          10,
          Color.lerp(
            themeColors.routeSpeedLow,
            themeColors.routeSpeedMedium,
            0.5,
          )!,
        ),
        (15, themeColors.routeSpeedMedium),
        (
          20,
          Color.lerp(
            themeColors.routeSpeedMedium,
            themeColors.routeSpeedHigh,
            0.5,
          )!,
        ),
        (30, themeColors.routeSpeedHigh),
      ];
    } else {
      stops = const [
        (5, Color(0xFFDC2626)),
        (10, Color(0xFFEA580C)),
        (15, Color(0xFFF59E0B)),
        (20, Color(0xFF84CC16)),
        (30, Color(0xFF22C55E)),
      ];
    }

    if (speedLimitKmh <= stops.first.$1) {
      return stops.first.$2;
    }
    if (speedLimitKmh >= stops.last.$1) {
      return stops.last.$2;
    }

    for (var i = 0; i < stops.length - 1; i++) {
      final (lowLimit, lowC) = stops[i];
      final (highLimit, highC) = stops[i + 1];
      if (speedLimitKmh > lowLimit && speedLimitKmh <= highLimit) {
        final t = (speedLimitKmh - lowLimit) / (highLimit - lowLimit);
        return Color.lerp(lowC, highC, t)!;
      }
    }

    return activeActionColor;
  }
}
