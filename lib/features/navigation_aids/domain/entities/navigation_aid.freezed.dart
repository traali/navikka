// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation_aid.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NavigationAid {

/// Unique identifier from Väylävirasto.
 String get id;/// Type of navigation aid.
 NavigationAidType get type;/// Geographic position.
 LatLng get position;/// Human-readable name or designation.
 String? get name;/// Physical mounting type (floating or fixed).
 NavigationAidMounting? get mounting;/// IALA color/shape code (e.g., "RED", "GREEN", "CARDINAL_N").
 String? get ialaCode;/// Light characteristics for illuminated aids (e.g., "Fl(2) 6s").
 String? get lightCharacteristics;/// Light range in nautical miles.
 double? get lightRangeNm;/// Sign type code for traffic signs.
 String? get signTypeCode;/// Sign type description in Finnish.
 String? get signTypeDescription;/// Restriction value (e.g., speed limit in km/h).
 double? get restrictionValue;/// Owner or maintainer organization.
 String? get owner;
/// Create a copy of NavigationAid
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NavigationAidCopyWith<NavigationAid> get copyWith => _$NavigationAidCopyWithImpl<NavigationAid>(this as NavigationAid, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NavigationAid&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.position, position) || other.position == position)&&(identical(other.name, name) || other.name == name)&&(identical(other.mounting, mounting) || other.mounting == mounting)&&(identical(other.ialaCode, ialaCode) || other.ialaCode == ialaCode)&&(identical(other.lightCharacteristics, lightCharacteristics) || other.lightCharacteristics == lightCharacteristics)&&(identical(other.lightRangeNm, lightRangeNm) || other.lightRangeNm == lightRangeNm)&&(identical(other.signTypeCode, signTypeCode) || other.signTypeCode == signTypeCode)&&(identical(other.signTypeDescription, signTypeDescription) || other.signTypeDescription == signTypeDescription)&&(identical(other.restrictionValue, restrictionValue) || other.restrictionValue == restrictionValue)&&(identical(other.owner, owner) || other.owner == owner));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,position,name,mounting,ialaCode,lightCharacteristics,lightRangeNm,signTypeCode,signTypeDescription,restrictionValue,owner);

@override
String toString() {
  return 'NavigationAid(id: $id, type: $type, position: $position, name: $name, mounting: $mounting, ialaCode: $ialaCode, lightCharacteristics: $lightCharacteristics, lightRangeNm: $lightRangeNm, signTypeCode: $signTypeCode, signTypeDescription: $signTypeDescription, restrictionValue: $restrictionValue, owner: $owner)';
}


}

/// @nodoc
abstract mixin class $NavigationAidCopyWith<$Res>  {
  factory $NavigationAidCopyWith(NavigationAid value, $Res Function(NavigationAid) _then) = _$NavigationAidCopyWithImpl;
@useResult
$Res call({
 String id, NavigationAidType type, LatLng position, String? name, NavigationAidMounting? mounting, String? ialaCode, String? lightCharacteristics, double? lightRangeNm, String? signTypeCode, String? signTypeDescription, double? restrictionValue, String? owner
});




}
/// @nodoc
class _$NavigationAidCopyWithImpl<$Res>
    implements $NavigationAidCopyWith<$Res> {
  _$NavigationAidCopyWithImpl(this._self, this._then);

  final NavigationAid _self;
  final $Res Function(NavigationAid) _then;

/// Create a copy of NavigationAid
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? position = null,Object? name = freezed,Object? mounting = freezed,Object? ialaCode = freezed,Object? lightCharacteristics = freezed,Object? lightRangeNm = freezed,Object? signTypeCode = freezed,Object? signTypeDescription = freezed,Object? restrictionValue = freezed,Object? owner = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NavigationAidType,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LatLng,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,mounting: freezed == mounting ? _self.mounting : mounting // ignore: cast_nullable_to_non_nullable
as NavigationAidMounting?,ialaCode: freezed == ialaCode ? _self.ialaCode : ialaCode // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [NavigationAid].
extension NavigationAidPatterns on NavigationAid {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NavigationAid value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NavigationAid() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NavigationAid value)  $default,){
final _that = this;
switch (_that) {
case _NavigationAid():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NavigationAid value)?  $default,){
final _that = this;
switch (_that) {
case _NavigationAid() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  NavigationAidType type,  LatLng position,  String? name,  NavigationAidMounting? mounting,  String? ialaCode,  String? lightCharacteristics,  double? lightRangeNm,  String? signTypeCode,  String? signTypeDescription,  double? restrictionValue,  String? owner)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NavigationAid() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  NavigationAidType type,  LatLng position,  String? name,  NavigationAidMounting? mounting,  String? ialaCode,  String? lightCharacteristics,  double? lightRangeNm,  String? signTypeCode,  String? signTypeDescription,  double? restrictionValue,  String? owner)  $default,) {final _that = this;
switch (_that) {
case _NavigationAid():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  NavigationAidType type,  LatLng position,  String? name,  NavigationAidMounting? mounting,  String? ialaCode,  String? lightCharacteristics,  double? lightRangeNm,  String? signTypeCode,  String? signTypeDescription,  double? restrictionValue,  String? owner)?  $default,) {final _that = this;
switch (_that) {
case _NavigationAid() when $default != null:
return $default(_that.id,_that.type,_that.position,_that.name,_that.mounting,_that.ialaCode,_that.lightCharacteristics,_that.lightRangeNm,_that.signTypeCode,_that.signTypeDescription,_that.restrictionValue,_that.owner);case _:
  return null;

}
}

}

