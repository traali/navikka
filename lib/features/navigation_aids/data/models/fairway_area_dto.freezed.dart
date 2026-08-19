// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fairway_area_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FairwayAreaDto {

 String get id; List<List<LatLng>> get rings; String? get name; double? get navigationDepth; double? get sweptDepth; String? get qualityClass; String? get fairwayType; String? get status; String? get buoyageSystem;
/// Create a copy of FairwayAreaDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FairwayAreaDtoCopyWith<FairwayAreaDto> get copyWith => _$FairwayAreaDtoCopyWithImpl<FairwayAreaDto>(this as FairwayAreaDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FairwayAreaDto&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.rings, rings)&&(identical(other.name, name) || other.name == name)&&(identical(other.navigationDepth, navigationDepth) || other.navigationDepth == navigationDepth)&&(identical(other.sweptDepth, sweptDepth) || other.sweptDepth == sweptDepth)&&(identical(other.qualityClass, qualityClass) || other.qualityClass == qualityClass)&&(identical(other.fairwayType, fairwayType) || other.fairwayType == fairwayType)&&(identical(other.status, status) || other.status == status)&&(identical(other.buoyageSystem, buoyageSystem) || other.buoyageSystem == buoyageSystem));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(rings),name,navigationDepth,sweptDepth,qualityClass,fairwayType,status,buoyageSystem);

@override
String toString() {
  return 'FairwayAreaDto(id: $id, rings: $rings, name: $name, navigationDepth: $navigationDepth, sweptDepth: $sweptDepth, qualityClass: $qualityClass, fairwayType: $fairwayType, status: $status, buoyageSystem: $buoyageSystem)';
}


}

/// @nodoc
abstract mixin class $FairwayAreaDtoCopyWith<$Res>  {
  factory $FairwayAreaDtoCopyWith(FairwayAreaDto value, $Res Function(FairwayAreaDto) _then) = _$FairwayAreaDtoCopyWithImpl;
@useResult
$Res call({
 String id, List<List<LatLng>> rings, String? name, double? navigationDepth, double? sweptDepth, String? qualityClass, String? fairwayType, String? status, String? buoyageSystem
});




}
/// @nodoc
class _$FairwayAreaDtoCopyWithImpl<$Res>
    implements $FairwayAreaDtoCopyWith<$Res> {
  _$FairwayAreaDtoCopyWithImpl(this._self, this._then);

  final FairwayAreaDto _self;
  final $Res Function(FairwayAreaDto) _then;

/// Create a copy of FairwayAreaDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? rings = null,Object? name = freezed,Object? navigationDepth = freezed,Object? sweptDepth = freezed,Object? qualityClass = freezed,Object? fairwayType = freezed,Object? status = freezed,Object? buoyageSystem = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,rings: null == rings ? _self.rings : rings // ignore: cast_nullable_to_non_nullable
as List<List<LatLng>>,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,navigationDepth: freezed == navigationDepth ? _self.navigationDepth : navigationDepth // ignore: cast_nullable_to_non_nullable
as double?,sweptDepth: freezed == sweptDepth ? _self.sweptDepth : sweptDepth // ignore: cast_nullable_to_non_nullable
as double?,qualityClass: freezed == qualityClass ? _self.qualityClass : qualityClass // ignore: cast_nullable_to_non_nullable
as String?,fairwayType: freezed == fairwayType ? _self.fairwayType : fairwayType // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,buoyageSystem: freezed == buoyageSystem ? _self.buoyageSystem : buoyageSystem // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FairwayAreaDto].
extension FairwayAreaDtoPatterns on FairwayAreaDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FairwayAreaDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FairwayAreaDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FairwayAreaDto value)  $default,){
final _that = this;
switch (_that) {
case _FairwayAreaDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FairwayAreaDto value)?  $default,){
final _that = this;
switch (_that) {
case _FairwayAreaDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  List<List<LatLng>> rings,  String? name,  double? navigationDepth,  double? sweptDepth,  String? qualityClass,  String? fairwayType,  String? status,  String? buoyageSystem)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FairwayAreaDto() when $default != null:
return $default(_that.id,_that.rings,_that.name,_that.navigationDepth,_that.sweptDepth,_that.qualityClass,_that.fairwayType,_that.status,_that.buoyageSystem);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  List<List<LatLng>> rings,  String? name,  double? navigationDepth,  double? sweptDepth,  String? qualityClass,  String? fairwayType,  String? status,  String? buoyageSystem)  $default,) {final _that = this;
switch (_that) {
case _FairwayAreaDto():
return $default(_that.id,_that.rings,_that.name,_that.navigationDepth,_that.sweptDepth,_that.qualityClass,_that.fairwayType,_that.status,_that.buoyageSystem);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  List<List<LatLng>> rings,  String? name,  double? navigationDepth,  double? sweptDepth,  String? qualityClass,  String? fairwayType,  String? status,  String? buoyageSystem)?  $default,) {final _that = this;
switch (_that) {
case _FairwayAreaDto() when $default != null:
return $default(_that.id,_that.rings,_that.name,_that.navigationDepth,_that.sweptDepth,_that.qualityClass,_that.fairwayType,_that.status,_that.buoyageSystem);case _:
  return null;

}
}

}

