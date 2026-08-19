// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lipas_harbor_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LipasHarborDto _$LipasHarborDtoFromJson(Map<String, dynamic> json) =>
    LipasHarborDto(
      sportsPlaceId: (json['sportsPlaceId'] as num).toInt(),
      name: json['name'] as String,
      typeCode: (json['typeCode'] as num).toInt(),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      municipalityName: json['municipalityName'] as String?,
      hasSauna: json['hasSauna'] as bool? ?? false,
      hasCampfire: json['hasCampfire'] as bool? ?? false,
      hasWater: json['hasWater'] as bool? ?? false,
      hasElectricity: json['hasElectricity'] as bool? ?? false,
      hasSeptic: json['hasSeptic'] as bool? ?? false,
      berths: (json['berths'] as num?)?.toInt(),
      depthMeters: (json['depthMeters'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LipasHarborDtoToJson(LipasHarborDto instance) =>
    <String, dynamic>{
      'sportsPlaceId': instance.sportsPlaceId,
      'name': instance.name,
      'typeCode': instance.typeCode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'municipalityName': instance.municipalityName,
      'hasSauna': instance.hasSauna,
      'hasCampfire': instance.hasCampfire,
      'hasWater': instance.hasWater,
      'hasElectricity': instance.hasElectricity,
      'hasSeptic': instance.hasSeptic,
      'berths': instance.berths,
      'depthMeters': instance.depthMeters,
    };
