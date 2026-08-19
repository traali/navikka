import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_forecast.dart';

class HeuristicInsightEngine {
  const HeuristicInsightEngine();

  /// Analyzes current weather and future forecasts against thresholds.
  WeatherInsight analyze({
    required WeatherData? weather,
    required WaveData? wave,
    required List<WeatherForecast> forecasts,
    required int windowHours,
    required SkipperThresholds thresholds,
    DateTime? now,
  }) {
    final effectiveNow = now ?? DateTime.now();

    // 1. Analyze Current State
    final currentStatus = _getCurrentStatus(weather, wave, thresholds);
    final currentAdvice = _getCurrentAdvice(
      currentStatus,
      weather,
      wave,
      thresholds,
    );

    // 2. Scan Forecast Window for Predictive Escalation
    final windowLimit = effectiveNow.add(Duration(hours: windowHours));
    final relevantForecasts = forecasts
        .where(
          (f) =>
              f.timestamp.isAfter(effectiveNow) &&
              f.timestamp.isBefore(windowLimit),
        )
        .toList();

    var maxForecastStatus = currentStatus;
    WeatherForecast? criticalForecast;

    for (final f in relevantForecasts) {
      final fStatus = _getForecastStatus(f, wave?.waveHeight, thresholds);
      if (fStatus.index > maxForecastStatus.index) {
        maxForecastStatus = fStatus;
        criticalForecast = f;
      }
    }

    // 3. Build structured reasons and risk score
    final reasons = _buildReasons(weather, wave, currentStatus, thresholds);
    final riskScore = _computeRiskScore(
      weather,
      wave,
      currentStatus,
      thresholds,
    );

    // 4. Combine: Elevate status if forecast is worse than current
    if (maxForecastStatus.index > currentStatus.index) {
      final arrivalTime =
          criticalForecast?.timestamp.difference(effectiveNow).inHours ?? 0;
      final arrivalText = arrivalTime <= 1 ? 'soon' : 'in ~$arrivalTime hours';
      final advice =
          'PREDICTIVE: ${maxForecastStatus.name.toUpperCase()} conditions expected $arrivalText. Current: $currentAdvice';

      return WeatherInsight(
        status: maxForecastStatus,
        advice: advice,
        timestamp: effectiveNow,
        insightId: _computeInsightId(maxForecastStatus, advice, effectiveNow),
        reasons: reasons,
        riskScore: riskScore,
      );
    }

    return WeatherInsight(
      status: currentStatus,
      advice: currentAdvice,
      timestamp: effectiveNow,
      insightId: _computeInsightId(currentStatus, currentAdvice, effectiveNow),
      reasons: reasons,
      riskScore: riskScore,
    );
  }

  SafetyStatus _getCurrentStatus(
    WeatherData? weather,
    WaveData? wave,
    SkipperThresholds t,
  ) {
    if (_isLimitExceeded(
      weather?.windGust,
      wave?.waveHeight,
      t.windRedMs,
      t.waveRedM,
    )) {
      return SafetyStatus.red;
    }
    if (_isLimitExceeded(
      weather?.windGust,
      wave?.waveHeight,
      t.windOrangeMs,
      t.waveOrangeM,
    )) {
      return SafetyStatus.orange;
    }
    if (_isLimitExceeded(
      weather?.windGust,
      wave?.waveHeight,
      t.windYellowMs,
      t.waveYellowM,
    )) {
      return SafetyStatus.yellow;
    }
    return SafetyStatus.green;
  }

  SafetyStatus _getForecastStatus(
    WeatherForecast f,
    double? currentWaveHeight,
    SkipperThresholds t,
  ) {
    // SECURITY PATCH: Use current wave height as a persistent floor for future risks.
    // If waves are currently 3m, we presume they won't instantly vanish even if wind drops.
    return _getCurrentStatus(
      WeatherData(
        timestamp: f.timestamp,
        location:
            f.location ??
            const LatLng(0, 0), // Use forecast location if available
        windGust: f.windGust,
        windSpeed: f.windSpeed,
        temperature: f.temperature,
        pressure: f.pressure,
        stationName: 'Forecast Proxy',
      ),
      currentWaveHeight != null
          ? WaveData(
              timestamp: f.timestamp,
              location: f.location ?? const LatLng(0, 0),
              stationName: 'Forecast Proxy',
              waveHeight: currentWaveHeight,
              wavePeriod: 0,
              waveDirection: 0,
              waterTemperature: null,
            )
          : null,
      t,
    );
  }

  String _computeInsightId(
    SafetyStatus status,
    String advice,
    DateTime timestamp,
  ) {
    final minute = DateTime(
      timestamp.year,
      timestamp.month,
      timestamp.day,
      timestamp.hour,
      timestamp.minute,
    );
    return '${status.name}_${advice.hashCode}_${minute.millisecondsSinceEpoch}';
  }

  bool _isLimitExceeded(
    double? wind,
    double? wave,
    double windLimit,
    double waveLimit,
  ) {
    if (wind != null && wind >= windLimit) return true;
    if (wave != null && wave >= waveLimit) return true;
    return false;
  }

