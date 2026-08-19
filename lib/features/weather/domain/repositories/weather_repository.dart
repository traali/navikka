import 'package:fpdart/fpdart.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/weather/domain/entities/algae_data.dart';
import 'package:sakkoja/features/weather/domain/entities/lightning_strike.dart';
import 'package:sakkoja/features/weather/domain/entities/sea_level.dart';
import 'package:sakkoja/features/weather/domain/entities/water_quality_data.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_alert.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_forecast.dart';

abstract class WeatherRepository {
  // Legacy / Snapshot methods
  Future<Either<Failure, List<WeatherAlert>>> getActiveAlerts();

  Future<Either<Failure, List<LightningStrike>>> getRecentLightning({
    DateTime? startTime,
    DateTime? endTime,
  });

  Future<Either<Failure, List<WeatherData>>> getWeatherObservations({
    required double lat,
    required double lon,
  });

  Future<Either<Failure, List<WaveData>>> getWaveObservations();

  Future<Either<Failure, List<WeatherForecast>>> getWeatherForecast({
    required double lat,
    required double lon,
  });

  Future<Either<Failure, List<SeaLevel>>> getSeaLevel();

  // Reactive Streams (Offline-First)
  Stream<List<WeatherData>> watchWeatherObservations(double lat, double lon);
  Stream<List<WeatherForecast>> watchWeatherForecast(double lat, double lon);
  Stream<List<WaveData>> watchWaveObservations();
  Stream<List<WaveData>> watchWaveObservationsNearest(double lat, double lon);
  Stream<List<SeaLevel>> watchSeaLevel();
  Stream<List<SeaLevel>> watchSeaLevelNearest(double lat, double lon);
  Stream<List<WeatherAlert>> watchActiveAlerts();
  Stream<List<LightningStrike>> watchRecentLightning();
  Stream<List<LightningStrike>> watchSafetyLightning();

  // Sync Methods (Trigger Refresh)
  Future<void> syncWeatherObservations(double lat, double lon);
  Future<void> syncWeatherForecast(double lat, double lon);
  Future<void> syncWaveObservations({double? lat, double? lon});
  Future<void> syncSeaLevel();
  Future<void> syncActiveAlerts();
  Future<void> syncRecentLightning({DateTime? startTime});

  /// Force clear all cached weather data.
  Future<void> clearCache();

  // SYKE Water Quality & Algae (Finnish Environment Institute)
  Future<Either<Failure, List<WaterQualityData>>> getWaterQuality({
    double? lat,
    double? lon,
  });

  Future<Either<Failure, List<AlgaeData>>> getAlgaeReports({
    double? lat,
    double? lon,
  });

  // Watch Methods (Reactive Streams)
  Stream<List<WaterQualityData>> watchWaterQuality();
  Stream<List<WaterQualityData>> watchWaterQualityNearest(
    double lat,
    double lon,
  );
  Stream<List<AlgaeData>> watchAlgaeReports();
  Stream<List<AlgaeData>> watchAlgaeReportsNearest(double lat, double lon);

  // Sync Methods (Specific to SYKE)
  Future<void> syncWaterQuality(double lat, double lon);
  Future<void> syncAlgaeReports(double lat, double lon);
}