/// @nodoc


class _FairwayAreaDto implements FairwayAreaDto {
  const _FairwayAreaDto({required this.id, required final  List<List<LatLng>> rings, this.name, this.navigationDepth, this.sweptDepth, this.qualityClass, this.fairwayType, this.status, this.buoyageSystem}): _rings = rings;
  

@override final  String id;
 final  List<List<LatLng>> _rings;
@override List<List<LatLng>> get rings {
  if (_rings is EqualUnmodifiableListView) return _rings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rings);
}

@override final  String? name;
@override final  double? navigationDepth;
@override final  double? sweptDepth;
@override final  String? qualityClass;
@override final  String? fairwayType;
@override final  String? status;
@override final  String? buoyageSystem;

/// Create a copy of FairwayAreaDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FairwayAreaDtoCopyWith<_FairwayAreaDto> get copyWith => __$FairwayAreaDtoCopyWithImpl<_FairwayAreaDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FairwayAreaDto&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._rings, _rings)&&(identical(other.name, name) || other.name == name)&&(identical(other.navigationDepth, navigationDepth) || other.navigationDepth == navigationDepth)&&(identical(other.sweptDepth, sweptDepth) || other.sweptDepth == sweptDepth)&&(identical(other.qualityClass, qualityClass) || other.qualityClass == qualityClass)&&(identical(other.fairwayType, fairwayType) || other.fairwayType == fairwayType)&&(identical(other.status, status) || other.status == status)&&(identical(other.buoyageSystem, buoyageSystem) || other.buoyageSystem == buoyageSystem));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_rings),name,navigationDepth,sweptDepth,qualityClass,fairwayType,status,buoyageSystem);

@override
String toString() {
  return 'FairwayAreaDto(id: $id, rings: $rings, name: $name, navigationDepth: $navigationDepth, sweptDepth: $sweptDepth, qualityClass: $qualityClass, fairwayType: $fairwayType, status: $status, buoyageSystem: $buoyageSystem)';
}


}

/// @nodoc
abstract mixin class _$FairwayAreaDtoCopyWith<$Res> implements $FairwayAreaDtoCopyWith<$Res> {
  factory _$FairwayAreaDtoCopyWith(_FairwayAreaDto value, $Res Function(_FairwayAreaDto) _then) = __$FairwayAreaDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, List<List<LatLng>> rings, String? name, double? navigationDepth, double? sweptDepth, String? qualityClass, String? fairwayType, String? status, String? buoyageSystem
});




}
/// @nodoc
class __$FairwayAreaDtoCopyWithImpl<$Res>
    implements _$FairwayAreaDtoCopyWith<$Res> {
  __$FairwayAreaDtoCopyWithImpl(this._self, this._then);

  final _FairwayAreaDto _self;
  final $Res Function(_FairwayAreaDto) _then;

/// Create a copy of FairwayAreaDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? rings = null,Object? name = freezed,Object? navigationDepth = freezed,Object? sweptDepth = freezed,Object? qualityClass = freezed,Object? fairwayType = freezed,Object? status = freezed,Object? buoyageSystem = freezed,}) {
  return _then(_FairwayAreaDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,rings: null == rings ? _self._rings : rings // ignore: cast_nullable_to_non_nullable
as List<List<LatLng>>,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,navigationDepth: freezed == navigationDepth ? _self.navigationDepth : navigationDepth // ignore: cast_nullable_to_non_nullable
as double?,sweptDepth: freezed == sweptDepth ? _self.sweptDepth : sweptDepth // ignore: cast_nullable_to_non_nullable
as double?,qualityClass: freezed == qualityClass ? _self.qualityClass : qualityClass // ignore: cast_nullable_to_non_nullable
as String?,fairwayType: freezed == fairwayType ? _self.fairwayType : fairwayType // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,buoyageSystem: freezed == buoyageSystem ? _self.buoyageSystem : buoyageSystem // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
