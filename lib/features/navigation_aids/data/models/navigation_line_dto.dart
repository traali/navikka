import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'navigation_line_dto.freezed.dart';

@freezed
abstract class NavigationLineDto with _$NavigationLineDto {
  const factory NavigationLineDto({
    required String id,
    required List<LatLng> points,
    String? name,
    double? navigationDepth,
    double? sweptDepth,
    String? fairwayClass,
    @Default(false) bool isBoatingRoute,
  }) = _NavigationLineDto;

  /// Creates DTO from GeoJSON feature.
  static NavigationLineDto fromGeoJson(Map<String, dynamic> feature) {
    final properties = feature['properties'] as Map<String, dynamic>? ?? {};
    final geometry = feature['geometry'] as Map<String, dynamic>?;

    final points = _parseLineString(geometry);

    final fairwayClass = properties['vaylaluokka']?.toString();
    final isBoating =
        fairwayClass == '4' || fairwayClass == '5' || fairwayClass == '6';

    return NavigationLineDto(
      id: feature['id']?.toString() ?? '',
      name:
          _parseString(properties['vaylaalue_nimi']) ??
          _parseString(properties['nimi']),
      navigationDepth: _parseDouble(properties['mitoitussyvays']),
      sweptDepth: _parseDouble(properties['haraussyvyys']),
      fairwayClass: fairwayClass,
      isBoatingRoute: isBoating,
      points: points,
    );
  }

  /// Creates DTO from cached JSON.
  static NavigationLineDto fromJson(Map<String, dynamic> json) {
    final pointsJson = json['points'] as List<dynamic>? ?? [];
    final points = <LatLng>[];
    for (final c in pointsJson) {
      if (c is List && c.length >= 2) {
        final lon = _parseDouble(c[0]);
        final lat = _parseDouble(c[1]);
        if (lon != null && lat != null) {
          points.add(LatLng(lat, lon));
        }
      }
    }

    return NavigationLineDto(
      id: json['id']?.toString() ?? '',
      name: _parseString(json['name']),
      navigationDepth: _parseDouble(json['navigationDepth']),
      sweptDepth: _parseDouble(json['sweptDepth']),
      fairwayClass: _parseString(json['fairwayClass']),
      isBoatingRoute: json['isBoatingRoute'] as bool? ?? false,
      points: points,
    );
  }

  static List<LatLng> _parseLineString(Map<String, dynamic>? geometry) {
    if (geometry == null) return [];
    final type = geometry['type'] as String?;
    final coordinates = geometry['coordinates'];

    if (type == 'LineString' && coordinates is List) {
      final points = <LatLng>[];
      for (final c in coordinates) {
        if (c is List && c.length >= 2) {
          final lon = _parseDouble(c[0]);
          final lat = _parseDouble(c[1]);
          if (lon != null && lat != null) {
            points.add(LatLng(lat, lon));
          }
        }
      }
      return points;
    }

    // Handle MultiLineString - take first for simplicity
    if (type == 'MultiLineString' &&
        coordinates is List &&
        coordinates.isNotEmpty) {
      final first = coordinates.first;
      if (first is List) {
        final points = <LatLng>[];
        for (final c in first) {
          if (c is List && c.length >= 2) {
            final lon = _parseDouble(c[0]);
            final lat = _parseDouble(c[1]);
            if (lon != null && lat != null) {
              points.add(LatLng(lat, lon));
            }
          }
        }
        return points;
      }
    }

    return [];
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

extension NavigationLineDtoX on NavigationLineDto {
  /// Converts DTO to JSON for caching.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'navigationDepth': navigationDepth,
      'sweptDepth': sweptDepth,
      'fairwayClass': fairwayClass,
      'isBoatingRoute': isBoatingRoute,
      'points': points.map((p) => [p.longitude, p.latitude]).toList(),
    };
  }
}
