import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'navigation_aid_dto.freezed.dart';

/// Types of navigation aids in Finnish waterways.
/// DTO-local enum — must mirror domain [NavigationAidType] exactly.
enum NavigationAidTypeDto {
  /// Water traffic sign - regulatory signs (speed limits, prohibitions).
  trafficSign,

  /// Maritime safety equipment - beacons, buoys, markers.
  safetyEquipment,

  /// Lighthouse - illuminated navigation aid with light patterns.
  lighthouse,
}

/// Physical mounting type for navigation aids.
/// DTO-local enum — must mirror domain [NavigationAidMounting] exactly.
enum NavigationAidMountingDto {
  /// Floating device (buoy, floating beacon).
  floating,

  /// Fixed device mounted on structure or ground.
  fixed,
}

/// Data Transfer Object for Navigation Aid from WFS API.
/// Unified DTO for traffic signs, safety equipment, and lighthouses.
@freezed
abstract class NavigationAidDto with _$NavigationAidDto {
  const factory NavigationAidDto({
    required String id,
    required NavigationAidTypeDto type,
    required LatLng position,
    String? name,
    NavigationAidMountingDto? mounting,
    String? ialaCode,
    String? lightCharacteristics,
    double? lightRangeNm,
    String? signTypeCode,
    String? signTypeDescription,
    double? restrictionValue,
    String? owner,
  }) = _NavigationAidDto;

  /// Creates DTO from traffic sign GeoJSON (vesiliikennemerkit_uusi).
  static NavigationAidDto fromTrafficSignGeoJson(Map<String, dynamic> feature) {
    final properties = feature['properties'] as Map<String, dynamic>? ?? {};
    final position = _parsePoint(feature['geometry'] as Map<String, dynamic>?);

    return NavigationAidDto(
      id: feature['id']?.toString() ?? '',
      type: NavigationAidTypeDto.trafficSign,
      name: _parseString(properties['nimifi']),
      position: position ?? const LatLng(0, 0),
      signTypeCode: properties['vlmlajityyppi']?.toString(),
      signTypeDescription: _parseString(properties['merkki_selite']),
      restrictionValue: _parseDouble(properties['rajoitusarvo']),
      owner: _parseString(properties['omistaja']),
    );
  }

  /// Creates DTO from safety equipment GeoJSON (turvalaitteet_uusi).
  static NavigationAidDto fromSafetyEquipmentGeoJson(
    Map<String, dynamic> feature,
  ) {
    final properties = feature['properties'] as Map<String, dynamic>? ?? {};
    final position = _parsePoint(feature['geometry'] as Map<String, dynamic>?);

    // Determine mounting type
    final alityyppi = _parseString(properties['alityyppi']);
    NavigationAidMountingDto? mounting;
    if (alityyppi != null) {
      mounting = alityyppi.toLowerCase().contains('kelluva')
          ? NavigationAidMountingDto.floating
          : NavigationAidMountingDto.fixed;
    }

    return NavigationAidDto(
      id: feature['id']?.toString() ?? '',
      type: NavigationAidTypeDto.safetyEquipment,
      name: _parseString(properties['nimifi']),
      position: position ?? const LatLng(0, 0),
      mounting: mounting,
      ialaCode: properties['navigointilajikoodi']?.toString(),
      lightCharacteristics: _parseString(properties['virallvalotunnus']),
      owner: _parseString(properties['omistaja']),
    );
  }

  /// Creates DTO from lighthouse GeoJSON (loistot_uusi).
  static NavigationAidDto fromLighthouseGeoJson(Map<String, dynamic> feature) {
    final properties = feature['properties'] as Map<String, dynamic>? ?? {};
    final position = _parsePoint(feature['geometry'] as Map<String, dynamic>?);

    return NavigationAidDto(
      id: feature['id']?.toString() ?? '',
      type: NavigationAidTypeDto.lighthouse,
      name:
          _parseString(properties['nimifi']) ??
          _parseString(properties['virallvalotunnus']),
      position: position ?? const LatLng(0, 0),
      mounting: NavigationAidMountingDto.fixed,
      lightCharacteristics: _parseString(properties['virallvalotunnus']),
      lightRangeNm: _parseDouble(properties['optinenkanto']),
      owner: _parseString(properties['omistaja']),
    );
  }

  /// Creates DTO from cached JSON.
  static NavigationAidDto fromJson(Map<String, dynamic> json) {
    final positionJson = json['position'] as List<dynamic>?;
    var position = const LatLng(0, 0);
    if (positionJson != null && positionJson.length >= 2) {
      final lon = _parseDouble(positionJson[0]) ?? 0.0;
      final lat = _parseDouble(positionJson[1]) ?? 0.0;
      position = LatLng(lat, lon);
    }

    final typeStr = _parseString(json['type']) ?? 'safetyEquipment';
    final type = NavigationAidTypeDto.values.firstWhere(
      (t) => t.name == typeStr,
      orElse: () => NavigationAidTypeDto.safetyEquipment,
    );

    final mountingStr = _parseString(json['mounting']);
    NavigationAidMountingDto? mounting;
    if (mountingStr != null) {
      for (final m in NavigationAidMountingDto.values) {
        if (m.name == mountingStr) {
          mounting = m;
          break;
        }
      }
    }

    return NavigationAidDto(
      id: json['id']?.toString() ?? '',
      type: type,
      name: _parseString(json['name']),
      position: position,
      mounting: mounting,
      ialaCode: _parseString(json['ialaCode']),
      lightCharacteristics: _parseString(json['lightCharacteristics']),
      lightRangeNm: _parseDouble(json['lightRangeNm']),
      signTypeCode: _parseString(json['signTypeCode']),
      signTypeDescription: _parseString(json['signTypeDescription']),
      restrictionValue: _parseDouble(json['restrictionValue']),
      owner: _parseString(json['owner']),
    );
  }

  static LatLng? _parsePoint(Map<String, dynamic>? geometry) {
    if (geometry == null) return null;
    final coords = geometry['coordinates'];
    if (coords is List && coords.length >= 2) {
      final lon = _parseDouble(coords[0]);
      final lat = _parseDouble(coords[1]);
      if (lon != null && lat != null) {
        return LatLng(lat, lon);
      }
    }
    return null;
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static String? _parseString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    return value.toString();
  }
}

extension NavigationAidDtoX on NavigationAidDto {
  /// Converts DTO to JSON for caching.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'position': [position.longitude, position.latitude],
      'name': name,
      'mounting': mounting?.name,
      'ialaCode': ialaCode,
      'lightCharacteristics': lightCharacteristics,
      'lightRangeNm': lightRangeNm,
      'signTypeCode': signTypeCode,
      'signTypeDescription': signTypeDescription,
      'restrictionValue': restrictionValue,
      'owner': owner,
    };
  }
}
