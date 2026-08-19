// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WeatherData {

 DateTime get timestamp; LatLng get location; double? get temperature; double? get feelsLike; double? get windSpeed; double? get windGust; double? get windDirection; double? get pressure; double? get visibility; double? get humidity; double? get dewPoint; double? get precipitation; double? get cloudCover; double? get uvIndex; double? get snowfall; int? get weatherCode; String? get weatherIcon; String? get weatherDescription; DateTime? get sunrise; DateTime? get sunset; String? get stationName;
/// Create a copy of WeatherData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherDataCopyWith<WeatherData> get copyWith => _$WeatherDataCopyWithImpl<WeatherData>(this as WeatherData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherData&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.feelsLike, feelsLike) || other.feelsLike == feelsLike)&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed)&&(identical(other.windGust, windGust) || other.windGust == windGust)&&(identical(other.windDirection, windDirection) || other.windDirection == windDirection)&&(identical(other.pressure, pressure) || other.pressure == pressure)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.dewPoint, dewPoint) || other.dewPoint == dewPoint)&&(identical(other.precipitation, precipitation) || other.precipitation == precipitation)&&(identical(other.cloudCover, cloudCover) || other.cloudCover == cloudCover)&&(identical(other.uvIndex, uvIndex) || other.uvIndex == uvIndex)&&(identical(other.snowfall, snowfall) || other.snowfall == snowfall)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode)&&(identical(other.weatherIcon, weatherIcon) || other.weatherIcon == weatherIcon)&&(identical(other.weatherDescription, weatherDescription) || other.weatherDescription == weatherDescription)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.sunset, sunset) || other.sunset == sunset)&&(identical(other.stationName, stationName) || other.stationName == stationName));
}


@override
int get hashCode => Object.hashAll([runtimeType,timestamp,location,temperature,feelsLike,windSpeed,windGust,windDirection,pressure,visibility,humidity,dewPoint,precipitation,cloudCover,uvIndex,snowfall,weatherCode,weatherIcon,weatherDescription,sunrise,sunset,stationName]);

@override
String toString() {
  return 'WeatherData(timestamp: $timestamp, location: $location, temperature: $temperature, feelsLike: $feelsLike, windSpeed: $windSpeed, windGust: $windGust, windDirection: $windDirection, pressure: $pressure, visibility: $visibility, humidity: $humidity, dewPoint: $dewPoint, precipitation: $precipitation, cloudCover: $cloudCover, uvIndex: $uvIndex, snowfall: $snowfall, weatherCode: $weatherCode, weatherIcon: $weatherIcon, weatherDescription: $weatherDescription, sunrise: $sunrise, sunset: $sunset, stationName: $stationName)';
}


}

