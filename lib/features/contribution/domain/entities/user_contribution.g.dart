// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_contribution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserContribution _$UserContributionFromJson(Map<String, dynamic> json) =>
    _UserContribution(
      id: json['id'] as String,
      type: $enumDecode(_$ContributionTypeEnumMap, json['type']),
      location: _latLngFromJson(json['location'] as Map<String, dynamic>),
      value: json['value'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isSynced: json['isSynced'] as bool? ?? false,
    );

Map<String, dynamic> _$UserContributionToJson(_UserContribution instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ContributionTypeEnumMap[instance.type]!,
      'location': _latLngToJson(instance.location),
      'value': instance.value,
      'createdAt': instance.createdAt.toIso8601String(),
      'isSynced': instance.isSynced,
    };

const _$ContributionTypeEnumMap = {
  ContributionType.speedLimit: 'speedLimit',
  ContributionType.trafficSign: 'trafficSign',
};
