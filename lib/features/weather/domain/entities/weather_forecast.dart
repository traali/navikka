import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'weather_forecast.freezed.dart';

@freezed
abstract class WeatherForecast with _$WeatherForecast {
  const factory WeatherForecast({
    required DateTime timestamp,
    LatLng? location,
    int? providerId, // Source identity for AI contradiction analysis
    double? temperature,
    double? feelsLike,
    double? windSpeed,
    double? windGust,
    double? windDirection,
    double? precipitation,
    double? precipitationProbability,
    double? pressure,
    double? humidity,
    double? dewPoint,
    double? cloudCover,
    double? uvIndex,
    String? weatherIcon,
    String? weatherDescription,
  }) = _WeatherForecast;
}
