// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catch_size.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CatchSize {

/// The species this regulation applies to.
 FishSpecies get species;/// Minimum length in centimeters to keep the catch.
 double get minimumSizeCm;/// Maximum length in centimeters (optional, e.g. for trophy fish protection).
 double? get maximumSizeCm;/// Whether the species is currently under seasonal protection.
 bool get isProtected;/// Optional region name if the regulation is location-specific (e.g. "Saimaa").
 String? get region;/// Start date of the seasonal protection period (optional).
 DateTime? get protectionStartDate;/// End date of the seasonal protection period (optional).
 DateTime? get protectionEndDate;
/// Create a copy of CatchSize
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatchSizeCopyWith<CatchSize> get copyWith => _$CatchSizeCopyWithImpl<CatchSize>(this as CatchSize, _$identity);

  /// Serializes this CatchSize to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatchSize&&(identical(other.species, species) || other.species == species)&&(identical(other.minimumSizeCm, minimumSizeCm) || other.minimumSizeCm == minimumSizeCm)&&(identical(other.maximumSizeCm, maximumSizeCm) || other.maximumSizeCm == maximumSizeCm)&&(identical(other.isProtected, isProtected) || other.isProtected == isProtected)&&(identical(other.region, region) || other.region == region)&&(identical(other.protectionStartDate, protectionStartDate) || other.protectionStartDate == protectionStartDate)&&(identical(other.protectionEndDate, protectionEndDate) || other.protectionEndDate == protectionEndDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,species,minimumSizeCm,maximumSizeCm,isProtected,region,protectionStartDate,protectionEndDate);

@override
String toString() {
  return 'CatchSize(species: $species, minimumSizeCm: $minimumSizeCm, maximumSizeCm: $maximumSizeCm, isProtected: $isProtected, region: $region, protectionStartDate: $protectionStartDate, protectionEndDate: $protectionEndDate)';
}


}

