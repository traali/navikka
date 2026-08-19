// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'water_quality_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WaterQualityData {

 DateTime get sampleDate; LatLng get location; String? get stationName;/// Water temperature in Celsius
 double? get temperature;/// Chlorophyll-a concentration (µg/L) - indicator of algae presence
 double? get chlorophyllA;/// Water turbidity in NTU
 double? get turbidity;/// Algae bloom status (e.g., "None", "Low", "Moderate", "High")
 String? get algaeStatus;/// Dissolved oxygen in mg/L
 double? get dissolvedOxygen;/// pH level
 double? get ph;
/// Create a copy of WaterQualityData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaterQualityDataCopyWith<WaterQualityData> get copyWith => _$WaterQualityDataCopyWithImpl<WaterQualityData>(this as WaterQualityData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaterQualityData&&(identical(other.sampleDate, sampleDate) || other.sampleDate == sampleDate)&&(identical(other.location, location) || other.location == location)&&(identical(other.stationName, stationName) || other.stationName == stationName)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.chlorophyllA, chlorophyllA) || other.chlorophyllA == chlorophyllA)&&(identical(other.turbidity, turbidity) || other.turbidity == turbidity)&&(identical(other.algaeStatus, algaeStatus) || other.algaeStatus == algaeStatus)&&(identical(other.dissolvedOxygen, dissolvedOxygen) || other.dissolvedOxygen == dissolvedOxygen)&&(identical(other.ph, ph) || other.ph == ph));
}


@override
int get hashCode => Object.hash(runtimeType,sampleDate,location,stationName,temperature,chlorophyllA,turbidity,algaeStatus,dissolvedOxygen,ph);

@override
String toString() {
  return 'WaterQualityData(sampleDate: $sampleDate, location: $location, stationName: $stationName, temperature: $temperature, chlorophyllA: $chlorophyllA, turbidity: $turbidity, algaeStatus: $algaeStatus, dissolvedOxygen: $dissolvedOxygen, ph: $ph)';
}


}

/// @nodoc
abstract mixin class $WaterQualityDataCopyWith<$Res>  {
  factory $WaterQualityDataCopyWith(WaterQualityData value, $Res Function(WaterQualityData) _then) = _$WaterQualityDataCopyWithImpl;
@useResult
$Res call({
 DateTime sampleDate, LatLng location, String? stationName, double? temperature, double? chlorophyllA, double? turbidity, String? algaeStatus, double? dissolvedOxygen, double? ph
});




}
/// @nodoc
class _$WaterQualityDataCopyWithImpl<$Res>
    implements $WaterQualityDataCopyWith<$Res> {
  _$WaterQualityDataCopyWithImpl(this._self, this._then);

  final WaterQualityData _self;
  final $Res Function(WaterQualityData) _then;

/// Create a copy of WaterQualityData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sampleDate = null,Object? location = null,Object? stationName = freezed,Object? temperature = freezed,Object? chlorophyllA = freezed,Object? turbidity = freezed,Object? algaeStatus = freezed,Object? dissolvedOxygen = freezed,Object? ph = freezed,}) {
  return _then(_self.copyWith(
sampleDate: null == sampleDate ? _self.sampleDate : sampleDate // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,stationName: freezed == stationName ? _self.stationName : stationName // ignore: cast_nullable_to_non_nullable
as String?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,chlorophyllA: freezed == chlorophyllA ? _self.chlorophyllA : chlorophyllA // ignore: cast_nullable_to_non_nullable
as double?,turbidity: freezed == turbidity ? _self.turbidity : turbidity // ignore: cast_nullable_to_non_nullable
as double?,algaeStatus: freezed == algaeStatus ? _self.algaeStatus : algaeStatus // ignore: cast_nullable_to_non_nullable
as String?,dissolvedOxygen: freezed == dissolvedOxygen ? _self.dissolvedOxygen : dissolvedOxygen // ignore: cast_nullable_to_non_nullable
as double?,ph: freezed == ph ? _self.ph : ph // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [WaterQualityData].
extension WaterQualityDataPatterns on WaterQualityData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WaterQualityData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WaterQualityData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WaterQualityData value)  $default,){
final _that = this;
switch (_that) {
case _WaterQualityData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WaterQualityData value)?  $default,){
final _that = this;
switch (_that) {
case _WaterQualityData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime sampleDate,  LatLng location,  String? stationName,  double? temperature,  double? chlorophyllA,  double? turbidity,  String? algaeStatus,  double? dissolvedOxygen,  double? ph)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WaterQualityData() when $default != null:
return $default(_that.sampleDate,_that.location,_that.stationName,_that.temperature,_that.chlorophyllA,_that.turbidity,_that.algaeStatus,_that.dissolvedOxygen,_that.ph);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime sampleDate,  LatLng location,  String? stationName,  double? temperature,  double? chlorophyllA,  double? turbidity,  String? algaeStatus,  double? dissolvedOxygen,  double? ph)  $default,) {final _that = this;
switch (_that) {
case _WaterQualityData():
return $default(_that.sampleDate,_that.location,_that.stationName,_that.temperature,_that.chlorophyllA,_that.turbidity,_that.algaeStatus,_that.dissolvedOxygen,_that.ph);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime sampleDate,  LatLng location,  String? stationName,  double? temperature,  double? chlorophyllA,  double? turbidity,  String? algaeStatus,  double? dissolvedOxygen,  double? ph)?  $default,) {final _that = this;
switch (_that) {
case _WaterQualityData() when $default != null:
return $default(_that.sampleDate,_that.location,_that.stationName,_that.temperature,_that.chlorophyllA,_that.turbidity,_that.algaeStatus,_that.dissolvedOxygen,_that.ph);case _:
  return null;

}
}

}

