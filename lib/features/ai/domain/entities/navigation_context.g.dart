// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_context.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NavigationContext _$NavigationContextFromJson(Map<String, dynamic> json) =>
    _NavigationContext(
      vesselType: $enumDecode(_$VesselTypeEnumMap, json['vesselType']),
      draftDepth: (json['draftDepth'] as num?)?.toDouble(),
      hasActiveRoute: json['hasActiveRoute'] as bool? ?? false,
      activeRouteName: json['activeRouteName'] as String?,
      routePoints: (json['routePoints'] as List<dynamic>?)
          ?.map((e) => LatLng.fromJson(e as Map<String, dynamic>))
          .toList(),
      detectedHazards: (json['detectedHazards'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isNearingCoast: json['isNearingCoast'] as bool? ?? false,
    );

Map<String, dynamic> _$NavigationContextToJson(_NavigationContext instance) =>
    <String, dynamic>{
      'vesselType': _$VesselTypeEnumMap[instance.vesselType]!,
      'draftDepth': instance.draftDepth,
      'hasActiveRoute': instance.hasActiveRoute,
      'activeRouteName': instance.activeRouteName,
      'routePoints': instance.routePoints,
      'detectedHazards': instance.detectedHazards,
      'isNearingCoast': instance.isNearingCoast,
    };

const _$VesselTypeEnumMap = {
  VesselType.openBoat: 'openBoat',
  VesselType.cabinBoat: 'cabinBoat',
  VesselType.sailboat: 'sailboat',
  VesselType.ship: 'ship',
};
