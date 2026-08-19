class GeometryConstants {
  const GeometryConstants._();

  /// Snapping for Tier 1 (Weather) - ~5.5km grid
  /// Used in providers to prevent excessive refreshes.
  static const double snappingWeatherTier1 = 0.05;

  /// Precision for remote API calls and deduplication keys - ~11m grid
  /// Used in DataSources for unique request identification.
  static const int precisionDeduplication = 4;

  /// Multiplier for Tier 1 snapping (1 / 0.05 = 20)
  static const double multiplierTier1 = 20;
}
