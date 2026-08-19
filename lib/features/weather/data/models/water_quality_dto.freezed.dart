// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'water_quality_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WaterQualityDto {

 DateTime get timestamp;@LatLngConverter() LatLng get location; String get stationName; double? get dissolvedOxygen; double? get pH; double? get chlorophyllA; double? get turbidity;
/// Create a copy of WaterQualityDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaterQualityDtoCopyWith<WaterQualityDto> get copyWith => _$WaterQualityDtoCopyWithImpl<WaterQualityDto>(this as WaterQualityDto, _$identity);

  /// Serializes this WaterQualityDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaterQualityDto&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.stationName, stationName) || other.stationName == stationName)&&(identical(other.dissolvedOxygen, dissolvedOxygen) || other.dissolvedOxygen == dissolvedOxygen)&&(identical(other.pH, pH) || other.pH == pH)&&(identical(other.chlorophyllA, chlorophyllA) || other.chlorophyllA == chlorophyllA)&&(identical(other.turbidity, turbidity) || other.turbidity == turbidity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timestamp,location,stationName,dissolvedOxygen,pH,chlorophyllA,turbidity);

@override
String toString() {
  return 'WaterQualityDto(timestamp: $timestamp, location: $location, stationName: $stationName, dissolvedOxygen: $dissolvedOxygen, pH: $pH, chlorophyllA: $chlorophyllA, turbidity: $turbidity)';
}


}

