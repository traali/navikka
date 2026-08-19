import 'package:freezed_annotation/freezed_annotation.dart';

part 'speed_limit_dto.freezed.dart';
part 'speed_limit_dto.g.dart';

@freezed
abstract class SpeedLimitDto with _$SpeedLimitDto {
  const factory SpeedLimitDto({
    required String id,
    required int limit,
    // Storing rings as simple lists for JSON/Sembast compatibility
    // List<List<List<double>>> : List of Rings, each Ring is List of Points,
    // each Point is [lon, lat]
    required List<List<List<double>>> rings,
    String? type,
    String? code,
  }) = _SpeedLimitDto;

  factory SpeedLimitDto.fromJson(Map<String, dynamic> json) =>
      _$SpeedLimitDtoFromJson(json);

  /// Parses GeoJSON feature into SpeedLimitDto(s).
  static List<SpeedLimitDto> fromGeoJsonMultiple(Map<String, dynamic> json) {
    try {
      final properties = json['properties'] as Map<String, dynamic>?;
      if (properties == null) return [];

      // Extract ID
      final baseId =
          json['id']?.toString() ?? properties['id']?.toString() ?? 'unknown';

      var limit = 0;
      final magnitude = properties['suuruus']?.toString();

      // Try to extract speed from 'suuruus' for ANY zone type
      if (magnitude != null && magnitude.isNotEmpty) {
        final normalized = magnitude.replaceAll(',', '.');
        final rawValue = double.tryParse(normalized) ?? 0.0;
        final unit = properties['yksikko']?.toString().toLowerCase() ?? '';
        final isKnots = unit.contains('solmu') || unit.contains('knot');
        final speedKmh = isKnots ? rawValue * 1.852 : rawValue;
        limit = speedKmh.round();
      }

      // Extract type code (e.g. "01", "11")
      final typeCode =
          properties['tyyppi']?.toString() ??
          properties['rajoitustyyppi']?.toString();
      final typeDescription =
          properties['rajoitustyyppi_selite']?.toString() ??
          properties['rajoitustyyppi']?.toString();

      // Extract Geometry
      final geometry = json['geometry'] as Map<String, dynamic>?;
      if (geometry == null) return [];

      final geometryType = geometry['type'] as String?;
      final coordinates = geometry['coordinates'] as List?;
      if (coordinates == null || coordinates.isEmpty) return [];

      final zones = <SpeedLimitDto>[];

      if (geometryType == 'Polygon') {
        // Single polygon
        final rings = _parsePolygonRings(coordinates);
        if (rings.isNotEmpty) {
          zones.add(
            SpeedLimitDto(
              id: baseId,
              limit: limit,
              rings: rings,
              type: typeDescription,
              code: typeCode,
            ),
          );
        }
      } else if (geometryType == 'MultiPolygon') {
        // Multiple polygons - create a zone for each
        for (var i = 0; i < coordinates.length; i++) {
          final polygonCoords = coordinates[i] as List;
          final rings = _parsePolygonRings(polygonCoords);
          if (rings.isNotEmpty) {
            zones.add(
              SpeedLimitDto(
                id: '${baseId}_$i', // Unique ID per polygon
                limit: limit,
                rings: rings,
                type: typeDescription,
                code: typeCode,
              ),
            );
          }
        }
      }

      return zones;
    } catch (e) {
      return [];
    }
  }

  /// Parses a polygon's coordinates into simple lists [lon, lat] (or whatever comes in, checking validity).
  /// Output: `List<List<[lon, lat]>>`
  static List<List<List<double>>> _parsePolygonRings(
    List<dynamic> coordinates,
  ) {
    if (coordinates.isEmpty) return [];

    final rings = <List<List<double>>>[];

    for (final ring in coordinates) {
      final ringCoords = ring as List;
      final points = <List<double>>[];

      for (final coord in ringCoords) {
        final c = coord as List;
        final val1 = (c[0] as num).toDouble();
        final val2 = (c[1] as num).toDouble();

        // GeoJSON is [Lng, Lat], but verify by checking latitude range
        if (val2 > 50.0 && val2 < 75.0) {
          // val2 is Latitude (Finland ~60N), val1 is Longitude
          points.add([val1, val2]);
        } else if (val1 > 50.0 && val1 < 75.0) {
          // val1 is Latitude (reversed order), val2 is Longitude
          points.add([val2, val1]);
        } else {
          // Fallback to standard GeoJSON [lon, lat]
          points.add([val1, val2]);
        }
      }
      if (points.length >= 3) {
        rings.add(points);
      }
    }
    return rings;
  }
}
