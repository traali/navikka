// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'algae_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AlgaeData {

 DateTime get observationTime; LatLng get location; String? get speciesName; double? get biomass; int? get cellCount; String? get dominantSpecies; AlgaeRiskLevel? get riskLevel;
/// Create a copy of AlgaeData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlgaeDataCopyWith<AlgaeData> get copyWith => _$AlgaeDataCopyWithImpl<AlgaeData>(this as AlgaeData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlgaeData&&(identical(other.observationTime, observationTime) || other.observationTime == observationTime)&&(identical(other.location, location) || other.location == location)&&(identical(other.speciesName, speciesName) || other.speciesName == speciesName)&&(identical(other.biomass, biomass) || other.biomass == biomass)&&(identical(other.cellCount, cellCount) || other.cellCount == cellCount)&&(identical(other.dominantSpecies, dominantSpecies) || other.dominantSpecies == dominantSpecies)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel));
}


@override
int get hashCode => Object.hash(runtimeType,observationTime,location,speciesName,biomass,cellCount,dominantSpecies,riskLevel);

@override
String toString() {
  return 'AlgaeData(observationTime: $observationTime, location: $location, speciesName: $speciesName, biomass: $biomass, cellCount: $cellCount, dominantSpecies: $dominantSpecies, riskLevel: $riskLevel)';
}


}

/// @nodoc
abstract mixin class $AlgaeDataCopyWith<$Res>  {
  factory $AlgaeDataCopyWith(AlgaeData value, $Res Function(AlgaeData) _then) = _$AlgaeDataCopyWithImpl;
@useResult
$Res call({
 DateTime observationTime, LatLng location, String? speciesName, double? biomass, int? cellCount, String? dominantSpecies, AlgaeRiskLevel? riskLevel
});




}
/// @nodoc
class _$AlgaeDataCopyWithImpl<$Res>
    implements $AlgaeDataCopyWith<$Res> {
  _$AlgaeDataCopyWithImpl(this._self, this._then);

  final AlgaeData _self;
  final $Res Function(AlgaeData) _then;

/// Create a copy of AlgaeData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? observationTime = null,Object? location = null,Object? speciesName = freezed,Object? biomass = freezed,Object? cellCount = freezed,Object? dominantSpecies = freezed,Object? riskLevel = freezed,}) {
  return _then(_self.copyWith(
observationTime: null == observationTime ? _self.observationTime : observationTime // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,speciesName: freezed == speciesName ? _self.speciesName : speciesName // ignore: cast_nullable_to_non_nullable
as String?,biomass: freezed == biomass ? _self.biomass : biomass // ignore: cast_nullable_to_non_nullable
as double?,cellCount: freezed == cellCount ? _self.cellCount : cellCount // ignore: cast_nullable_to_non_nullable
as int?,dominantSpecies: freezed == dominantSpecies ? _self.dominantSpecies : dominantSpecies // ignore: cast_nullable_to_non_nullable
as String?,riskLevel: freezed == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as AlgaeRiskLevel?,
  ));
}

}


