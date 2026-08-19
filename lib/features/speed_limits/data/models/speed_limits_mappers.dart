import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/speed_limits/data/models/speed_limit_dto.dart';
import 'package:sakkoja/features/speed_limits/data/models/traffic_sign_dto.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/traffic_sign.dart';

extension SpeedLimitDtoX on SpeedLimitDto {
  SpeedLimitZone toEntity() {
    return SpeedLimitZone(
      id: id,
      speedLimitKmh: limit,
      rings: rings
          .map(
            (ring) => ring.map((p) => LatLng(p[1], p[0])).toList(),
          )
          .toList(),
      typeDescription: type,
      typeCode: code,
    );
  }
}

extension SpeedLimitZoneX on SpeedLimitZone {
  SpeedLimitDto toDto() {
    return SpeedLimitDto(
      id: id,
      limit: speedLimitKmh,
      rings: rings
          .map((ring) => ring.map((p) => [p.longitude, p.latitude]).toList())
          .toList(),
      type: typeDescription,
      code: typeCode,
    );
  }
}

extension TrafficSignDtoX on TrafficSignDto {
  TrafficSign toEntity() {
    return TrafficSign(
      id: id,
      typeName: typeName,
      position: position,
      value: value,
      text: text ?? '',
    );
  }
}
