import 'dart:async';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/satellite/domain/entities/satellite_state.dart';

part 'satellite_providers.g.dart';

/// Provider for initial and tracked satellite viewer location.
/// Defaults to current vessel/user GPS location, with fallback to Finnish coastal center.
@riverpod
LatLng satelliteInitialLocation(Ref ref) {
  final mapState = ref.watch(mapProvider);
  if (mapState.hasLocation) {
    return mapState.userLocation;
  }
  // Default Finnish marine overview center (Helsinki / Porkkala archipelago)
  return const LatLng(60.15, 24.90);
}

@riverpod
class SatelliteController extends _$SatelliteController {
  Timer? _animationTimer;

  @override
  SatelliteState build() {
    final timestamps = _generateEumetsatTimestamps();
    ref.onDispose(() {
      _animationTimer?.cancel();
    });

    return SatelliteState.initial().copyWith(
      availableTimestamps: timestamps,
      currentTimestampIndex: timestamps.isNotEmpty ? timestamps.length - 1 : 0,
    );
  }

  List<DateTime> _generateEumetsatTimestamps() {
    final now = DateTime.now().toUtc();
    // Safety buffer of 15 min for latest complete satellite scan
    final latestTime = now.subtract(const Duration(minutes: 15));
    final flooredMinute = (latestTime.minute ~/ 15) * 15;
    final baseTime = DateTime.utc(
      latestTime.year,
      latestTime.month,
      latestTime.day,
      latestTime.hour,
      flooredMinute,
    );

    // Generate 24 steps (6 hours of 15-min scans)
    final timestamps = <DateTime>[];
    for (int i = 23; i >= 0; i--) {
      timestamps.add(baseTime.subtract(Duration(minutes: i * 15)));
    }
    return timestamps;
  }

  void setMode(SatelliteMode mode) {
    state = state.copyWith(mode: mode);
  }

  void setSentinelPreset(SentinelPreset preset) {
    state = state.copyWith(sentinelPreset: preset);
  }

  void setEumetsatPreset(EumetsatPreset preset) {
    state = state.copyWith(eumetsatPreset: preset);
  }

  void toggleNauticalOverlay() {
    state = state.copyWith(showNauticalOverlay: !state.showNauticalOverlay);
  }

  void setNauticalOverlayOpacity(double opacity) {
    state = state.copyWith(
      nauticalOverlayOpacity: opacity.clamp(0.1, 1.0),
    );
  }

  void setTimestampIndex(int index) {
    if (state.availableTimestamps.isEmpty) return;
    final clamped = index.clamp(0, state.availableTimestamps.length - 1);
    state = state.copyWith(currentTimestampIndex: clamped);
  }

  void togglePlayAnimation() {
    final isPlaying = !state.isPlaying;
    _animationTimer?.cancel();

    if (isPlaying) {
      _animationTimer = Timer.periodic(const Duration(milliseconds: 650), (_) {
        if (state.availableTimestamps.isEmpty) return;
        final nextIndex =
            (state.currentTimestampIndex + 1) %
            state.availableTimestamps.length;
        state = state.copyWith(currentTimestampIndex: nextIndex);
      });
    }

    state = state.copyWith(isPlaying: isPlaying);
  }
}
