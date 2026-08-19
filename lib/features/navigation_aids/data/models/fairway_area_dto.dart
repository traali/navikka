import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'fairway_area_dto.freezed.dart';

/// Data Transfer Object for Fairway Area from WFS API.
///
/// Handles parsing GeoJSON from vesivaylatiedot:vaylaalueet_uusi layer.
@freezed
abstract class FairwayAreaDto with _$FairwayAreaDto {
  const factory FairwayAreaDto({
    required String id,
    required List<List<LatLng>> rings,
    String? name,
    double? navigationDepth,
    double? sweptDepth,
    String? qualityClass,
    String? fairwayType,
    String? status,
    String? buoyageSystem,
  }) = _FairwayAreaDto;

  /// Creates DTO from GeoJSON feature.
  static FairwayAreaDto fromGeoJson(Map<String, dynamic> feature) {
    final properties = feature['properties'] as Map<String, dynamic>? ?? {};
    final geometry = feature['geometry'] as Map<String, dynamic>?;

    // Parse polygon rings from GeoJSON coordinates
    final rings = _parsePolygonRings(geometry);

    return FairwayAreaDto(
      id: feature['id']?.toString() ?? '',
      name: _parseString(properties['vaylat']),
      navigationDepth: _parseDouble(properties['mitoitussyvays']),
      sweptDepth: _parseDouble(properties['haraussyvyys']),
      qualityClass: _parseString(properties['laatulk']),
      fairwayType: _parseString(properties['tyyppi']),
      status: _parseString(properties['liikennointistatus']),
      buoyageSystem: _parseString(properties['merkintalaji']),
      rings: rings,
    );
  }

  /// Creates DTO from cached JSON.
  static FairwayAreaDto fromJson(Map<String, dynamic> json) {
    final ringsJson = json['rings'] as List<dynamic>? ?? [];
    final rings = <List<LatLng>>[];

    for (final ringJson in ringsJson) {
      if (ringJson is List) {
        final points = <LatLng>[];
        for (final coord in ringJson) {
          if (coord is List && coord.length >= 2) {
            final lon = _parseDouble(coord[0]);
            final lat = _parseDouble(coord[1]);
            if (lon != null && lat != null) {
              points.add(LatLng(lat, lon));
            }
          }
        }
        if (points.isNotEmpty) {
          rings.add(points);
        }
      }
    }

    return FairwayAreaDto(
      id: json['id']?.toString() ?? '',
      name: _parseString(json['name']),
      navigationDepth: _parseDouble(json['navigationDepth']),
      sweptDepth: _parseDouble(json['sweptDepth']),
      qualityClass: _parseString(json['qualityClass']),
      fairwayType: _parseString(json['fairwayType']),
      status: _parseString(json['status']),
      buoyageSystem: _parseString(json['buoyageSystem']),
      rings: rings,
    );
  }

  /// Parses polygon rings from GeoJSON geometry.
  static List<List<LatLng>> _parsePolygonRings(Map<String, dynamic>? geometry) {
    if (geometry == null) return [];

    final type = geometry['type'] as String?;
    final coordinates = geometry['coordinates'];

    if (coordinates == null) return [];

    // Handle Polygon type
    if (type == 'Polygon' && coordinates is List) {
      return _parseRingsFromCoords(coordinates);
    }

    // Handle MultiPolygon - take first polygon only for simplicity
    if (type == 'MultiPolygon' &&
        coordinates is List &&
        coordinates.isNotEmpty) {
      final firstPolygon = coordinates.first;
      if (firstPolygon is List) {
        return _parseRingsFromCoords(firstPolygon);
      }
    }

    return [];
  }

  static List<List<LatLng>> _parseRingsFromCoords(List<dynamic> coordsRings) {
    final result = <List<LatLng>>[];
    for (final ring in coordsRings) {
      if (ring is List) {
        final points = <LatLng>[];
        for (final pt in ring) {
          if (pt is List && pt.length >= 2) {
            final lon = _parseDouble(pt[0]);
            final lat = _parseDouble(pt[1]);
            if (lon != null && lat != null) {
              points.add(LatLng(lat, lon));
            }
          }
        }
        if (points.length >= 3) {
          result.add(points);
        }
      }
    }
    return result;
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

extension FairwayAreaDtoX on FairwayAreaDto {
  /// Converts DTO to JSON for caching.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'navigationDepth': navigationDepth,
      'sweptDepth': sweptDepth,
      'qualityClass': qualityClass,
      'fairwayType': fairwayType,
      'status': status,
      'buoyageSystem': buoyageSystem,
      'rings': rings
          .map((r) => r.map((p) => [p.longitude, p.latitude]).toList())
          .toList(),
    };
  }
}
