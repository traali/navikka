import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/utils/lat_lng_converter.dart';

part 'weather_forecast_dto.freezed.dart';
part 'weather_forecast_dto.g.dart';

@freezed
abstract class WeatherForecastDto with _$WeatherForecastDto {
  const factory WeatherForecastDto({
    required DateTime timestamp,
    @LatLngConverter() required LatLng location,
    DateTime? issuedAt,
    int? providerId,
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
  }) = _WeatherForecastDto;

  factory WeatherForecastDto.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastDtoFromJson(json);
}
