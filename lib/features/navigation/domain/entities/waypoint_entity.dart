import 'package:freezed_annotation/freezed_annotation.dart';

part 'waypoint_entity.freezed.dart';

@freezed
abstract class WaypointEntity with _$WaypointEntity {
  const factory WaypointEntity({
    required int id,
    required int routeId,
    required double lat,
    required double lon,
    required int orderIndex,
    String? label,
  }) = _WaypointEntity;
}
