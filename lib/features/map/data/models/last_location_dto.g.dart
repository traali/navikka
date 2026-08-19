// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LastLocationDto _$LastLocationDtoFromJson(Map<String, dynamic> json) =>
    _LastLocationDto(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$LastLocationDtoToJson(_LastLocationDto instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
