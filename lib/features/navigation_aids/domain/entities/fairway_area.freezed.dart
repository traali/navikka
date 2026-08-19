// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fairway_area.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FairwayArea {

/// Unique identifier from Väylävirasto.
 String get id;/// Polygon rings defining the fairway area geometry.
/// First ring is exterior, subsequent rings are holes.
 List<List<LatLng>> get rings;/// Human-readable name of the fairway.
 String? get name;/// Navigation depth in meters (kulkusyvyys).
 double? get navigationDepth;/// Verified swept depth in meters (haraussyvyys).
 double? get sweptDepth;/// Quality class of the depth data.
 String? get qualityClass;/// Fairway type classification.
 String? get fairwayType;/// Current status (e.g., active, planned).
 String? get status;/// Buoyage system used (IALA A/B).
 String? get buoyageSystem;/// Bounding box of the fairway area for fast viewport filtering.
 LatLngBounds? get bounds;
/// Create a copy of FairwayArea
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FairwayAreaCopyWith<FairwayArea> get copyWith => _$FairwayAreaCopyWithImpl<FairwayArea>(this as FairwayArea, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FairwayArea&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.rings, rings)&&(identical(other.name, name) || other.name == name)&&(identical(other.navigationDepth, navigationDepth) || other.navigationDepth == navigationDepth)&&(identical(other.sweptDepth, sweptDepth) || other.sweptDepth == sweptDepth)&&(identical(other.qualityClass, qualityClass) || other.qualityClass == qualityClass)&&(identical(other.fairwayType, fairwayType) || other.fairwayType == fairwayType)&&(identical(other.status, status) || other.status == status)&&(identical(other.buoyageSystem, buoyageSystem) || other.buoyageSystem == buoyageSystem)&&(identical(other.bounds, bounds) || other.bounds == bounds));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(rings),name,navigationDepth,sweptDepth,qualityClass,fairwayType,status,buoyageSystem,bounds);

@override
String toString() {
  return 'FairwayArea(id: $id, rings: $rings, name: $name, navigationDepth: $navigationDepth, sweptDepth: $sweptDepth, qualityClass: $qualityClass, fairwayType: $fairwayType, status: $status, buoyageSystem: $buoyageSystem, bounds: $bounds)';
}


}

/// @nodoc
abstract mixin class $FairwayAreaCopyWith<$Res>  {
  factory $FairwayAreaCopyWith(FairwayArea value, $Res Function(FairwayArea) _then) = _$FairwayAreaCopyWithImpl;
@useResult
$Res call({
 String id, List<List<LatLng>> rings, String? name, double? navigationDepth, double? sweptDepth, String? qualityClass, String? fairwayType, String? status, String? buoyageSystem, LatLngBounds? bounds
});




}
/// @nodoc
class _$FairwayAreaCopyWithImpl<$Res>
    implements $FairwayAreaCopyWith<$Res> {
  _$FairwayAreaCopyWithImpl(this._self, this._then);

  final FairwayArea _self;
  final $Res Function(FairwayArea) _then;

/// Create a copy of FairwayArea
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? rings = null,Object? name = freezed,Object? navigationDepth = freezed,Object? sweptDepth = freezed,Object? qualityClass = freezed,Object? fairwayType = freezed,Object? status = freezed,Object? buoyageSystem = freezed,Object? bounds = freezed,}) {
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
as String?,bounds: freezed == bounds ? _self.bounds : bounds // ignore: cast_nullable_to_non_nullable
as LatLngBounds?,
  ));
}

}


