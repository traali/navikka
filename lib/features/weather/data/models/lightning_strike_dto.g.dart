// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lightning_strike_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LightningStrikeDto _$LightningStrikeDtoFromJson(Map<String, dynamic> json) =>
    _LightningStrikeDto(
      time: DateTime.parse(json['time'] as String),
      location: LatLng.fromJson(json['location'] as Map<String, dynamic>),
      peakCurrent: (json['peakCurrent'] as num).toDouble(),
      multiplicity: (json['multiplicity'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$LightningStrikeDtoToJson(_LightningStrikeDto instance) =>
    <String, dynamic>{
      'time': instance.time.toIso8601String(),
      'location': instance.location,
      'peakCurrent': instance.peakCurrent,
      'multiplicity': instance.multiplicity,
    };
