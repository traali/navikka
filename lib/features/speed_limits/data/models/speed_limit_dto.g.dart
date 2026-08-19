// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speed_limit_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpeedLimitDto _$SpeedLimitDtoFromJson(Map<String, dynamic> json) =>
    _SpeedLimitDto(
      id: json['id'] as String,
      limit: (json['limit'] as num).toInt(),
      rings: (json['rings'] as List<dynamic>)
          .map(
            (e) => (e as List<dynamic>)
                .map(
                  (e) => (e as List<dynamic>)
                      .map((e) => (e as num).toDouble())
                      .toList(),
                )
                .toList(),
          )
          .toList(),
      type: json['type'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$SpeedLimitDtoToJson(_SpeedLimitDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'limit': instance.limit,
      'rings': instance.rings,
      'type': instance.type,
      'code': instance.code,
    };
