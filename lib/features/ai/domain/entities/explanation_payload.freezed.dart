// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explanation_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExplanationPayload {

 ExplanationMeta get meta; ExplanationObservation get observation; ExplanationThresholds get thresholds; String get status; List<ExplanationForecast>? get forecast;
/// Create a copy of ExplanationPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExplanationPayloadCopyWith<ExplanationPayload> get copyWith => _$ExplanationPayloadCopyWithImpl<ExplanationPayload>(this as ExplanationPayload, _$identity);

  /// Serializes this ExplanationPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExplanationPayload&&(identical(other.meta, meta) || other.meta == meta)&&(identical(other.observation, observation) || other.observation == observation)&&(identical(other.thresholds, thresholds) || other.thresholds == thresholds)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.forecast, forecast));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meta,observation,thresholds,status,const DeepCollectionEquality().hash(forecast));

@override
String toString() {
  return 'ExplanationPayload(meta: $meta, observation: $observation, thresholds: $thresholds, status: $status, forecast: $forecast)';
}


}

/// @nodoc
abstract mixin class $ExplanationPayloadCopyWith<$Res>  {
  factory $ExplanationPayloadCopyWith(ExplanationPayload value, $Res Function(ExplanationPayload) _then) = _$ExplanationPayloadCopyWithImpl;
@useResult
$Res call({
 ExplanationMeta meta, ExplanationObservation observation, ExplanationThresholds thresholds, String status, List<ExplanationForecast>? forecast
});


$ExplanationMetaCopyWith<$Res> get meta;$ExplanationObservationCopyWith<$Res> get observation;$ExplanationThresholdsCopyWith<$Res> get thresholds;

}
/// @nodoc
class _$ExplanationPayloadCopyWithImpl<$Res>
    implements $ExplanationPayloadCopyWith<$Res> {
  _$ExplanationPayloadCopyWithImpl(this._self, this._then);

  final ExplanationPayload _self;
  final $Res Function(ExplanationPayload) _then;

/// Create a copy of ExplanationPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meta = null,Object? observation = null,Object? thresholds = null,Object? status = null,Object? forecast = freezed,}) {
  return _then(_self.copyWith(
meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as ExplanationMeta,observation: null == observation ? _self.observation : observation // ignore: cast_nullable_to_non_nullable
as ExplanationObservation,thresholds: null == thresholds ? _self.thresholds : thresholds // ignore: cast_nullable_to_non_nullable
as ExplanationThresholds,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,forecast: freezed == forecast ? _self.forecast : forecast // ignore: cast_nullable_to_non_nullable
as List<ExplanationForecast>?,
  ));
}
/// Create a copy of ExplanationPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExplanationMetaCopyWith<$Res> get meta {
  
  return $ExplanationMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}/// Create a copy of ExplanationPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExplanationObservationCopyWith<$Res> get observation {
  
  return $ExplanationObservationCopyWith<$Res>(_self.observation, (value) {
    return _then(_self.copyWith(observation: value));
  });
}/// Create a copy of ExplanationPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExplanationThresholdsCopyWith<$Res> get thresholds {
  
  return $ExplanationThresholdsCopyWith<$Res>(_self.thresholds, (value) {
    return _then(_self.copyWith(thresholds: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExplanationPayload].
extension ExplanationPayloadPatterns on ExplanationPayload {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExplanationPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExplanationPayload() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExplanationPayload value)  $default,){
final _that = this;
switch (_that) {
case _ExplanationPayload():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExplanationPayload value)?  $default,){
final _that = this;
switch (_that) {
case _ExplanationPayload() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ExplanationMeta meta,  ExplanationObservation observation,  ExplanationThresholds thresholds,  String status,  List<ExplanationForecast>? forecast)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExplanationPayload() when $default != null:
return $default(_that.meta,_that.observation,_that.thresholds,_that.status,_that.forecast);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ExplanationMeta meta,  ExplanationObservation observation,  ExplanationThresholds thresholds,  String status,  List<ExplanationForecast>? forecast)  $default,) {final _that = this;
switch (_that) {
case _ExplanationPayload():
return $default(_that.meta,_that.observation,_that.thresholds,_that.status,_that.forecast);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ExplanationMeta meta,  ExplanationObservation observation,  ExplanationThresholds thresholds,  String status,  List<ExplanationForecast>? forecast)?  $default,) {final _that = this;
switch (_that) {
case _ExplanationPayload() when $default != null:
return $default(_that.meta,_that.observation,_that.thresholds,_that.status,_that.forecast);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExplanationPayload implements ExplanationPayload {
  const _ExplanationPayload({required this.meta, required this.observation, required this.thresholds, required this.status, final  List<ExplanationForecast>? forecast}): _forecast = forecast;
  factory _ExplanationPayload.fromJson(Map<String, dynamic> json) => _$ExplanationPayloadFromJson(json);

@override final  ExplanationMeta meta;
@override final  ExplanationObservation observation;
@override final  ExplanationThresholds thresholds;
@override final  String status;
 final  List<ExplanationForecast>? _forecast;
@override List<ExplanationForecast>? get forecast {
  final value = _forecast;
  if (value == null) return null;
  if (_forecast is EqualUnmodifiableListView) return _forecast;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ExplanationPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExplanationPayloadCopyWith<_ExplanationPayload> get copyWith => __$ExplanationPayloadCopyWithImpl<_ExplanationPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExplanationPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExplanationPayload&&(identical(other.meta, meta) || other.meta == meta)&&(identical(other.observation, observation) || other.observation == observation)&&(identical(other.thresholds, thresholds) || other.thresholds == thresholds)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._forecast, _forecast));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meta,observation,thresholds,status,const DeepCollectionEquality().hash(_forecast));

@override
String toString() {
  return 'ExplanationPayload(meta: $meta, observation: $observation, thresholds: $thresholds, status: $status, forecast: $forecast)';
}


}

/// @nodoc
abstract mixin class _$ExplanationPayloadCopyWith<$Res> implements $ExplanationPayloadCopyWith<$Res> {
  factory _$ExplanationPayloadCopyWith(_ExplanationPayload value, $Res Function(_ExplanationPayload) _then) = __$ExplanationPayloadCopyWithImpl;
@override @useResult
$Res call({
 ExplanationMeta meta, ExplanationObservation observation, ExplanationThresholds thresholds, String status, List<ExplanationForecast>? forecast
});


@override $ExplanationMetaCopyWith<$Res> get meta;@override $ExplanationObservationCopyWith<$Res> get observation;@override $ExplanationThresholdsCopyWith<$Res> get thresholds;

}
/// @nodoc
class __$ExplanationPayloadCopyWithImpl<$Res>
    implements _$ExplanationPayloadCopyWith<$Res> {
  __$ExplanationPayloadCopyWithImpl(this._self, this._then);

  final _ExplanationPayload _self;
  final $Res Function(_ExplanationPayload) _then;

/// Create a copy of ExplanationPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meta = null,Object? observation = null,Object? thresholds = null,Object? status = null,Object? forecast = freezed,}) {
  return _then(_ExplanationPayload(
meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as ExplanationMeta,observation: null == observation ? _self.observation : observation // ignore: cast_nullable_to_non_nullable
as ExplanationObservation,thresholds: null == thresholds ? _self.thresholds : thresholds // ignore: cast_nullable_to_non_nullable
as ExplanationThresholds,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,forecast: freezed == forecast ? _self._forecast : forecast // ignore: cast_nullable_to_non_nullable
as List<ExplanationForecast>?,
  ));
}

/// Create a copy of ExplanationPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExplanationMetaCopyWith<$Res> get meta {
  
  return $ExplanationMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}/// Create a copy of ExplanationPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExplanationObservationCopyWith<$Res> get observation {
  
  return $ExplanationObservationCopyWith<$Res>(_self.observation, (value) {
    return _then(_self.copyWith(observation: value));
  });
}/// Create a copy of ExplanationPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExplanationThresholdsCopyWith<$Res> get thresholds {
  
  return $ExplanationThresholdsCopyWith<$Res>(_self.thresholds, (value) {
    return _then(_self.copyWith(thresholds: value));
  });
}
}


