import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'last_location_dto.freezed.dart';
part 'last_location_dto.g.dart';

@freezed
abstract class LastLocationDto with _$LastLocationDto {
  const factory LastLocationDto({
    required double latitude,
    required double longitude,
  }) = _LastLocationDto;

  factory LastLocationDto.fromJson(Map<String, dynamic> json) =>
      _$LastLocationDtoFromJson(json);

  /// Creates DTO from LatLng.
  factory LastLocationDto.fromLatLng(LatLng latLng) {
    return LastLocationDto(
      latitude: latLng.latitude,
      longitude: latLng.longitude,
    );
  }
}

extension LastLocationDtoX on LastLocationDto {
  /// Converts DTO to LatLng.
  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }
}
