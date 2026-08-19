// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_observation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeatherObservationDto _$WeatherObservationDtoFromJson(
  Map<String, dynamic> json,
) => _WeatherObservationDto(
  timestamp: DateTime.parse(json['timestamp'] as String),
  location: const LatLngConverter().fromJson(
    json['location'] as Map<String, dynamic>,
  ),
  temperature: (json['temperature'] as num?)?.toDouble(),
  feelsLike: (json['feelsLike'] as num?)?.toDouble(),
  windSpeed: (json['windSpeed'] as num?)?.toDouble(),
  windGust: (json['windGust'] as num?)?.toDouble(),
  windDirection: (json['windDirection'] as num?)?.toDouble(),
  pressure: (json['pressure'] as num?)?.toDouble(),
  stationName: json['stationName'] as String?,
  providerId: (json['providerId'] as num?)?.toInt(),
  visibility: (json['visibility'] as num?)?.toDouble(),
  humidity: (json['humidity'] as num?)?.toDouble(),
  dewPoint: (json['dewPoint'] as num?)?.toDouble(),
  precipitation: (json['precipitation'] as num?)?.toDouble(),
  cloudCover: (json['cloudCover'] as num?)?.toDouble(),
  uvIndex: (json['uvIndex'] as num?)?.toDouble(),
  snowfall: (json['snowfall'] as num?)?.toDouble(),
  weatherCode: (json['weatherCode'] as num?)?.toInt(),
  weatherIcon: json['weatherIcon'] as String?,
  weatherDescription: json['weatherDescription'] as String?,
  sunrise: json['sunrise'] == null
      ? null
      : DateTime.parse(json['sunrise'] as String),
  sunset: json['sunset'] == null
      ? null
      : DateTime.parse(json['sunset'] as String),
);

Map<String, dynamic> _$WeatherObservationDtoToJson(
  _WeatherObservationDto instance,
) => <String, dynamic>{
  'timestamp': instance.timestamp.toIso8601String(),
  'location': const LatLngConverter().toJson(instance.location),
  'temperature': instance.temperature,
  'feelsLike': instance.feelsLike,
  'windSpeed': instance.windSpeed,
  'windGust': instance.windGust,
  'windDirection': instance.windDirection,
  'pressure': instance.pressure,
  'stationName': instance.stationName,
  'providerId': instance.providerId,
  'visibility': instance.visibility,
  'humidity': instance.humidity,
  'dewPoint': instance.dewPoint,
  'precipitation': instance.precipitation,
  'cloudCover': instance.cloudCover,
  'uvIndex': instance.uvIndex,
  'snowfall': instance.snowfall,
  'weatherCode': instance.weatherCode,
  'weatherIcon': instance.weatherIcon,
  'weatherDescription': instance.weatherDescription,
  'sunrise': instance.sunrise?.toIso8601String(),
  'sunset': instance.sunset?.toIso8601String(),
};
