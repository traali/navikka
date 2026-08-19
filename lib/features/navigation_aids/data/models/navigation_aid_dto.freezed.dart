// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation_aid_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NavigationAidDto {

 String get id; NavigationAidTypeDto get type; LatLng get position; String? get name; NavigationAidMountingDto? get mounting; String? get ialaCode; String? get lightCharacteristics; double? get lightRangeNm; String? get signTypeCode; String? get signTypeDescription; double? get restrictionValue; String? get owner;
/// Create a copy of NavigationAidDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NavigationAidDtoCopyWith<NavigationAidDto> get copyWith => _$NavigationAidDtoCopyWithImpl<NavigationAidDto>(this as NavigationAidDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NavigationAidDto&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.position, position) || other.position == position)&&(identical(other.name, name) || other.name == name)&&(identical(other.mounting, mounting) || other.mounting == mounting)&&(identical(other.ialaCode, ialaCode) || other.ialaCode == ialaCode)&&(identical(other.lightCharacteristics, lightCharacteristics) || other.lightCharacteristics == lightCharacteristics)&&(identical(other.lightRangeNm, lightRangeNm) || other.lightRangeNm == lightRangeNm)&&(identical(other.signTypeCode, signTypeCode) || other.signTypeCode == signTypeCode)&&(identical(other.signTypeDescription, signTypeDescription) || other.signTypeDescription == signTypeDescription)&&(identical(other.restrictionValue, restrictionValue) || other.restrictionValue == restrictionValue)&&(identical(other.owner, owner) || other.owner == owner));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,position,name,mounting,ialaCode,lightCharacteristics,lightRangeNm,signTypeCode,signTypeDescription,restrictionValue,owner);

@override
String toString() {
  return 'NavigationAidDto(id: $id, type: $type, position: $position, name: $name, mounting: $mounting, ialaCode: $ialaCode, lightCharacteristics: $lightCharacteristics, lightRangeNm: $lightRangeNm, signTypeCode: $signTypeCode, signTypeDescription: $signTypeDescription, restrictionValue: $restrictionValue, owner: $owner)';
}


}

/// @nodoc
abstract mixin class $NavigationAidDtoCopyWith<$Res>  {
  factory $NavigationAidDtoCopyWith(NavigationAidDto value, $Res Function(NavigationAidDto) _then) = _$NavigationAidDtoCopyWithImpl;
@useResult
$Res call({
 String id, NavigationAidTypeDto type, LatLng position, String? name, NavigationAidMountingDto? mounting, String? ialaCode, String? lightCharacteristics, double? lightRangeNm, String? signTypeCode, String? signTypeDescription, double? restrictionValue, String? owner
});




}
/// @nodoc
class _$NavigationAidDtoCopyWithImpl<$Res>
    implements $NavigationAidDtoCopyWith<$Res> {
  _$NavigationAidDtoCopyWithImpl(this._self, this._then);

  final NavigationAidDto _self;
  final $Res Function(NavigationAidDto) _then;

/// Create a copy of NavigationAidDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? position = null,Object? name = freezed,Object? mounting = freezed,Object? ialaCode = freezed,Object? lightCharacteristics = freezed,Object? lightRangeNm = freezed,Object? signTypeCode = freezed,Object? signTypeDescription = freezed,Object? restrictionValue = freezed,Object? owner = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NavigationAidTypeDto,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LatLng,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,mounting: freezed == mounting ? _self.mounting : mounting // ignore: cast_nullable_to_non_nullable
as NavigationAidMountingDto?,ialaCode: freezed == ialaCode ? _self.ialaCode : ialaCode // ignore: cast_nullable_to_non_nullable
as String?,lightCharacteristics: freezed == lightCharacteristics ? _self.lightCharacteristics : lightCharacteristics // ignore: cast_nullable_to_non_nullable
as String?,lightRangeNm: freezed == lightRangeNm ? _self.lightRangeNm : lightRangeNm // ignore: cast_nullable_to_non_nullable
as double?,signTypeCode: freezed == signTypeCode ? _self.signTypeCode : signTypeCode // ignore: cast_nullable_to_non_nullable
as String?,signTypeDescription: freezed == signTypeDescription ? _self.signTypeDescription : signTypeDescription // ignore: cast_nullable_to_non_nullable
as String?,restrictionValue: freezed == restrictionValue ? _self.restrictionValue : restrictionValue // ignore: cast_nullable_to_non_nullable
as double?,owner: freezed == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NavigationAidDto].
extension NavigationAidDtoPatterns on NavigationAidDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NavigationAidDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NavigationAidDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NavigationAidDto value)  $default,){
final _that = this;
switch (_that) {
case _NavigationAidDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NavigationAidDto value)?  $default,){
final _that = this;
switch (_that) {
case _NavigationAidDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  NavigationAidTypeDto type,  LatLng position,  String? name,  NavigationAidMountingDto? mounting,  String? ialaCode,  String? lightCharacteristics,  double? lightRangeNm,  String? signTypeCode,  String? signTypeDescription,  double? restrictionValue,  String? owner)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NavigationAidDto() when $default != null:
return $default(_that.id,_that.type,_that.position,_that.name,_that.mounting,_that.ialaCode,_that.lightCharacteristics,_that.lightRangeNm,_that.signTypeCode,_that.signTypeDescription,_that.restrictionValue,_that.owner);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  NavigationAidTypeDto type,  LatLng position,  String? name,  NavigationAidMountingDto? mounting,  String? ialaCode,  String? lightCharacteristics,  double? lightRangeNm,  String? signTypeCode,  String? signTypeDescription,  double? restrictionValue,  String? owner)  $default,) {final _that = this;
switch (_that) {
case _NavigationAidDto():
return $default(_that.id,_that.type,_that.position,_that.name,_that.mounting,_that.ialaCode,_that.lightCharacteristics,_that.lightRangeNm,_that.signTypeCode,_that.signTypeDescription,_that.restrictionValue,_that.owner);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  NavigationAidTypeDto type,  LatLng position,  String? name,  NavigationAidMountingDto? mounting,  String? ialaCode,  String? lightCharacteristics,  double? lightRangeNm,  String? signTypeCode,  String? signTypeDescription,  double? restrictionValue,  String? owner)?  $default,) {final _that = this;
switch (_that) {
case _NavigationAidDto() when $default != null:
return $default(_that.id,_that.type,_that.position,_that.name,_that.mounting,_that.ialaCode,_that.lightCharacteristics,_that.lightRangeNm,_that.signTypeCode,_that.signTypeDescription,_that.restrictionValue,_that.owner);case _:
  return null;

}
}

}

