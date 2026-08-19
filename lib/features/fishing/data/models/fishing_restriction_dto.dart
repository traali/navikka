import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'fishing_restriction_dto.freezed.dart';

@freezed
abstract class FishingRestrictionDto with _$FishingRestrictionDto {
  const factory FishingRestrictionDto({
    required String id,
    required String title,
    required List<List<LatLng>> rings,
    String? type,
    String? description,
    String? validity,
  }) = _FishingRestrictionDto;

  /// Creates DTO from JSON (custom parsing for LatLng).
  static FishingRestrictionDto fromJson(Map<String, dynamic> json) {
    final rings = (json['rings'] as List<dynamic>)
        .map(
          (r) => (r as List<dynamic>)
              .map(
                (c) => LatLng(
                  (c['lat'] as num).toDouble(),
                  (c['lng'] as num).toDouble(),
                ),
              )
              .toList(),
        )
        .toList();

    return FishingRestrictionDto(
      id: json['id'] as String,
      title: json['title'] as String,
      rings: rings,
      type: json['type'] as String?,
      description: json['description'] as String?,
      validity: json['validity'] as String?,
    );
  }

  /// Parses GeoJSON to list of DTOs (handling MultiPolygon).
  static List<FishingRestrictionDto> fromGeoJsonList(
    Map<String, dynamic> json,
  ) {
    final properties = json['properties'] as Map<String, dynamic>? ?? {};
    final idBase =
        json['id']?.toString() ?? properties['id']?.toString() ?? 'unknown';
    final title =
        properties['nimi']?.toString() ??
        properties['title']?.toString() ??
        properties['KIELLONNIMI']?.toString() ??
        'Unnamed Restriction';
    final type =
        properties['rajoitustyyppi']?.toString() ??
        properties['KIELLONTYYPIT']?.toString();
    final description =
        properties['selite']?.toString() ??
        properties['KIELLONLISATIETO']?.toString();
    final validity =
        properties['voimassaolo']?.toString() ??
        properties['KIELLONVOIMASSAOLO']?.toString();

    final geometry = json['geometry'] as Map<String, dynamic>?;
    final results = <FishingRestrictionDto>[];

    if (geometry != null) {
      final typeStr = geometry['type'];
      final coordinates = geometry['coordinates'] as List<dynamic>?;

      if (coordinates != null) {
        if (typeStr == 'Polygon') {
          // Single Polygon: One entity
          final rings = _parseRings(coordinates);
          results.add(
            FishingRestrictionDto(
              id: idBase,
              title: title,
              rings: rings,
              type: type,
              description: description,
              validity: validity,
            ),
          );
        } else if (typeStr == 'MultiPolygon') {
          // MultiPolygon: Multiple entities (one per polygon part)
          // coordinates is List<List<List<coord>>> -> List<Polygon>
          for (var i = 0; i < coordinates.length; i++) {
            final polyCoords = coordinates[i] as List<dynamic>;
            final rings = _parseRings(polyCoords);
            // Suffix ID to keep them unique but related
            final pId = '$idBase-part$i';
            results.add(
              FishingRestrictionDto(
                id: pId,
                title: title,
                rings: rings,
                type: type,
                description: description,
                validity: validity,
              ),
            );
          }
        }
      }
    }

    return results;
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

extension FishingRestrictionDtoX on FishingRestrictionDto {
  /// Converts DTO to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'description': description,
      'validity': validity,
      'rings': rings
          .map(
            (r) =>
                r.map((c) => {'lat': c.latitude, 'lng': c.longitude}).toList(),
          )
          .toList(),
    };
  }
}
