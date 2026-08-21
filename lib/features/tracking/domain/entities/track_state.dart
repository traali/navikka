import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sakkoja/features/tracking/domain/entities/track_point_entity.dart';

part 'track_state.freezed.dart';

@freezed
abstract class TrackState with _$TrackState {
  const factory TrackState({
    int? activeTrackId,
    String? trackName,
    @Default(false) bool isRecording,
    @Default([]) List<TrackPointEntity> points,
    @Default(0.0) double totalDistance,
    DateTime? startTime,
    @Default(0.0) double maxSpeedKmh,
  }) = _TrackState;
}
