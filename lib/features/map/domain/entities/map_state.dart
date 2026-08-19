import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';

part 'map_state.freezed.dart';

enum LocationPermissionStatus {
  unknown,
  granted,
  denied,
  deniedForever,
  serviceDisabled,
}

@freezed
abstract class MapState with _$MapState {
  const factory MapState({
    required LatLng userLocation,
    @Default(false) bool hasLocation,
    @Default(false) bool isLocationFresh,
    DateTime? lastPositionAt,
    @Default(0.0) double currentSpeedKmh,
    @Default(0.0) double heading,
    LatLng? projectedCenter,
    SpeedLimitZone? currentZone,
    @Default([]) List<SpeedLimitZone> visibleZones,
    @Default(LocationPermissionStatus.unknown)
    LocationPermissionStatus locationPermissionStatus,
  }) = _MapState;
}
