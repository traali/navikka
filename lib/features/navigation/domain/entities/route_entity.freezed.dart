// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RouteEntity {

 int get id; String get name; DateTime get createdAt; DateTime get updatedAt; bool get isActive; double get totalDistanceMeters;
/// Create a copy of RouteEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouteEntityCopyWith<RouteEntity> get copyWith => _$RouteEntityCopyWithImpl<RouteEntity>(this as RouteEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.totalDistanceMeters, totalDistanceMeters) || other.totalDistanceMeters == totalDistanceMeters));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,createdAt,updatedAt,isActive,totalDistanceMeters);

@override
String toString() {
  return 'RouteEntity(id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt, isActive: $isActive, totalDistanceMeters: $totalDistanceMeters)';
}


}

/// @nodoc
abstract mixin class $RouteEntityCopyWith<$Res>  {
  factory $RouteEntityCopyWith(RouteEntity value, $Res Function(RouteEntity) _then) = _$RouteEntityCopyWithImpl;
@useResult
$Res call({
 int id, String name, DateTime createdAt, DateTime updatedAt, bool isActive, double totalDistanceMeters
});




}
/// @nodoc
class _$RouteEntityCopyWithImpl<$Res>
    implements $RouteEntityCopyWith<$Res> {
  _$RouteEntityCopyWithImpl(this._self, this._then);

  final RouteEntity _self;
  final $Res Function(RouteEntity) _then;

/// Create a copy of RouteEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? createdAt = null,Object? updatedAt = null,Object? isActive = null,Object? totalDistanceMeters = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,totalDistanceMeters: null == totalDistanceMeters ? _self.totalDistanceMeters : totalDistanceMeters // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [RouteEntity].
extension RouteEntityPatterns on RouteEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RouteEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RouteEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RouteEntity value)  $default,){
final _that = this;
switch (_that) {
case _RouteEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RouteEntity value)?  $default,){
final _that = this;
switch (_that) {
case _RouteEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  DateTime createdAt,  DateTime updatedAt,  bool isActive,  double totalDistanceMeters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RouteEntity() when $default != null:
return $default(_that.id,_that.name,_that.createdAt,_that.updatedAt,_that.isActive,_that.totalDistanceMeters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  DateTime createdAt,  DateTime updatedAt,  bool isActive,  double totalDistanceMeters)  $default,) {final _that = this;
switch (_that) {
case _RouteEntity():
return $default(_that.id,_that.name,_that.createdAt,_that.updatedAt,_that.isActive,_that.totalDistanceMeters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  DateTime createdAt,  DateTime updatedAt,  bool isActive,  double totalDistanceMeters)?  $default,) {final _that = this;
switch (_that) {
case _RouteEntity() when $default != null:
return $default(_that.id,_that.name,_that.createdAt,_that.updatedAt,_that.isActive,_that.totalDistanceMeters);case _:
  return null;

}
}

}

/// @nodoc


class _RouteEntity implements RouteEntity {
  const _RouteEntity({required this.id, required this.name, required this.createdAt, required this.updatedAt, required this.isActive, required this.totalDistanceMeters});
  

@override final  int id;
@override final  String name;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  bool isActive;
@override final  double totalDistanceMeters;

/// Create a copy of RouteEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RouteEntityCopyWith<_RouteEntity> get copyWith => __$RouteEntityCopyWithImpl<_RouteEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RouteEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.totalDistanceMeters, totalDistanceMeters) || other.totalDistanceMeters == totalDistanceMeters));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,createdAt,updatedAt,isActive,totalDistanceMeters);

@override
String toString() {
  return 'RouteEntity(id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt, isActive: $isActive, totalDistanceMeters: $totalDistanceMeters)';
}


}

/// @nodoc
abstract mixin class _$RouteEntityCopyWith<$Res> implements $RouteEntityCopyWith<$Res> {
  factory _$RouteEntityCopyWith(_RouteEntity value, $Res Function(_RouteEntity) _then) = __$RouteEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, DateTime createdAt, DateTime updatedAt, bool isActive, double totalDistanceMeters
});




}
/// @nodoc
class __$RouteEntityCopyWithImpl<$Res>
    implements _$RouteEntityCopyWith<$Res> {
  __$RouteEntityCopyWithImpl(this._self, this._then);

  final _RouteEntity _self;
  final $Res Function(_RouteEntity) _then;

/// Create a copy of RouteEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? createdAt = null,Object? updatedAt = null,Object? isActive = null,Object? totalDistanceMeters = null,}) {
  return _then(_RouteEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,totalDistanceMeters: null == totalDistanceMeters ? _self.totalDistanceMeters : totalDistanceMeters // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
