import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'water_quality_data.freezed.dart';

/// Domain entity for water quality observations.
/// Data source: SYKE OData API (future integration).
@freezed
abstract class WaterQualityData with _$WaterQualityData {
  const factory WaterQualityData({
    required DateTime sampleDate,
    required LatLng location,
    required String? stationName,

    /// Water temperature in Celsius
    required double? temperature,

    /// Chlorophyll-a concentration (µg/L) - indicator of algae presence
    required double? chlorophyllA,

    /// Water turbidity in NTU
    required double? turbidity,

    /// Algae bloom status (e.g., "None", "Low", "Moderate", "High")
    required String? algaeStatus,

    /// Dissolved oxygen in mg/L
    required double? dissolvedOxygen,

    /// pH level
    required double? ph,
  }) = _WaterQualityData;
}