/// @nodoc


class _WaterQualityData implements WaterQualityData {
  const _WaterQualityData({required this.sampleDate, required this.location, required this.stationName, required this.temperature, required this.chlorophyllA, required this.turbidity, required this.algaeStatus, required this.dissolvedOxygen, required this.ph});
  

@override final  DateTime sampleDate;
@override final  LatLng location;
@override final  String? stationName;
/// Water temperature in Celsius
@override final  double? temperature;
/// Chlorophyll-a concentration (µg/L) - indicator of algae presence
@override final  double? chlorophyllA;
/// Water turbidity in NTU
@override final  double? turbidity;
/// Algae bloom status (e.g., "None", "Low", "Moderate", "High")
@override final  String? algaeStatus;
/// Dissolved oxygen in mg/L
@override final  double? dissolvedOxygen;
/// pH level
@override final  double? ph;

/// Create a copy of WaterQualityData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaterQualityDataCopyWith<_WaterQualityData> get copyWith => __$WaterQualityDataCopyWithImpl<_WaterQualityData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaterQualityData&&(identical(other.sampleDate, sampleDate) || other.sampleDate == sampleDate)&&(identical(other.location, location) || other.location == location)&&(identical(other.stationName, stationName) || other.stationName == stationName)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.chlorophyllA, chlorophyllA) || other.chlorophyllA == chlorophyllA)&&(identical(other.turbidity, turbidity) || other.turbidity == turbidity)&&(identical(other.algaeStatus, algaeStatus) || other.algaeStatus == algaeStatus)&&(identical(other.dissolvedOxygen, dissolvedOxygen) || other.dissolvedOxygen == dissolvedOxygen)&&(identical(other.ph, ph) || other.ph == ph));
}


@override
int get hashCode => Object.hash(runtimeType,sampleDate,location,stationName,temperature,chlorophyllA,turbidity,algaeStatus,dissolvedOxygen,ph);

@override
String toString() {
  return 'WaterQualityData(sampleDate: $sampleDate, location: $location, stationName: $stationName, temperature: $temperature, chlorophyllA: $chlorophyllA, turbidity: $turbidity, algaeStatus: $algaeStatus, dissolvedOxygen: $dissolvedOxygen, ph: $ph)';
}


}

/// @nodoc
abstract mixin class _$WaterQualityDataCopyWith<$Res> implements $WaterQualityDataCopyWith<$Res> {
  factory _$WaterQualityDataCopyWith(_WaterQualityData value, $Res Function(_WaterQualityData) _then) = __$WaterQualityDataCopyWithImpl;
@override @useResult
$Res call({
 DateTime sampleDate, LatLng location, String? stationName, double? temperature, double? chlorophyllA, double? turbidity, String? algaeStatus, double? dissolvedOxygen, double? ph
});




}
/// @nodoc
class __$WaterQualityDataCopyWithImpl<$Res>
    implements _$WaterQualityDataCopyWith<$Res> {
  __$WaterQualityDataCopyWithImpl(this._self, this._then);

  final _WaterQualityData _self;
  final $Res Function(_WaterQualityData) _then;

/// Create a copy of WaterQualityData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sampleDate = null,Object? location = null,Object? stationName = freezed,Object? temperature = freezed,Object? chlorophyllA = freezed,Object? turbidity = freezed,Object? algaeStatus = freezed,Object? dissolvedOxygen = freezed,Object? ph = freezed,}) {
  return _then(_WaterQualityData(
sampleDate: null == sampleDate ? _self.sampleDate : sampleDate // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,stationName: freezed == stationName ? _self.stationName : stationName // ignore: cast_nullable_to_non_nullable
as String?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,chlorophyllA: freezed == chlorophyllA ? _self.chlorophyllA : chlorophyllA // ignore: cast_nullable_to_non_nullable
as double?,turbidity: freezed == turbidity ? _self.turbidity : turbidity // ignore: cast_nullable_to_non_nullable
as double?,algaeStatus: freezed == algaeStatus ? _self.algaeStatus : algaeStatus // ignore: cast_nullable_to_non_nullable
as String?,dissolvedOxygen: freezed == dissolvedOxygen ? _self.dissolvedOxygen : dissolvedOxygen // ignore: cast_nullable_to_non_nullable
as double?,ph: freezed == ph ? _self.ph : ph // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
