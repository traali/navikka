import 'dart:math' as math;
import 'package:sakkoja/features/weather/domain/entities/weather_forecast.dart';

extension DateTimeFormatting on DateTime {
  String get formattedTime {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}

extension WeatherForecastConversion on WeatherForecast {
  /// Returns the wind direction in radians, adjusted for UI rotation
  /// (where 0 is typically UP/North).
  ///
  /// Formula: (degrees * pi / 180) + pi
  /// This rotates the arrow to point *with* the wind flow.
  double get windRotationRadians {
    if (windDirection == null) return 0;
    return (windDirection! * math.pi / 180) + math.pi;
  }
}
