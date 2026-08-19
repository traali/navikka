// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wave_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WaveData {

 DateTime get timestamp; LatLng get location; String? get stationName; double? get waveHeight; double? get wavePeriod; double? get waveDirection; double? get waterTemperature;
/// Create a copy of WaveData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaveDataCopyWith<WaveData> get copyWith => _$WaveDataCopyWithImpl<WaveData>(this as WaveData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaveData&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.stationName, stationName) || other.stationName == stationName)&&(identical(other.waveHeight, waveHeight) || other.waveHeight == waveHeight)&&(identical(other.wavePeriod, wavePeriod) || other.wavePeriod == wavePeriod)&&(identical(other.waveDirection, waveDirection) || other.waveDirection == waveDirection)&&(identical(other.waterTemperature, waterTemperature) || other.waterTemperature == waterTemperature));
}


@override
int get hashCode => Object.hash(runtimeType,timestamp,location,stationName,waveHeight,wavePeriod,waveDirection,waterTemperature);

@override
String toString() {
  return 'WaveData(timestamp: $timestamp, location: $location, stationName: $stationName, waveHeight: $waveHeight, wavePeriod: $wavePeriod, waveDirection: $waveDirection, waterTemperature: $waterTemperature)';
}


}

/// @nodoc
abstract mixin class $WaveDataCopyWith<$Res>  {
  factory $WaveDataCopyWith(WaveData value, $Res Function(WaveData) _then) = _$WaveDataCopyWithImpl;
@useResult
$Res call({
 DateTime timestamp, LatLng location, String? stationName, double? waveHeight, double? wavePeriod, double? waveDirection, double? waterTemperature
});




}
/// @nodoc
class _$WaveDataCopyWithImpl<$Res>
    implements $WaveDataCopyWith<$Res> {
  _$WaveDataCopyWithImpl(this._self, this._then);

  final WaveData _self;
  final $Res Function(WaveData) _then;

/// Create a copy of WaveData
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


/// Adds pattern-matching-related methods to [WaveData].
extension WaveDataPatterns on WaveData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WaveData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WaveData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WaveData value)  $default,){
final _that = this;
switch (_that) {
case _WaveData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WaveData value)?  $default,){
final _that = this;
switch (_that) {
case _WaveData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime timestamp,  LatLng location,  String? stationName,  double? waveHeight,  double? wavePeriod,  double? waveDirection,  double? waterTemperature)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WaveData() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime timestamp,  LatLng location,  String? stationName,  double? waveHeight,  double? wavePeriod,  double? waveDirection,  double? waterTemperature)  $default,) {final _that = this;
switch (_that) {
case _WaveData():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime timestamp,  LatLng location,  String? stationName,  double? waveHeight,  double? wavePeriod,  double? waveDirection,  double? waterTemperature)?  $default,) {final _that = this;
switch (_that) {
case _WaveData() when $default != null:
return $default(_that.timestamp,_that.location,_that.stationName,_that.waveHeight,_that.wavePeriod,_that.waveDirection,_that.waterTemperature);case _:
  return null;

}
}

}

/// @nodoc


class _WaveData implements WaveData {
  const _WaveData({required this.timestamp, required this.location, required this.stationName, required this.waveHeight, required this.wavePeriod, required this.waveDirection, required this.waterTemperature});
  

@override final  DateTime timestamp;
@override final  LatLng location;
@override final  String? stationName;
@override final  double? waveHeight;
@override final  double? wavePeriod;
@override final  double? waveDirection;
@override final  double? waterTemperature;

/// Create a copy of WaveData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaveDataCopyWith<_WaveData> get copyWith => __$WaveDataCopyWithImpl<_WaveData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaveData&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.stationName, stationName) || other.stationName == stationName)&&(identical(other.waveHeight, waveHeight) || other.waveHeight == waveHeight)&&(identical(other.wavePeriod, wavePeriod) || other.wavePeriod == wavePeriod)&&(identical(other.waveDirection, waveDirection) || other.waveDirection == waveDirection)&&(identical(other.waterTemperature, waterTemperature) || other.waterTemperature == waterTemperature));
}


@override
int get hashCode => Object.hash(runtimeType,timestamp,location,stationName,waveHeight,wavePeriod,waveDirection,waterTemperature);

@override
String toString() {
  return 'WaveData(timestamp: $timestamp, location: $location, stationName: $stationName, waveHeight: $waveHeight, wavePeriod: $wavePeriod, waveDirection: $waveDirection, waterTemperature: $waterTemperature)';
}


}

/// @nodoc
abstract mixin class _$WaveDataCopyWith<$Res> implements $WaveDataCopyWith<$Res> {
  factory _$WaveDataCopyWith(_WaveData value, $Res Function(_WaveData) _then) = __$WaveDataCopyWithImpl;
@override @useResult
$Res call({
 DateTime timestamp, LatLng location, String? stationName, double? waveHeight, double? wavePeriod, double? waveDirection, double? waterTemperature
});




}
/// @nodoc
class __$WaveDataCopyWithImpl<$Res>
    implements _$WaveDataCopyWith<$Res> {
  __$WaveDataCopyWithImpl(this._self, this._then);

  final _WaveData _self;
  final $Res Function(_WaveData) _then;

/// Create a copy of WaveData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timestamp = null,Object? location = null,Object? stationName = freezed,Object? waveHeight = freezed,Object? wavePeriod = freezed,Object? waveDirection = freezed,Object? waterTemperature = freezed,}) {
  return _then(_WaveData(
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
