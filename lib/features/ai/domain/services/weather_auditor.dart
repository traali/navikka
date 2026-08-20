import 'package:sakkoja/features/ai/domain/entities/weather_discrepancy.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_forecast.dart';

class WeatherAuditor {
  const WeatherAuditor();

  /// Compares real-time observation with the forecast for the same time.
  /// Identifies discrepancies that might indicate dangerous weather patterns
  /// (e.g., wind increasing faster than forecasted).
  WeatherDiscrepancy audit({
    required WeatherData? observation,
    required WeatherForecast? forecast,
    required WaveData? wave,
    required SkipperThresholds thresholds,
  }) {
    if (observation == null || forecast == null) {
      return WeatherDiscrepancy(
        status: SafetyStatus.green,
        message: 'Normal: Operating on forecast models only.',
        windDeltaMs: 0,
        waveDeltaM: 0,
        pressureDeltaHpa: 0,
        timestamp: DateTime.now(),
      );
    }

    // 1. Wind Discrepancy
    // We prioritize windGust for safety, falling back to windSpeed.
    final obsWind = observation.windGust ?? observation.windSpeed ?? 0.0;
    final fcastWind = forecast.windGust ?? forecast.windSpeed ?? 0.0;
    final windDelta = obsWind - fcastWind;

    // 2. Wave Height Discrepancy (relative to skipper's yellow threshold)
    final obsWave = wave?.waveHeight ?? 0.0;
    final waveDelta = obsWave > 0 ? obsWave - thresholds.waveYellowM : 0.0;

    // 3. Pressure Discrepancy (Critical for Squalls/Storms)
    final obsPressure = observation.pressure;
    final fcastPressure = forecast.pressure;
    final pressureDelta = (obsPressure != null && fcastPressure != null)
        ? obsPressure - fcastPressure
        : 0.0;

    var status = SafetyStatus.green;
    var message = 'Weather is tracking according to forecast.';

    // Escalation Logic: Wind
    if (windDelta >= 5.0) {
      status = SafetyStatus.red;
      message =
          'CRITICAL DISCREPANCY: Wind is significantly higher than forecasted (+${windDelta.toStringAsFixed(1)} m/s). Seek harbor.';
    } else if (windDelta >= 3.0) {
      status = SafetyStatus.orange;
      message =
          'WARNING: Weather is deteriorating faster than expected (+${windDelta.toStringAsFixed(1)} m/s over forecast).';
    } else if (windDelta >= 2.0) {
      status = SafetyStatus.yellow;
      message = 'CAUTION: Observed wind is higher than forecasted.';
    }

    // Escalation Logic: Pressure Drop vs Forecast
    // A pressure drop of > 2hPa deeper than forecasted is a strong warning sign.
    if (pressureDelta <= -3.0 &&
        observation.pressure != null &&
        forecast.pressure != null) {
      status = SafetyStatus.red;
      message =
          'SQUALL RISK: Barometric pressure is ${pressureDelta.abs().toStringAsFixed(1)} hPa BELOW forecast. High probability of extreme gusts.';
    } else if (pressureDelta <= -1.5 &&
        status.index < SafetyStatus.orange.index) {
      status = SafetyStatus.orange;
      message =
          'ALARM: Pressure is dropping faster than forecasted. Deteriorating weather likely.';
    }

    // 4. Fog & Reduced Visibility Escalation (COLREG Rule 19 & 35)
    final obsVisibility = observation.visibility;
    if (obsVisibility != null) {
      if (obsVisibility <= 500) {
        status = SafetyStatus.red;
        message =
            'SUMUHÄLYTYS: Sankka sumu (näkyvyys vain ${obsVisibility.round()} m). Sytytä kulkuvalot, anna sumumerkit (COLREG sääntö 35) ja alenna nopeutta.';
      } else if (obsVisibility <= 1000 &&
          status.index < SafetyStatus.orange.index) {
        status = SafetyStatus.orange;
        message =
            'SUMUVAROITUS: Näkyvyys heikentynyt alle 1 km (${obsVisibility.round()} m). Tehosta tähystystä ja seuraa tutkaa/AIS:ää.';
      } else if (obsVisibility <= 2500 &&
          status.index < SafetyStatus.yellow.index) {
        status = SafetyStatus.yellow;
        message =
            'HUOMIO: Utua ja rajoittunutta näkyvyyttä merellä (${(obsVisibility / 1000).toStringAsFixed(1)} km).';
      }
    }

    // 5. Rapid Dew Point / Sea Fog Condensation Risk
    final temp = observation.temperature;
    final dew = observation.dewPoint;
    final humidity = observation.humidity ?? 0.0;
    if (temp != null &&
        dew != null &&
        (temp - dew).abs() <= 1.2 &&
        humidity >= 90.0 &&
        status.index < SafetyStatus.orange.index) {
      status = SafetyStatus.orange;
      message =
          'SUMUN TIIVISTYMISRISKI: Lämpötila ja kastepiste ovat lähes samat (${temp.toStringAsFixed(1)}°C / ${dew.toStringAsFixed(1)}°C, kosteus ${humidity.round()}%). Äkillinen merisumu tai matalapilvi todennäköinen.';
    }

    return WeatherDiscrepancy(
      status: status,
      message: message,
      windDeltaMs: windDelta,
      waveDeltaM: waveDelta,
      pressureDeltaHpa: pressureDelta,
      timestamp: DateTime.now(),
    );
  }
}
