import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_mode_provider.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';

/// Calculates dynamic non-overlapping top and bottom safe-zone padding
/// for map HUD controls, search bar, emergency banners, and weather badges.
class HudLayoutMetrics {
  const HudLayoutMetrics({
    required this.topPadding,
    required this.searchBarTopPadding,
    required this.badgeTopPadding,
    required this.bottomPadding,
    required this.hasActiveBanner,
  });

  /// Top position for high-priority emergency banners (Lightning / Fishing)
  final double topPadding;

  /// Top position for Marine Search Bar (below active emergency banners)
  final double searchBarTopPadding;

  /// Top position for Weather Alert Badge & Telemetry HUDs (below Search Bar)
  final double badgeTopPadding;

  /// Bottom padding for FAB controls
  final double bottomPadding;

  /// True if an emergency banner is active
  final bool hasActiveBanner;
}

final hudLayoutMetricsProvider = Provider<HudLayoutMetrics>((ref) {
  final isFishingMode =
      ref.watch(fishingModeControllerProvider).value?.isEnabled ?? false;
  final lightningLevel =
      ref.watch(pointWeatherControllerProvider).lightningAlarmLevel;

  final hasLightning = lightningLevel.index > 0;
  final hasActiveBanner = isFishingMode || hasLightning;

  // Emergency Banners anchor at top: 12
  var bannerHeight = 0.0;
  if (isFishingMode) bannerHeight += 64.0;
  if (hasLightning) bannerHeight += 64.0;

  // Search Bar sits below active emergency banners
  final searchBarTop = 12.0 + bannerHeight;

  // Badges & Boating HUD sit below Search Bar (+48px search bar height + 8px gap)
  final badgeTop = searchBarTop + 56.0;

  return HudLayoutMetrics(
    topPadding: 12,
    searchBarTopPadding: searchBarTop,
    badgeTopPadding: badgeTop,
    bottomPadding: 16,
    hasActiveBanner: hasActiveBanner,
  );
});
