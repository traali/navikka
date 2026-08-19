import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/utils/lat_lng_converter.dart';

part 'weather_observation_dto.freezed.dart';
part 'weather_observation_dto.g.dart';

@freezed
abstract class WeatherObservationDto with _$WeatherObservationDto {
  const factory WeatherObservationDto({
    required DateTime timestamp,
    @LatLngConverter() required LatLng location,
    double? temperature,
    double? feelsLike,
    double? windSpeed,
    double? windGust,
    double? windDirection,
    double? pressure,
    String? stationName,
    int? providerId,
    double? visibility,
    double? humidity,
    double? dewPoint,
    double? precipitation,
    double? cloudCover,
    double? uvIndex,
    double? snowfall,
    int? weatherCode,
    String? weatherIcon,
    String? weatherDescription,
    DateTime? sunrise,
    DateTime? sunset,
  }) = _WeatherObservationDto;

  factory WeatherObservationDto.fromJson(Map<String, dynamic> json) =>
      _$WeatherObservationDtoFromJson(json);
}