/// @nodoc
abstract mixin class $CatchSizeCopyWith<$Res>  {
  factory $CatchSizeCopyWith(CatchSize value, $Res Function(CatchSize) _then) = _$CatchSizeCopyWithImpl;
@useResult
$Res call({
 FishSpecies species, double minimumSizeCm, double? maximumSizeCm, bool isProtected, String? region, DateTime? protectionStartDate, DateTime? protectionEndDate
});




}
/// @nodoc
class _$CatchSizeCopyWithImpl<$Res>
    implements $CatchSizeCopyWith<$Res> {
  _$CatchSizeCopyWithImpl(this._self, this._then);

  final CatchSize _self;
  final $Res Function(CatchSize) _then;

/// Create a copy of CatchSize
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? species = null,Object? minimumSizeCm = null,Object? maximumSizeCm = freezed,Object? isProtected = null,Object? region = freezed,Object? protectionStartDate = freezed,Object? protectionEndDate = freezed,}) {
  return _then(_self.copyWith(
species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as FishSpecies,minimumSizeCm: null == minimumSizeCm ? _self.minimumSizeCm : minimumSizeCm // ignore: cast_nullable_to_non_nullable
as double,maximumSizeCm: freezed == maximumSizeCm ? _self.maximumSizeCm : maximumSizeCm // ignore: cast_nullable_to_non_nullable
as double?,isProtected: null == isProtected ? _self.isProtected : isProtected // ignore: cast_nullable_to_non_nullable
as bool,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,protectionStartDate: freezed == protectionStartDate ? _self.protectionStartDate : protectionStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,protectionEndDate: freezed == protectionEndDate ? _self.protectionEndDate : protectionEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CatchSize].
extension CatchSizePatterns on CatchSize {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatchSize value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatchSize() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatchSize value)  $default,){
final _that = this;
switch (_that) {
case _CatchSize():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatchSize value)?  $default,){
final _that = this;
switch (_that) {
case _CatchSize() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FishSpecies species,  double minimumSizeCm,  double? maximumSizeCm,  bool isProtected,  String? region,  DateTime? protectionStartDate,  DateTime? protectionEndDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatchSize() when $default != null:
return $default(_that.species,_that.minimumSizeCm,_that.maximumSizeCm,_that.isProtected,_that.region,_that.protectionStartDate,_that.protectionEndDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FishSpecies species,  double minimumSizeCm,  double? maximumSizeCm,  bool isProtected,  String? region,  DateTime? protectionStartDate,  DateTime? protectionEndDate)  $default,) {final _that = this;
switch (_that) {
case _CatchSize():
return $default(_that.species,_that.minimumSizeCm,_that.maximumSizeCm,_that.isProtected,_that.region,_that.protectionStartDate,_that.protectionEndDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FishSpecies species,  double minimumSizeCm,  double? maximumSizeCm,  bool isProtected,  String? region,  DateTime? protectionStartDate,  DateTime? protectionEndDate)?  $default,) {final _that = this;
switch (_that) {
case _CatchSize() when $default != null:
return $default(_that.species,_that.minimumSizeCm,_that.maximumSizeCm,_that.isProtected,_that.region,_that.protectionStartDate,_that.protectionEndDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatchSize implements CatchSize {
  const _CatchSize({required this.species, required this.minimumSizeCm, this.maximumSizeCm, this.isProtected = false, this.region, this.protectionStartDate, this.protectionEndDate});
  factory _CatchSize.fromJson(Map<String, dynamic> json) => _$CatchSizeFromJson(json);

/// The species this regulation applies to.
@override final  FishSpecies species;
/// Minimum length in centimeters to keep the catch.
@override final  double minimumSizeCm;
/// Maximum length in centimeters (optional, e.g. for trophy fish protection).
@override final  double? maximumSizeCm;
/// Whether the species is currently under seasonal protection.
@override@JsonKey() final  bool isProtected;
/// Optional region name if the regulation is location-specific (e.g. "Saimaa").
@override final  String? region;
/// Start date of the seasonal protection period (optional).
@override final  DateTime? protectionStartDate;
/// End date of the seasonal protection period (optional).
@override final  DateTime? protectionEndDate;

/// Create a copy of CatchSize
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatchSizeCopyWith<_CatchSize> get copyWith => __$CatchSizeCopyWithImpl<_CatchSize>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatchSizeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatchSize&&(identical(other.species, species) || other.species == species)&&(identical(other.minimumSizeCm, minimumSizeCm) || other.minimumSizeCm == minimumSizeCm)&&(identical(other.maximumSizeCm, maximumSizeCm) || other.maximumSizeCm == maximumSizeCm)&&(identical(other.isProtected, isProtected) || other.isProtected == isProtected)&&(identical(other.region, region) || other.region == region)&&(identical(other.protectionStartDate, protectionStartDate) || other.protectionStartDate == protectionStartDate)&&(identical(other.protectionEndDate, protectionEndDate) || other.protectionEndDate == protectionEndDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,species,minimumSizeCm,maximumSizeCm,isProtected,region,protectionStartDate,protectionEndDate);

@override
String toString() {
  return 'CatchSize(species: $species, minimumSizeCm: $minimumSizeCm, maximumSizeCm: $maximumSizeCm, isProtected: $isProtected, region: $region, protectionStartDate: $protectionStartDate, protectionEndDate: $protectionEndDate)';
}


}

/// @nodoc
abstract mixin class _$CatchSizeCopyWith<$Res> implements $CatchSizeCopyWith<$Res> {
  factory _$CatchSizeCopyWith(_CatchSize value, $Res Function(_CatchSize) _then) = __$CatchSizeCopyWithImpl;
@override @useResult
$Res call({
 FishSpecies species, double minimumSizeCm, double? maximumSizeCm, bool isProtected, String? region, DateTime? protectionStartDate, DateTime? protectionEndDate
});




}
/// @nodoc
class __$CatchSizeCopyWithImpl<$Res>
    implements _$CatchSizeCopyWith<$Res> {
  __$CatchSizeCopyWithImpl(this._self, this._then);

  final _CatchSize _self;
  final $Res Function(_CatchSize) _then;

/// Create a copy of CatchSize
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? species = null,Object? minimumSizeCm = null,Object? maximumSizeCm = freezed,Object? isProtected = null,Object? region = freezed,Object? protectionStartDate = freezed,Object? protectionEndDate = freezed,}) {
  return _then(_CatchSize(
species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as FishSpecies,minimumSizeCm: null == minimumSizeCm ? _self.minimumSizeCm : minimumSizeCm // ignore: cast_nullable_to_non_nullable
as double,maximumSizeCm: freezed == maximumSizeCm ? _self.maximumSizeCm : maximumSizeCm // ignore: cast_nullable_to_non_nullable
as double?,isProtected: null == isProtected ? _self.isProtected : isProtected // ignore: cast_nullable_to_non_nullable
as bool,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,protectionStartDate: freezed == protectionStartDate ? _self.protectionStartDate : protectionStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,protectionEndDate: freezed == protectionEndDate ? _self.protectionEndDate : protectionEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