/// @nodoc
mixin _$ExplanationMeta {

 String get language; String get vesselType; bool get hasActiveRoute; String get timestamp;
/// Create a copy of ExplanationMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExplanationMetaCopyWith<ExplanationMeta> get copyWith => _$ExplanationMetaCopyWithImpl<ExplanationMeta>(this as ExplanationMeta, _$identity);

  /// Serializes this ExplanationMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExplanationMeta&&(identical(other.language, language) || other.language == language)&&(identical(other.vesselType, vesselType) || other.vesselType == vesselType)&&(identical(other.hasActiveRoute, hasActiveRoute) || other.hasActiveRoute == hasActiveRoute)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,language,vesselType,hasActiveRoute,timestamp);

@override
String toString() {
  return 'ExplanationMeta(language: $language, vesselType: $vesselType, hasActiveRoute: $hasActiveRoute, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $ExplanationMetaCopyWith<$Res>  {
  factory $ExplanationMetaCopyWith(ExplanationMeta value, $Res Function(ExplanationMeta) _then) = _$ExplanationMetaCopyWithImpl;
@useResult
$Res call({
 String language, String vesselType, bool hasActiveRoute, String timestamp
});




}
/// @nodoc
class _$ExplanationMetaCopyWithImpl<$Res>
    implements $ExplanationMetaCopyWith<$Res> {
  _$ExplanationMetaCopyWithImpl(this._self, this._then);

  final ExplanationMeta _self;
  final $Res Function(ExplanationMeta) _then;

/// Create a copy of ExplanationMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? language = null,Object? vesselType = null,Object? hasActiveRoute = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,vesselType: null == vesselType ? _self.vesselType : vesselType // ignore: cast_nullable_to_non_nullable
as String,hasActiveRoute: null == hasActiveRoute ? _self.hasActiveRoute : hasActiveRoute // ignore: cast_nullable_to_non_nullable
as bool,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ExplanationMeta].
extension ExplanationMetaPatterns on ExplanationMeta {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExplanationMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExplanationMeta() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExplanationMeta value)  $default,){
final _that = this;
switch (_that) {
case _ExplanationMeta():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExplanationMeta value)?  $default,){
final _that = this;
switch (_that) {
case _ExplanationMeta() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String language,  String vesselType,  bool hasActiveRoute,  String timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExplanationMeta() when $default != null:
return $default(_that.language,_that.vesselType,_that.hasActiveRoute,_that.timestamp);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String language,  String vesselType,  bool hasActiveRoute,  String timestamp)  $default,) {final _that = this;
switch (_that) {
case _ExplanationMeta():
return $default(_that.language,_that.vesselType,_that.hasActiveRoute,_that.timestamp);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String language,  String vesselType,  bool hasActiveRoute,  String timestamp)?  $default,) {final _that = this;
switch (_that) {
case _ExplanationMeta() when $default != null:
return $default(_that.language,_that.vesselType,_that.hasActiveRoute,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExplanationMeta implements ExplanationMeta {
  const _ExplanationMeta({required this.language, required this.vesselType, required this.hasActiveRoute, required this.timestamp});
  factory _ExplanationMeta.fromJson(Map<String, dynamic> json) => _$ExplanationMetaFromJson(json);

@override final  String language;
@override final  String vesselType;
@override final  bool hasActiveRoute;
@override final  String timestamp;

/// Create a copy of ExplanationMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExplanationMetaCopyWith<_ExplanationMeta> get copyWith => __$ExplanationMetaCopyWithImpl<_ExplanationMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExplanationMetaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExplanationMeta&&(identical(other.language, language) || other.language == language)&&(identical(other.vesselType, vesselType) || other.vesselType == vesselType)&&(identical(other.hasActiveRoute, hasActiveRoute) || other.hasActiveRoute == hasActiveRoute)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,language,vesselType,hasActiveRoute,timestamp);

@override
String toString() {
  return 'ExplanationMeta(language: $language, vesselType: $vesselType, hasActiveRoute: $hasActiveRoute, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$ExplanationMetaCopyWith<$Res> implements $ExplanationMetaCopyWith<$Res> {
  factory _$ExplanationMetaCopyWith(_ExplanationMeta value, $Res Function(_ExplanationMeta) _then) = __$ExplanationMetaCopyWithImpl;
@override @useResult
$Res call({
 String language, String vesselType, bool hasActiveRoute, String timestamp
});




}
/// @nodoc
class __$ExplanationMetaCopyWithImpl<$Res>
    implements _$ExplanationMetaCopyWith<$Res> {
  __$ExplanationMetaCopyWithImpl(this._self, this._then);

  final _ExplanationMeta _self;
  final $Res Function(_ExplanationMeta) _then;

/// Create a copy of ExplanationMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? language = null,Object? vesselType = null,Object? hasActiveRoute = null,Object? timestamp = null,}) {
  return _then(_ExplanationMeta(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,vesselType: null == vesselType ? _self.vesselType : vesselType // ignore: cast_nullable_to_non_nullable
as String,hasActiveRoute: null == hasActiveRoute ? _self.hasActiveRoute : hasActiveRoute // ignore: cast_nullable_to_non_nullable
as bool,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ExplanationObservation {

 double? get windSpeed; double? get windGust; double? get windDirection; double? get waveHeight; double? get wavePeriod; double? get waveDirection; double? get pressure; double? get visibility; double? get temperature; double? get precipitation; double? get cloudCover; double? get humidity;
/// Create a copy of ExplanationObservation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExplanationObservationCopyWith<ExplanationObservation> get copyWith => _$ExplanationObservationCopyWithImpl<ExplanationObservation>(this as ExplanationObservation, _$identity);

  /// Serializes this ExplanationObservation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExplanationObservation&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed)&&(identical(other.windGust, windGust) || other.windGust == windGust)&&(identical(other.windDirection, windDirection) || other.windDirection == windDirection)&&(identical(other.waveHeight, waveHeight) || other.waveHeight == waveHeight)&&(identical(other.wavePeriod, wavePeriod) || other.wavePeriod == wavePeriod)&&(identical(other.waveDirection, waveDirection) || other.waveDirection == waveDirection)&&(identical(other.pressure, pressure) || other.pressure == pressure)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.precipitation, precipitation) || other.precipitation == precipitation)&&(identical(other.cloudCover, cloudCover) || other.cloudCover == cloudCover)&&(identical(other.humidity, humidity) || other.humidity == humidity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,windSpeed,windGust,windDirection,waveHeight,wavePeriod,waveDirection,pressure,visibility,temperature,precipitation,cloudCover,humidity);

@override
String toString() {
  return 'ExplanationObservation(windSpeed: $windSpeed, windGust: $windGust, windDirection: $windDirection, waveHeight: $waveHeight, wavePeriod: $wavePeriod, waveDirection: $waveDirection, pressure: $pressure, visibility: $visibility, temperature: $temperature, precipitation: $precipitation, cloudCover: $cloudCover, humidity: $humidity)';
}


}

/// @nodoc
abstract mixin class $ExplanationObservationCopyWith<$Res>  {
  factory $ExplanationObservationCopyWith(ExplanationObservation value, $Res Function(ExplanationObservation) _then) = _$ExplanationObservationCopyWithImpl;
@useResult
$Res call({
 double? windSpeed, double? windGust, double? windDirection, double? waveHeight, double? wavePeriod, double? waveDirection, double? pressure, double? visibility, double? temperature, double? precipitation, double? cloudCover, double? humidity
});




}
/// @nodoc
class _$ExplanationObservationCopyWithImpl<$Res>
    implements $ExplanationObservationCopyWith<$Res> {
  _$ExplanationObservationCopyWithImpl(this._self, this._then);

  final ExplanationObservation _self;
  final $Res Function(ExplanationObservation) _then;

/// Create a copy of ExplanationObservation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? windSpeed = freezed,Object? windGust = freezed,Object? windDirection = freezed,Object? waveHeight = freezed,Object? wavePeriod = freezed,Object? waveDirection = freezed,Object? pressure = freezed,Object? visibility = freezed,Object? temperature = freezed,Object? precipitation = freezed,Object? cloudCover = freezed,Object? humidity = freezed,}) {
  return _then(_self.copyWith(
windSpeed: freezed == windSpeed ? _self.windSpeed : windSpeed // ignore: cast_nullable_to_non_nullable
as double?,windGust: freezed == windGust ? _self.windGust : windGust // ignore: cast_nullable_to_non_nullable
as double?,windDirection: freezed == windDirection ? _self.windDirection : windDirection // ignore: cast_nullable_to_non_nullable
as double?,waveHeight: freezed == waveHeight ? _self.waveHeight : waveHeight // ignore: cast_nullable_to_non_nullable
as double?,wavePeriod: freezed == wavePeriod ? _self.wavePeriod : wavePeriod // ignore: cast_nullable_to_non_nullable
as double?,waveDirection: freezed == waveDirection ? _self.waveDirection : waveDirection // ignore: cast_nullable_to_non_nullable
as double?,pressure: freezed == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as double?,visibility: freezed == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as double?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,precipitation: freezed == precipitation ? _self.precipitation : precipitation // ignore: cast_nullable_to_non_nullable
as double?,cloudCover: freezed == cloudCover ? _self.cloudCover : cloudCover // ignore: cast_nullable_to_non_nullable
as double?,humidity: freezed == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExplanationObservation].
extension ExplanationObservationPatterns on ExplanationObservation {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExplanationObservation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExplanationObservation() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExplanationObservation value)  $default,){
final _that = this;
switch (_that) {
case _ExplanationObservation():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExplanationObservation value)?  $default,){
final _that = this;
switch (_that) {
case _ExplanationObservation() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? windSpeed,  double? windGust,  double? windDirection,  double? waveHeight,  double? wavePeriod,  double? waveDirection,  double? pressure,  double? visibility,  double? temperature,  double? precipitation,  double? cloudCover,  double? humidity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExplanationObservation() when $default != null:
return $default(_that.windSpeed,_that.windGust,_that.windDirection,_that.waveHeight,_that.wavePeriod,_that.waveDirection,_that.pressure,_that.visibility,_that.temperature,_that.precipitation,_that.cloudCover,_that.humidity);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? windSpeed,  double? windGust,  double? windDirection,  double? waveHeight,  double? wavePeriod,  double? waveDirection,  double? pressure,  double? visibility,  double? temperature,  double? precipitation,  double? cloudCover,  double? humidity)  $default,) {final _that = this;
switch (_that) {
case _ExplanationObservation():
return $default(_that.windSpeed,_that.windGust,_that.windDirection,_that.waveHeight,_that.wavePeriod,_that.waveDirection,_that.pressure,_that.visibility,_that.temperature,_that.precipitation,_that.cloudCover,_that.humidity);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? windSpeed,  double? windGust,  double? windDirection,  double? waveHeight,  double? wavePeriod,  double? waveDirection,  double? pressure,  double? visibility,  double? temperature,  double? precipitation,  double? cloudCover,  double? humidity)?  $default,) {final _that = this;
switch (_that) {
case _ExplanationObservation() when $default != null:
return $default(_that.windSpeed,_that.windGust,_that.windDirection,_that.waveHeight,_that.wavePeriod,_that.waveDirection,_that.pressure,_that.visibility,_that.temperature,_that.precipitation,_that.cloudCover,_that.humidity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExplanationObservation implements ExplanationObservation {
  const _ExplanationObservation({this.windSpeed, this.windGust, this.windDirection, this.waveHeight, this.wavePeriod, this.waveDirection, this.pressure, this.visibility, this.temperature, this.precipitation, this.cloudCover, this.humidity});
  factory _ExplanationObservation.fromJson(Map<String, dynamic> json) => _$ExplanationObservationFromJson(json);

@override final  double? windSpeed;
@override final  double? windGust;
@override final  double? windDirection;
@override final  double? waveHeight;
@override final  double? wavePeriod;
@override final  double? waveDirection;
@override final  double? pressure;
@override final  double? visibility;
@override final  double? temperature;
@override final  double? precipitation;
@override final  double? cloudCover;
@override final  double? humidity;

/// Create a copy of ExplanationObservation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExplanationObservationCopyWith<_ExplanationObservation> get copyWith => __$ExplanationObservationCopyWithImpl<_ExplanationObservation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExplanationObservationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExplanationObservation&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed)&&(identical(other.windGust, windGust) || other.windGust == windGust)&&(identical(other.windDirection, windDirection) || other.windDirection == windDirection)&&(identical(other.waveHeight, waveHeight) || other.waveHeight == waveHeight)&&(identical(other.wavePeriod, wavePeriod) || other.wavePeriod == wavePeriod)&&(identical(other.waveDirection, waveDirection) || other.waveDirection == waveDirection)&&(identical(other.pressure, pressure) || other.pressure == pressure)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.precipitation, precipitation) || other.precipitation == precipitation)&&(identical(other.cloudCover, cloudCover) || other.cloudCover == cloudCover)&&(identical(other.humidity, humidity) || other.humidity == humidity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,windSpeed,windGust,windDirection,waveHeight,wavePeriod,waveDirection,pressure,visibility,temperature,precipitation,cloudCover,humidity);

@override
String toString() {
  return 'ExplanationObservation(windSpeed: $windSpeed, windGust: $windGust, windDirection: $windDirection, waveHeight: $waveHeight, wavePeriod: $wavePeriod, waveDirection: $waveDirection, pressure: $pressure, visibility: $visibility, temperature: $temperature, precipitation: $precipitation, cloudCover: $cloudCover, humidity: $humidity)';
}


}

/// @nodoc
abstract mixin class _$ExplanationObservationCopyWith<$Res> implements $ExplanationObservationCopyWith<$Res> {
  factory _$ExplanationObservationCopyWith(_ExplanationObservation value, $Res Function(_ExplanationObservation) _then) = __$ExplanationObservationCopyWithImpl;
@override @useResult
$Res call({
 double? windSpeed, double? windGust, double? windDirection, double? waveHeight, double? wavePeriod, double? waveDirection, double? pressure, double? visibility, double? temperature, double? precipitation, double? cloudCover, double? humidity
});




}
/// @nodoc
class __$ExplanationObservationCopyWithImpl<$Res>
    implements _$ExplanationObservationCopyWith<$Res> {
  __$ExplanationObservationCopyWithImpl(this._self, this._then);

  final _ExplanationObservation _self;
  final $Res Function(_ExplanationObservation) _then;

/// Create a copy of ExplanationObservation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? windSpeed = freezed,Object? windGust = freezed,Object? windDirection = freezed,Object? waveHeight = freezed,Object? wavePeriod = freezed,Object? waveDirection = freezed,Object? pressure = freezed,Object? visibility = freezed,Object? temperature = freezed,Object? precipitation = freezed,Object? cloudCover = freezed,Object? humidity = freezed,}) {
  return _then(_ExplanationObservation(
windSpeed: freezed == windSpeed ? _self.windSpeed : windSpeed // ignore: cast_nullable_to_non_nullable
as double?,windGust: freezed == windGust ? _self.windGust : windGust // ignore: cast_nullable_to_non_nullable
as double?,windDirection: freezed == windDirection ? _self.windDirection : windDirection // ignore: cast_nullable_to_non_nullable
as double?,waveHeight: freezed == waveHeight ? _self.waveHeight : waveHeight // ignore: cast_nullable_to_non_nullable
as double?,wavePeriod: freezed == wavePeriod ? _self.wavePeriod : wavePeriod // ignore: cast_nullable_to_non_nullable
as double?,waveDirection: freezed == waveDirection ? _self.waveDirection : waveDirection // ignore: cast_nullable_to_non_nullable
as double?,pressure: freezed == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as double?,visibility: freezed == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as double?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,precipitation: freezed == precipitation ? _self.precipitation : precipitation // ignore: cast_nullable_to_non_nullable
as double?,cloudCover: freezed == cloudCover ? _self.cloudCover : cloudCover // ignore: cast_nullable_to_non_nullable
as double?,humidity: freezed == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$ExplanationThresholds {

 double get windYellowMs; double get windOrangeMs; double get windRedMs; double get waveYellowM; double get waveOrangeM; double get waveRedM;
/// Create a copy of ExplanationThresholds
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExplanationThresholdsCopyWith<ExplanationThresholds> get copyWith => _$ExplanationThresholdsCopyWithImpl<ExplanationThresholds>(this as ExplanationThresholds, _$identity);

  /// Serializes this ExplanationThresholds to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExplanationThresholds&&(identical(other.windYellowMs, windYellowMs) || other.windYellowMs == windYellowMs)&&(identical(other.windOrangeMs, windOrangeMs) || other.windOrangeMs == windOrangeMs)&&(identical(other.windRedMs, windRedMs) || other.windRedMs == windRedMs)&&(identical(other.waveYellowM, waveYellowM) || other.waveYellowM == waveYellowM)&&(identical(other.waveOrangeM, waveOrangeM) || other.waveOrangeM == waveOrangeM)&&(identical(other.waveRedM, waveRedM) || other.waveRedM == waveRedM));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,windYellowMs,windOrangeMs,windRedMs,waveYellowM,waveOrangeM,waveRedM);

@override
String toString() {
  return 'ExplanationThresholds(windYellowMs: $windYellowMs, windOrangeMs: $windOrangeMs, windRedMs: $windRedMs, waveYellowM: $waveYellowM, waveOrangeM: $waveOrangeM, waveRedM: $waveRedM)';
}


}

/// @nodoc
abstract mixin class $ExplanationThresholdsCopyWith<$Res>  {
  factory $ExplanationThresholdsCopyWith(ExplanationThresholds value, $Res Function(ExplanationThresholds) _then) = _$ExplanationThresholdsCopyWithImpl;
@useResult
$Res call({
 double windYellowMs, double windOrangeMs, double windRedMs, double waveYellowM, double waveOrangeM, double waveRedM
});




}
/// @nodoc
class _$ExplanationThresholdsCopyWithImpl<$Res>
    implements $ExplanationThresholdsCopyWith<$Res> {
  _$ExplanationThresholdsCopyWithImpl(this._self, this._then);

  final ExplanationThresholds _self;
  final $Res Function(ExplanationThresholds) _then;

/// Create a copy of ExplanationThresholds
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? windYellowMs = null,Object? windOrangeMs = null,Object? windRedMs = null,Object? waveYellowM = null,Object? waveOrangeM = null,Object? waveRedM = null,}) {
  return _then(_self.copyWith(
windYellowMs: null == windYellowMs ? _self.windYellowMs : windYellowMs // ignore: cast_nullable_to_non_nullable
as double,windOrangeMs: null == windOrangeMs ? _self.windOrangeMs : windOrangeMs // ignore: cast_nullable_to_non_nullable
as double,windRedMs: null == windRedMs ? _self.windRedMs : windRedMs // ignore: cast_nullable_to_non_nullable
as double,waveYellowM: null == waveYellowM ? _self.waveYellowM : waveYellowM // ignore: cast_nullable_to_non_nullable
as double,waveOrangeM: null == waveOrangeM ? _self.waveOrangeM : waveOrangeM // ignore: cast_nullable_to_non_nullable
as double,waveRedM: null == waveRedM ? _self.waveRedM : waveRedM // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ExplanationThresholds].
extension ExplanationThresholdsPatterns on ExplanationThresholds {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExplanationThresholds value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExplanationThresholds() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExplanationThresholds value)  $default,){
final _that = this;
switch (_that) {
case _ExplanationThresholds():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExplanationThresholds value)?  $default,){
final _that = this;
switch (_that) {
case _ExplanationThresholds() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double windYellowMs,  double windOrangeMs,  double windRedMs,  double waveYellowM,  double waveOrangeM,  double waveRedM)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExplanationThresholds() when $default != null:
return $default(_that.windYellowMs,_that.windOrangeMs,_that.windRedMs,_that.waveYellowM,_that.waveOrangeM,_that.waveRedM);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double windYellowMs,  double windOrangeMs,  double windRedMs,  double waveYellowM,  double waveOrangeM,  double waveRedM)  $default,) {final _that = this;
switch (_that) {
case _ExplanationThresholds():
return $default(_that.windYellowMs,_that.windOrangeMs,_that.windRedMs,_that.waveYellowM,_that.waveOrangeM,_that.waveRedM);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double windYellowMs,  double windOrangeMs,  double windRedMs,  double waveYellowM,  double waveOrangeM,  double waveRedM)?  $default,) {final _that = this;
switch (_that) {
case _ExplanationThresholds() when $default != null:
return $default(_that.windYellowMs,_that.windOrangeMs,_that.windRedMs,_that.waveYellowM,_that.waveOrangeM,_that.waveRedM);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExplanationThresholds implements ExplanationThresholds {
  const _ExplanationThresholds({required this.windYellowMs, required this.windOrangeMs, required this.windRedMs, required this.waveYellowM, required this.waveOrangeM, required this.waveRedM});
  factory _ExplanationThresholds.fromJson(Map<String, dynamic> json) => _$ExplanationThresholdsFromJson(json);

@override final  double windYellowMs;
@override final  double windOrangeMs;
@override final  double windRedMs;
@override final  double waveYellowM;
@override final  double waveOrangeM;
@override final  double waveRedM;

/// Create a copy of ExplanationThresholds
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExplanationThresholdsCopyWith<_ExplanationThresholds> get copyWith => __$ExplanationThresholdsCopyWithImpl<_ExplanationThresholds>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExplanationThresholdsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExplanationThresholds&&(identical(other.windYellowMs, windYellowMs) || other.windYellowMs == windYellowMs)&&(identical(other.windOrangeMs, windOrangeMs) || other.windOrangeMs == windOrangeMs)&&(identical(other.windRedMs, windRedMs) || other.windRedMs == windRedMs)&&(identical(other.waveYellowM, waveYellowM) || other.waveYellowM == waveYellowM)&&(identical(other.waveOrangeM, waveOrangeM) || other.waveOrangeM == waveOrangeM)&&(identical(other.waveRedM, waveRedM) || other.waveRedM == waveRedM));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,windYellowMs,windOrangeMs,windRedMs,waveYellowM,waveOrangeM,waveRedM);

@override
String toString() {
  return 'ExplanationThresholds(windYellowMs: $windYellowMs, windOrangeMs: $windOrangeMs, windRedMs: $windRedMs, waveYellowM: $waveYellowM, waveOrangeM: $waveOrangeM, waveRedM: $waveRedM)';
}


}

/// @nodoc
abstract mixin class _$ExplanationThresholdsCopyWith<$Res> implements $ExplanationThresholdsCopyWith<$Res> {
  factory _$ExplanationThresholdsCopyWith(_ExplanationThresholds value, $Res Function(_ExplanationThresholds) _then) = __$ExplanationThresholdsCopyWithImpl;
@override @useResult
$Res call({
 double windYellowMs, double windOrangeMs, double windRedMs, double waveYellowM, double waveOrangeM, double waveRedM
});




}
/// @nodoc
class __$ExplanationThresholdsCopyWithImpl<$Res>
    implements _$ExplanationThresholdsCopyWith<$Res> {
  __$ExplanationThresholdsCopyWithImpl(this._self, this._then);

  final _ExplanationThresholds _self;
  final $Res Function(_ExplanationThresholds) _then;

/// Create a copy of ExplanationThresholds
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? windYellowMs = null,Object? windOrangeMs = null,Object? windRedMs = null,Object? waveYellowM = null,Object? waveOrangeM = null,Object? waveRedM = null,}) {
  return _then(_ExplanationThresholds(
windYellowMs: null == windYellowMs ? _self.windYellowMs : windYellowMs // ignore: cast_nullable_to_non_nullable
as double,windOrangeMs: null == windOrangeMs ? _self.windOrangeMs : windOrangeMs // ignore: cast_nullable_to_non_nullable
as double,windRedMs: null == windRedMs ? _self.windRedMs : windRedMs // ignore: cast_nullable_to_non_nullable
as double,waveYellowM: null == waveYellowM ? _self.waveYellowM : waveYellowM // ignore: cast_nullable_to_non_nullable
as double,waveOrangeM: null == waveOrangeM ? _self.waveOrangeM : waveOrangeM // ignore: cast_nullable_to_non_nullable
as double,waveRedM: null == waveRedM ? _self.waveRedM : waveRedM // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ExplanationForecast {

 String get timestamp; double? get windGust; double? get waveHeight; double? get precipitation; double? get pressure;
/// Create a copy of ExplanationForecast
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExplanationForecastCopyWith<ExplanationForecast> get copyWith => _$ExplanationForecastCopyWithImpl<ExplanationForecast>(this as ExplanationForecast, _$identity);

  /// Serializes this ExplanationForecast to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExplanationForecast&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.windGust, windGust) || other.windGust == windGust)&&(identical(other.waveHeight, waveHeight) || other.waveHeight == waveHeight)&&(identical(other.precipitation, precipitation) || other.precipitation == precipitation)&&(identical(other.pressure, pressure) || other.pressure == pressure));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timestamp,windGust,waveHeight,precipitation,pressure);

@override
String toString() {
  return 'ExplanationForecast(timestamp: $timestamp, windGust: $windGust, waveHeight: $waveHeight, precipitation: $precipitation, pressure: $pressure)';
}


}

/// @nodoc
abstract mixin class $ExplanationForecastCopyWith<$Res>  {
  factory $ExplanationForecastCopyWith(ExplanationForecast value, $Res Function(ExplanationForecast) _then) = _$ExplanationForecastCopyWithImpl;
@useResult
$Res call({
 String timestamp, double? windGust, double? waveHeight, double? precipitation, double? pressure
});




}
/// @nodoc
class _$ExplanationForecastCopyWithImpl<$Res>
    implements $ExplanationForecastCopyWith<$Res> {
  _$ExplanationForecastCopyWithImpl(this._self, this._then);

  final ExplanationForecast _self;
  final $Res Function(ExplanationForecast) _then;

/// Create a copy of ExplanationForecast
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timestamp = null,Object? windGust = freezed,Object? waveHeight = freezed,Object? precipitation = freezed,Object? pressure = freezed,}) {
  return _then(_self.copyWith(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,windGust: freezed == windGust ? _self.windGust : windGust // ignore: cast_nullable_to_non_nullable
as double?,waveHeight: freezed == waveHeight ? _self.waveHeight : waveHeight // ignore: cast_nullable_to_non_nullable
as double?,precipitation: freezed == precipitation ? _self.precipitation : precipitation // ignore: cast_nullable_to_non_nullable
as double?,pressure: freezed == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExplanationForecast].
extension ExplanationForecastPatterns on ExplanationForecast {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExplanationForecast value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExplanationForecast() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExplanationForecast value)  $default,){
final _that = this;
switch (_that) {
case _ExplanationForecast():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExplanationForecast value)?  $default,){
final _that = this;
switch (_that) {
case _ExplanationForecast() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String timestamp,  double? windGust,  double? waveHeight,  double? precipitation,  double? pressure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExplanationForecast() when $default != null:
return $default(_that.timestamp,_that.windGust,_that.waveHeight,_that.precipitation,_that.pressure);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String timestamp,  double? windGust,  double? waveHeight,  double? precipitation,  double? pressure)  $default,) {final _that = this;
switch (_that) {
case _ExplanationForecast():
return $default(_that.timestamp,_that.windGust,_that.waveHeight,_that.precipitation,_that.pressure);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String timestamp,  double? windGust,  double? waveHeight,  double? precipitation,  double? pressure)?  $default,) {final _that = this;
switch (_that) {
case _ExplanationForecast() when $default != null:
return $default(_that.timestamp,_that.windGust,_that.waveHeight,_that.precipitation,_that.pressure);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExplanationForecast implements ExplanationForecast {
  const _ExplanationForecast({required this.timestamp, this.windGust, this.waveHeight, this.precipitation, this.pressure});
  factory _ExplanationForecast.fromJson(Map<String, dynamic> json) => _$ExplanationForecastFromJson(json);

@override final  String timestamp;
@override final  double? windGust;
@override final  double? waveHeight;
@override final  double? precipitation;
@override final  double? pressure;

/// Create a copy of ExplanationForecast
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExplanationForecastCopyWith<_ExplanationForecast> get copyWith => __$ExplanationForecastCopyWithImpl<_ExplanationForecast>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExplanationForecastToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExplanationForecast&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.windGust, windGust) || other.windGust == windGust)&&(identical(other.waveHeight, waveHeight) || other.waveHeight == waveHeight)&&(identical(other.precipitation, precipitation) || other.precipitation == precipitation)&&(identical(other.pressure, pressure) || other.pressure == pressure));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timestamp,windGust,waveHeight,precipitation,pressure);

@override
String toString() {
  return 'ExplanationForecast(timestamp: $timestamp, windGust: $windGust, waveHeight: $waveHeight, precipitation: $precipitation, pressure: $pressure)';
}


}

/// @nodoc
abstract mixin class _$ExplanationForecastCopyWith<$Res> implements $ExplanationForecastCopyWith<$Res> {
  factory _$ExplanationForecastCopyWith(_ExplanationForecast value, $Res Function(_ExplanationForecast) _then) = __$ExplanationForecastCopyWithImpl;
@override @useResult
$Res call({
 String timestamp, double? windGust, double? waveHeight, double? precipitation, double? pressure
});




}
/// @nodoc
class __$ExplanationForecastCopyWithImpl<$Res>
    implements _$ExplanationForecastCopyWith<$Res> {
  __$ExplanationForecastCopyWithImpl(this._self, this._then);

  final _ExplanationForecast _self;
  final $Res Function(_ExplanationForecast) _then;

/// Create a copy of ExplanationForecast
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timestamp = null,Object? windGust = freezed,Object? waveHeight = freezed,Object? precipitation = freezed,Object? pressure = freezed,}) {
  return _then(_ExplanationForecast(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,windGust: freezed == windGust ? _self.windGust : windGust // ignore: cast_nullable_to_non_nullable
as double?,waveHeight: freezed == waveHeight ? _self.waveHeight : waveHeight // ignore: cast_nullable_to_non_nullable
as double?,precipitation: freezed == precipitation ? _self.precipitation : precipitation // ignore: cast_nullable_to_non_nullable
as double?,pressure: freezed == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
