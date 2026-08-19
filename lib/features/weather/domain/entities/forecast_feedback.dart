import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

/// User accuracy feedback entry stored locally in Drift SQLite DB.
class ForecastFeedbackEntry extends Equatable {
  const ForecastFeedbackEntry({
    required this.id,
    required this.createdAt,
    required this.gridKey,
    required this.location,
    required this.preferredSource,
    this.customNote,
    this.observedWindMs,
    this.observedWaveMeters,
  });

  final String id;
  final DateTime createdAt;
  final String gridKey;
  final LatLng location;
  final String preferredSource; // e.g. 'FMI', 'MET Norway', 'OpenWeather'
  final String? customNote;
  final double? observedWindMs;
  final double? observedWaveMeters;

  @override
  List<Object?> get props => [
    id,
    createdAt,
    gridKey,
    location,
    preferredSource,
    customNote,
    observedWindMs,
    observedWaveMeters,
  ];
}
