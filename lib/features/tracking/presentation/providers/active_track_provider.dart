import 'dart:async';

import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_mode_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/tracking/data/repositories/track_repository.dart';
import 'package:sakkoja/features/tracking/domain/entities/track_point_entity.dart';
import 'package:sakkoja/features/tracking/domain/entities/track_state.dart';

part 'active_track_provider.g.dart';

@riverpod
class ActiveTrackNotifier extends _$ActiveTrackNotifier {
  _PendingTrackPoint? _pendingPoint;
  Future<void>? _drainFuture;

  @override
  TrackState build() {
    // Listen to Map updates to record points
    ref.listen(mapProvider, (prev, next) {
      if (state.isRecording && next.isLocationFresh) {
        _queuePoint(
          _PendingTrackPoint(
            location: next.userLocation,
            speedKmh: next.currentSpeedKmh,
            timestamp: next.lastPositionAt ?? DateTime.now(),
          ),
        );
      }
    });

    return const TrackState();
  }

  Future<void> startRecording({String? name}) async {
    await _drainFuture;
    _pendingPoint = null;
    final isFishingMode =
        ref.read(fishingModeControllerProvider).value?.isEnabled ?? false;
    final result = await ref
        .read(trackRepositoryProvider)
        .startTrack(
          name: name,
          isFishingMode: isFishingMode,
        );
    result.fold(
      (failure) => Log.e('ActiveTrack: Failed to start track', failure),
      (trackId) {
        state = state.copyWith(
          activeTrackId: trackId,
          isRecording: true,
          points: [],
          totalDistance: 0,
        );
      },
    );
  }

  Future<void> stopRecording() async {
    if (state.activeTrackId == null) return;
    state = state.copyWith(isRecording: false);
    await _drainFuture;
    final result = await ref
        .read(trackRepositoryProvider)
        .endTrack(state.activeTrackId!, state.totalDistance);
    result.fold(
      (failure) {
        state = state.copyWith(isRecording: true);
        Log.e('ActiveTrack: Failed to end track', failure);
      },
      (_) {
        state = state.copyWith(isRecording: false, activeTrackId: null);
      },
    );
  }

  void _queuePoint(_PendingTrackPoint point) {
    _pendingPoint = point;
    if (_drainFuture != null) return;

    final drain = _drainPoints();
    _drainFuture = drain;
    unawaited(
      drain.whenComplete(() {
        _drainFuture = null;
        if (_pendingPoint != null && state.isRecording) {
          _queuePoint(_pendingPoint!);
        }
      }),
    );
  }

  Future<void> _drainPoints() async {
    while (_pendingPoint != null) {
      final point = _pendingPoint!;
      _pendingPoint = null;
      await _recordPoint(point);
    }
  }

  Future<void> _recordPoint(_PendingTrackPoint sample) async {
    if (state.activeTrackId == null) return;
    final location = sample.location;

    // Filter: Only record if moved > 5m or first point (or 5-minute heartbeat)
    var newDistance = state.totalDistance;
    if (state.points.isNotEmpty) {
      final lastPoint = state.points.last;
      final distance = const Distance().as(
        LengthUnit.Meter,
        LatLng(lastPoint.latitude, lastPoint.longitude),
        location,
      );
      final elapsed = sample.timestamp.difference(lastPoint.timestamp);
      if (distance < 5.0 &&
          sample.speedKmh < 0.926 &&
          elapsed < const Duration(minutes: 5)) {
        return;
      }
      newDistance += distance;
    }

    var persisted = false;
    try {
      final result = await ref
          .read(trackRepositoryProvider)
          .addPoint(
            state.activeTrackId!,
            location.latitude,
            location.longitude,
            sample.speedKmh,
            timestamp: sample.timestamp,
          );
      result.fold(
        (failure) => Log.e('ActiveTrack: Failed to record point', failure),
        (_) => persisted = true,
      );
    } catch (e, stackTrace) {
      Log.e('ActiveTrack: Unexpected error recording point', e, stackTrace);
    }
    if (!persisted) return;

    // Update local state for UI (limited to last 500 points for performance)
    const maxPoints = 500;
    final newPoint = TrackPointEntity(
      latitude: location.latitude,
      longitude: location.longitude,
      speedKmh: sample.speedKmh,
      timestamp: sample.timestamp,
    );
    final newPoints = <TrackPointEntity>[
      if (state.points.length >= maxPoints)
        ...state.points.getRange(1, maxPoints)
      else
        ...state.points,
      newPoint,
    ];
    state = state.copyWith(points: newPoints, totalDistance: newDistance);
  }
}

class _PendingTrackPoint {
  const _PendingTrackPoint({
    required this.location,
    required this.speedKmh,
    required this.timestamp,
  });

  final LatLng location;
  final double speedKmh;
  final DateTime timestamp;
}
