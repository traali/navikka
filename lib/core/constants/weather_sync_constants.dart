/// Per-source sync parameters tuned to Finnish coastal data infrastructure.
///
/// These values are derived from verified FMI/SYKE update frequencies
/// and Finnish coastal station spacing.
class WeatherSyncConstants {
  const WeatherSyncConstants._();

  // ═══════════════════════════════════════════
  // SAFETY TIER — poll aggressively
  // ═══════════════════════════════════════════

  /// Lightning detection network updates every 5 min.
  static const Duration lightningTtl = Duration(minutes: 5);
  // No distance trigger — lightning is area-wide (200 km radius)

  /// Weather alerts issued irregularly by FMI forecasters.
  static const Duration alertsTtl = Duration(minutes: 5);
  // No distance trigger — alerts are area-wide

  // ═══════════════════════════════════════════
  // OBSERVATION TIER — match source update rate
  // ═══════════════════════════════════════════

  /// FMI automatic weather stations report every 10 min.
  /// Gulf of Finland station spacing: 20-45 km.
  static const Duration observationsTtl = Duration(minutes: 10);
  static const double observationsBoatDistanceKm = 17.5; // midpoint of 15-20 km
  static const double observationsPanDistanceKm = 25;
  static const Duration observationsPanCooldown = Duration(minutes: 10);

  /// FMI HARMONIE-AROME: model runs every 3h, nowcast every 1h.
  /// Archipelago microclimate boundary: ~10 km.
  static const Duration forecastTtl = Duration(minutes: 30);
  static const double forecastBoatDistanceKm = 10;
  static const double forecastPanDistanceKm = 20;
  static const Duration forecastPanCooldown = Duration(minutes: 10);

  /// FMI mareographs report every ~15 min.
  /// 14 stations, 50-120 km apart in Gulf of Finland.
  static const Duration seaLevelTtl = Duration(minutes: 15);
  static const double seaLevelBoatDistanceKm = 30;
  static const double seaLevelPanDistanceKm = 40;
  static const Duration seaLevelPanCooldown = Duration(minutes: 15);

  // ═══════════════════════════════════════════
  // SUPPLEMENTARY TIER
  // ═══════════════════════════════════════════

  /// FMI wave buoys: 30-min measurement window.
  /// Gulf of Finland: ~80 km between buoys.
  static const Duration wavesTtl = Duration(minutes: 30);
  static const double wavesBoatDistanceKm = 40;
  static const double wavesPanDistanceKm = 50;
  static const Duration wavesPanCooldown = Duration(minutes: 15);

  // ═══════════════════════════════════════════
  // ENVIRONMENT TIER — startup + manual refresh
  // ═══════════════════════════════════════════

  /// SYKE water quality: daily satellite, weekly in-situ.
  static const Duration waterQualityTtl = Duration(hours: 6);

  /// SYKE algae: 3-day rolling window.
  static const Duration algaeTtl = Duration(hours: 6);

  // ═══════════════════════════════════════════
  // STARTUP STAGGER — prevent cold-start burst
  // ═══════════════════════════════════════════

  static const Duration startupDelaySafety = Duration.zero;
  static const Duration startupDelayObservations = Duration(seconds: 2);
  static const Duration startupDelaySupplementary = Duration(seconds: 5);
  static const Duration startupDelayEnvironment = Duration(seconds: 10);

  /// Minimum gap between any two syncs (global rate limit).
  static const Duration globalMinSyncGap = Duration(seconds: 5);
}
