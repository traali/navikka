// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'waypoint_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WaypointEntity {

 int get id; int get routeId; double get lat; double get lon; int get orderIndex; String? get label;
/// Create a copy of WaypointEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaypointEntityCopyWith<WaypointEntity> get copyWith => _$WaypointEntityCopyWithImpl<WaypointEntity>(this as WaypointEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaypointEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode => Object.hash(runtimeType,id,routeId,lat,lon,orderIndex,label);

@override
String toString() {
  return 'WaypointEntity(id: $id, routeId: $routeId, lat: $lat, lon: $lon, orderIndex: $orderIndex, label: $label)';
}


}

/// @nodoc
abstract mixin class $WaypointEntityCopyWith<$Res>  {
  factory $WaypointEntityCopyWith(WaypointEntity value, $Res Function(WaypointEntity) _then) = _$WaypointEntityCopyWithImpl;
@useResult
$Res call({
 int id, int routeId, double lat, double lon, int orderIndex, String? label
});




}
/// @nodoc
class _$WaypointEntityCopyWithImpl<$Res>
    implements $WaypointEntityCopyWith<$Res> {
  _$WaypointEntityCopyWithImpl(this._self, this._then);

  final WaypointEntity _self;
  final $Res Function(WaypointEntity) _then;

/// Create a copy of WaypointEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? routeId = null,Object? lat = null,Object? lon = null,Object? orderIndex = null,Object? label = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as int,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WaypointEntity].
extension WaypointEntityPatterns on WaypointEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WaypointEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WaypointEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WaypointEntity value)  $default,){
final _that = this;
switch (_that) {
case _WaypointEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WaypointEntity value)?  $default,){
final _that = this;
switch (_that) {
case _WaypointEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int routeId,  double lat,  double lon,  int orderIndex,  String? label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WaypointEntity() when $default != null:
return $default(_that.id,_that.routeId,_that.lat,_that.lon,_that.orderIndex,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int routeId,  double lat,  double lon,  int orderIndex,  String? label)  $default,) {final _that = this;
switch (_that) {
case _WaypointEntity():
return $default(_that.id,_that.routeId,_that.lat,_that.lon,_that.orderIndex,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int routeId,  double lat,  double lon,  int orderIndex,  String? label)?  $default,) {final _that = this;
switch (_that) {
case _WaypointEntity() when $default != null:
return $default(_that.id,_that.routeId,_that.lat,_that.lon,_that.orderIndex,_that.label);case _:
  return null;

}
}

}

/// @nodoc


class _WaypointEntity implements WaypointEntity {
  const _WaypointEntity({required this.id, required this.routeId, required this.lat, required this.lon, required this.orderIndex, this.label});
  

@override final  int id;
@override final  int routeId;
@override final  double lat;
@override final  double lon;
@override final  int orderIndex;
@override final  String? label;

/// Create a copy of WaypointEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaypointEntityCopyWith<_WaypointEntity> get copyWith => __$WaypointEntityCopyWithImpl<_WaypointEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaypointEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode => Object.hash(runtimeType,id,routeId,lat,lon,orderIndex,label);

@override
String toString() {
  return 'WaypointEntity(id: $id, routeId: $routeId, lat: $lat, lon: $lon, orderIndex: $orderIndex, label: $label)';
}


}

/// @nodoc
abstract mixin class _$WaypointEntityCopyWith<$Res> implements $WaypointEntityCopyWith<$Res> {
  factory _$WaypointEntityCopyWith(_WaypointEntity value, $Res Function(_WaypointEntity) _then) = __$WaypointEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, int routeId, double lat, double lon, int orderIndex, String? label
});




}
/// @nodoc
class __$WaypointEntityCopyWithImpl<$Res>
    implements _$WaypointEntityCopyWith<$Res> {
  __$WaypointEntityCopyWithImpl(this._self, this._then);

  final _WaypointEntity _self;
  final $Res Function(_WaypointEntity) _then;

/// Create a copy of WaypointEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? routeId = null,Object? lat = null,Object? lon = null,Object? orderIndex = null,Object? label = freezed,}) {
  return _then(_WaypointEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as int,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