/// @nodoc


class _NavigationAid extends NavigationAid {
  const _NavigationAid({required this.id, required this.type, required this.position, this.name, this.mounting, this.ialaCode, this.lightCharacteristics, this.lightRangeNm, this.signTypeCode, this.signTypeDescription, this.restrictionValue, this.owner}): super._();
  

/// Unique identifier from Väylävirasto.
@override final  String id;
/// Type of navigation aid.
@override final  NavigationAidType type;
/// Geographic position.
@override final  LatLng position;
/// Human-readable name or designation.
@override final  String? name;
/// Physical mounting type (floating or fixed).
@override final  NavigationAidMounting? mounting;
/// IALA color/shape code (e.g., "RED", "GREEN", "CARDINAL_N").
@override final  String? ialaCode;
/// Light characteristics for illuminated aids (e.g., "Fl(2) 6s").
@override final  String? lightCharacteristics;
/// Light range in nautical miles.
@override final  double? lightRangeNm;
/// Sign type code for traffic signs.
@override final  String? signTypeCode;
/// Sign type description in Finnish.
@override final  String? signTypeDescription;
/// Restriction value (e.g., speed limit in km/h).
@override final  double? restrictionValue;
/// Owner or maintainer organization.
@override final  String? owner;

/// Create a copy of NavigationAid
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NavigationAidCopyWith<_NavigationAid> get copyWith => __$NavigationAidCopyWithImpl<_NavigationAid>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NavigationAid&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.position, position) || other.position == position)&&(identical(other.name, name) || other.name == name)&&(identical(other.mounting, mounting) || other.mounting == mounting)&&(identical(other.ialaCode, ialaCode) || other.ialaCode == ialaCode)&&(identical(other.lightCharacteristics, lightCharacteristics) || other.lightCharacteristics == lightCharacteristics)&&(identical(other.lightRangeNm, lightRangeNm) || other.lightRangeNm == lightRangeNm)&&(identical(other.signTypeCode, signTypeCode) || other.signTypeCode == signTypeCode)&&(identical(other.signTypeDescription, signTypeDescription) || other.signTypeDescription == signTypeDescription)&&(identical(other.restrictionValue, restrictionValue) || other.restrictionValue == restrictionValue)&&(identical(other.owner, owner) || other.owner == owner));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,position,name,mounting,ialaCode,lightCharacteristics,lightRangeNm,signTypeCode,signTypeDescription,restrictionValue,owner);

@override
String toString() {
  return 'NavigationAid(id: $id, type: $type, position: $position, name: $name, mounting: $mounting, ialaCode: $ialaCode, lightCharacteristics: $lightCharacteristics, lightRangeNm: $lightRangeNm, signTypeCode: $signTypeCode, signTypeDescription: $signTypeDescription, restrictionValue: $restrictionValue, owner: $owner)';
}


}

/// @nodoc
abstract mixin class _$NavigationAidCopyWith<$Res> implements $NavigationAidCopyWith<$Res> {
  factory _$NavigationAidCopyWith(_NavigationAid value, $Res Function(_NavigationAid) _then) = __$NavigationAidCopyWithImpl;
@override @useResult
$Res call({
 String id, NavigationAidType type, LatLng position, String? name, NavigationAidMounting? mounting, String? ialaCode, String? lightCharacteristics, double? lightRangeNm, String? signTypeCode, String? signTypeDescription, double? restrictionValue, String? owner
});




}
/// @nodoc
class __$NavigationAidCopyWithImpl<$Res>
    implements _$NavigationAidCopyWith<$Res> {
  __$NavigationAidCopyWithImpl(this._self, this._then);

  final _NavigationAid _self;
  final $Res Function(_NavigationAid) _then;

/// Create a copy of NavigationAid
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? position = null,Object? name = freezed,Object? mounting = freezed,Object? ialaCode = freezed,Object? lightCharacteristics = freezed,Object? lightRangeNm = freezed,Object? signTypeCode = freezed,Object? signTypeDescription = freezed,Object? restrictionValue = freezed,Object? owner = freezed,}) {
  return _then(_NavigationAid(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NavigationAidType,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LatLng,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,mounting: freezed == mounting ? _self.mounting : mounting // ignore: cast_nullable_to_non_nullable
as NavigationAidMounting?,ialaCode: freezed == ialaCode ? _self.ialaCode : ialaCode // ignore: cast_nullable_to_non_nullable
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
