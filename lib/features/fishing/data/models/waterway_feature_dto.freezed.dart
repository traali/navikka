// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'waterway_feature_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WaterwayFeatureDto {

 String get id; WaterwayFeatureDtoType get type; String? get name; List<List<LatLng>>? get rings; List<LatLng>? get points; LatLng? get position;
/// Create a copy of WaterwayFeatureDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaterwayFeatureDtoCopyWith<WaterwayFeatureDto> get copyWith => _$WaterwayFeatureDtoCopyWithImpl<WaterwayFeatureDto>(this as WaterwayFeatureDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaterwayFeatureDto&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.rings, rings)&&const DeepCollectionEquality().equals(other.points, points)&&(identical(other.position, position) || other.position == position));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,name,const DeepCollectionEquality().hash(rings),const DeepCollectionEquality().hash(points),position);

@override
String toString() {
  return 'WaterwayFeatureDto(id: $id, type: $type, name: $name, rings: $rings, points: $points, position: $position)';
}


}

/// @nodoc
abstract mixin class $WaterwayFeatureDtoCopyWith<$Res>  {
  factory $WaterwayFeatureDtoCopyWith(WaterwayFeatureDto value, $Res Function(WaterwayFeatureDto) _then) = _$WaterwayFeatureDtoCopyWithImpl;
@useResult
$Res call({
 String id, WaterwayFeatureDtoType type, String? name, List<List<LatLng>>? rings, List<LatLng>? points, LatLng? position
});




}
/// @nodoc
class _$WaterwayFeatureDtoCopyWithImpl<$Res>
    implements $WaterwayFeatureDtoCopyWith<$Res> {
  _$WaterwayFeatureDtoCopyWithImpl(this._self, this._then);

  final WaterwayFeatureDto _self;
  final $Res Function(WaterwayFeatureDto) _then;

/// Create a copy of WaterwayFeatureDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? name = freezed,Object? rings = freezed,Object? points = freezed,Object? position = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as WaterwayFeatureDtoType,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,rings: freezed == rings ? _self.rings : rings // ignore: cast_nullable_to_non_nullable
as List<List<LatLng>>?,points: freezed == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<LatLng>?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LatLng?,
  ));
}

}


/// Adds pattern-matching-related methods to [WaterwayFeatureDto].
extension WaterwayFeatureDtoPatterns on WaterwayFeatureDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WaterwayFeatureDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WaterwayFeatureDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WaterwayFeatureDto value)  $default,){
final _that = this;
switch (_that) {
case _WaterwayFeatureDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WaterwayFeatureDto value)?  $default,){
final _that = this;
switch (_that) {
case _WaterwayFeatureDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  WaterwayFeatureDtoType type,  String? name,  List<List<LatLng>>? rings,  List<LatLng>? points,  LatLng? position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WaterwayFeatureDto() when $default != null:
return $default(_that.id,_that.type,_that.name,_that.rings,_that.points,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  WaterwayFeatureDtoType type,  String? name,  List<List<LatLng>>? rings,  List<LatLng>? points,  LatLng? position)  $default,) {final _that = this;
switch (_that) {
case _WaterwayFeatureDto():
return $default(_that.id,_that.type,_that.name,_that.rings,_that.points,_that.position);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  WaterwayFeatureDtoType type,  String? name,  List<List<LatLng>>? rings,  List<LatLng>? points,  LatLng? position)?  $default,) {final _that = this;
switch (_that) {
case _WaterwayFeatureDto() when $default != null:
return $default(_that.id,_that.type,_that.name,_that.rings,_that.points,_that.position);case _:
  return null;

}
}

}

/// @nodoc


class _WaterwayFeatureDto implements WaterwayFeatureDto {
  const _WaterwayFeatureDto({required this.id, required this.type, this.name, final  List<List<LatLng>>? rings, final  List<LatLng>? points, this.position}): _rings = rings,_points = points;
  

@override final  String id;
@override final  WaterwayFeatureDtoType type;
@override final  String? name;
 final  List<List<LatLng>>? _rings;
@override List<List<LatLng>>? get rings {
  final value = _rings;
  if (value == null) return null;
  if (_rings is EqualUnmodifiableListView) return _rings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<LatLng>? _points;
@override List<LatLng>? get points {
  final value = _points;
  if (value == null) return null;
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  LatLng? position;

/// Create a copy of WaterwayFeatureDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaterwayFeatureDtoCopyWith<_WaterwayFeatureDto> get copyWith => __$WaterwayFeatureDtoCopyWithImpl<_WaterwayFeatureDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaterwayFeatureDto&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._rings, _rings)&&const DeepCollectionEquality().equals(other._points, _points)&&(identical(other.position, position) || other.position == position));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,name,const DeepCollectionEquality().hash(_rings),const DeepCollectionEquality().hash(_points),position);

@override
String toString() {
  return 'WaterwayFeatureDto(id: $id, type: $type, name: $name, rings: $rings, points: $points, position: $position)';
}


}

/// @nodoc
abstract mixin class _$WaterwayFeatureDtoCopyWith<$Res> implements $WaterwayFeatureDtoCopyWith<$Res> {
  factory _$WaterwayFeatureDtoCopyWith(_WaterwayFeatureDto value, $Res Function(_WaterwayFeatureDto) _then) = __$WaterwayFeatureDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, WaterwayFeatureDtoType type, String? name, List<List<LatLng>>? rings, List<LatLng>? points, LatLng? position
});




}
/// @nodoc
class __$WaterwayFeatureDtoCopyWithImpl<$Res>
    implements _$WaterwayFeatureDtoCopyWith<$Res> {
  __$WaterwayFeatureDtoCopyWithImpl(this._self, this._then);

  final _WaterwayFeatureDto _self;
  final $Res Function(_WaterwayFeatureDto) _then;

/// Create a copy of WaterwayFeatureDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? name = freezed,Object? rings = freezed,Object? points = freezed,Object? position = freezed,}) {
  return _then(_WaterwayFeatureDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as WaterwayFeatureDtoType,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,rings: freezed == rings ? _self._rings : rings // ignore: cast_nullable_to_non_nullable
as List<List<LatLng>>?,points: freezed == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<LatLng>?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LatLng?,
  ));
}


}

// dart format on
