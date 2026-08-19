import 'package:freezed_annotation/freezed_annotation.dart';

part 'point_weather_ui_state.freezed.dart';

@freezed
abstract class PointWeatherUiState with _$PointWeatherUiState {
  const factory PointWeatherUiState({
    @Default(false) bool isRadarVisible,
    @Default([]) List<DateTime> radarTimestamps,
    @Default(0) int currentTimestampIndex,
    @Default(false) bool isAnimating,
  }) = _PointWeatherUiState;
}
