// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wave_observation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WaveObservationDto _$WaveObservationDtoFromJson(Map<String, dynamic> json) =>
    _WaveObservationDto(
      timestamp: DateTime.parse(json['timestamp'] as String),
      location: const LatLngConverter().fromJson(
        json['location'] as Map<String, dynamic>,
      ),
      stationName: json['stationName'] as String?,
      waveHeight: (json['waveHeight'] as num?)?.toDouble(),
      wavePeriod: (json['wavePeriod'] as num?)?.toDouble(),
      waveDirection: (json['waveDirection'] as num?)?.toDouble(),
      waterTemperature: (json['waterTemperature'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WaveObservationDtoToJson(_WaveObservationDto instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'location': const LatLngConverter().toJson(instance.location),
      'stationName': instance.stationName,
      'waveHeight': instance.waveHeight,
      'wavePeriod': instance.wavePeriod,
      'waveDirection': instance.waveDirection,
      'waterTemperature': instance.waterTemperature,
    };
