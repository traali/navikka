import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'sea_level.freezed.dart';

@freezed
abstract class SeaLevel with _$SeaLevel {
  const factory SeaLevel({
    required DateTime timestamp,
    required LatLng location,
    required double seaLevel, // in mm
    String? stationName,
  }) = _SeaLevel;
}
