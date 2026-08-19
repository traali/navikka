// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'algae_report_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AlgaeReportDto {

 DateTime get timestamp;@LatLngConverter() LatLng get location; String? get speciesName; double? get biomass; int? get cellCount; String? get dominantSpecies; AlgaeRiskLevelDto? get riskLevel;
/// Create a copy of AlgaeReportDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlgaeReportDtoCopyWith<AlgaeReportDto> get copyWith => _$AlgaeReportDtoCopyWithImpl<AlgaeReportDto>(this as AlgaeReportDto, _$identity);

  /// Serializes this AlgaeReportDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlgaeReportDto&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.speciesName, speciesName) || other.speciesName == speciesName)&&(identical(other.biomass, biomass) || other.biomass == biomass)&&(identical(other.cellCount, cellCount) || other.cellCount == cellCount)&&(identical(other.dominantSpecies, dominantSpecies) || other.dominantSpecies == dominantSpecies)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timestamp,location,speciesName,biomass,cellCount,dominantSpecies,riskLevel);

@override
String toString() {
  return 'AlgaeReportDto(timestamp: $timestamp, location: $location, speciesName: $speciesName, biomass: $biomass, cellCount: $cellCount, dominantSpecies: $dominantSpecies, riskLevel: $riskLevel)';
}


}

/// @nodoc
abstract mixin class $AlgaeReportDtoCopyWith<$Res>  {
  factory $AlgaeReportDtoCopyWith(AlgaeReportDto value, $Res Function(AlgaeReportDto) _then) = _$AlgaeReportDtoCopyWithImpl;
@useResult
$Res call({
 DateTime timestamp,@LatLngConverter() LatLng location, String? speciesName, double? biomass, int? cellCount, String? dominantSpecies, AlgaeRiskLevelDto? riskLevel
});




}
/// @nodoc
class _$AlgaeReportDtoCopyWithImpl<$Res>
    implements $AlgaeReportDtoCopyWith<$Res> {
  _$AlgaeReportDtoCopyWithImpl(this._self, this._then);

  final AlgaeReportDto _self;
  final $Res Function(AlgaeReportDto) _then;

/// Create a copy of AlgaeReportDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timestamp = null,Object? location = null,Object? speciesName = freezed,Object? biomass = freezed,Object? cellCount = freezed,Object? dominantSpecies = freezed,Object? riskLevel = freezed,}) {
  return _then(_self.copyWith(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,speciesName: freezed == speciesName ? _self.speciesName : speciesName // ignore: cast_nullable_to_non_nullable
as String?,biomass: freezed == biomass ? _self.biomass : biomass // ignore: cast_nullable_to_non_nullable
as double?,cellCount: freezed == cellCount ? _self.cellCount : cellCount // ignore: cast_nullable_to_non_nullable
as int?,dominantSpecies: freezed == dominantSpecies ? _self.dominantSpecies : dominantSpecies // ignore: cast_nullable_to_non_nullable
as String?,riskLevel: freezed == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as AlgaeRiskLevelDto?,
  ));
}

}


