// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catch_size.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatchSize _$CatchSizeFromJson(Map<String, dynamic> json) => _CatchSize(
  species: $enumDecode(_$FishSpeciesEnumMap, json['species']),
  minimumSizeCm: (json['minimumSizeCm'] as num).toDouble(),
  maximumSizeCm: (json['maximumSizeCm'] as num?)?.toDouble(),
  isProtected: json['isProtected'] as bool? ?? false,
  region: json['region'] as String?,
  protectionStartDate: json['protectionStartDate'] == null
      ? null
      : DateTime.parse(json['protectionStartDate'] as String),
  protectionEndDate: json['protectionEndDate'] == null
      ? null
      : DateTime.parse(json['protectionEndDate'] as String),
);

Map<String, dynamic> _$CatchSizeToJson(_CatchSize instance) =>
    <String, dynamic>{
      'species': _$FishSpeciesEnumMap[instance.species]!,
      'minimumSizeCm': instance.minimumSizeCm,
      'maximumSizeCm': instance.maximumSizeCm,
      'isProtected': instance.isProtected,
      'region': instance.region,
      'protectionStartDate': instance.protectionStartDate?.toIso8601String(),
      'protectionEndDate': instance.protectionEndDate?.toIso8601String(),
    };

const _$FishSpeciesEnumMap = {
  FishSpecies.ahven: 'ahven',
  FishSpecies.hauki: 'hauki',
  FishSpecies.kuha: 'kuha',
  FishSpecies.lahna: 'lahna',
  FishSpecies.made: 'made',
  FishSpecies.lohi: 'lohi',
  FishSpecies.taimen: 'taimen',
  FishSpecies.siika: 'siika',
  FishSpecies.kirjolohi: 'kirjolohi',
  FishSpecies.muikku: 'muikku',
  FishSpecies.sarki: 'sarki',
  FishSpecies.kiiski: 'kiiski',
  FishSpecies.other: 'other',
};
