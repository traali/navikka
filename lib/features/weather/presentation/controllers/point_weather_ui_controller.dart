import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_ui_state.dart';

part 'point_weather_ui_controller.g.dart';

@riverpod
class PointWeatherUiController extends _$PointWeatherUiController {
  Timer? _radarTimer;
  bool _isDisposed = false;

  @override
  PointWeatherUiState build() {
    _isDisposed = false;
    ref.onDispose(() {
      _isDisposed = true;
      _radarTimer?.cancel();
    });

    return PointWeatherUiState(
      radarTimestamps: _generateRadarTimestamps(),
      currentTimestampIndex: 11, // Start at latest
    );
  }

  void toggleRadar() {
    state = state.copyWith(isRadarVisible: !state.isRadarVisible);
    if (!state.isRadarVisible && state.isAnimating) {
      toggleAnimation();
    }
  }

  void toggleAnimation() {
    final newAnimating = !state.isAnimating;
    state = state.copyWith(isAnimating: newAnimating);

    if (newAnimating) {
      _radarTimer?.cancel();
      _radarTimer = Timer.periodic(const Duration(milliseconds: 800), (_) {
        if (_isDisposed) return;
        final timestamps = _generateRadarTimestamps();
        final nextIndex = (state.currentTimestampIndex + 1) % timestamps.length;
        state = state.copyWith(
          radarTimestamps: timestamps,
          currentTimestampIndex: nextIndex,
        );
      });
    } else {
      _radarTimer?.cancel();
      _radarTimer = null;
    }
  }

  void setTimestampIndex(int index) {
    if (index >= 0 && index < 12) {
      state = state.copyWith(currentTimestampIndex: index);
    }
  }

  List<DateTime> _generateRadarTimestamps() {
    final now = DateTime.now();
    final baseTime = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      (now.minute ~/ 5) * 5,
    ).toUtc();
    return List.generate(12, (i) {
      return baseTime.subtract(Duration(minutes: (11 - i) * 5));
    });
  }
}
