import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sakkoja/features/weather/domain/entities/lightning_strike.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_alert.dart';

part 'point_weather_alert_state.freezed.dart';

@freezed
abstract class PointWeatherAlertState with _$PointWeatherAlertState {
  const factory PointWeatherAlertState({
    required List<WeatherAlert> activeAlerts,
    required List<LightningStrike> lightningStrikes,
    required double? nearestLightning,
  }) = _PointWeatherAlertState;
}
