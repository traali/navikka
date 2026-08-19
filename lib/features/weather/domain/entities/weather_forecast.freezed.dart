// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_forecast.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WeatherForecast {

 DateTime get timestamp; LatLng? get location; int? get providerId; double? get temperature; double? get feelsLike; double? get windSpeed; double? get windGust; double? get windDirection; double? get precipitation; double? get precipitationProbability; double? get pressure; double? get humidity; double? get dewPoint; double? get cloudCover; double? get uvIndex; String? get weatherIcon; String? get weatherDescription;
/// Create a copy of WeatherForecast
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherForecastCopyWith<WeatherForecast> get copyWith => _$WeatherForecastCopyWithImpl<WeatherForecast>(this as WeatherForecast, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherForecast&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.feelsLike, feelsLike) || other.feelsLike == feelsLike)&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed)&&(identical(other.windGust, windGust) || other.windGust == windGust)&&(identical(other.windDirection, windDirection) || other.windDirection == windDirection)&&(identical(other.precipitation, precipitation) || other.precipitation == precipitation)&&(identical(other.precipitationProbability, precipitationProbability) || other.precipitationProbability == precipitationProbability)&&(identical(other.pressure, pressure) || other.pressure == pressure)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.dewPoint, dewPoint) || other.dewPoint == dewPoint)&&(identical(other.cloudCover, cloudCover) || other.cloudCover == cloudCover)&&(identical(other.uvIndex, uvIndex) || other.uvIndex == uvIndex)&&(identical(other.weatherIcon, weatherIcon) || other.weatherIcon == weatherIcon)&&(identical(other.weatherDescription, weatherDescription) || other.weatherDescription == weatherDescription));
}


@override
int get hashCode => Object.hash(runtimeType,timestamp,location,providerId,temperature,feelsLike,windSpeed,windGust,windDirection,precipitation,precipitationProbability,pressure,humidity,dewPoint,cloudCover,uvIndex,weatherIcon,weatherDescription);

@override
String toString() {
  return 'WeatherForecast(timestamp: $timestamp, location: $location, providerId: $providerId, temperature: $temperature, feelsLike: $feelsLike, windSpeed: $windSpeed, windGust: $windGust, windDirection: $windDirection, precipitation: $precipitation, precipitationProbability: $precipitationProbability, pressure: $pressure, humidity: $humidity, dewPoint: $dewPoint, cloudCover: $cloudCover, uvIndex: $uvIndex, weatherIcon: $weatherIcon, weatherDescription: $weatherDescription)';
}


}

