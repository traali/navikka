import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

/// Helper utility for location grid snapping (~2 km grid).
class LocationGridUtils {
  const LocationGridUtils._();

  /// Calculates a spatial grid key (approx 2km grid cell).
  static String getGridKey(LatLng location) {
    final latGrid = (location.latitude / 0.02).floor();
    final lngGrid = (location.longitude / 0.04).floor();
    return '${latGrid}_$lngGrid';
  }

  /// Calculates distance in meters between two coordinates.
  static double distanceMeters(LatLng p1, LatLng p2) {
    const dist = Distance();
    return dist.as(LengthUnit.Meter, p1, p2);
  }
}

/// Point forecast snapshot for a specific location grid key.
class ForecastSnapshot extends Equatable {
  const ForecastSnapshot({
    required this.gridKey,
    required this.location,
    required this.timestamp,
    required this.windSpeed,
    required this.windGust,
    required this.waveHeight,
    required this.pressure,
  });

  final String gridKey;
  final LatLng location;
  final DateTime timestamp;
  final double? windSpeed;
  final double? windGust;
  final double? waveHeight;
  final double? pressure;

  @override
  List<Object?> get props => [
    gridKey,
    location,
    timestamp,
    windSpeed,
    windGust,
    waveHeight,
    pressure,
  ];
}

/// Severity of a forecast intelligence event.
enum ForecastAlertSeverity {
  green,
  yellow,
  orange,
  red,
}

/// Revision event when a new forecast run for the SAME location changes significantly.
class ForecastRevisionEvent extends Equatable {
  const ForecastRevisionEvent({
    required this.gridKey,
    required this.severity,
    required this.message,
    required this.windDeltaMs,
    required this.waveDeltaMeters,
    required this.detectedAt,
  });

  final String gridKey;
  final ForecastAlertSeverity severity;
  final String message;
  final double windDeltaMs;
  final double waveDeltaMeters;
  final DateTime detectedAt;

  @override
  List<Object?> get props => [
    gridKey,
    severity,
    message,
    windDeltaMs,
    waveDeltaMeters,
    detectedAt,
  ];
}

/// Disagreement event when multi-source providers (FMI vs MET Norway vs OpenWeather) diverge.
class SourceDisagreementEvent extends Equatable {
  const SourceDisagreementEvent({
    required this.gridKey,
    required this.severity,
    required this.message,
    required this.minWindMs,
    required this.maxWindMs,
    required this.minWaveMeters,
    required this.maxWaveMeters,
    required this.fmiWindMs,
    required this.metWindMs,
    required this.openWeatherWindMs,
    this.observedWindMs,
  });

  final String gridKey;
  final ForecastAlertSeverity severity;
  final String message;
  final double minWindMs;
  final double maxWindMs;
  final double minWaveMeters;
  final double maxWaveMeters;
  final double? fmiWindMs;
  final double? metWindMs;
  final double? openWeatherWindMs;
  final double? observedWindMs;

  @override
  List<Object?> get props => [
    gridKey,
    severity,
    message,
    minWindMs,
    maxWindMs,
    minWaveMeters,
    maxWaveMeters,
    fmiWindMs,
    metWindMs,
    openWeatherWindMs,
    observedWindMs,
  ];
}
