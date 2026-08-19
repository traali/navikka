import 'package:freezed_annotation/freezed_annotation.dart';

part 'track_point_entity.freezed.dart';

@freezed
abstract class TrackPointEntity with _$TrackPointEntity {
  const factory TrackPointEntity({
    required double latitude,
    required double longitude,
    required double speedKmh,
    required DateTime timestamp,
  }) = _TrackPointEntity;
}