/// @nodoc
abstract mixin class $WeatherForecastCopyWith<$Res>  {
  factory $WeatherForecastCopyWith(WeatherForecast value, $Res Function(WeatherForecast) _then) = _$WeatherForecastCopyWithImpl;
@useResult
$Res call({
 DateTime timestamp, LatLng? location, int? providerId, double? temperature, double? feelsLike, double? windSpeed, double? windGust, double? windDirection, double? precipitation, double? precipitationProbability, double? pressure, double? humidity, double? dewPoint, double? cloudCover, double? uvIndex, String? weatherIcon, String? weatherDescription
});




}
/// @nodoc
class _$WeatherForecastCopyWithImpl<$Res>
    implements $WeatherForecastCopyWith<$Res> {
  _$WeatherForecastCopyWithImpl(this._self, this._then);

  final WeatherForecast _self;
  final $Res Function(WeatherForecast) _then;

/// Create a copy of WeatherForecast
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timestamp = null,Object? location = freezed,Object? providerId = freezed,Object? temperature = freezed,Object? feelsLike = freezed,Object? windSpeed = freezed,Object? windGust = freezed,Object? windDirection = freezed,Object? precipitation = freezed,Object? precipitationProbability = freezed,Object? pressure = freezed,Object? humidity = freezed,Object? dewPoint = freezed,Object? cloudCover = freezed,Object? uvIndex = freezed,Object? weatherIcon = freezed,Object? weatherDescription = freezed,}) {
  return _then(_self.copyWith(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng?,providerId: freezed == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as int?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,feelsLike: freezed == feelsLike ? _self.feelsLike : feelsLike // ignore: cast_nullable_to_non_nullable
as double?,windSpeed: freezed == windSpeed ? _self.windSpeed : windSpeed // ignore: cast_nullable_to_non_nullable
as double?,windGust: freezed == windGust ? _self.windGust : windGust // ignore: cast_nullable_to_non_nullable
as double?,windDirection: freezed == windDirection ? _self.windDirection : windDirection // ignore: cast_nullable_to_non_nullable
as double?,precipitation: freezed == precipitation ? _self.precipitation : precipitation // ignore: cast_nullable_to_non_nullable
as double?,precipitationProbability: freezed == precipitationProbability ? _self.precipitationProbability : precipitationProbability // ignore: cast_nullable_to_non_nullable
as double?,pressure: freezed == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as double?,humidity: freezed == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as double?,dewPoint: freezed == dewPoint ? _self.dewPoint : dewPoint // ignore: cast_nullable_to_non_nullable
as double?,cloudCover: freezed == cloudCover ? _self.cloudCover : cloudCover // ignore: cast_nullable_to_non_nullable
as double?,uvIndex: freezed == uvIndex ? _self.uvIndex : uvIndex // ignore: cast_nullable_to_non_nullable
as double?,weatherIcon: freezed == weatherIcon ? _self.weatherIcon : weatherIcon // ignore: cast_nullable_to_non_nullable
as String?,weatherDescription: freezed == weatherDescription ? _self.weatherDescription : weatherDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherForecast].
extension WeatherForecastPatterns on WeatherForecast {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherForecast value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherForecast() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherForecast value)  $default,){
final _that = this;
switch (_that) {
case _WeatherForecast():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherForecast value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherForecast() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime timestamp,  LatLng? location,  int? providerId,  double? temperature,  double? feelsLike,  double? windSpeed,  double? windGust,  double? windDirection,  double? precipitation,  double? precipitationProbability,  double? pressure,  double? humidity,  double? dewPoint,  double? cloudCover,  double? uvIndex,  String? weatherIcon,  String? weatherDescription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherForecast() when $default != null:
return $default(_that.timestamp,_that.location,_that.providerId,_that.temperature,_that.feelsLike,_that.windSpeed,_that.windGust,_that.windDirection,_that.precipitation,_that.precipitationProbability,_that.pressure,_that.humidity,_that.dewPoint,_that.cloudCover,_that.uvIndex,_that.weatherIcon,_that.weatherDescription);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime timestamp,  LatLng? location,  int? providerId,  double? temperature,  double? feelsLike,  double? windSpeed,  double? windGust,  double? windDirection,  double? precipitation,  double? precipitationProbability,  double? pressure,  double? humidity,  double? dewPoint,  double? cloudCover,  double? uvIndex,  String? weatherIcon,  String? weatherDescription)  $default,) {final _that = this;
switch (_that) {
case _WeatherForecast():
return $default(_that.timestamp,_that.location,_that.providerId,_that.temperature,_that.feelsLike,_that.windSpeed,_that.windGust,_that.windDirection,_that.precipitation,_that.precipitationProbability,_that.pressure,_that.humidity,_that.dewPoint,_that.cloudCover,_that.uvIndex,_that.weatherIcon,_that.weatherDescription);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime timestamp,  LatLng? location,  int? providerId,  double? temperature,  double? feelsLike,  double? windSpeed,  double? windGust,  double? windDirection,  double? precipitation,  double? precipitationProbability,  double? pressure,  double? humidity,  double? dewPoint,  double? cloudCover,  double? uvIndex,  String? weatherIcon,  String? weatherDescription)?  $default,) {final _that = this;
switch (_that) {
case _WeatherForecast() when $default != null:
return $default(_that.timestamp,_that.location,_that.providerId,_that.temperature,_that.feelsLike,_that.windSpeed,_that.windGust,_that.windDirection,_that.precipitation,_that.precipitationProbability,_that.pressure,_that.humidity,_that.dewPoint,_that.cloudCover,_that.uvIndex,_that.weatherIcon,_that.weatherDescription);case _:
  return null;

}
}

}

/// @nodoc


class _WeatherForecast implements WeatherForecast {
  const _WeatherForecast({required this.timestamp, this.location, this.providerId, this.temperature, this.feelsLike, this.windSpeed, this.windGust, this.windDirection, this.precipitation, this.precipitationProbability, this.pressure, this.humidity, this.dewPoint, this.cloudCover, this.uvIndex, this.weatherIcon, this.weatherDescription});
  

@override final  DateTime timestamp;
@override final  LatLng? location;
@override final  int? providerId;
@override final  double? temperature;
@override final  double? feelsLike;
@override final  double? windSpeed;
@override final  double? windGust;
@override final  double? windDirection;
@override final  double? precipitation;
@override final  double? precipitationProbability;
@override final  double? pressure;
@override final  double? humidity;
@override final  double? dewPoint;
@override final  double? cloudCover;
@override final  double? uvIndex;
@override final  String? weatherIcon;
@override final  String? weatherDescription;

/// Create a copy of WeatherForecast
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherForecastCopyWith<_WeatherForecast> get copyWith => __$WeatherForecastCopyWithImpl<_WeatherForecast>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherForecast&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.feelsLike, feelsLike) || other.feelsLike == feelsLike)&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed)&&(identical(other.windGust, windGust) || other.windGust == windGust)&&(identical(other.windDirection, windDirection) || other.windDirection == windDirection)&&(identical(other.precipitation, precipitation) || other.precipitation == precipitation)&&(identical(other.precipitationProbability, precipitationProbability) || other.precipitationProbability == precipitationProbability)&&(identical(other.pressure, pressure) || other.pressure == pressure)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.dewPoint, dewPoint) || other.dewPoint == dewPoint)&&(identical(other.cloudCover, cloudCover) || other.cloudCover == cloudCover)&&(identical(other.uvIndex, uvIndex) || other.uvIndex == uvIndex)&&(identical(other.weatherIcon, weatherIcon) || other.weatherIcon == weatherIcon)&&(identical(other.weatherDescription, weatherDescription) || other.weatherDescription == weatherDescription));
}


