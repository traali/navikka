import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sakkoja/features/weather/domain/entities/algae_data.dart';
import 'package:sakkoja/features/weather/domain/entities/sea_level.dart';
import 'package:sakkoja/features/weather/domain/entities/water_quality_data.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_forecast.dart';

part 'point_weather_data_state.freezed.dart';

@freezed
abstract class PointWeatherDataState with _$PointWeatherDataState {
  const factory PointWeatherDataState({
    required List<WeatherData> observations,
    required List<WeatherForecast> forecast,
    required List<WaveData> waves,
    required List<SeaLevel> seaLevels,
    required List<WaterQualityData> waterQuality,
    required List<AlgaeData> algae,
  }) = _PointWeatherDataState;
}
