import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';

part 'weather_discrepancy.freezed.dart';
part 'weather_discrepancy.g.dart';

@freezed
abstract class WeatherDiscrepancy with _$WeatherDiscrepancy {
  const factory WeatherDiscrepancy({
    required SafetyStatus status,
    required String message,
    required double windDeltaMs,
    required double waveDeltaM,
    required double pressureDeltaHpa,
    required DateTime timestamp,
  }) = _WeatherDiscrepancy;

  factory WeatherDiscrepancy.fromJson(Map<String, dynamic> json) =>
      _$WeatherDiscrepancyFromJson(json);
}
