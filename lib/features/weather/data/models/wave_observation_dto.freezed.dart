// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wave_observation_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WaveObservationDto {

 DateTime get timestamp;@LatLngConverter() LatLng get location; String? get stationName; double? get waveHeight; double? get wavePeriod; double? get waveDirection; double? get waterTemperature;
/// Create a copy of WaveObservationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaveObservationDtoCopyWith<WaveObservationDto> get copyWith => _$WaveObservationDtoCopyWithImpl<WaveObservationDto>(this as WaveObservationDto, _$identity);

  /// Serializes this WaveObservationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaveObservationDto&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.stationName, stationName) || other.stationName == stationName)&&(identical(other.waveHeight, waveHeight) || other.waveHeight == waveHeight)&&(identical(other.wavePeriod, wavePeriod) || other.wavePeriod == wavePeriod)&&(identical(other.waveDirection, waveDirection) || other.waveDirection == waveDirection)&&(identical(other.waterTemperature, waterTemperature) || other.waterTemperature == waterTemperature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timestamp,location,stationName,waveHeight,wavePeriod,waveDirection,waterTemperature);

@override
String toString() {
  return 'WaveObservationDto(timestamp: $timestamp, location: $location, stationName: $stationName, waveHeight: $waveHeight, wavePeriod: $wavePeriod, waveDirection: $waveDirection, waterTemperature: $waterTemperature)';
}


}