/// @nodoc
abstract mixin class $WeatherDataCopyWith<$Res>  {
  factory $WeatherDataCopyWith(WeatherData value, $Res Function(WeatherData) _then) = _$WeatherDataCopyWithImpl;
@useResult
$Res call({
 DateTime timestamp, LatLng location, double? temperature, double? feelsLike, double? windSpeed, double? windGust, double? windDirection, double? pressure, double? visibility, double? humidity, double? dewPoint, double? precipitation, double? cloudCover, double? uvIndex, double? snowfall, int? weatherCode, String? weatherIcon, String? weatherDescription, DateTime? sunrise, DateTime? sunset, String? stationName
});




}
/// @nodoc
class _$WeatherDataCopyWithImpl<$Res>
    implements $WeatherDataCopyWith<$Res> {
  _$WeatherDataCopyWithImpl(this._self, this._then);

  final WeatherData _self;
  final $Res Function(WeatherData) _then;

/// Create a copy of WeatherData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timestamp = null,Object? location = null,Object? temperature = freezed,Object? feelsLike = freezed,Object? windSpeed = freezed,Object? windGust = freezed,Object? windDirection = freezed,Object? pressure = freezed,Object? visibility = freezed,Object? humidity = freezed,Object? dewPoint = freezed,Object? precipitation = freezed,Object? cloudCover = freezed,Object? uvIndex = freezed,Object? snowfall = freezed,Object? weatherCode = freezed,Object? weatherIcon = freezed,Object? weatherDescription = freezed,Object? sunrise = freezed,Object? sunset = freezed,Object? stationName = freezed,}) {
  return _then(_self.copyWith(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,feelsLike: freezed == feelsLike ? _self.feelsLike : feelsLike // ignore: cast_nullable_to_non_nullable
as double?,windSpeed: freezed == windSpeed ? _self.windSpeed : windSpeed // ignore: cast_nullable_to_non_nullable
as double?,windGust: freezed == windGust ? _self.windGust : windGust // ignore: cast_nullable_to_non_nullable
as double?,windDirection: freezed == windDirection ? _self.windDirection : windDirection // ignore: cast_nullable_to_non_nullable
as double?,pressure: freezed == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as double?,visibility: freezed == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as double?,humidity: freezed == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as double?,dewPoint: freezed == dewPoint ? _self.dewPoint : dewPoint // ignore: cast_nullable_to_non_nullable
as double?,precipitation: freezed == precipitation ? _self.precipitation : precipitation // ignore: cast_nullable_to_non_nullable
as double?,cloudCover: freezed == cloudCover ? _self.cloudCover : cloudCover // ignore: cast_nullable_to_non_nullable
as double?,uvIndex: freezed == uvIndex ? _self.uvIndex : uvIndex // ignore: cast_nullable_to_non_nullable
as double?,snowfall: freezed == snowfall ? _self.snowfall : snowfall // ignore: cast_nullable_to_non_nullable
as double?,weatherCode: freezed == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as int?,weatherIcon: freezed == weatherIcon ? _self.weatherIcon : weatherIcon // ignore: cast_nullable_to_non_nullable
as String?,weatherDescription: freezed == weatherDescription ? _self.weatherDescription : weatherDescription // ignore: cast_nullable_to_non_nullable
as String?,sunrise: freezed == sunrise ? _self.sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as DateTime?,sunset: freezed == sunset ? _self.sunset : sunset // ignore: cast_nullable_to_non_nullable
as DateTime?,stationName: freezed == stationName ? _self.stationName : stationName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherData].
extension WeatherDataPatterns on WeatherData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherData value)  $default,){
final _that = this;
switch (_that) {
case _WeatherData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherData value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime timestamp,  LatLng location,  double? temperature,  double? feelsLike,  double? windSpeed,  double? windGust,  double? windDirection,  double? pressure,  double? visibility,  double? humidity,  double? dewPoint,  double? precipitation,  double? cloudCover,  double? uvIndex,  double? snowfall,  int? weatherCode,  String? weatherIcon,  String? weatherDescription,  DateTime? sunrise,  DateTime? sunset,  String? stationName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherData() when $default != null:
return $default(_that.timestamp,_that.location,_that.temperature,_that.feelsLike,_that.windSpeed,_that.windGust,_that.windDirection,_that.pressure,_that.visibility,_that.humidity,_that.dewPoint,_that.precipitation,_that.cloudCover,_that.uvIndex,_that.snowfall,_that.weatherCode,_that.weatherIcon,_that.weatherDescription,_that.sunrise,_that.sunset,_that.stationName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime timestamp,  LatLng location,  double? temperature,  double? feelsLike,  double? windSpeed,  double? windGust,  double? windDirection,  double? pressure,  double? visibility,  double? humidity,  double? dewPoint,  double? precipitation,  double? cloudCover,  double? uvIndex,  double? snowfall,  int? weatherCode,  String? weatherIcon,  String? weatherDescription,  DateTime? sunrise,  DateTime? sunset,  String? stationName)  $default,) {final _that = this;
switch (_that) {
case _WeatherData():
return $default(_that.timestamp,_that.location,_that.temperature,_that.feelsLike,_that.windSpeed,_that.windGust,_that.windDirection,_that.pressure,_that.visibility,_that.humidity,_that.dewPoint,_that.precipitation,_that.cloudCover,_that.uvIndex,_that.snowfall,_that.weatherCode,_that.weatherIcon,_that.weatherDescription,_that.sunrise,_that.sunset,_that.stationName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime timestamp,  LatLng location,  double? temperature,  double? feelsLike,  double? windSpeed,  double? windGust,  double? windDirection,  double? pressure,  double? visibility,  double? humidity,  double? dewPoint,  double? precipitation,  double? cloudCover,  double? uvIndex,  double? snowfall,  int? weatherCode,  String? weatherIcon,  String? weatherDescription,  DateTime? sunrise,  DateTime? sunset,  String? stationName)?  $default,) {final _that = this;
switch (_that) {
case _WeatherData() when $default != null:
return $default(_that.timestamp,_that.location,_that.temperature,_that.feelsLike,_that.windSpeed,_that.windGust,_that.windDirection,_that.pressure,_that.visibility,_that.humidity,_that.dewPoint,_that.precipitation,_that.cloudCover,_that.uvIndex,_that.snowfall,_that.weatherCode,_that.weatherIcon,_that.weatherDescription,_that.sunrise,_that.sunset,_that.stationName);case _:
  return null;

}
}

}

/// @nodoc


class _WeatherData implements WeatherData {
  const _WeatherData({required this.timestamp, required this.location, this.temperature, this.feelsLike, this.windSpeed, this.windGust, this.windDirection, this.pressure, this.visibility, this.humidity, this.dewPoint, this.precipitation, this.cloudCover, this.uvIndex, this.snowfall, this.weatherCode, this.weatherIcon, this.weatherDescription, this.sunrise, this.sunset, this.stationName});
  

@override final  DateTime timestamp;
@override final  LatLng location;
@override final  double? temperature;
@override final  double? feelsLike;
@override final  double? windSpeed;
@override final  double? windGust;
@override final  double? windDirection;
@override final  double? pressure;
@override final  double? visibility;
@override final  double? humidity;
@override final  double? dewPoint;
@override final  double? precipitation;
@override final  double? cloudCover;
@override final  double? uvIndex;
@override final  double? snowfall;
@override final  int? weatherCode;
@override final  String? weatherIcon;
@override final  String? weatherDescription;
@override final  DateTime? sunrise;
@override final  DateTime? sunset;
@override final  String? stationName;

/// Create a copy of WeatherData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherDataCopyWith<_WeatherData> get copyWith => __$WeatherDataCopyWithImpl<_WeatherData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherData&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.feelsLike, feelsLike) || other.feelsLike == feelsLike)&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed)&&(identical(other.windGust, windGust) || other.windGust == windGust)&&(identical(other.windDirection, windDirection) || other.windDirection == windDirection)&&(identical(other.pressure, pressure) || other.pressure == pressure)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.dewPoint, dewPoint) || other.dewPoint == dewPoint)&&(identical(other.precipitation, precipitation) || other.precipitation == precipitation)&&(identical(other.cloudCover, cloudCover) || other.cloudCover == cloudCover)&&(identical(other.uvIndex, uvIndex) || other.uvIndex == uvIndex)&&(identical(other.snowfall, snowfall) || other.snowfall == snowfall)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode)&&(identical(other.weatherIcon, weatherIcon) || other.weatherIcon == weatherIcon)&&(identical(other.weatherDescription, weatherDescription) || other.weatherDescription == weatherDescription)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.sunset, sunset) || other.sunset == sunset)&&(identical(other.stationName, stationName) || other.stationName == stationName));
}


@override
int get hashCode => Object.hashAll([runtimeType,timestamp,location,temperature,feelsLike,windSpeed,windGust,windDirection,pressure,visibility,humidity,dewPoint,precipitation,cloudCover,uvIndex,snowfall,weatherCode,weatherIcon,weatherDescription,sunrise,sunset,stationName]);

@override
String toString() {
  return 'WeatherData(timestamp: $timestamp, location: $location, temperature: $temperature, feelsLike: $feelsLike, windSpeed: $windSpeed, windGust: $windGust, windDirection: $windDirection, pressure: $pressure, visibility: $visibility, humidity: $humidity, dewPoint: $dewPoint, precipitation: $precipitation, cloudCover: $cloudCover, uvIndex: $uvIndex, snowfall: $snowfall, weatherCode: $weatherCode, weatherIcon: $weatherIcon, weatherDescription: $weatherDescription, sunrise: $sunrise, sunset: $sunset, stationName: $stationName)';
}


}

