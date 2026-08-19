// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sea_level_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeaLevelDto {

 DateTime get timestamp;@LatLngConverter() LatLng get location; String? get stationName; double? get seaLevel;
/// Create a copy of SeaLevelDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeaLevelDtoCopyWith<SeaLevelDto> get copyWith => _$SeaLevelDtoCopyWithImpl<SeaLevelDto>(this as SeaLevelDto, _$identity);

  /// Serializes this SeaLevelDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeaLevelDto&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.stationName, stationName) || other.stationName == stationName)&&(identical(other.seaLevel, seaLevel) || other.seaLevel == seaLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timestamp,location,stationName,seaLevel);

@override
String toString() {
  return 'SeaLevelDto(timestamp: $timestamp, location: $location, stationName: $stationName, seaLevel: $seaLevel)';
}


}

/// @nodoc
abstract mixin class $SeaLevelDtoCopyWith<$Res>  {
  factory $SeaLevelDtoCopyWith(SeaLevelDto value, $Res Function(SeaLevelDto) _then) = _$SeaLevelDtoCopyWithImpl;
@useResult
$Res call({
 DateTime timestamp,@LatLngConverter() LatLng location, String? stationName, double? seaLevel
});




}
/// @nodoc
class _$SeaLevelDtoCopyWithImpl<$Res>
    implements $SeaLevelDtoCopyWith<$Res> {
  _$SeaLevelDtoCopyWithImpl(this._self, this._then);

  final SeaLevelDto _self;
  final $Res Function(SeaLevelDto) _then;

/// Create a copy of SeaLevelDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timestamp = null,Object? location = null,Object? stationName = freezed,Object? seaLevel = freezed,}) {
  return _then(_self.copyWith(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,stationName: freezed == stationName ? _self.stationName : stationName // ignore: cast_nullable_to_non_nullable
as String?,seaLevel: freezed == seaLevel ? _self.seaLevel : seaLevel // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [SeaLevelDto].
extension SeaLevelDtoPatterns on SeaLevelDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeaLevelDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeaLevelDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeaLevelDto value)  $default,){
final _that = this;
switch (_that) {
case _SeaLevelDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeaLevelDto value)?  $default,){
final _that = this;
switch (_that) {
case _SeaLevelDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime timestamp, @LatLngConverter()  LatLng location,  String? stationName,  double? seaLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeaLevelDto() when $default != null:
return $default(_that.timestamp,_that.location,_that.stationName,_that.seaLevel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime timestamp, @LatLngConverter()  LatLng location,  String? stationName,  double? seaLevel)  $default,) {final _that = this;
switch (_that) {
case _SeaLevelDto():
return $default(_that.timestamp,_that.location,_that.stationName,_that.seaLevel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime timestamp, @LatLngConverter()  LatLng location,  String? stationName,  double? seaLevel)?  $default,) {final _that = this;
switch (_that) {
case _SeaLevelDto() when $default != null:
return $default(_that.timestamp,_that.location,_that.stationName,_that.seaLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeaLevelDto implements SeaLevelDto {
  const _SeaLevelDto({required this.timestamp, @LatLngConverter() required this.location, this.stationName, this.seaLevel});
  factory _SeaLevelDto.fromJson(Map<String, dynamic> json) => _$SeaLevelDtoFromJson(json);

@override final  DateTime timestamp;
@override@LatLngConverter() final  LatLng location;
@override final  String? stationName;
@override final  double? seaLevel;

/// Create a copy of SeaLevelDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeaLevelDtoCopyWith<_SeaLevelDto> get copyWith => __$SeaLevelDtoCopyWithImpl<_SeaLevelDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeaLevelDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeaLevelDto&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.stationName, stationName) || other.stationName == stationName)&&(identical(other.seaLevel, seaLevel) || other.seaLevel == seaLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timestamp,location,stationName,seaLevel);

@override
String toString() {
  return 'SeaLevelDto(timestamp: $timestamp, location: $location, stationName: $stationName, seaLevel: $seaLevel)';
}


}

/// @nodoc
abstract mixin class _$SeaLevelDtoCopyWith<$Res> implements $SeaLevelDtoCopyWith<$Res> {
  factory _$SeaLevelDtoCopyWith(_SeaLevelDto value, $Res Function(_SeaLevelDto) _then) = __$SeaLevelDtoCopyWithImpl;
@override @useResult
$Res call({
 DateTime timestamp,@LatLngConverter() LatLng location, String? stationName, double? seaLevel
});




}
/// @nodoc
class __$SeaLevelDtoCopyWithImpl<$Res>
    implements _$SeaLevelDtoCopyWith<$Res> {
  __$SeaLevelDtoCopyWithImpl(this._self, this._then);

  final _SeaLevelDto _self;
  final $Res Function(_SeaLevelDto) _then;

/// Create a copy of SeaLevelDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timestamp = null,Object? location = null,Object? stationName = freezed,Object? seaLevel = freezed,}) {
  return _then(_SeaLevelDto(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,stationName: freezed == stationName ? _self.stationName : stationName // ignore: cast_nullable_to_non_nullable
as String?,seaLevel: freezed == seaLevel ? _self.seaLevel : seaLevel // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
