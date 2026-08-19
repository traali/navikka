class WeatherConstants {
  // Prevent instantiation
  const WeatherConstants._();

  /// Spatial tolerance for "nearby" data matching in degrees.
  /// 0.15 degrees is approximately 17km — matches station spacing.
  static const double spatialToleranceDegrees = 0.15;

  /// Number of past/future radar frames to show.
  static const int radarTimestampCount = 12;

  /// Data retention period for cached weather in SQLite.
  /// Old data is cleaned up after this duration.
  static const Duration dataRetention = Duration(days: 7);

  /// Interval between radar animation frames.
  static const Duration radarAnimationInterval = Duration(milliseconds: 800);

  /// Minimum interval between cleanup operations.
  static const Duration cleanupInterval = Duration(hours: 1);
}