/// Adds pattern-matching-related methods to [AlgaeData].
extension AlgaeDataPatterns on AlgaeData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlgaeData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlgaeData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlgaeData value)  $default,){
final _that = this;
switch (_that) {
case _AlgaeData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlgaeData value)?  $default,){
final _that = this;
switch (_that) {
case _AlgaeData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime observationTime,  LatLng location,  String? speciesName,  double? biomass,  int? cellCount,  String? dominantSpecies,  AlgaeRiskLevel? riskLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlgaeData() when $default != null:
return $default(_that.observationTime,_that.location,_that.speciesName,_that.biomass,_that.cellCount,_that.dominantSpecies,_that.riskLevel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime observationTime,  LatLng location,  String? speciesName,  double? biomass,  int? cellCount,  String? dominantSpecies,  AlgaeRiskLevel? riskLevel)  $default,) {final _that = this;
switch (_that) {
case _AlgaeData():
return $default(_that.observationTime,_that.location,_that.speciesName,_that.biomass,_that.cellCount,_that.dominantSpecies,_that.riskLevel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime observationTime,  LatLng location,  String? speciesName,  double? biomass,  int? cellCount,  String? dominantSpecies,  AlgaeRiskLevel? riskLevel)?  $default,) {final _that = this;
switch (_that) {
case _AlgaeData() when $default != null:
return $default(_that.observationTime,_that.location,_that.speciesName,_that.biomass,_that.cellCount,_that.dominantSpecies,_that.riskLevel);case _:
  return null;

}
}

}

/// @nodoc


class _AlgaeData implements AlgaeData {
  const _AlgaeData({required this.observationTime, required this.location, this.speciesName, this.biomass, this.cellCount, this.dominantSpecies, this.riskLevel});
  

@override final  DateTime observationTime;
@override final  LatLng location;
@override final  String? speciesName;
@override final  double? biomass;
@override final  int? cellCount;
@override final  String? dominantSpecies;
@override final  AlgaeRiskLevel? riskLevel;

/// Create a copy of AlgaeData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlgaeDataCopyWith<_AlgaeData> get copyWith => __$AlgaeDataCopyWithImpl<_AlgaeData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlgaeData&&(identical(other.observationTime, observationTime) || other.observationTime == observationTime)&&(identical(other.location, location) || other.location == location)&&(identical(other.speciesName, speciesName) || other.speciesName == speciesName)&&(identical(other.biomass, biomass) || other.biomass == biomass)&&(identical(other.cellCount, cellCount) || other.cellCount == cellCount)&&(identical(other.dominantSpecies, dominantSpecies) || other.dominantSpecies == dominantSpecies)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel));
}


@override
int get hashCode => Object.hash(runtimeType,observationTime,location,speciesName,biomass,cellCount,dominantSpecies,riskLevel);

@override
String toString() {
  return 'AlgaeData(observationTime: $observationTime, location: $location, speciesName: $speciesName, biomass: $biomass, cellCount: $cellCount, dominantSpecies: $dominantSpecies, riskLevel: $riskLevel)';
}


}

/// @nodoc
abstract mixin class _$AlgaeDataCopyWith<$Res> implements $AlgaeDataCopyWith<$Res> {
  factory _$AlgaeDataCopyWith(_AlgaeData value, $Res Function(_AlgaeData) _then) = __$AlgaeDataCopyWithImpl;
@override @useResult
$Res call({
 DateTime observationTime, LatLng location, String? speciesName, double? biomass, int? cellCount, String? dominantSpecies, AlgaeRiskLevel? riskLevel
});




}
/// @nodoc
class __$AlgaeDataCopyWithImpl<$Res>
    implements _$AlgaeDataCopyWith<$Res> {
  __$AlgaeDataCopyWithImpl(this._self, this._then);

  final _AlgaeData _self;
  final $Res Function(_AlgaeData) _then;

/// Create a copy of AlgaeData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? observationTime = null,Object? location = null,Object? speciesName = freezed,Object? biomass = freezed,Object? cellCount = freezed,Object? dominantSpecies = freezed,Object? riskLevel = freezed,}) {
  return _then(_AlgaeData(
observationTime: null == observationTime ? _self.observationTime : observationTime // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,speciesName: freezed == speciesName ? _self.speciesName : speciesName // ignore: cast_nullable_to_non_nullable
as String?,biomass: freezed == biomass ? _self.biomass : biomass // ignore: cast_nullable_to_non_nullable
as double?,cellCount: freezed == cellCount ? _self.cellCount : cellCount // ignore: cast_nullable_to_non_nullable
as int?,dominantSpecies: freezed == dominantSpecies ? _self.dominantSpecies : dominantSpecies // ignore: cast_nullable_to_non_nullable
as String?,riskLevel: freezed == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as AlgaeRiskLevel?,
  ));
}


}

// dart format on
