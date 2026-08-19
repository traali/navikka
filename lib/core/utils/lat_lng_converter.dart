import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

/// A [JsonConverter] that converts [LatLng] to and from a [Map].
///
/// This is required for Sembast compatibility on Web, where custom types
/// like [LatLng] are not automatically serialized to JSON-compatible types,
/// leading to minification errors.
class LatLngConverter implements JsonConverter<LatLng, Map<String, dynamic>> {
  const LatLngConverter();

  @override
  LatLng fromJson(Map<String, dynamic> json) {
    return LatLng(
      (json['lat'] as num).toDouble(),
      (json['lng'] as num).toDouble(),
    );
  }

  @override
  Map<String, dynamic> toJson(LatLng latLng) {
    return {'lat': latLng.latitude, 'lng': latLng.longitude};
  }
}

/// A [JsonConverter] that converts a [List<LatLng>] to and from a [List].
class LatLngListConverter
    implements JsonConverter<List<LatLng>, List<dynamic>> {
  const LatLngListConverter();

  @override
  List<LatLng> fromJson(List<dynamic> json) {
    return json
        .map((e) => const LatLngConverter().fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  List<dynamic> toJson(List<LatLng> objects) {
    return objects.map((e) => const LatLngConverter().toJson(e)).toList();
  }
}
