// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fishing_restriction_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FishingRestrictionDto {

 String get id; String get title; List<List<LatLng>> get rings; String? get type; String? get description; String? get validity;
/// Create a copy of FishingRestrictionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FishingRestrictionDtoCopyWith<FishingRestrictionDto> get copyWith => _$FishingRestrictionDtoCopyWithImpl<FishingRestrictionDto>(this as FishingRestrictionDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FishingRestrictionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.rings, rings)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.validity, validity) || other.validity == validity));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(rings),type,description,validity);

@override
String toString() {
  return 'FishingRestrictionDto(id: $id, title: $title, rings: $rings, type: $type, description: $description, validity: $validity)';
}


}

/// @nodoc
abstract mixin class $FishingRestrictionDtoCopyWith<$Res>  {
  factory $FishingRestrictionDtoCopyWith(FishingRestrictionDto value, $Res Function(FishingRestrictionDto) _then) = _$FishingRestrictionDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, List<List<LatLng>> rings, String? type, String? description, String? validity
});




}
/// @nodoc
class _$FishingRestrictionDtoCopyWithImpl<$Res>
    implements $FishingRestrictionDtoCopyWith<$Res> {
  _$FishingRestrictionDtoCopyWithImpl(this._self, this._then);

  final FishingRestrictionDto _self;
  final $Res Function(FishingRestrictionDto) _then;

/// Create a copy of FishingRestrictionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? rings = null,Object? type = freezed,Object? description = freezed,Object? validity = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,rings: null == rings ? _self.rings : rings // ignore: cast_nullable_to_non_nullable
as List<List<LatLng>>,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,validity: freezed == validity ? _self.validity : validity // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FishingRestrictionDto].
extension FishingRestrictionDtoPatterns on FishingRestrictionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FishingRestrictionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FishingRestrictionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FishingRestrictionDto value)  $default,){
final _that = this;
switch (_that) {
case _FishingRestrictionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FishingRestrictionDto value)?  $default,){
final _that = this;
switch (_that) {
case _FishingRestrictionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  List<List<LatLng>> rings,  String? type,  String? description,  String? validity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FishingRestrictionDto() when $default != null:
return $default(_that.id,_that.title,_that.rings,_that.type,_that.description,_that.validity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  List<List<LatLng>> rings,  String? type,  String? description,  String? validity)  $default,) {final _that = this;
switch (_that) {
case _FishingRestrictionDto():
return $default(_that.id,_that.title,_that.rings,_that.type,_that.description,_that.validity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  List<List<LatLng>> rings,  String? type,  String? description,  String? validity)?  $default,) {final _that = this;
switch (_that) {
case _FishingRestrictionDto() when $default != null:
return $default(_that.id,_that.title,_that.rings,_that.type,_that.description,_that.validity);case _:
  return null;

}
}

}

/// @nodoc


class _FishingRestrictionDto implements FishingRestrictionDto {
  const _FishingRestrictionDto({required this.id, required this.title, required final  List<List<LatLng>> rings, this.type, this.description, this.validity}): _rings = rings;
  

@override final  String id;
@override final  String title;
 final  List<List<LatLng>> _rings;
@override List<List<LatLng>> get rings {
  if (_rings is EqualUnmodifiableListView) return _rings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rings);
}

@override final  String? type;
@override final  String? description;
@override final  String? validity;

/// Create a copy of FishingRestrictionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FishingRestrictionDtoCopyWith<_FishingRestrictionDto> get copyWith => __$FishingRestrictionDtoCopyWithImpl<_FishingRestrictionDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FishingRestrictionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._rings, _rings)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.validity, validity) || other.validity == validity));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_rings),type,description,validity);

@override
String toString() {
  return 'FishingRestrictionDto(id: $id, title: $title, rings: $rings, type: $type, description: $description, validity: $validity)';
}


}

/// @nodoc
abstract mixin class _$FishingRestrictionDtoCopyWith<$Res> implements $FishingRestrictionDtoCopyWith<$Res> {
  factory _$FishingRestrictionDtoCopyWith(_FishingRestrictionDto value, $Res Function(_FishingRestrictionDto) _then) = __$FishingRestrictionDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, List<List<LatLng>> rings, String? type, String? description, String? validity
});




}
/// @nodoc
class __$FishingRestrictionDtoCopyWithImpl<$Res>
    implements _$FishingRestrictionDtoCopyWith<$Res> {
  __$FishingRestrictionDtoCopyWithImpl(this._self, this._then);

  final _FishingRestrictionDto _self;
  final $Res Function(_FishingRestrictionDto) _then;

/// Create a copy of FishingRestrictionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? rings = null,Object? type = freezed,Object? description = freezed,Object? validity = freezed,}) {
  return _then(_FishingRestrictionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,rings: null == rings ? _self._rings : rings // ignore: cast_nullable_to_non_nullable
as List<List<LatLng>>,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,validity: freezed == validity ? _self.validity : validity // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