@override
int get hashCode => Object.hash(runtimeType,timestamp,location,providerId,temperature,feelsLike,windSpeed,windGust,windDirection,precipitation,precipitationProbability,pressure,humidity,dewPoint,cloudCover,uvIndex,weatherIcon,weatherDescription);

@override
String toString() {
  return 'WeatherForecast(timestamp: $timestamp, location: $location, providerId: $providerId, temperature: $temperature, feelsLike: $feelsLike, windSpeed: $windSpeed, windGust: $windGust, windDirection: $windDirection, precipitation: $precipitation, precipitationProbability: $precipitationProbability, pressure: $pressure, humidity: $humidity, dewPoint: $dewPoint, cloudCover: $cloudCover, uvIndex: $uvIndex, weatherIcon: $weatherIcon, weatherDescription: $weatherDescription)';
}


}

/// @nodoc
abstract mixin class _$WeatherForecastCopyWith<$Res> implements $WeatherForecastCopyWith<$Res> {
  factory _$WeatherForecastCopyWith(_WeatherForecast value, $Res Function(_WeatherForecast) _then) = __$WeatherForecastCopyWithImpl;
@override @useResult
$Res call({
 DateTime timestamp, LatLng? location, int? providerId, double? temperature, double? feelsLike, double? windSpeed, double? windGust, double? windDirection, double? precipitation, double? precipitationProbability, double? pressure, double? humidity, double? dewPoint, double? cloudCover, double? uvIndex, String? weatherIcon, String? weatherDescription
});




}
/// @nodoc
class __$WeatherForecastCopyWithImpl<$Res>
    implements _$WeatherForecastCopyWith<$Res> {
  __$WeatherForecastCopyWithImpl(this._self, this._then);

  final _WeatherForecast _self;
  final $Res Function(_WeatherForecast) _then;

/// Create a copy of WeatherForecast
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timestamp = null,Object? location = freezed,Object? providerId = freezed,Object? temperature = freezed,Object? feelsLike = freezed,Object? windSpeed = freezed,Object? windGust = freezed,Object? windDirection = freezed,Object? precipitation = freezed,Object? precipitationProbability = freezed,Object? pressure = freezed,Object? humidity = freezed,Object? dewPoint = freezed,Object? cloudCover = freezed,Object? uvIndex = freezed,Object? weatherIcon = freezed,Object? weatherDescription = freezed,}) {
  return _then(_WeatherForecast(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng?,providerId: freezed == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as int?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,feelsLike: freezed == feelsLike ? _self.feelsLike : feelsLike // ignore: cast_nullable_to_non_nullable
as double?,windSpeed: freezed == windSpeed ? _self.windSpeed : windSpeed // ignore: cast_nullable_to_non_nullable
as double?,windGust: freezed == windGust ? _self.windGust : windGust // ignore: cast_nullable_to_non_nullable
as double?,windDirection: freezed == windDirection ? _self.windDirection : windDirection // ignore: cast_nullable_to_non_nullable
as double?,precipitation: freezed == precipitation ? _self.precipitation : precipitation // ignore: cast_nullable_to_non_nullable
as double?,precipitationProbability: freezed == precipitationProbability ? _self.precipitationProbability : precipitationProbability // ignore: cast_nullable_to_non_nullable
as double?,pressure: freezed == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as double?,humidity: freezed == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as double?,dewPoint: freezed == dewPoint ? _self.dewPoint : dewPoint // ignore: cast_nullable_to_non_nullable
as double?,cloudCover: freezed == cloudCover ? _self.cloudCover : cloudCover // ignore: cast_nullable_to_non_nullable
as double?,uvIndex: freezed == uvIndex ? _self.uvIndex : uvIndex // ignore: cast_nullable_to_non_nullable
as double?,weatherIcon: freezed == weatherIcon ? _self.weatherIcon : weatherIcon // ignore: cast_nullable_to_non_nullable
as String?,weatherDescription: freezed == weatherDescription ? _self.weatherDescription : weatherDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
