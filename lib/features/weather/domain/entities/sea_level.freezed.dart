// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sea_level.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeaLevel {

 DateTime get timestamp; LatLng get location; double get seaLevel; String? get stationName;
/// Create a copy of SeaLevel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeaLevelCopyWith<SeaLevel> get copyWith => _$SeaLevelCopyWithImpl<SeaLevel>(this as SeaLevel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeaLevel&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.seaLevel, seaLevel) || other.seaLevel == seaLevel)&&(identical(other.stationName, stationName) || other.stationName == stationName));
}


@override
int get hashCode => Object.hash(runtimeType,timestamp,location,seaLevel,stationName);

@override
String toString() {
  return 'SeaLevel(timestamp: $timestamp, location: $location, seaLevel: $seaLevel, stationName: $stationName)';
}


}

/// @nodoc
abstract mixin class $SeaLevelCopyWith<$Res>  {
  factory $SeaLevelCopyWith(SeaLevel value, $Res Function(SeaLevel) _then) = _$SeaLevelCopyWithImpl;
@useResult
$Res call({
 DateTime timestamp, LatLng location, double seaLevel, String? stationName
});




}
/// @nodoc
class _$SeaLevelCopyWithImpl<$Res>
    implements $SeaLevelCopyWith<$Res> {
  _$SeaLevelCopyWithImpl(this._self, this._then);

  final SeaLevel _self;
  final $Res Function(SeaLevel) _then;

/// Create a copy of SeaLevel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timestamp = null,Object? location = null,Object? seaLevel = null,Object? stationName = freezed,}) {
  return _then(_self.copyWith(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,seaLevel: null == seaLevel ? _self.seaLevel : seaLevel // ignore: cast_nullable_to_non_nullable
as double,stationName: freezed == stationName ? _self.stationName : stationName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SeaLevel].
extension SeaLevelPatterns on SeaLevel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeaLevel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeaLevel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeaLevel value)  $default,){
final _that = this;
switch (_that) {
case _SeaLevel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeaLevel value)?  $default,){
final _that = this;
switch (_that) {
case _SeaLevel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime timestamp,  LatLng location,  double seaLevel,  String? stationName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeaLevel() when $default != null:
return $default(_that.timestamp,_that.location,_that.seaLevel,_that.stationName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime timestamp,  LatLng location,  double seaLevel,  String? stationName)  $default,) {final _that = this;
switch (_that) {
case _SeaLevel():
return $default(_that.timestamp,_that.location,_that.seaLevel,_that.stationName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime timestamp,  LatLng location,  double seaLevel,  String? stationName)?  $default,) {final _that = this;
switch (_that) {
case _SeaLevel() when $default != null:
return $default(_that.timestamp,_that.location,_that.seaLevel,_that.stationName);case _:
  return null;

}
}

}

/// @nodoc


class _SeaLevel implements SeaLevel {
  const _SeaLevel({required this.timestamp, required this.location, required this.seaLevel, this.stationName});
  

@override final  DateTime timestamp;
@override final  LatLng location;
@override final  double seaLevel;
@override final  String? stationName;

/// Create a copy of SeaLevel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeaLevelCopyWith<_SeaLevel> get copyWith => __$SeaLevelCopyWithImpl<_SeaLevel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeaLevel&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.seaLevel, seaLevel) || other.seaLevel == seaLevel)&&(identical(other.stationName, stationName) || other.stationName == stationName));
}


@override
int get hashCode => Object.hash(runtimeType,timestamp,location,seaLevel,stationName);

@override
String toString() {
  return 'SeaLevel(timestamp: $timestamp, location: $location, seaLevel: $seaLevel, stationName: $stationName)';
}


}

/// @nodoc
abstract mixin class _$SeaLevelCopyWith<$Res> implements $SeaLevelCopyWith<$Res> {
  factory _$SeaLevelCopyWith(_SeaLevel value, $Res Function(_SeaLevel) _then) = __$SeaLevelCopyWithImpl;
@override @useResult
$Res call({
 DateTime timestamp, LatLng location, double seaLevel, String? stationName
});




}
/// @nodoc
class __$SeaLevelCopyWithImpl<$Res>
    implements _$SeaLevelCopyWith<$Res> {
  __$SeaLevelCopyWithImpl(this._self, this._then);

  final _SeaLevel _self;
  final $Res Function(_SeaLevel) _then;

/// Create a copy of SeaLevel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timestamp = null,Object? location = null,Object? seaLevel = null,Object? stationName = freezed,}) {
  return _then(_SeaLevel(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,seaLevel: null == seaLevel ? _self.seaLevel : seaLevel // ignore: cast_nullable_to_non_nullable
as double,stationName: freezed == stationName ? _self.stationName : stationName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
