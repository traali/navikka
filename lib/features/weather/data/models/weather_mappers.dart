import 'package:sakkoja/features/weather/data/models/algae_report_dto.dart';
import 'package:sakkoja/features/weather/data/models/lightning_strike_dto.dart';
import 'package:sakkoja/features/weather/data/models/sea_level_dto.dart';
import 'package:sakkoja/features/weather/data/models/water_quality_dto.dart';
import 'package:sakkoja/features/weather/data/models/wave_observation_dto.dart';
import 'package:sakkoja/features/weather/data/models/weather_alert_dto.dart';
import 'package:sakkoja/features/weather/data/models/weather_forecast_dto.dart';
import 'package:sakkoja/features/weather/data/models/weather_observation_dto.dart';
import 'package:sakkoja/features/weather/domain/entities/algae_data.dart';
import 'package:sakkoja/features/weather/domain/entities/lightning_strike.dart';
import 'package:sakkoja/features/weather/domain/entities/sea_level.dart';
import 'package:sakkoja/features/weather/domain/entities/water_quality_data.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_alert.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_forecast.dart';

extension AlgaeReportDtoX on AlgaeReportDto {
  AlgaeData toEntity() {
    AlgaeRiskLevel? parsedRiskLevel;
    if (riskLevel != null) {
      for (final l in AlgaeRiskLevel.values) {
        if (l.name == riskLevel!.name) {
          parsedRiskLevel = l;
          break;
        }
      }
    }
    return AlgaeData(
      observationTime: timestamp,
      location: location,
      speciesName: speciesName,
      biomass: biomass,
      cellCount: cellCount,
      dominantSpecies: dominantSpecies,
      riskLevel: parsedRiskLevel,
    );
  }
}

extension WaterQualityDtoX on WaterQualityDto {
  WaterQualityData toEntity() {
    return WaterQualityData(
      sampleDate: timestamp,
      location: location,
      stationName: stationName,
      temperature: null,
      chlorophyllA: chlorophyllA,
      turbidity: turbidity,
      algaeStatus: null,
      dissolvedOxygen: dissolvedOxygen,
      ph: pH,
    );
  }
}

extension LightningStrikeDtoX on LightningStrikeDto {
  LightningStrike toEntity() {
    return LightningStrike(
      time: time,
      location: location,
      peakCurrent: peakCurrent,
      multiplicity: multiplicity,
    );
  }
}

extension SeaLevelDtoX on SeaLevelDto {
  SeaLevel? toEntityOrNull() {
    final mm = seaLevel;
    if (mm == null) return null;
    return SeaLevel(
      timestamp: timestamp,
      seaLevel: mm,
      location: location,
      stationName: stationName,
    );
  }

  SeaLevel toEntity() {
    return toEntityOrNull() ??
        (throw StateError('SeaLevelDto missing seaLevel — do not mint 0 cm'));
  }
}

extension WaveObservationDtoX on WaveObservationDto {
  WaveData toEntity() {
    return WaveData(
      timestamp: timestamp,
      location: location,
      waveHeight: waveHeight,
      wavePeriod: wavePeriod,
      waveDirection: waveDirection,
      waterTemperature: waterTemperature,
      stationName: stationName,
    );
  }
}

extension WeatherAlertDtoX on WeatherAlertDto {
  WeatherAlert toEntity() {
    return WeatherAlert(
      id: id,
      event: event,
      description: description,
      severity: severity,
      onset: onset,
      expires: expires,
      issued: issued,
      polygon: polygon,
      areaDescription: areaDescription,
    );
  }
}

extension WeatherForecastDtoX on WeatherForecastDto {
  WeatherForecast toEntity() {
    return WeatherForecast(
      timestamp: timestamp,
      location: location,
      temperature: temperature,
      windSpeed: windSpeed,
      windGust: windGust,
      windDirection: windDirection,
      pressure: pressure,
      humidity: humidity,
      dewPoint: dewPoint,
      cloudCover: cloudCover,
      uvIndex: uvIndex,
      precipitation: precipitation,
      precipitationProbability: precipitationProbability,
      weatherIcon: weatherIcon,
      weatherDescription: weatherDescription,
      providerId: providerId,
    );
  }
}

extension WeatherObservationDtoX on WeatherObservationDto {
  WeatherData toEntity() {
    return WeatherData(
      timestamp: timestamp,
      location: location,
      temperature: temperature,
      feelsLike: feelsLike,
      windSpeed: windSpeed,
      windGust: windGust,
      windDirection: windDirection,
      pressure: pressure,
      visibility: visibility,
      humidity: humidity,
      dewPoint: dewPoint,
      precipitation: precipitation,
      cloudCover: cloudCover,
      uvIndex: uvIndex,
      snowfall: snowfall,
      weatherCode: weatherCode,
      weatherIcon: weatherIcon,
      weatherDescription: weatherDescription,
      sunrise: sunrise,
      sunset: sunset,
      stationName: stationName,
    );
  }
}
