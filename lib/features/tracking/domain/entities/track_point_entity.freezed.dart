// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'track_point_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrackPointEntity {

 double get latitude; double get longitude; double get speedKmh; DateTime get timestamp;
/// Create a copy of TrackPointEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrackPointEntityCopyWith<TrackPointEntity> get copyWith => _$TrackPointEntityCopyWithImpl<TrackPointEntity>(this as TrackPointEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrackPointEntity&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.speedKmh, speedKmh) || other.speedKmh == speedKmh)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,speedKmh,timestamp);

@override
String toString() {
  return 'TrackPointEntity(latitude: $latitude, longitude: $longitude, speedKmh: $speedKmh, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $TrackPointEntityCopyWith<$Res>  {
  factory $TrackPointEntityCopyWith(TrackPointEntity value, $Res Function(TrackPointEntity) _then) = _$TrackPointEntityCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, double speedKmh, DateTime timestamp
});




}
/// @nodoc
class _$TrackPointEntityCopyWithImpl<$Res>
    implements $TrackPointEntityCopyWith<$Res> {
  _$TrackPointEntityCopyWithImpl(this._self, this._then);

  final TrackPointEntity _self;
  final $Res Function(TrackPointEntity) _then;

/// Create a copy of TrackPointEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? speedKmh = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,speedKmh: null == speedKmh ? _self.speedKmh : speedKmh // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TrackPointEntity].
extension TrackPointEntityPatterns on TrackPointEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrackPointEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrackPointEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrackPointEntity value)  $default,){
final _that = this;
switch (_that) {
case _TrackPointEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrackPointEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TrackPointEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude,  double speedKmh,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrackPointEntity() when $default != null:
return $default(_that.latitude,_that.longitude,_that.speedKmh,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude,  double speedKmh,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _TrackPointEntity():
return $default(_that.latitude,_that.longitude,_that.speedKmh,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude,  double speedKmh,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _TrackPointEntity() when $default != null:
return $default(_that.latitude,_that.longitude,_that.speedKmh,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc


class _TrackPointEntity implements TrackPointEntity {
  const _TrackPointEntity({required this.latitude, required this.longitude, required this.speedKmh, required this.timestamp});
  

@override final  double latitude;
@override final  double longitude;
@override final  double speedKmh;
@override final  DateTime timestamp;

/// Create a copy of TrackPointEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrackPointEntityCopyWith<_TrackPointEntity> get copyWith => __$TrackPointEntityCopyWithImpl<_TrackPointEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrackPointEntity&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.speedKmh, speedKmh) || other.speedKmh == speedKmh)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,speedKmh,timestamp);

@override
String toString() {
  return 'TrackPointEntity(latitude: $latitude, longitude: $longitude, speedKmh: $speedKmh, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$TrackPointEntityCopyWith<$Res> implements $TrackPointEntityCopyWith<$Res> {
  factory _$TrackPointEntityCopyWith(_TrackPointEntity value, $Res Function(_TrackPointEntity) _then) = __$TrackPointEntityCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude, double speedKmh, DateTime timestamp
});




}
/// @nodoc
class __$TrackPointEntityCopyWithImpl<$Res>
    implements _$TrackPointEntityCopyWith<$Res> {
  __$TrackPointEntityCopyWithImpl(this._self, this._then);

  final _TrackPointEntity _self;
  final $Res Function(_TrackPointEntity) _then;

/// Create a copy of TrackPointEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? speedKmh = null,Object? timestamp = null,}) {
  return _then(_TrackPointEntity(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,speedKmh: null == speedKmh ? _self.speedKmh : speedKmh // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
