import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'waterway_feature_dto.freezed.dart';

/// DTO-local enum mirroring domain WaterwayFeatureType.
enum WaterwayFeatureDtoType {
  fairwayArea,
  waterwayLink,
  beacon,
  buoy,
  unknown,
}

@freezed
abstract class WaterwayFeatureDto with _$WaterwayFeatureDto {
  const factory WaterwayFeatureDto({
    required String id,
    required WaterwayFeatureDtoType type,
    String? name,
    List<List<LatLng>>? rings,
    List<LatLng>? points,
    LatLng? position,
  }) = _WaterwayFeatureDto;

  /// Creates DTO from JSON (custom parsing).
  static WaterwayFeatureDto fromJson(Map<String, dynamic> json) {
    return WaterwayFeatureDto(
      id: json['id'] as String,
      name: json['name'] as String?,
      type: WaterwayFeatureDtoType.values.byName(json['type'] as String),
      rings: (json['rings'] as List?)
          ?.map(
            (r) => (r as List<dynamic>)
                .map(
                  (c) => LatLng(
                    (c['lat'] as num).toDouble(),
                    (c['lng'] as num).toDouble(),
                  ),
                )
                .toList(),
          )
          .toList(),
      points: (json['points'] as List?)
          ?.map(
            (c) => LatLng(
              (c['lat'] as num).toDouble(),
              (c['lng'] as num).toDouble(),
            ),
          )
          .toList(),
      position: json['position'] != null
          ? LatLng(
              (json['position']['lat'] as num).toDouble(),
              (json['position']['lng'] as num).toDouble(),
            )
          : null,
    );
  }

  /// Parses GeoJSON with fallback type.
  static WaterwayFeatureDto fromGeoJson(
    Map<String, dynamic> json,
    WaterwayFeatureDtoType fallbackType,
  ) {
    final properties = json['properties'] as Map<String, dynamic>? ?? {};
    final id =
        json['id']?.toString() ?? properties['id']?.toString() ?? 'unknown';
    final name =
        properties['nimi']?.toString() ?? properties['name']?.toString();

    // Determine type from properties or fallback
    var type = fallbackType;
    if (json['id']?.toString().startsWith('FairwayArea') ?? false) {
      type = WaterwayFeatureDtoType.fairwayArea;
    } else if (json['id']?.toString().startsWith('Beacon') ?? false) {
      type = WaterwayFeatureDtoType.beacon;
    } else if (json['id']?.toString().startsWith('Buoy') ?? false) {
      type = WaterwayFeatureDtoType.buoy;
    }

    final geometry = json['geometry'] as Map<String, dynamic>?;
    List<List<LatLng>>? rings;
    List<LatLng>? points;
    LatLng? position;

    if (geometry != null) {
      final gType = geometry['type'];
      final coordinates = geometry['coordinates'];

      if (gType == 'Point') {
        final pair = coordinates as List<dynamic>;
        position = LatLng(
          (pair[1] as num).toDouble(),
          (pair[0] as num).toDouble(),
        );
      } else if (gType == 'LineString') {
        final list = coordinates as List<dynamic>;
        points = list.map((c) {
          final pair = c as List<dynamic>;
          return LatLng(
            (pair[1] as num).toDouble(),
            (pair[0] as num).toDouble(),
          );
        }).toList();
      } else if (gType == 'Polygon') {
        rings = _parseRings(coordinates as List<dynamic>);
      } else if (gType == 'MultiPolygon') {
        rings = [];
        for (final poly in (coordinates as List<dynamic>)) {
          rings.addAll(_parseRings(poly as List<dynamic>));
        }
      }
    }

    return WaterwayFeatureDto(
      id: id,
      name: name,
      type: type,
      rings: rings,
      points: points,
      position: position,
    );
  }

  static List<List<LatLng>> _parseRings(List<dynamic> ringsJson) {
    final rings = <List<LatLng>>[];
    for (final ring in ringsJson) {
      final ringCoords = ring as List<dynamic>;
      final points = ringCoords.map((c) {
        final pair = c as List<dynamic>;
        return LatLng((pair[1] as num).toDouble(), (pair[0] as num).toDouble());
      }).toList();
      if (points.isNotEmpty) rings.add(points);
    }
    return rings;
  }
}

extension WaterwayFeatureDtoX on WaterwayFeatureDto {
  /// Converts DTO to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.name,
      'rings': rings
          ?.map(
            (r) =>
                r.map((c) => {'lat': c.latitude, 'lng': c.longitude}).toList(),
          )
          .toList(),
      'points': points
          ?.map((c) => {'lat': c.latitude, 'lng': c.longitude})
          .toList(),
      'position': position != null
          ? {'lat': position!.latitude, 'lng': position!.longitude}
          : null,
    };
  }
}
