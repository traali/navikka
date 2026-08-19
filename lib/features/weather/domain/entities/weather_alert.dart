import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'weather_alert.freezed.dart';

@freezed
abstract class WeatherAlert with _$WeatherAlert {
  const factory WeatherAlert({
    required String id,
    required String event,
    required String description,
    required String severity, // e.g., "Moderate", "Severe", "Extreme"
    required DateTime onset,
    required DateTime expires,
    required List<LatLng> polygon, // Geometric area of the warning
    required String areaDescription,
    DateTime? issued,
  }) = _WeatherAlert;
}
