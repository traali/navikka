// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lightning_strike_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LightningStrikeDto {

 DateTime get time; LatLng get location; double get peakCurrent; int get multiplicity;
/// Create a copy of LightningStrikeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LightningStrikeDtoCopyWith<LightningStrikeDto> get copyWith => _$LightningStrikeDtoCopyWithImpl<LightningStrikeDto>(this as LightningStrikeDto, _$identity);

  /// Serializes this LightningStrikeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LightningStrikeDto&&(identical(other.time, time) || other.time == time)&&(identical(other.location, location) || other.location == location)&&(identical(other.peakCurrent, peakCurrent) || other.peakCurrent == peakCurrent)&&(identical(other.multiplicity, multiplicity) || other.multiplicity == multiplicity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,location,peakCurrent,multiplicity);

@override
String toString() {
  return 'LightningStrikeDto(time: $time, location: $location, peakCurrent: $peakCurrent, multiplicity: $multiplicity)';
}


}

/// @nodoc
abstract mixin class $LightningStrikeDtoCopyWith<$Res>  {
  factory $LightningStrikeDtoCopyWith(LightningStrikeDto value, $Res Function(LightningStrikeDto) _then) = _$LightningStrikeDtoCopyWithImpl;
@useResult
$Res call({
 DateTime time, LatLng location, double peakCurrent, int multiplicity
});




}
/// @nodoc
class _$LightningStrikeDtoCopyWithImpl<$Res>
    implements $LightningStrikeDtoCopyWith<$Res> {
  _$LightningStrikeDtoCopyWithImpl(this._self, this._then);

  final LightningStrikeDto _self;
  final $Res Function(LightningStrikeDto) _then;

/// Create a copy of LightningStrikeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = null,Object? location = null,Object? peakCurrent = null,Object? multiplicity = null,}) {
  return _then(_self.copyWith(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,peakCurrent: null == peakCurrent ? _self.peakCurrent : peakCurrent // ignore: cast_nullable_to_non_nullable
as double,multiplicity: null == multiplicity ? _self.multiplicity : multiplicity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LightningStrikeDto].
extension LightningStrikeDtoPatterns on LightningStrikeDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LightningStrikeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LightningStrikeDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LightningStrikeDto value)  $default,){
final _that = this;
switch (_that) {
case _LightningStrikeDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LightningStrikeDto value)?  $default,){
final _that = this;
switch (_that) {
case _LightningStrikeDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime time,  LatLng location,  double peakCurrent,  int multiplicity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LightningStrikeDto() when $default != null:
return $default(_that.time,_that.location,_that.peakCurrent,_that.multiplicity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime time,  LatLng location,  double peakCurrent,  int multiplicity)  $default,) {final _that = this;
switch (_that) {
case _LightningStrikeDto():
return $default(_that.time,_that.location,_that.peakCurrent,_that.multiplicity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime time,  LatLng location,  double peakCurrent,  int multiplicity)?  $default,) {final _that = this;
switch (_that) {
case _LightningStrikeDto() when $default != null:
return $default(_that.time,_that.location,_that.peakCurrent,_that.multiplicity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LightningStrikeDto implements LightningStrikeDto {
  const _LightningStrikeDto({required this.time, required this.location, required this.peakCurrent, this.multiplicity = 0});
  factory _LightningStrikeDto.fromJson(Map<String, dynamic> json) => _$LightningStrikeDtoFromJson(json);

@override final  DateTime time;
@override final  LatLng location;
@override final  double peakCurrent;
@override@JsonKey() final  int multiplicity;

/// Create a copy of LightningStrikeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LightningStrikeDtoCopyWith<_LightningStrikeDto> get copyWith => __$LightningStrikeDtoCopyWithImpl<_LightningStrikeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LightningStrikeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LightningStrikeDto&&(identical(other.time, time) || other.time == time)&&(identical(other.location, location) || other.location == location)&&(identical(other.peakCurrent, peakCurrent) || other.peakCurrent == peakCurrent)&&(identical(other.multiplicity, multiplicity) || other.multiplicity == multiplicity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,location,peakCurrent,multiplicity);

@override
String toString() {
  return 'LightningStrikeDto(time: $time, location: $location, peakCurrent: $peakCurrent, multiplicity: $multiplicity)';
}


}

/// @nodoc
abstract mixin class _$LightningStrikeDtoCopyWith<$Res> implements $LightningStrikeDtoCopyWith<$Res> {
  factory _$LightningStrikeDtoCopyWith(_LightningStrikeDto value, $Res Function(_LightningStrikeDto) _then) = __$LightningStrikeDtoCopyWithImpl;
@override @useResult
$Res call({
 DateTime time, LatLng location, double peakCurrent, int multiplicity
});




}
/// @nodoc
class __$LightningStrikeDtoCopyWithImpl<$Res>
    implements _$LightningStrikeDtoCopyWith<$Res> {
  __$LightningStrikeDtoCopyWithImpl(this._self, this._then);

  final _LightningStrikeDto _self;
  final $Res Function(_LightningStrikeDto) _then;

/// Create a copy of LightningStrikeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = null,Object? location = null,Object? peakCurrent = null,Object? multiplicity = null,}) {
  return _then(_LightningStrikeDto(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,peakCurrent: null == peakCurrent ? _self.peakCurrent : peakCurrent // ignore: cast_nullable_to_non_nullable
as double,multiplicity: null == multiplicity ? _self.multiplicity : multiplicity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
