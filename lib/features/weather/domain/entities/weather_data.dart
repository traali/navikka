import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:latlong2/latlong.dart';

part 'weather_data.freezed.dart';

@freezed
abstract class WeatherData with _$WeatherData {
  const factory WeatherData({
    required DateTime timestamp,
    required LatLng location,
    double? temperature,
    double? feelsLike,
    double? windSpeed,
    double? windGust,
    double? windDirection,
    double? pressure,
    double? visibility, // in meters
    double? humidity, // percentage
    double? dewPoint,
    double? precipitation, // mm/h
    double? cloudCover, // 0-100%
    double? uvIndex,
    double? snowfall,
    int? weatherCode,
    String? weatherIcon,
    String? weatherDescription,
    DateTime? sunrise,
    DateTime? sunset,
    String? stationName,
  }) = _WeatherData;
}
