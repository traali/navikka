// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_observation_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeatherObservationDto {

 DateTime get timestamp;@LatLngConverter() LatLng get location; double? get temperature; double? get feelsLike; double? get windSpeed; double? get windGust; double? get windDirection; double? get pressure; String? get stationName; int? get providerId; double? get visibility; double? get humidity; double? get dewPoint; double? get precipitation; double? get cloudCover; double? get uvIndex; double? get snowfall; int? get weatherCode; String? get weatherIcon; String? get weatherDescription; DateTime? get sunrise; DateTime? get sunset;
/// Create a copy of WeatherObservationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherObservationDtoCopyWith<WeatherObservationDto> get copyWith => _$WeatherObservationDtoCopyWithImpl<WeatherObservationDto>(this as WeatherObservationDto, _$identity);

  /// Serializes this WeatherObservationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherObservationDto&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.feelsLike, feelsLike) || other.feelsLike == feelsLike)&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed)&&(identical(other.windGust, windGust) || other.windGust == windGust)&&(identical(other.windDirection, windDirection) || other.windDirection == windDirection)&&(identical(other.pressure, pressure) || other.pressure == pressure)&&(identical(other.stationName, stationName) || other.stationName == stationName)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.dewPoint, dewPoint) || other.dewPoint == dewPoint)&&(identical(other.precipitation, precipitation) || other.precipitation == precipitation)&&(identical(other.cloudCover, cloudCover) || other.cloudCover == cloudCover)&&(identical(other.uvIndex, uvIndex) || other.uvIndex == uvIndex)&&(identical(other.snowfall, snowfall) || other.snowfall == snowfall)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode)&&(identical(other.weatherIcon, weatherIcon) || other.weatherIcon == weatherIcon)&&(identical(other.weatherDescription, weatherDescription) || other.weatherDescription == weatherDescription)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.sunset, sunset) || other.sunset == sunset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,timestamp,location,temperature,feelsLike,windSpeed,windGust,windDirection,pressure,stationName,providerId,visibility,humidity,dewPoint,precipitation,cloudCover,uvIndex,snowfall,weatherCode,weatherIcon,weatherDescription,sunrise,sunset]);

@override
String toString() {
  return 'WeatherObservationDto(timestamp: $timestamp, location: $location, temperature: $temperature, feelsLike: $feelsLike, windSpeed: $windSpeed, windGust: $windGust, windDirection: $windDirection, pressure: $pressure, stationName: $stationName, providerId: $providerId, visibility: $visibility, humidity: $humidity, dewPoint: $dewPoint, precipitation: $precipitation, cloudCover: $cloudCover, uvIndex: $uvIndex, snowfall: $snowfall, weatherCode: $weatherCode, weatherIcon: $weatherIcon, weatherDescription: $weatherDescription, sunrise: $sunrise, sunset: $sunset)';
}


}