/// Adds pattern-matching-related methods to [AlgaeReportDto].
extension AlgaeReportDtoPatterns on AlgaeReportDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlgaeReportDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlgaeReportDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlgaeReportDto value)  $default,){
final _that = this;
switch (_that) {
case _AlgaeReportDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlgaeReportDto value)?  $default,){
final _that = this;
switch (_that) {
case _AlgaeReportDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime timestamp, @LatLngConverter()  LatLng location,  String? speciesName,  double? biomass,  int? cellCount,  String? dominantSpecies,  AlgaeRiskLevelDto? riskLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlgaeReportDto() when $default != null:
return $default(_that.timestamp,_that.location,_that.speciesName,_that.biomass,_that.cellCount,_that.dominantSpecies,_that.riskLevel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime timestamp, @LatLngConverter()  LatLng location,  String? speciesName,  double? biomass,  int? cellCount,  String? dominantSpecies,  AlgaeRiskLevelDto? riskLevel)  $default,) {final _that = this;
switch (_that) {
case _AlgaeReportDto():
return $default(_that.timestamp,_that.location,_that.speciesName,_that.biomass,_that.cellCount,_that.dominantSpecies,_that.riskLevel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime timestamp, @LatLngConverter()  LatLng location,  String? speciesName,  double? biomass,  int? cellCount,  String? dominantSpecies,  AlgaeRiskLevelDto? riskLevel)?  $default,) {final _that = this;
switch (_that) {
case _AlgaeReportDto() when $default != null:
return $default(_that.timestamp,_that.location,_that.speciesName,_that.biomass,_that.cellCount,_that.dominantSpecies,_that.riskLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AlgaeReportDto implements AlgaeReportDto {
  const _AlgaeReportDto({required this.timestamp, @LatLngConverter() required this.location, this.speciesName, this.biomass, this.cellCount, this.dominantSpecies, this.riskLevel});
  factory _AlgaeReportDto.fromJson(Map<String, dynamic> json) => _$AlgaeReportDtoFromJson(json);

@override final  DateTime timestamp;
@override@LatLngConverter() final  LatLng location;
@override final  String? speciesName;
@override final  double? biomass;
@override final  int? cellCount;
@override final  String? dominantSpecies;
@override final  AlgaeRiskLevelDto? riskLevel;

/// Create a copy of AlgaeReportDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlgaeReportDtoCopyWith<_AlgaeReportDto> get copyWith => __$AlgaeReportDtoCopyWithImpl<_AlgaeReportDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlgaeReportDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlgaeReportDto&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.speciesName, speciesName) || other.speciesName == speciesName)&&(identical(other.biomass, biomass) || other.biomass == biomass)&&(identical(other.cellCount, cellCount) || other.cellCount == cellCount)&&(identical(other.dominantSpecies, dominantSpecies) || other.dominantSpecies == dominantSpecies)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timestamp,location,speciesName,biomass,cellCount,dominantSpecies,riskLevel);

@override
String toString() {
  return 'AlgaeReportDto(timestamp: $timestamp, location: $location, speciesName: $speciesName, biomass: $biomass, cellCount: $cellCount, dominantSpecies: $dominantSpecies, riskLevel: $riskLevel)';
}


}

/// @nodoc
abstract mixin class _$AlgaeReportDtoCopyWith<$Res> implements $AlgaeReportDtoCopyWith<$Res> {
  factory _$AlgaeReportDtoCopyWith(_AlgaeReportDto value, $Res Function(_AlgaeReportDto) _then) = __$AlgaeReportDtoCopyWithImpl;
@override @useResult
$Res call({
 DateTime timestamp,@LatLngConverter() LatLng location, String? speciesName, double? biomass, int? cellCount, String? dominantSpecies, AlgaeRiskLevelDto? riskLevel
});




}
/// @nodoc
class __$AlgaeReportDtoCopyWithImpl<$Res>
    implements _$AlgaeReportDtoCopyWith<$Res> {
  __$AlgaeReportDtoCopyWithImpl(this._self, this._then);

  final _AlgaeReportDto _self;
  final $Res Function(_AlgaeReportDto) _then;

/// Create a copy of AlgaeReportDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timestamp = null,Object? location = null,Object? speciesName = freezed,Object? biomass = freezed,Object? cellCount = freezed,Object? dominantSpecies = freezed,Object? riskLevel = freezed,}) {
  return _then(_AlgaeReportDto(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,speciesName: freezed == speciesName ? _self.speciesName : speciesName // ignore: cast_nullable_to_non_nullable
as String?,biomass: freezed == biomass ? _self.biomass : biomass // ignore: cast_nullable_to_non_nullable
as double?,cellCount: freezed == cellCount ? _self.cellCount : cellCount // ignore: cast_nullable_to_non_nullable
as int?,dominantSpecies: freezed == dominantSpecies ? _self.dominantSpecies : dominantSpecies // ignore: cast_nullable_to_non_nullable
as String?,riskLevel: freezed == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as AlgaeRiskLevelDto?,
  ));
}


}


/// @nodoc
mixin _$AlgaeForecastDto {

 DateTime get forecastDate; double get centerLat; double get centerLon; double? get probability; String? get season;
/// Create a copy of AlgaeForecastDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlgaeForecastDtoCopyWith<AlgaeForecastDto> get copyWith => _$AlgaeForecastDtoCopyWithImpl<AlgaeForecastDto>(this as AlgaeForecastDto, _$identity);

  /// Serializes this AlgaeForecastDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlgaeForecastDto&&(identical(other.forecastDate, forecastDate) || other.forecastDate == forecastDate)&&(identical(other.centerLat, centerLat) || other.centerLat == centerLat)&&(identical(other.centerLon, centerLon) || other.centerLon == centerLon)&&(identical(other.probability, probability) || other.probability == probability)&&(identical(other.season, season) || other.season == season));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,forecastDate,centerLat,centerLon,probability,season);

@override
String toString() {
  return 'AlgaeForecastDto(forecastDate: $forecastDate, centerLat: $centerLat, centerLon: $centerLon, probability: $probability, season: $season)';
}


}

/// @nodoc
abstract mixin class $AlgaeForecastDtoCopyWith<$Res>  {
  factory $AlgaeForecastDtoCopyWith(AlgaeForecastDto value, $Res Function(AlgaeForecastDto) _then) = _$AlgaeForecastDtoCopyWithImpl;
@useResult
$Res call({
 DateTime forecastDate, double centerLat, double centerLon, double? probability, String? season
});




}
/// @nodoc
class _$AlgaeForecastDtoCopyWithImpl<$Res>
    implements $AlgaeForecastDtoCopyWith<$Res> {
  _$AlgaeForecastDtoCopyWithImpl(this._self, this._then);

  final AlgaeForecastDto _self;
  final $Res Function(AlgaeForecastDto) _then;

/// Create a copy of AlgaeForecastDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? forecastDate = null,Object? centerLat = null,Object? centerLon = null,Object? probability = freezed,Object? season = freezed,}) {
  return _then(_self.copyWith(
forecastDate: null == forecastDate ? _self.forecastDate : forecastDate // ignore: cast_nullable_to_non_nullable
as DateTime,centerLat: null == centerLat ? _self.centerLat : centerLat // ignore: cast_nullable_to_non_nullable
as double,centerLon: null == centerLon ? _self.centerLon : centerLon // ignore: cast_nullable_to_non_nullable
as double,probability: freezed == probability ? _self.probability : probability // ignore: cast_nullable_to_non_nullable
as double?,season: freezed == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AlgaeForecastDto].
extension AlgaeForecastDtoPatterns on AlgaeForecastDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlgaeForecastDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlgaeForecastDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlgaeForecastDto value)  $default,){
final _that = this;
switch (_that) {
case _AlgaeForecastDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlgaeForecastDto value)?  $default,){
final _that = this;
switch (_that) {
case _AlgaeForecastDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime forecastDate,  double centerLat,  double centerLon,  double? probability,  String? season)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlgaeForecastDto() when $default != null:
return $default(_that.forecastDate,_that.centerLat,_that.centerLon,_that.probability,_that.season);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime forecastDate,  double centerLat,  double centerLon,  double? probability,  String? season)  $default,) {final _that = this;
switch (_that) {
case _AlgaeForecastDto():
return $default(_that.forecastDate,_that.centerLat,_that.centerLon,_that.probability,_that.season);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime forecastDate,  double centerLat,  double centerLon,  double? probability,  String? season)?  $default,) {final _that = this;
switch (_that) {
case _AlgaeForecastDto() when $default != null:
return $default(_that.forecastDate,_that.centerLat,_that.centerLon,_that.probability,_that.season);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AlgaeForecastDto implements AlgaeForecastDto {
  const _AlgaeForecastDto({required this.forecastDate, required this.centerLat, required this.centerLon, this.probability, this.season});
  factory _AlgaeForecastDto.fromJson(Map<String, dynamic> json) => _$AlgaeForecastDtoFromJson(json);

@override final  DateTime forecastDate;
@override final  double centerLat;
@override final  double centerLon;
@override final  double? probability;
@override final  String? season;

/// Create a copy of AlgaeForecastDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlgaeForecastDtoCopyWith<_AlgaeForecastDto> get copyWith => __$AlgaeForecastDtoCopyWithImpl<_AlgaeForecastDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlgaeForecastDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlgaeForecastDto&&(identical(other.forecastDate, forecastDate) || other.forecastDate == forecastDate)&&(identical(other.centerLat, centerLat) || other.centerLat == centerLat)&&(identical(other.centerLon, centerLon) || other.centerLon == centerLon)&&(identical(other.probability, probability) || other.probability == probability)&&(identical(other.season, season) || other.season == season));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,forecastDate,centerLat,centerLon,probability,season);

@override
String toString() {
  return 'AlgaeForecastDto(forecastDate: $forecastDate, centerLat: $centerLat, centerLon: $centerLon, probability: $probability, season: $season)';
}


}

/// @nodoc
abstract mixin class _$AlgaeForecastDtoCopyWith<$Res> implements $AlgaeForecastDtoCopyWith<$Res> {
  factory _$AlgaeForecastDtoCopyWith(_AlgaeForecastDto value, $Res Function(_AlgaeForecastDto) _then) = __$AlgaeForecastDtoCopyWithImpl;
@override @useResult
$Res call({
 DateTime forecastDate, double centerLat, double centerLon, double? probability, String? season
});




}
/// @nodoc
class __$AlgaeForecastDtoCopyWithImpl<$Res>
    implements _$AlgaeForecastDtoCopyWith<$Res> {
  __$AlgaeForecastDtoCopyWithImpl(this._self, this._then);

  final _AlgaeForecastDto _self;
  final $Res Function(_AlgaeForecastDto) _then;

/// Create a copy of AlgaeForecastDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? forecastDate = null,Object? centerLat = null,Object? centerLon = null,Object? probability = freezed,Object? season = freezed,}) {
  return _then(_AlgaeForecastDto(
forecastDate: null == forecastDate ? _self.forecastDate : forecastDate // ignore: cast_nullable_to_non_nullable
as DateTime,centerLat: null == centerLat ? _self.centerLat : centerLat // ignore: cast_nullable_to_non_nullable
as double,centerLon: null == centerLon ? _self.centerLon : centerLon // ignore: cast_nullable_to_non_nullable
as double,probability: freezed == probability ? _self.probability : probability // ignore: cast_nullable_to_non_nullable
as double?,season: freezed == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