  String _getCurrentAdvice(
    SafetyStatus status,
    WeatherData? weather,
    WaveData? wave,
    SkipperThresholds t,
  ) {
    switch (status) {
      case SafetyStatus.red:
        return _getRedAdvice(weather?.windGust, wave?.waveHeight, t);
      case SafetyStatus.orange:
        return _getOrangeAdvice(weather?.windGust, wave?.waveHeight, t);
      case SafetyStatus.yellow:
        return _getYellowAdvice(weather?.windGust, wave?.waveHeight, t);
      case SafetyStatus.green:
        return 'Conditions are within safe limits for boating.';
    }
  }

  String _getRedAdvice(double? wind, double? wave, SkipperThresholds t) {
    if (wave != null && wave >= t.waveRedM) {
      return 'DANGER: Extreme waves (${wave.toStringAsFixed(1)}m). Avoid open sea areas immediately.';
    }
    if (wind != null && wind >= t.windRedMs) {
      return 'DANGER: Storm force gusts (${wind.toStringAsFixed(1)}m/s). Seek harbor immediately.';
    }
    return 'DANGER: Conditions are extremely hazardous.';
  }

  String _getOrangeAdvice(double? wind, double? wave, SkipperThresholds t) {
    if (wave != null && wave >= t.waveOrangeM) {
      return 'WARNING: High waves (${wave.toStringAsFixed(1)}m). Not suitable for small crafts.';
    }
    if (wind != null && wind >= t.windOrangeMs) {
      return 'WARNING: Strong wind gusts (${wind.toStringAsFixed(1)}m/s). Use extreme caution.';
    }
    return 'WARNING: Conditions are deteriorating.';
  }

  String _getYellowAdvice(double? wind, double? wave, SkipperThresholds t) {
    if (wave != null && wave >= t.waveYellowM) {
      return 'CAUTION: Moderate waves (${wave.toStringAsFixed(1)}m). Keep an eye on conditions.';
    }
    if (wind != null && wind >= t.windYellowMs) {
      return 'CAUTION: Increasing wind (${wind.toStringAsFixed(1)}m/s). Ideal for experienced sailors only.';
    }
    return 'CAUTION: Variable conditions expected.';
  }

  List<String> _buildReasons(
    WeatherData? weather,
    WaveData? wave,
    SafetyStatus status,
    SkipperThresholds t,
  ) {
    if (status == SafetyStatus.green) return [];

    final reasons = <String>[];
    final wind = weather?.windGust;
    final waveHeight = wave?.waveHeight;

    if (wind != null) {
      if (wind >= t.windRedMs) {
        reasons.add(
          'Wind gust ${wind.toStringAsFixed(1)} m/s exceeds red threshold (${t.windRedMs} m/s)',
        );
      } else if (wind >= t.windOrangeMs) {
        reasons.add(
          'Wind gust ${wind.toStringAsFixed(1)} m/s exceeds orange threshold (${t.windOrangeMs} m/s)',
        );
      } else if (wind >= t.windYellowMs) {
        reasons.add(
          'Wind gust ${wind.toStringAsFixed(1)} m/s exceeds yellow threshold (${t.windYellowMs} m/s)',
        );
      }
    }

    if (waveHeight != null) {
      if (waveHeight >= t.waveRedM) {
        reasons.add(
          'Wave height ${waveHeight.toStringAsFixed(1)} m exceeds red threshold (${t.waveRedM} m)',
        );
      } else if (waveHeight >= t.waveOrangeM) {
        reasons.add(
          'Wave height ${waveHeight.toStringAsFixed(1)} m exceeds orange threshold (${t.waveOrangeM} m)',
        );
      } else if (waveHeight >= t.waveYellowM) {
        reasons.add(
          'Wave height ${waveHeight.toStringAsFixed(1)} m exceeds yellow threshold (${t.waveYellowM} m)',
        );
      }
    }

    return reasons;
  }

  /// Computes a 0-100 risk score based on how severely thresholds are exceeded.
  int _computeRiskScore(
    WeatherData? weather,
    WaveData? wave,
    SafetyStatus status,
    SkipperThresholds t,
  ) {
    if (status == SafetyStatus.green) return 0;

    var score = 0;
    final wind = weather?.windGust;
    final waveHeight = wave?.waveHeight;

    // Base score from status level: yellow=30, orange=60, red=85
    score = switch (status) {
      SafetyStatus.green => 0,
      SafetyStatus.yellow => 30,
      SafetyStatus.orange => 60,
      SafetyStatus.red => 85,
    };

    // Add up to 15 points based on how much wind exceeds threshold
    if (wind != null) {
      final windLimit = switch (status) {
        SafetyStatus.yellow => t.windYellowMs,
        SafetyStatus.orange => t.windOrangeMs,
        SafetyStatus.red => t.windRedMs,
        _ => t.windYellowMs,
      };
      if (wind > windLimit) {
        final excess = wind - windLimit;
        score += (excess * 5).clamp(0, 15).round();
      }
    }

    // Add up to 15 points based on how much wave exceeds threshold
    if (waveHeight != null) {
      final waveLimit = switch (status) {
        SafetyStatus.yellow => t.waveYellowM,
        SafetyStatus.orange => t.waveOrangeM,
        SafetyStatus.red => t.waveRedM,
        _ => t.waveYellowM,
      };
      if (waveHeight > waveLimit) {
        final excess = waveHeight - waveLimit;
        score += (excess * 10).clamp(0, 15).round();
      }
    }

    return score.clamp(0, 100);
  }
}
