import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sakkoja/features/weather/domain/entities/algae_data.dart';
import 'package:sakkoja/features/weather/domain/entities/lightning_strike.dart';
import 'package:sakkoja/features/weather/domain/entities/sea_level.dart';
import 'package:sakkoja/features/weather/domain/entities/water_quality_data.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_alert.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_forecast.dart';

part 'point_weather_state.freezed.dart';

@freezed
abstract class PointWeatherState with _$PointWeatherState {
  const factory PointWeatherState({
    required DateTime lastUpdated,
    WeatherData? weather,
    WaveData? wave,
    SeaLevel? seaLevel,
    @Default([]) List<WeatherForecast> forecast,
    @Default([]) List<WeatherAlert> activeAlerts,
    @Default([]) List<LightningStrike> lightningStrikes,
    double? nearestLightningDistanceMeters,
    WaterQualityData? waterQuality,
    AlgaeData? algae,
    @Default(false) bool isLoading,
    String? error,
    // Bug fix: Sync status tracking
    String? syncError,
    DateTime? lastSuccessfulSync,
    @Default(false) bool isSyncing,

    // Radar State
    @Default(false) bool isRadarVisible,
    @Default([]) List<DateTime> radarTimestamps,
    @Default(0) int currentTimestampIndex,
    @Default(false) bool isAnimating,
  }) = _PointWeatherState;
}

enum LightningAlarmLevel { none, warning, danger }

extension PointWeatherStateX on PointWeatherState {
  LightningAlarmLevel get lightningAlarmLevel {
    if (nearestLightningDistanceMeters == null) return LightningAlarmLevel.none;
    if (nearestLightningDistanceMeters! < 5000) {
      return LightningAlarmLevel.danger;
    }
    if (nearestLightningDistanceMeters! < 20000) {
      return LightningAlarmLevel.warning;
    }
    return LightningAlarmLevel.none;
  }

  bool get isStale =>
      DateTime.now().difference(lastUpdated) > const Duration(minutes: 60);
}