/// @nodoc
abstract mixin class $WaveObservationDtoCopyWith<$Res>  {
  factory $WaveObservationDtoCopyWith(WaveObservationDto value, $Res Function(WaveObservationDto) _then) = _$WaveObservationDtoCopyWithImpl;
@useResult
$Res call({
 DateTime timestamp,@LatLngConverter() LatLng location, String? stationName, double? waveHeight, double? wavePeriod, double? waveDirection, double? waterTemperature
});




}
/// @nodoc
class _$WaveObservationDtoCopyWithImpl<$Res>
    implements $WaveObservationDtoCopyWith<$Res> {
  _$WaveObservationDtoCopyWithImpl(this._self, this._then);

  final WaveObservationDto _self;
  final $Res Function(WaveObservationDto) _then;

/// Create a copy of WaveObservationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timestamp = null,Object? location = null,Object? stationName = freezed,Object? waveHeight = freezed,Object? wavePeriod = freezed,Object? waveDirection = freezed,Object? waterTemperature = freezed,}) {
  return _then(_self.copyWith(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,stationName: freezed == stationName ? _self.stationName : stationName // ignore: cast_nullable_to_non_nullable
as String?,waveHeight: freezed == waveHeight ? _self.waveHeight : waveHeight // ignore: cast_nullable_to_non_nullable
as double?,wavePeriod: freezed == wavePeriod ? _self.wavePeriod : wavePeriod // ignore: cast_nullable_to_non_nullable
as double?,waveDirection: freezed == waveDirection ? _self.waveDirection : waveDirection // ignore: cast_nullable_to_non_nullable
as double?,waterTemperature: freezed == waterTemperature ? _self.waterTemperature : waterTemperature // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [WaveObservationDto].
extension WaveObservationDtoPatterns on WaveObservationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WaveObservationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WaveObservationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WaveObservationDto value)  $default,){
final _that = this;
switch (_that) {
case _WaveObservationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WaveObservationDto value)?  $default,){
final _that = this;
switch (_that) {
case _WaveObservationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime timestamp, @LatLngConverter()  LatLng location,  String? stationName,  double? waveHeight,  double? wavePeriod,  double? waveDirection,  double? waterTemperature)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WaveObservationDto() when $default != null:
return $default(_that.timestamp,_that.location,_that.stationName,_that.waveHeight,_that.wavePeriod,_that.waveDirection,_that.waterTemperature);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime timestamp, @LatLngConverter()  LatLng location,  String? stationName,  double? waveHeight,  double? wavePeriod,  double? waveDirection,  double? waterTemperature)  $default,) {final _that = this;
switch (_that) {
case _WaveObservationDto():
return $default(_that.timestamp,_that.location,_that.stationName,_that.waveHeight,_that.wavePeriod,_that.waveDirection,_that.waterTemperature);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime timestamp, @LatLngConverter()  LatLng location,  String? stationName,  double? waveHeight,  double? wavePeriod,  double? waveDirection,  double? waterTemperature)?  $default,) {final _that = this;
switch (_that) {
case _WaveObservationDto() when $default != null:
return $default(_that.timestamp,_that.location,_that.stationName,_that.waveHeight,_that.wavePeriod,_that.waveDirection,_that.waterTemperature);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WaveObservationDto implements WaveObservationDto {
  const _WaveObservationDto({required this.timestamp, @LatLngConverter() required this.location, this.stationName, this.waveHeight, this.wavePeriod, this.waveDirection, this.waterTemperature});
  factory _WaveObservationDto.fromJson(Map<String, dynamic> json) => _$WaveObservationDtoFromJson(json);

@override final  DateTime timestamp;
@override@LatLngConverter() final  LatLng location;
@override final  String? stationName;
@override final  double? waveHeight;
@override final  double? wavePeriod;
@override final  double? waveDirection;
@override final  double? waterTemperature;

/// Create a copy of WaveObservationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaveObservationDtoCopyWith<_WaveObservationDto> get copyWith => __$WaveObservationDtoCopyWithImpl<_WaveObservationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WaveObservationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaveObservationDto&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.stationName, stationName) || other.stationName == stationName)&&(identical(other.waveHeight, waveHeight) || other.waveHeight == waveHeight)&&(identical(other.wavePeriod, wavePeriod) || other.wavePeriod == wavePeriod)&&(identical(other.waveDirection, waveDirection) || other.waveDirection == waveDirection)&&(identical(other.waterTemperature, waterTemperature) || other.waterTemperature == waterTemperature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timestamp,location,stationName,waveHeight,wavePeriod,waveDirection,waterTemperature);

@override
String toString() {
  return 'WaveObservationDto(timestamp: $timestamp, location: $location, stationName: $stationName, waveHeight: $waveHeight, wavePeriod: $wavePeriod, waveDirection: $waveDirection, waterTemperature: $waterTemperature)';
}


}

/// @nodoc
abstract mixin class _$WaveObservationDtoCopyWith<$Res> implements $WaveObservationDtoCopyWith<$Res> {
  factory _$WaveObservationDtoCopyWith(_WaveObservationDto value, $Res Function(_WaveObservationDto) _then) = __$WaveObservationDtoCopyWithImpl;
@override @useResult
$Res call({
 DateTime timestamp,@LatLngConverter() LatLng location, String? stationName, double? waveHeight, double? wavePeriod, double? waveDirection, double? waterTemperature
});




}
/// @nodoc
class __$WaveObservationDtoCopyWithImpl<$Res>
    implements _$WaveObservationDtoCopyWith<$Res> {
  __$WaveObservationDtoCopyWithImpl(this._self, this._then);

  final _WaveObservationDto _self;
  final $Res Function(_WaveObservationDto) _then;

/// Create a copy of WaveObservationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timestamp = null,Object? location = null,Object? stationName = freezed,Object? waveHeight = freezed,Object? wavePeriod = freezed,Object? waveDirection = freezed,Object? waterTemperature = freezed,}) {
  return _then(_WaveObservationDto(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,stationName: freezed == stationName ? _self.stationName : stationName // ignore: cast_nullable_to_non_nullable
as String?,waveHeight: freezed == waveHeight ? _self.waveHeight : waveHeight // ignore: cast_nullable_to_non_nullable
as double?,wavePeriod: freezed == wavePeriod ? _self.wavePeriod : wavePeriod // ignore: cast_nullable_to_non_nullable
as double?,waveDirection: freezed == waveDirection ? _self.waveDirection : waveDirection // ignore: cast_nullable_to_non_nullable
as double?,waterTemperature: freezed == waterTemperature ? _self.waterTemperature : waterTemperature // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