/// @nodoc
abstract mixin class $WaterQualityDtoCopyWith<$Res>  {
  factory $WaterQualityDtoCopyWith(WaterQualityDto value, $Res Function(WaterQualityDto) _then) = _$WaterQualityDtoCopyWithImpl;
@useResult
$Res call({
 DateTime timestamp,@LatLngConverter() LatLng location, String stationName, double? dissolvedOxygen, double? pH, double? chlorophyllA, double? turbidity
});




}
/// @nodoc
class _$WaterQualityDtoCopyWithImpl<$Res>
    implements $WaterQualityDtoCopyWith<$Res> {
  _$WaterQualityDtoCopyWithImpl(this._self, this._then);

  final WaterQualityDto _self;
  final $Res Function(WaterQualityDto) _then;

/// Create a copy of WaterQualityDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timestamp = null,Object? location = null,Object? stationName = null,Object? dissolvedOxygen = freezed,Object? pH = freezed,Object? chlorophyllA = freezed,Object? turbidity = freezed,}) {
  return _then(_self.copyWith(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,stationName: null == stationName ? _self.stationName : stationName // ignore: cast_nullable_to_non_nullable
as String,dissolvedOxygen: freezed == dissolvedOxygen ? _self.dissolvedOxygen : dissolvedOxygen // ignore: cast_nullable_to_non_nullable
as double?,pH: freezed == pH ? _self.pH : pH // ignore: cast_nullable_to_non_nullable
as double?,chlorophyllA: freezed == chlorophyllA ? _self.chlorophyllA : chlorophyllA // ignore: cast_nullable_to_non_nullable
as double?,turbidity: freezed == turbidity ? _self.turbidity : turbidity // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [WaterQualityDto].
extension WaterQualityDtoPatterns on WaterQualityDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WaterQualityDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WaterQualityDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WaterQualityDto value)  $default,){
final _that = this;
switch (_that) {
case _WaterQualityDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WaterQualityDto value)?  $default,){
final _that = this;
switch (_that) {
case _WaterQualityDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime timestamp, @LatLngConverter()  LatLng location,  String stationName,  double? dissolvedOxygen,  double? pH,  double? chlorophyllA,  double? turbidity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WaterQualityDto() when $default != null:
return $default(_that.timestamp,_that.location,_that.stationName,_that.dissolvedOxygen,_that.pH,_that.chlorophyllA,_that.turbidity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime timestamp, @LatLngConverter()  LatLng location,  String stationName,  double? dissolvedOxygen,  double? pH,  double? chlorophyllA,  double? turbidity)  $default,) {final _that = this;
switch (_that) {
case _WaterQualityDto():
return $default(_that.timestamp,_that.location,_that.stationName,_that.dissolvedOxygen,_that.pH,_that.chlorophyllA,_that.turbidity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime timestamp, @LatLngConverter()  LatLng location,  String stationName,  double? dissolvedOxygen,  double? pH,  double? chlorophyllA,  double? turbidity)?  $default,) {final _that = this;
switch (_that) {
case _WaterQualityDto() when $default != null:
return $default(_that.timestamp,_that.location,_that.stationName,_that.dissolvedOxygen,_that.pH,_that.chlorophyllA,_that.turbidity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WaterQualityDto implements WaterQualityDto {
  const _WaterQualityDto({required this.timestamp, @LatLngConverter() required this.location, required this.stationName, this.dissolvedOxygen, this.pH, this.chlorophyllA, this.turbidity});
  factory _WaterQualityDto.fromJson(Map<String, dynamic> json) => _$WaterQualityDtoFromJson(json);

@override final  DateTime timestamp;
@override@LatLngConverter() final  LatLng location;
@override final  String stationName;
@override final  double? dissolvedOxygen;
@override final  double? pH;
@override final  double? chlorophyllA;
@override final  double? turbidity;

/// Create a copy of WaterQualityDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaterQualityDtoCopyWith<_WaterQualityDto> get copyWith => __$WaterQualityDtoCopyWithImpl<_WaterQualityDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WaterQualityDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaterQualityDto&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.stationName, stationName) || other.stationName == stationName)&&(identical(other.dissolvedOxygen, dissolvedOxygen) || other.dissolvedOxygen == dissolvedOxygen)&&(identical(other.pH, pH) || other.pH == pH)&&(identical(other.chlorophyllA, chlorophyllA) || other.chlorophyllA == chlorophyllA)&&(identical(other.turbidity, turbidity) || other.turbidity == turbidity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timestamp,location,stationName,dissolvedOxygen,pH,chlorophyllA,turbidity);

@override
String toString() {
  return 'WaterQualityDto(timestamp: $timestamp, location: $location, stationName: $stationName, dissolvedOxygen: $dissolvedOxygen, pH: $pH, chlorophyllA: $chlorophyllA, turbidity: $turbidity)';
}


}

/// @nodoc
abstract mixin class _$WaterQualityDtoCopyWith<$Res> implements $WaterQualityDtoCopyWith<$Res> {
  factory _$WaterQualityDtoCopyWith(_WaterQualityDto value, $Res Function(_WaterQualityDto) _then) = __$WaterQualityDtoCopyWithImpl;
@override @useResult
$Res call({
 DateTime timestamp,@LatLngConverter() LatLng location, String stationName, double? dissolvedOxygen, double? pH, double? chlorophyllA, double? turbidity
});




}
/// @nodoc
class __$WaterQualityDtoCopyWithImpl<$Res>
    implements _$WaterQualityDtoCopyWith<$Res> {
  __$WaterQualityDtoCopyWithImpl(this._self, this._then);

  final _WaterQualityDto _self;
  final $Res Function(_WaterQualityDto) _then;

/// Create a copy of WaterQualityDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timestamp = null,Object? location = null,Object? stationName = null,Object? dissolvedOxygen = freezed,Object? pH = freezed,Object? chlorophyllA = freezed,Object? turbidity = freezed,}) {
  return _then(_WaterQualityDto(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,stationName: null == stationName ? _self.stationName : stationName // ignore: cast_nullable_to_non_nullable
as String,dissolvedOxygen: freezed == dissolvedOxygen ? _self.dissolvedOxygen : dissolvedOxygen // ignore: cast_nullable_to_non_nullable
as double?,pH: freezed == pH ? _self.pH : pH // ignore: cast_nullable_to_non_nullable
as double?,chlorophyllA: freezed == chlorophyllA ? _self.chlorophyllA : chlorophyllA // ignore: cast_nullable_to_non_nullable
as double?,turbidity: freezed == turbidity ? _self.turbidity : turbidity // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
