import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/constants/sign_constants.dart';

part 'traffic_sign_dto.freezed.dart';

@freezed
abstract class TrafficSignDto with _$TrafficSignDto {
  const factory TrafficSignDto({
    required String id,
    required String typeName,
    required LatLng position,
    double? value,
    String? text,
  }) = _TrafficSignDto;

  static TrafficSignDto? fromGeoJson(Map<String, dynamic> json) {
    try {
      final properties = json['properties'] as Map<String, dynamic>?;
      if (properties == null) return null;

      final id =
          json['id']?.toString() ?? properties['id']?.toString() ?? 'unknown';

      // Parse Geometry (Point)
      final geometry = json['geometry'] as Map<String, dynamic>?;
      if (geometry == null || geometry['type'] != 'Point') return null;

      final coordinates = geometry['coordinates'] as List;
      if (coordinates.isEmpty) return null;

      var lon = (coordinates[0] as num).toDouble();
      var lat = (coordinates[1] as num).toDouble();

      // Simple coordinate swap check (Finland is ~60N, 25E)
      if (lat > 50 && lat < 75) {
        // lat is correct
      } else if (lon > 50 && lon < 75) {
        // swapped
        final temp = lat;
        lat = lon;
        lon = temp;
      }

      // Attributes
      // vlmtyyppi: Code for sign type.
      // 109 = Speed Limit? We need to map these codes or just show the 'rajoitusarvo'.
      // For now, store raw values and we can map them in UI or specialized mappers.

      final valStr = properties['rajoitusarvo']?.toString();
      double? value;
      if (valStr != null) {
        value = double.tryParse(valStr.replaceAll(',', '.'));
      }

      final text1 = properties['lisakilventeksti1']?.toString() ?? '';

      // Determine human readable type
      var readableType = SignConstants.kUnknownTypeName;
      if (value != null) {
        readableType = SignConstants.kSpeedLimitTypeName;
      } else if (properties['nimifi'] != null) {
        readableType = properties['nimifi'].toString();
      }

      return TrafficSignDto(
        id: id,
        typeName: readableType,
        position: LatLng(lat, lon),
        value: value,
        text: text1,
      );
    } catch (e) {
      return null;
    }
  }
}
