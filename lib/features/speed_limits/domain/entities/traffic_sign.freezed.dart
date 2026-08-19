// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'traffic_sign.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrafficSign {

 String get id; String get typeName; LatLng get position; double? get value; String get text; String get direction;
/// Create a copy of TrafficSign
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrafficSignCopyWith<TrafficSign> get copyWith => _$TrafficSignCopyWithImpl<TrafficSign>(this as TrafficSign, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrafficSign&&(identical(other.id, id) || other.id == id)&&(identical(other.typeName, typeName) || other.typeName == typeName)&&(identical(other.position, position) || other.position == position)&&(identical(other.value, value) || other.value == value)&&(identical(other.text, text) || other.text == text)&&(identical(other.direction, direction) || other.direction == direction));
}


@override
int get hashCode => Object.hash(runtimeType,id,typeName,position,value,text,direction);

@override
String toString() {
  return 'TrafficSign(id: $id, typeName: $typeName, position: $position, value: $value, text: $text, direction: $direction)';
}


}

/// @nodoc
abstract mixin class $TrafficSignCopyWith<$Res>  {
  factory $TrafficSignCopyWith(TrafficSign value, $Res Function(TrafficSign) _then) = _$TrafficSignCopyWithImpl;
@useResult
$Res call({
 String id, String typeName, LatLng position, double? value, String text, String direction
});




}
/// @nodoc
class _$TrafficSignCopyWithImpl<$Res>
    implements $TrafficSignCopyWith<$Res> {
  _$TrafficSignCopyWithImpl(this._self, this._then);

  final TrafficSign _self;
  final $Res Function(TrafficSign) _then;

/// Create a copy of TrafficSign
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? typeName = null,Object? position = null,Object? value = freezed,Object? text = null,Object? direction = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,typeName: null == typeName ? _self.typeName : typeName // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LatLng,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TrafficSign].
extension TrafficSignPatterns on TrafficSign {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrafficSign value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrafficSign() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrafficSign value)  $default,){
final _that = this;
switch (_that) {
case _TrafficSign():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrafficSign value)?  $default,){
final _that = this;
switch (_that) {
case _TrafficSign() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String typeName,  LatLng position,  double? value,  String text,  String direction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrafficSign() when $default != null:
return $default(_that.id,_that.typeName,_that.position,_that.value,_that.text,_that.direction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String typeName,  LatLng position,  double? value,  String text,  String direction)  $default,) {final _that = this;
switch (_that) {
case _TrafficSign():
return $default(_that.id,_that.typeName,_that.position,_that.value,_that.text,_that.direction);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String typeName,  LatLng position,  double? value,  String text,  String direction)?  $default,) {final _that = this;
switch (_that) {
case _TrafficSign() when $default != null:
return $default(_that.id,_that.typeName,_that.position,_that.value,_that.text,_that.direction);case _:
  return null;

}
}

}

/// @nodoc


class _TrafficSign implements TrafficSign {
  const _TrafficSign({required this.id, required this.typeName, required this.position, this.value, this.text = '', this.direction = ''});
  

@override final  String id;
@override final  String typeName;
@override final  LatLng position;
@override final  double? value;
@override@JsonKey() final  String text;
@override@JsonKey() final  String direction;

/// Create a copy of TrafficSign
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrafficSignCopyWith<_TrafficSign> get copyWith => __$TrafficSignCopyWithImpl<_TrafficSign>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrafficSign&&(identical(other.id, id) || other.id == id)&&(identical(other.typeName, typeName) || other.typeName == typeName)&&(identical(other.position, position) || other.position == position)&&(identical(other.value, value) || other.value == value)&&(identical(other.text, text) || other.text == text)&&(identical(other.direction, direction) || other.direction == direction));
}


@override
int get hashCode => Object.hash(runtimeType,id,typeName,position,value,text,direction);

@override
String toString() {
  return 'TrafficSign(id: $id, typeName: $typeName, position: $position, value: $value, text: $text, direction: $direction)';
}


}

/// @nodoc
abstract mixin class _$TrafficSignCopyWith<$Res> implements $TrafficSignCopyWith<$Res> {
  factory _$TrafficSignCopyWith(_TrafficSign value, $Res Function(_TrafficSign) _then) = __$TrafficSignCopyWithImpl;
@override @useResult
$Res call({
 String id, String typeName, LatLng position, double? value, String text, String direction
});




}
/// @nodoc
class __$TrafficSignCopyWithImpl<$Res>
    implements _$TrafficSignCopyWith<$Res> {
  __$TrafficSignCopyWithImpl(this._self, this._then);

  final _TrafficSign _self;
  final $Res Function(_TrafficSign) _then;

/// Create a copy of TrafficSign
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? typeName = null,Object? position = null,Object? value = freezed,Object? text = null,Object? direction = null,}) {
  return _then(_TrafficSign(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,typeName: null == typeName ? _self.typeName : typeName // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LatLng,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