/// Adds pattern-matching-related methods to [FairwayArea].
extension FairwayAreaPatterns on FairwayArea {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FairwayArea value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FairwayArea() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FairwayArea value)  $default,){
final _that = this;
switch (_that) {
case _FairwayArea():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FairwayArea value)?  $default,){
final _that = this;
switch (_that) {
case _FairwayArea() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  List<List<LatLng>> rings,  String? name,  double? navigationDepth,  double? sweptDepth,  String? qualityClass,  String? fairwayType,  String? status,  String? buoyageSystem,  LatLngBounds? bounds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FairwayArea() when $default != null:
return $default(_that.id,_that.rings,_that.name,_that.navigationDepth,_that.sweptDepth,_that.qualityClass,_that.fairwayType,_that.status,_that.buoyageSystem,_that.bounds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  List<List<LatLng>> rings,  String? name,  double? navigationDepth,  double? sweptDepth,  String? qualityClass,  String? fairwayType,  String? status,  String? buoyageSystem,  LatLngBounds? bounds)  $default,) {final _that = this;
switch (_that) {
case _FairwayArea():
return $default(_that.id,_that.rings,_that.name,_that.navigationDepth,_that.sweptDepth,_that.qualityClass,_that.fairwayType,_that.status,_that.buoyageSystem,_that.bounds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  List<List<LatLng>> rings,  String? name,  double? navigationDepth,  double? sweptDepth,  String? qualityClass,  String? fairwayType,  String? status,  String? buoyageSystem,  LatLngBounds? bounds)?  $default,) {final _that = this;
switch (_that) {
case _FairwayArea() when $default != null:
return $default(_that.id,_that.rings,_that.name,_that.navigationDepth,_that.sweptDepth,_that.qualityClass,_that.fairwayType,_that.status,_that.buoyageSystem,_that.bounds);case _:
  return null;

}
}

}

/// @nodoc


class _FairwayArea implements FairwayArea {
  const _FairwayArea({required this.id, required final  List<List<LatLng>> rings, this.name, this.navigationDepth, this.sweptDepth, this.qualityClass, this.fairwayType, this.status, this.buoyageSystem, this.bounds}): _rings = rings;
  

/// Unique identifier from Väylävirasto.
@override final  String id;
/// Polygon rings defining the fairway area geometry.
/// First ring is exterior, subsequent rings are holes.
 final  List<List<LatLng>> _rings;
/// Polygon rings defining the fairway area geometry.
/// First ring is exterior, subsequent rings are holes.
@override List<List<LatLng>> get rings {
  if (_rings is EqualUnmodifiableListView) return _rings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rings);
}

/// Human-readable name of the fairway.
@override final  String? name;
/// Navigation depth in meters (kulkusyvyys).
@override final  double? navigationDepth;
/// Verified swept depth in meters (haraussyvyys).
@override final  double? sweptDepth;
/// Quality class of the depth data.
@override final  String? qualityClass;
/// Fairway type classification.
@override final  String? fairwayType;
/// Current status (e.g., active, planned).
@override final  String? status;
/// Buoyage system used (IALA A/B).
@override final  String? buoyageSystem;
/// Bounding box of the fairway area for fast viewport filtering.
@override final  LatLngBounds? bounds;

/// Create a copy of FairwayArea
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FairwayAreaCopyWith<_FairwayArea> get copyWith => __$FairwayAreaCopyWithImpl<_FairwayArea>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FairwayArea&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._rings, _rings)&&(identical(other.name, name) || other.name == name)&&(identical(other.navigationDepth, navigationDepth) || other.navigationDepth == navigationDepth)&&(identical(other.sweptDepth, sweptDepth) || other.sweptDepth == sweptDepth)&&(identical(other.qualityClass, qualityClass) || other.qualityClass == qualityClass)&&(identical(other.fairwayType, fairwayType) || other.fairwayType == fairwayType)&&(identical(other.status, status) || other.status == status)&&(identical(other.buoyageSystem, buoyageSystem) || other.buoyageSystem == buoyageSystem)&&(identical(other.bounds, bounds) || other.bounds == bounds));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_rings),name,navigationDepth,sweptDepth,qualityClass,fairwayType,status,buoyageSystem,bounds);

@override
String toString() {
  return 'FairwayArea(id: $id, rings: $rings, name: $name, navigationDepth: $navigationDepth, sweptDepth: $sweptDepth, qualityClass: $qualityClass, fairwayType: $fairwayType, status: $status, buoyageSystem: $buoyageSystem, bounds: $bounds)';
}


}

/// @nodoc
abstract mixin class _$FairwayAreaCopyWith<$Res> implements $FairwayAreaCopyWith<$Res> {
  factory _$FairwayAreaCopyWith(_FairwayArea value, $Res Function(_FairwayArea) _then) = __$FairwayAreaCopyWithImpl;
@override @useResult
$Res call({
 String id, List<List<LatLng>> rings, String? name, double? navigationDepth, double? sweptDepth, String? qualityClass, String? fairwayType, String? status, String? buoyageSystem, LatLngBounds? bounds
});




}
/// @nodoc
class __$FairwayAreaCopyWithImpl<$Res>
    implements _$FairwayAreaCopyWith<$Res> {
  __$FairwayAreaCopyWithImpl(this._self, this._then);

  final _FairwayArea _self;
  final $Res Function(_FairwayArea) _then;

/// Create a copy of FairwayArea
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? rings = null,Object? name = freezed,Object? navigationDepth = freezed,Object? sweptDepth = freezed,Object? qualityClass = freezed,Object? fairwayType = freezed,Object? status = freezed,Object? buoyageSystem = freezed,Object? bounds = freezed,}) {
  return _then(_FairwayArea(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,rings: null == rings ? _self._rings : rings // ignore: cast_nullable_to_non_nullable
as List<List<LatLng>>,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,navigationDepth: freezed == navigationDepth ? _self.navigationDepth : navigationDepth // ignore: cast_nullable_to_non_nullable
as double?,sweptDepth: freezed == sweptDepth ? _self.sweptDepth : sweptDepth // ignore: cast_nullable_to_non_nullable
as double?,qualityClass: freezed == qualityClass ? _self.qualityClass : qualityClass // ignore: cast_nullable_to_non_nullable
as String?,fairwayType: freezed == fairwayType ? _self.fairwayType : fairwayType // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,buoyageSystem: freezed == buoyageSystem ? _self.buoyageSystem : buoyageSystem // ignore: cast_nullable_to_non_nullable
as String?,bounds: freezed == bounds ? _self.bounds : bounds // ignore: cast_nullable_to_non_nullable
as LatLngBounds?,
  ));
}


}

// dart format on
