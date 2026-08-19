import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'traffic_sign.freezed.dart';

@freezed
abstract class TrafficSign with _$TrafficSign {
  const factory TrafficSign({
    required String id,
    required String typeName,
    required LatLng position,
    double? value,
    @Default('') String text,
    @Default('') String direction,
  }) = _TrafficSign;
}