/// @nodoc
abstract mixin class _$WeatherDataCopyWith<$Res> implements $WeatherDataCopyWith<$Res> {
  factory _$WeatherDataCopyWith(_WeatherData value, $Res Function(_WeatherData) _then) = __$WeatherDataCopyWithImpl;
@override @useResult
$Res call({
 DateTime timestamp, LatLng location, double? temperature, double? feelsLike, double? windSpeed, double? windGust, double? windDirection, double? pressure, double? visibility, double? humidity, double? dewPoint, double? precipitation, double? cloudCover, double? uvIndex, double? snowfall, int? weatherCode, String? weatherIcon, String? weatherDescription, DateTime? sunrise, DateTime? sunset, String? stationName
});




}
/// @nodoc
class __$WeatherDataCopyWithImpl<$Res>
    implements _$WeatherDataCopyWith<$Res> {
  __$WeatherDataCopyWithImpl(this._self, this._then);

  final _WeatherData _self;
  final $Res Function(_WeatherData) _then;

/// Create a copy of WeatherData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timestamp = null,Object? location = null,Object? temperature = freezed,Object? feelsLike = freezed,Object? windSpeed = freezed,Object? windGust = freezed,Object? windDirection = freezed,Object? pressure = freezed,Object? visibility = freezed,Object? humidity = freezed,Object? dewPoint = freezed,Object? precipitation = freezed,Object? cloudCover = freezed,Object? uvIndex = freezed,Object? snowfall = freezed,Object? weatherCode = freezed,Object? weatherIcon = freezed,Object? weatherDescription = freezed,Object? sunrise = freezed,Object? sunset = freezed,Object? stationName = freezed,}) {
  return _then(_WeatherData(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,feelsLike: freezed == feelsLike ? _self.feelsLike : feelsLike // ignore: cast_nullable_to_non_nullable
as double?,windSpeed: freezed == windSpeed ? _self.windSpeed : windSpeed // ignore: cast_nullable_to_non_nullable
as double?,windGust: freezed == windGust ? _self.windGust : windGust // ignore: cast_nullable_to_non_nullable
as double?,windDirection: freezed == windDirection ? _self.windDirection : windDirection // ignore: cast_nullable_to_non_nullable
as double?,pressure: freezed == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as double?,visibility: freezed == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as double?,humidity: freezed == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as double?,dewPoint: freezed == dewPoint ? _self.dewPoint : dewPoint // ignore: cast_nullable_to_non_nullable
as double?,precipitation: freezed == precipitation ? _self.precipitation : precipitation // ignore: cast_nullable_to_non_nullable
as double?,cloudCover: freezed == cloudCover ? _self.cloudCover : cloudCover // ignore: cast_nullable_to_non_nullable
as double?,uvIndex: freezed == uvIndex ? _self.uvIndex : uvIndex // ignore: cast_nullable_to_non_nullable
as double?,snowfall: freezed == snowfall ? _self.snowfall : snowfall // ignore: cast_nullable_to_non_nullable
as double?,weatherCode: freezed == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as int?,weatherIcon: freezed == weatherIcon ? _self.weatherIcon : weatherIcon // ignore: cast_nullable_to_non_nullable
as String?,weatherDescription: freezed == weatherDescription ? _self.weatherDescription : weatherDescription // ignore: cast_nullable_to_non_nullable
as String?,sunrise: freezed == sunrise ? _self.sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as DateTime?,sunset: freezed == sunset ? _self.sunset : sunset // ignore: cast_nullable_to_non_nullable
as DateTime?,stationName: freezed == stationName ? _self.stationName : stationName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
