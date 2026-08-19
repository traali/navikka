// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fish_catch_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FishCatchDTO _$FishCatchDTOFromJson(Map<String, dynamic> json) =>
    _FishCatchDTO(
      id: json['id'] as String,
      species: json['species'] as String,
      timestampMs: (json['timestampMs'] as num).toInt(),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      weightGrams: (json['weightGrams'] as num?)?.toInt(),
      lengthCm: (json['lengthCm'] as num?)?.toDouble(),
      lure: json['lure'] as String?,
      method: json['method'] as String?,
      notes: json['notes'] as String?,
      weatherTemp: (json['weatherTemp'] as num?)?.toDouble(),
      weatherWindSpeed: (json['weatherWindSpeed'] as num?)?.toDouble(),
      weatherWindDir: (json['weatherWindDir'] as num?)?.toDouble(),
      weatherDesc: json['weatherDesc'] as String?,
      weatherIcon: json['weatherIcon'] as String?,
    );

Map<String, dynamic> _$FishCatchDTOToJson(_FishCatchDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'species': instance.species,
      'timestampMs': instance.timestampMs,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'weightGrams': instance.weightGrams,
      'lengthCm': instance.lengthCm,
      'lure': instance.lure,
      'method': instance.method,
      'notes': instance.notes,
      'weatherTemp': instance.weatherTemp,
      'weatherWindSpeed': instance.weatherWindSpeed,
      'weatherWindDir': instance.weatherWindDir,
      'weatherDesc': instance.weatherDesc,
      'weatherIcon': instance.weatherIcon,
    };
