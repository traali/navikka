// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explanation_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExplanationPayload _$ExplanationPayloadFromJson(Map<String, dynamic> json) =>
    _ExplanationPayload(
      meta: ExplanationMeta.fromJson(json['meta'] as Map<String, dynamic>),
      observation: ExplanationObservation.fromJson(
        json['observation'] as Map<String, dynamic>,
      ),
      thresholds: ExplanationThresholds.fromJson(
        json['thresholds'] as Map<String, dynamic>,
      ),
      status: json['status'] as String,
      forecast: (json['forecast'] as List<dynamic>?)
          ?.map((e) => ExplanationForecast.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExplanationPayloadToJson(_ExplanationPayload instance) =>
    <String, dynamic>{
      'meta': instance.meta,
      'observation': instance.observation,
      'thresholds': instance.thresholds,
      'status': instance.status,
      'forecast': instance.forecast,
    };

_ExplanationMeta _$ExplanationMetaFromJson(Map<String, dynamic> json) =>
    _ExplanationMeta(
      language: json['language'] as String,
      vesselType: json['vesselType'] as String,
      hasActiveRoute: json['hasActiveRoute'] as bool,
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$ExplanationMetaToJson(_ExplanationMeta instance) =>
    <String, dynamic>{
      'language': instance.language,
      'vesselType': instance.vesselType,
      'hasActiveRoute': instance.hasActiveRoute,
      'timestamp': instance.timestamp,
    };

_ExplanationObservation _$ExplanationObservationFromJson(
  Map<String, dynamic> json,
) => _ExplanationObservation(
  windSpeed: (json['windSpeed'] as num?)?.toDouble(),
  windGust: (json['windGust'] as num?)?.toDouble(),
  windDirection: (json['windDirection'] as num?)?.toDouble(),
  waveHeight: (json['waveHeight'] as num?)?.toDouble(),
  wavePeriod: (json['wavePeriod'] as num?)?.toDouble(),
  waveDirection: (json['waveDirection'] as num?)?.toDouble(),
  pressure: (json['pressure'] as num?)?.toDouble(),
  visibility: (json['visibility'] as num?)?.toDouble(),
  temperature: (json['temperature'] as num?)?.toDouble(),
  precipitation: (json['precipitation'] as num?)?.toDouble(),
  cloudCover: (json['cloudCover'] as num?)?.toDouble(),
  humidity: (json['humidity'] as num?)?.toDouble(),
);

Map<String, dynamic> _$ExplanationObservationToJson(
  _ExplanationObservation instance,
) => <String, dynamic>{
  'windSpeed': instance.windSpeed,
  'windGust': instance.windGust,
  'windDirection': instance.windDirection,
  'waveHeight': instance.waveHeight,
  'wavePeriod': instance.wavePeriod,
  'waveDirection': instance.waveDirection,
  'pressure': instance.pressure,
  'visibility': instance.visibility,
  'temperature': instance.temperature,
  'precipitation': instance.precipitation,
  'cloudCover': instance.cloudCover,
  'humidity': instance.humidity,
};

_ExplanationThresholds _$ExplanationThresholdsFromJson(
  Map<String, dynamic> json,
) => _ExplanationThresholds(
  windYellowMs: (json['windYellowMs'] as num).toDouble(),
  windOrangeMs: (json['windOrangeMs'] as num).toDouble(),
  windRedMs: (json['windRedMs'] as num).toDouble(),
  waveYellowM: (json['waveYellowM'] as num).toDouble(),
  waveOrangeM: (json['waveOrangeM'] as num).toDouble(),
  waveRedM: (json['waveRedM'] as num).toDouble(),
);

Map<String, dynamic> _$ExplanationThresholdsToJson(
  _ExplanationThresholds instance,
) => <String, dynamic>{
  'windYellowMs': instance.windYellowMs,
  'windOrangeMs': instance.windOrangeMs,
  'windRedMs': instance.windRedMs,
  'waveYellowM': instance.waveYellowM,
  'waveOrangeM': instance.waveOrangeM,
  'waveRedM': instance.waveRedM,
};

_ExplanationForecast _$ExplanationForecastFromJson(Map<String, dynamic> json) =>
    _ExplanationForecast(
      timestamp: json['timestamp'] as String,
      windGust: (json['windGust'] as num?)?.toDouble(),
      waveHeight: (json['waveHeight'] as num?)?.toDouble(),
      precipitation: (json['precipitation'] as num?)?.toDouble(),
      pressure: (json['pressure'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ExplanationForecastToJson(
  _ExplanationForecast instance,
) => <String, dynamic>{
  'timestamp': instance.timestamp,
  'windGust': instance.windGust,
  'waveHeight': instance.waveHeight,
  'precipitation': instance.precipitation,
  'pressure': instance.pressure,
};
