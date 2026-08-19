import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'algae_data.freezed.dart';

@freezed
abstract class AlgaeData with _$AlgaeData {
  const factory AlgaeData({
    required DateTime observationTime,
    required LatLng location,
    String? speciesName,
    double? biomass,
    int? cellCount,
    String? dominantSpecies,
    AlgaeRiskLevel? riskLevel,
  }) = _AlgaeData;
}

enum AlgaeRiskLevel {
  low,
  moderate,
  high,
  veryHigh,
}
