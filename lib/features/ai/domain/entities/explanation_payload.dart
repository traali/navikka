import 'package:freezed_annotation/freezed_annotation.dart';

part 'explanation_payload.freezed.dart';
part 'explanation_payload.g.dart';

/// Structured JSON payload sent to the AI explanation model.
///
/// This payload contains all the raw data the AI needs to generate
/// a human-readable, localized safety explanation for the boater.
/// It deliberately does NOT include the heuristic advice — the AI
/// must reason from first principles using the observation + thresholds.
@freezed
abstract class ExplanationPayload with _$ExplanationPayload {
  const factory ExplanationPayload({
    required ExplanationMeta meta,
    required ExplanationObservation observation,
    required ExplanationThresholds thresholds,
    required String status, // 'green' | 'yellow' | 'orange' | 'red'
    List<ExplanationForecast>? forecast,
  }) = _ExplanationPayload;

  factory ExplanationPayload.fromJson(Map<String, dynamic> json) =>
      _$ExplanationPayloadFromJson(json);
}

@freezed
abstract class ExplanationMeta with _$ExplanationMeta {
  const factory ExplanationMeta({
    required String language, // e.g. 'en', 'fi', 'sv'
    required String vesselType,
    required bool hasActiveRoute,
    required String timestamp,
  }) = _ExplanationMeta;

  factory ExplanationMeta.fromJson(Map<String, dynamic> json) =>
      _$ExplanationMetaFromJson(json);
}

@freezed
abstract class ExplanationObservation with _$ExplanationObservation {
  const factory ExplanationObservation({
    double? windSpeed,
    double? windGust,
    double? windDirection,
    double? waveHeight,
    double? wavePeriod,
    double? waveDirection,
    double? pressure,
    double? visibility,
    double? temperature,
    double? precipitation,
    double? cloudCover,
    double? humidity,
  }) = _ExplanationObservation;

  factory ExplanationObservation.fromJson(Map<String, dynamic> json) =>
      _$ExplanationObservationFromJson(json);
}

@freezed
abstract class ExplanationThresholds with _$ExplanationThresholds {
  const factory ExplanationThresholds({
    required double windYellowMs,
    required double windOrangeMs,
    required double windRedMs,
    required double waveYellowM,
    required double waveOrangeM,
    required double waveRedM,
  }) = _ExplanationThresholds;

  factory ExplanationThresholds.fromJson(Map<String, dynamic> json) =>
      _$ExplanationThresholdsFromJson(json);
}

@freezed
abstract class ExplanationForecast with _$ExplanationForecast {
  const factory ExplanationForecast({
    required String timestamp,
    double? windGust,
    double? waveHeight,
    double? precipitation,
    double? pressure,
  }) = _ExplanationForecast;

  factory ExplanationForecast.fromJson(Map<String, dynamic> json) =>
      _$ExplanationForecastFromJson(json);
}
