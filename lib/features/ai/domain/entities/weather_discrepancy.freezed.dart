// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_discrepancy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeatherDiscrepancy {

 SafetyStatus get status; String get message; double get windDeltaMs; double get waveDeltaM; double get pressureDeltaHpa; DateTime get timestamp;
/// Create a copy of WeatherDiscrepancy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherDiscrepancyCopyWith<WeatherDiscrepancy> get copyWith => _$WeatherDiscrepancyCopyWithImpl<WeatherDiscrepancy>(this as WeatherDiscrepancy, _$identity);

  /// Serializes this WeatherDiscrepancy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherDiscrepancy&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.windDeltaMs, windDeltaMs) || other.windDeltaMs == windDeltaMs)&&(identical(other.waveDeltaM, waveDeltaM) || other.waveDeltaM == waveDeltaM)&&(identical(other.pressureDeltaHpa, pressureDeltaHpa) || other.pressureDeltaHpa == pressureDeltaHpa)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message,windDeltaMs,waveDeltaM,pressureDeltaHpa,timestamp);

@override
String toString() {
  return 'WeatherDiscrepancy(status: $status, message: $message, windDeltaMs: $windDeltaMs, waveDeltaM: $waveDeltaM, pressureDeltaHpa: $pressureDeltaHpa, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $WeatherDiscrepancyCopyWith<$Res>  {
  factory $WeatherDiscrepancyCopyWith(WeatherDiscrepancy value, $Res Function(WeatherDiscrepancy) _then) = _$WeatherDiscrepancyCopyWithImpl;
@useResult
$Res call({
 SafetyStatus status, String message, double windDeltaMs, double waveDeltaM, double pressureDeltaHpa, DateTime timestamp
});




}
/// @nodoc
class _$WeatherDiscrepancyCopyWithImpl<$Res>
    implements $WeatherDiscrepancyCopyWith<$Res> {
  _$WeatherDiscrepancyCopyWithImpl(this._self, this._then);

  final WeatherDiscrepancy _self;
  final $Res Function(WeatherDiscrepancy) _then;

/// Create a copy of WeatherDiscrepancy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? message = null,Object? windDeltaMs = null,Object? waveDeltaM = null,Object? pressureDeltaHpa = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SafetyStatus,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,windDeltaMs: null == windDeltaMs ? _self.windDeltaMs : windDeltaMs // ignore: cast_nullable_to_non_nullable
as double,waveDeltaM: null == waveDeltaM ? _self.waveDeltaM : waveDeltaM // ignore: cast_nullable_to_non_nullable
as double,pressureDeltaHpa: null == pressureDeltaHpa ? _self.pressureDeltaHpa : pressureDeltaHpa // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherDiscrepancy].
extension WeatherDiscrepancyPatterns on WeatherDiscrepancy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherDiscrepancy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherDiscrepancy() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherDiscrepancy value)  $default,){
final _that = this;
switch (_that) {
case _WeatherDiscrepancy():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherDiscrepancy value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherDiscrepancy() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SafetyStatus status,  String message,  double windDeltaMs,  double waveDeltaM,  double pressureDeltaHpa,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherDiscrepancy() when $default != null:
return $default(_that.status,_that.message,_that.windDeltaMs,_that.waveDeltaM,_that.pressureDeltaHpa,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SafetyStatus status,  String message,  double windDeltaMs,  double waveDeltaM,  double pressureDeltaHpa,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _WeatherDiscrepancy():
return $default(_that.status,_that.message,_that.windDeltaMs,_that.waveDeltaM,_that.pressureDeltaHpa,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SafetyStatus status,  String message,  double windDeltaMs,  double waveDeltaM,  double pressureDeltaHpa,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _WeatherDiscrepancy() when $default != null:
return $default(_that.status,_that.message,_that.windDeltaMs,_that.waveDeltaM,_that.pressureDeltaHpa,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeatherDiscrepancy implements WeatherDiscrepancy {
  const _WeatherDiscrepancy({required this.status, required this.message, required this.windDeltaMs, required this.waveDeltaM, required this.pressureDeltaHpa, required this.timestamp});
  factory _WeatherDiscrepancy.fromJson(Map<String, dynamic> json) => _$WeatherDiscrepancyFromJson(json);

@override final  SafetyStatus status;
@override final  String message;
@override final  double windDeltaMs;
@override final  double waveDeltaM;
@override final  double pressureDeltaHpa;
@override final  DateTime timestamp;

/// Create a copy of WeatherDiscrepancy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherDiscrepancyCopyWith<_WeatherDiscrepancy> get copyWith => __$WeatherDiscrepancyCopyWithImpl<_WeatherDiscrepancy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherDiscrepancyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherDiscrepancy&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.windDeltaMs, windDeltaMs) || other.windDeltaMs == windDeltaMs)&&(identical(other.waveDeltaM, waveDeltaM) || other.waveDeltaM == waveDeltaM)&&(identical(other.pressureDeltaHpa, pressureDeltaHpa) || other.pressureDeltaHpa == pressureDeltaHpa)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message,windDeltaMs,waveDeltaM,pressureDeltaHpa,timestamp);

@override
String toString() {
  return 'WeatherDiscrepancy(status: $status, message: $message, windDeltaMs: $windDeltaMs, waveDeltaM: $waveDeltaM, pressureDeltaHpa: $pressureDeltaHpa, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$WeatherDiscrepancyCopyWith<$Res> implements $WeatherDiscrepancyCopyWith<$Res> {
  factory _$WeatherDiscrepancyCopyWith(_WeatherDiscrepancy value, $Res Function(_WeatherDiscrepancy) _then) = __$WeatherDiscrepancyCopyWithImpl;
@override @useResult
$Res call({
 SafetyStatus status, String message, double windDeltaMs, double waveDeltaM, double pressureDeltaHpa, DateTime timestamp
});




}
/// @nodoc
class __$WeatherDiscrepancyCopyWithImpl<$Res>
    implements _$WeatherDiscrepancyCopyWith<$Res> {
  __$WeatherDiscrepancyCopyWithImpl(this._self, this._then);

  final _WeatherDiscrepancy _self;
  final $Res Function(_WeatherDiscrepancy) _then;

/// Create a copy of WeatherDiscrepancy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? message = null,Object? windDeltaMs = null,Object? waveDeltaM = null,Object? pressureDeltaHpa = null,Object? timestamp = null,}) {
  return _then(_WeatherDiscrepancy(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SafetyStatus,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,windDeltaMs: null == windDeltaMs ? _self.windDeltaMs : windDeltaMs // ignore: cast_nullable_to_non_nullable
as double,waveDeltaM: null == waveDeltaM ? _self.waveDeltaM : waveDeltaM // ignore: cast_nullable_to_non_nullable
as double,pressureDeltaHpa: null == pressureDeltaHpa ? _self.pressureDeltaHpa : pressureDeltaHpa // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
