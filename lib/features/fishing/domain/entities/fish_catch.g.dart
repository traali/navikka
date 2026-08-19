// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fish_catch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FishCatch _$FishCatchFromJson(Map<String, dynamic> json) => _FishCatch(
  id: json['id'] as String,
  species: $enumDecode(_$FishSpeciesEnumMap, json['species']),
  timestamp: DateTime.parse(json['timestamp'] as String),
  location: _latLngFromJson(json['location'] as Map<String, dynamic>),
  weightGrams: (json['weightGrams'] as num?)?.toInt(),
  lengthCm: (json['lengthCm'] as num?)?.toDouble(),
  lure: json['lure'] as String?,
  method: $enumDecodeNullable(_$FishingMethodEnumMap, json['method']),
  notes: json['notes'] as String?,
  weatherTemp: (json['weatherTemp'] as num?)?.toDouble(),
  weatherWindSpeed: (json['weatherWindSpeed'] as num?)?.toDouble(),
  weatherWindDir: (json['weatherWindDir'] as num?)?.toDouble(),
  weatherDesc: json['weatherDesc'] as String?,
  weatherIcon: json['weatherIcon'] as String?,
);

Map<String, dynamic> _$FishCatchToJson(_FishCatch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'species': _$FishSpeciesEnumMap[instance.species]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'location': _latLngToJson(instance.location),
      'weightGrams': instance.weightGrams,
      'lengthCm': instance.lengthCm,
      'lure': instance.lure,
      'method': _$FishingMethodEnumMap[instance.method],
      'notes': instance.notes,
      'weatherTemp': instance.weatherTemp,
      'weatherWindSpeed': instance.weatherWindSpeed,
      'weatherWindDir': instance.weatherWindDir,
      'weatherDesc': instance.weatherDesc,
      'weatherIcon': instance.weatherIcon,
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

const _$FishingMethodEnumMap = {
  FishingMethod.trolling: 'trolling',
  FishingMethod.spinning: 'spinning',
  FishingMethod.jigging: 'jigging',
  FishingMethod.flyfishing: 'flyfishing',
  FishingMethod.netting: 'netting',
  FishingMethod.other: 'other',
};