/// @nodoc


class _NavigationAidDto implements NavigationAidDto {
  const _NavigationAidDto({required this.id, required this.type, required this.position, this.name, this.mounting, this.ialaCode, this.lightCharacteristics, this.lightRangeNm, this.signTypeCode, this.signTypeDescription, this.restrictionValue, this.owner});
  

@override final  String id;
@override final  NavigationAidTypeDto type;
@override final  LatLng position;
@override final  String? name;
@override final  NavigationAidMountingDto? mounting;
@override final  String? ialaCode;
@override final  String? lightCharacteristics;
@override final  double? lightRangeNm;
@override final  String? signTypeCode;
@override final  String? signTypeDescription;
@override final  double? restrictionValue;
@override final  String? owner;

/// Create a copy of NavigationAidDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NavigationAidDtoCopyWith<_NavigationAidDto> get copyWith => __$NavigationAidDtoCopyWithImpl<_NavigationAidDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NavigationAidDto&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.position, position) || other.position == position)&&(identical(other.name, name) || other.name == name)&&(identical(other.mounting, mounting) || other.mounting == mounting)&&(identical(other.ialaCode, ialaCode) || other.ialaCode == ialaCode)&&(identical(other.lightCharacteristics, lightCharacteristics) || other.lightCharacteristics == lightCharacteristics)&&(identical(other.lightRangeNm, lightRangeNm) || other.lightRangeNm == lightRangeNm)&&(identical(other.signTypeCode, signTypeCode) || other.signTypeCode == signTypeCode)&&(identical(other.signTypeDescription, signTypeDescription) || other.signTypeDescription == signTypeDescription)&&(identical(other.restrictionValue, restrictionValue) || other.restrictionValue == restrictionValue)&&(identical(other.owner, owner) || other.owner == owner));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,position,name,mounting,ialaCode,lightCharacteristics,lightRangeNm,signTypeCode,signTypeDescription,restrictionValue,owner);

@override
String toString() {
  return 'NavigationAidDto(id: $id, type: $type, position: $position, name: $name, mounting: $mounting, ialaCode: $ialaCode, lightCharacteristics: $lightCharacteristics, lightRangeNm: $lightRangeNm, signTypeCode: $signTypeCode, signTypeDescription: $signTypeDescription, restrictionValue: $restrictionValue, owner: $owner)';
}


}

/// @nodoc
abstract mixin class _$NavigationAidDtoCopyWith<$Res> implements $NavigationAidDtoCopyWith<$Res> {
  factory _$NavigationAidDtoCopyWith(_NavigationAidDto value, $Res Function(_NavigationAidDto) _then) = __$NavigationAidDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, NavigationAidTypeDto type, LatLng position, String? name, NavigationAidMountingDto? mounting, String? ialaCode, String? lightCharacteristics, double? lightRangeNm, String? signTypeCode, String? signTypeDescription, double? restrictionValue, String? owner
});




}
/// @nodoc
class __$NavigationAidDtoCopyWithImpl<$Res>
    implements _$NavigationAidDtoCopyWith<$Res> {
  __$NavigationAidDtoCopyWithImpl(this._self, this._then);

  final _NavigationAidDto _self;
  final $Res Function(_NavigationAidDto) _then;

/// Create a copy of NavigationAidDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? position = null,Object? name = freezed,Object? mounting = freezed,Object? ialaCode = freezed,Object? lightCharacteristics = freezed,Object? lightRangeNm = freezed,Object? signTypeCode = freezed,Object? signTypeDescription = freezed,Object? restrictionValue = freezed,Object? owner = freezed,}) {
  return _then(_NavigationAidDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NavigationAidTypeDto,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LatLng,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,mounting: freezed == mounting ? _self.mounting : mounting // ignore: cast_nullable_to_non_nullable
as NavigationAidMountingDto?,ialaCode: freezed == ialaCode ? _self.ialaCode : ialaCode // ignore: cast_nullable_to_non_nullable
as String?,lightCharacteristics: freezed == lightCharacteristics ? _self.lightCharacteristics : lightCharacteristics // ignore: cast_nullable_to_non_nullable
as String?,lightRangeNm: freezed == lightRangeNm ? _self.lightRangeNm : lightRangeNm // ignore: cast_nullable_to_non_nullable
as double?,signTypeCode: freezed == signTypeCode ? _self.signTypeCode : signTypeCode // ignore: cast_nullable_to_non_nullable
as String?,signTypeDescription: freezed == signTypeDescription ? _self.signTypeDescription : signTypeDescription // ignore: cast_nullable_to_non_nullable
as String?,restrictionValue: freezed == restrictionValue ? _self.restrictionValue : restrictionValue // ignore: cast_nullable_to_non_nullable
as double?,owner: freezed == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
