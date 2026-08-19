// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeatherForecastDto _$WeatherForecastDtoFromJson(Map<String, dynamic> json) =>
    _WeatherForecastDto(
      timestamp: DateTime.parse(json['timestamp'] as String),
      location: const LatLngConverter().fromJson(
        json['location'] as Map<String, dynamic>,
      ),
      issuedAt: json['issuedAt'] == null
          ? null
          : DateTime.parse(json['issuedAt'] as String),
      providerId: (json['providerId'] as num?)?.toInt(),
      temperature: (json['temperature'] as num?)?.toDouble(),
      feelsLike: (json['feelsLike'] as num?)?.toDouble(),
      windSpeed: (json['windSpeed'] as num?)?.toDouble(),
      windGust: (json['windGust'] as num?)?.toDouble(),
      windDirection: (json['windDirection'] as num?)?.toDouble(),
      precipitation: (json['precipitation'] as num?)?.toDouble(),
      precipitationProbability: (json['precipitationProbability'] as num?)
          ?.toDouble(),
      pressure: (json['pressure'] as num?)?.toDouble(),
      humidity: (json['humidity'] as num?)?.toDouble(),
      dewPoint: (json['dewPoint'] as num?)?.toDouble(),
      cloudCover: (json['cloudCover'] as num?)?.toDouble(),
      uvIndex: (json['uvIndex'] as num?)?.toDouble(),
      weatherIcon: json['weatherIcon'] as String?,
      weatherDescription: json['weatherDescription'] as String?,
    );

Map<String, dynamic> _$WeatherForecastDtoToJson(_WeatherForecastDto instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'location': const LatLngConverter().toJson(instance.location),
      'issuedAt': instance.issuedAt?.toIso8601String(),
      'providerId': instance.providerId,
      'temperature': instance.temperature,
      'feelsLike': instance.feelsLike,
      'windSpeed': instance.windSpeed,
      'windGust': instance.windGust,
      'windDirection': instance.windDirection,
      'precipitation': instance.precipitation,
      'precipitationProbability': instance.precipitationProbability,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'dewPoint': instance.dewPoint,
      'cloudCover': instance.cloudCover,
      'uvIndex': instance.uvIndex,
      'weatherIcon': instance.weatherIcon,
      'weatherDescription': instance.weatherDescription,
    };