/// @nodoc
abstract mixin class $WeatherObservationDtoCopyWith<$Res>  {
  factory $WeatherObservationDtoCopyWith(WeatherObservationDto value, $Res Function(WeatherObservationDto) _then) = _$WeatherObservationDtoCopyWithImpl;
@useResult
$Res call({
 DateTime timestamp,@LatLngConverter() LatLng location, double? temperature, double? feelsLike, double? windSpeed, double? windGust, double? windDirection, double? pressure, String? stationName, int? providerId, double? visibility, double? humidity, double? dewPoint, double? precipitation, double? cloudCover, double? uvIndex, double? snowfall, int? weatherCode, String? weatherIcon, String? weatherDescription, DateTime? sunrise, DateTime? sunset
});




}
/// @nodoc
class _$WeatherObservationDtoCopyWithImpl<$Res>
    implements $WeatherObservationDtoCopyWith<$Res> {
  _$WeatherObservationDtoCopyWithImpl(this._self, this._then);

  final WeatherObservationDto _self;
  final $Res Function(WeatherObservationDto) _then;

/// Create a copy of WeatherObservationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timestamp = null,Object? location = null,Object? temperature = freezed,Object? feelsLike = freezed,Object? windSpeed = freezed,Object? windGust = freezed,Object? windDirection = freezed,Object? pressure = freezed,Object? stationName = freezed,Object? providerId = freezed,Object? visibility = freezed,Object? humidity = freezed,Object? dewPoint = freezed,Object? precipitation = freezed,Object? cloudCover = freezed,Object? uvIndex = freezed,Object? snowfall = freezed,Object? weatherCode = freezed,Object? weatherIcon = freezed,Object? weatherDescription = freezed,Object? sunrise = freezed,Object? sunset = freezed,}) {
  return _then(_self.copyWith(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,feelsLike: freezed == feelsLike ? _self.feelsLike : feelsLike // ignore: cast_nullable_to_non_nullable
as double?,windSpeed: freezed == windSpeed ? _self.windSpeed : windSpeed // ignore: cast_nullable_to_non_nullable
as double?,windGust: freezed == windGust ? _self.windGust : windGust // ignore: cast_nullable_to_non_nullable
as double?,windDirection: freezed == windDirection ? _self.windDirection : windDirection // ignore: cast_nullable_to_non_nullable
as double?,pressure: freezed == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as double?,stationName: freezed == stationName ? _self.stationName : stationName // ignore: cast_nullable_to_non_nullable
as String?,providerId: freezed == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as int?,visibility: freezed == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
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
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherObservationDto].
extension WeatherObservationDtoPatterns on WeatherObservationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherObservationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherObservationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherObservationDto value)  $default,){
final _that = this;
switch (_that) {
case _WeatherObservationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherObservationDto value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherObservationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime timestamp, @LatLngConverter()  LatLng location,  double? temperature,  double? feelsLike,  double? windSpeed,  double? windGust,  double? windDirection,  double? pressure,  String? stationName,  int? providerId,  double? visibility,  double? humidity,  double? dewPoint,  double? precipitation,  double? cloudCover,  double? uvIndex,  double? snowfall,  int? weatherCode,  String? weatherIcon,  String? weatherDescription,  DateTime? sunrise,  DateTime? sunset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherObservationDto() when $default != null:
return $default(_that.timestamp,_that.location,_that.temperature,_that.feelsLike,_that.windSpeed,_that.windGust,_that.windDirection,_that.pressure,_that.stationName,_that.providerId,_that.visibility,_that.humidity,_that.dewPoint,_that.precipitation,_that.cloudCover,_that.uvIndex,_that.snowfall,_that.weatherCode,_that.weatherIcon,_that.weatherDescription,_that.sunrise,_that.sunset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime timestamp, @LatLngConverter()  LatLng location,  double? temperature,  double? feelsLike,  double? windSpeed,  double? windGust,  double? windDirection,  double? pressure,  String? stationName,  int? providerId,  double? visibility,  double? humidity,  double? dewPoint,  double? precipitation,  double? cloudCover,  double? uvIndex,  double? snowfall,  int? weatherCode,  String? weatherIcon,  String? weatherDescription,  DateTime? sunrise,  DateTime? sunset)  $default,) {final _that = this;
switch (_that) {
case _WeatherObservationDto():
return $default(_that.timestamp,_that.location,_that.temperature,_that.feelsLike,_that.windSpeed,_that.windGust,_that.windDirection,_that.pressure,_that.stationName,_that.providerId,_that.visibility,_that.humidity,_that.dewPoint,_that.precipitation,_that.cloudCover,_that.uvIndex,_that.snowfall,_that.weatherCode,_that.weatherIcon,_that.weatherDescription,_that.sunrise,_that.sunset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime timestamp, @LatLngConverter()  LatLng location,  double? temperature,  double? feelsLike,  double? windSpeed,  double? windGust,  double? windDirection,  double? pressure,  String? stationName,  int? providerId,  double? visibility,  double? humidity,  double? dewPoint,  double? precipitation,  double? cloudCover,  double? uvIndex,  double? snowfall,  int? weatherCode,  String? weatherIcon,  String? weatherDescription,  DateTime? sunrise,  DateTime? sunset)?  $default,) {final _that = this;
switch (_that) {
case _WeatherObservationDto() when $default != null:
return $default(_that.timestamp,_that.location,_that.temperature,_that.feelsLike,_that.windSpeed,_that.windGust,_that.windDirection,_that.pressure,_that.stationName,_that.providerId,_that.visibility,_that.humidity,_that.dewPoint,_that.precipitation,_that.cloudCover,_that.uvIndex,_that.snowfall,_that.weatherCode,_that.weatherIcon,_that.weatherDescription,_that.sunrise,_that.sunset);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeatherObservationDto implements WeatherObservationDto {
  const _WeatherObservationDto({required this.timestamp, @LatLngConverter() required this.location, this.temperature, this.feelsLike, this.windSpeed, this.windGust, this.windDirection, this.pressure, this.stationName, this.providerId, this.visibility, this.humidity, this.dewPoint, this.precipitation, this.cloudCover, this.uvIndex, this.snowfall, this.weatherCode, this.weatherIcon, this.weatherDescription, this.sunrise, this.sunset});
  factory _WeatherObservationDto.fromJson(Map<String, dynamic> json) => _$WeatherObservationDtoFromJson(json);

@override final  DateTime timestamp;
@override@LatLngConverter() final  LatLng location;
@override final  double? temperature;
@override final  double? feelsLike;
@override final  double? windSpeed;
@override final  double? windGust;
@override final  double? windDirection;
@override final  double? pressure;
@override final  String? stationName;
@override final  int? providerId;
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

/// Create a copy of WeatherObservationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherObservationDtoCopyWith<_WeatherObservationDto> get copyWith => __$WeatherObservationDtoCopyWithImpl<_WeatherObservationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherObservationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherObservationDto&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.feelsLike, feelsLike) || other.feelsLike == feelsLike)&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed)&&(identical(other.windGust, windGust) || other.windGust == windGust)&&(identical(other.windDirection, windDirection) || other.windDirection == windDirection)&&(identical(other.pressure, pressure) || other.pressure == pressure)&&(identical(other.stationName, stationName) || other.stationName == stationName)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.dewPoint, dewPoint) || other.dewPoint == dewPoint)&&(identical(other.precipitation, precipitation) || other.precipitation == precipitation)&&(identical(other.cloudCover, cloudCover) || other.cloudCover == cloudCover)&&(identical(other.uvIndex, uvIndex) || other.uvIndex == uvIndex)&&(identical(other.snowfall, snowfall) || other.snowfall == snowfall)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode)&&(identical(other.weatherIcon, weatherIcon) || other.weatherIcon == weatherIcon)&&(identical(other.weatherDescription, weatherDescription) || other.weatherDescription == weatherDescription)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.sunset, sunset) || other.sunset == sunset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,timestamp,location,temperature,feelsLike,windSpeed,windGust,windDirection,pressure,stationName,providerId,visibility,humidity,dewPoint,precipitation,cloudCover,uvIndex,snowfall,weatherCode,weatherIcon,weatherDescription,sunrise,sunset]);

@override
String toString() {
  return 'WeatherObservationDto(timestamp: $timestamp, location: $location, temperature: $temperature, feelsLike: $feelsLike, windSpeed: $windSpeed, windGust: $windGust, windDirection: $windDirection, pressure: $pressure, stationName: $stationName, providerId: $providerId, visibility: $visibility, humidity: $humidity, dewPoint: $dewPoint, precipitation: $precipitation, cloudCover: $cloudCover, uvIndex: $uvIndex, snowfall: $snowfall, weatherCode: $weatherCode, weatherIcon: $weatherIcon, weatherDescription: $weatherDescription, sunrise: $sunrise, sunset: $sunset)';
}


}

/// @nodoc
abstract mixin class _$WeatherObservationDtoCopyWith<$Res> implements $WeatherObservationDtoCopyWith<$Res> {
  factory _$WeatherObservationDtoCopyWith(_WeatherObservationDto value, $Res Function(_WeatherObservationDto) _then) = __$WeatherObservationDtoCopyWithImpl;
@override @useResult
$Res call({
 DateTime timestamp,@LatLngConverter() LatLng location, double? temperature, double? feelsLike, double? windSpeed, double? windGust, double? windDirection, double? pressure, String? stationName, int? providerId, double? visibility, double? humidity, double? dewPoint, double? precipitation, double? cloudCover, double? uvIndex, double? snowfall, int? weatherCode, String? weatherIcon, String? weatherDescription, DateTime? sunrise, DateTime? sunset
});




}
/// @nodoc
class __$WeatherObservationDtoCopyWithImpl<$Res>
    implements _$WeatherObservationDtoCopyWith<$Res> {
  __$WeatherObservationDtoCopyWithImpl(this._self, this._then);

  final _WeatherObservationDto _self;
  final $Res Function(_WeatherObservationDto) _then;

/// Create a copy of WeatherObservationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timestamp = null,Object? location = null,Object? temperature = freezed,Object? feelsLike = freezed,Object? windSpeed = freezed,Object? windGust = freezed,Object? windDirection = freezed,Object? pressure = freezed,Object? stationName = freezed,Object? providerId = freezed,Object? visibility = freezed,Object? humidity = freezed,Object? dewPoint = freezed,Object? precipitation = freezed,Object? cloudCover = freezed,Object? uvIndex = freezed,Object? snowfall = freezed,Object? weatherCode = freezed,Object? weatherIcon = freezed,Object? weatherDescription = freezed,Object? sunrise = freezed,Object? sunset = freezed,}) {
  return _then(_WeatherObservationDto(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,feelsLike: freezed == feelsLike ? _self.feelsLike : feelsLike // ignore: cast_nullable_to_non_nullable
as double?,windSpeed: freezed == windSpeed ? _self.windSpeed : windSpeed // ignore: cast_nullable_to_non_nullable
as double?,windGust: freezed == windGust ? _self.windGust : windGust // ignore: cast_nullable_to_non_nullable
as double?,windDirection: freezed == windDirection ? _self.windDirection : windDirection // ignore: cast_nullable_to_non_nullable
as double?,pressure: freezed == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as double?,stationName: freezed == stationName ? _self.stationName : stationName // ignore: cast_nullable_to_non_nullable
as String?,providerId: freezed == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as int?,visibility: freezed == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
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
as DateTime?,
  ));
}


}

// dart format on
