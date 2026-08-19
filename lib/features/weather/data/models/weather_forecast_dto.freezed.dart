// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_forecast_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeatherForecastDto {

 DateTime get timestamp;@LatLngConverter() LatLng get location; DateTime? get issuedAt; int? get providerId; double? get temperature; double? get feelsLike; double? get windSpeed; double? get windGust; double? get windDirection; double? get precipitation; double? get precipitationProbability; double? get pressure; double? get humidity; double? get dewPoint; double? get cloudCover; double? get uvIndex; String? get weatherIcon; String? get weatherDescription;
/// Create a copy of WeatherForecastDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherForecastDtoCopyWith<WeatherForecastDto> get copyWith => _$WeatherForecastDtoCopyWithImpl<WeatherForecastDto>(this as WeatherForecastDto, _$identity);

  /// Serializes this WeatherForecastDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherForecastDto&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.feelsLike, feelsLike) || other.feelsLike == feelsLike)&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed)&&(identical(other.windGust, windGust) || other.windGust == windGust)&&(identical(other.windDirection, windDirection) || other.windDirection == windDirection)&&(identical(other.precipitation, precipitation) || other.precipitation == precipitation)&&(identical(other.precipitationProbability, precipitationProbability) || other.precipitationProbability == precipitationProbability)&&(identical(other.pressure, pressure) || other.pressure == pressure)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.dewPoint, dewPoint) || other.dewPoint == dewPoint)&&(identical(other.cloudCover, cloudCover) || other.cloudCover == cloudCover)&&(identical(other.uvIndex, uvIndex) || other.uvIndex == uvIndex)&&(identical(other.weatherIcon, weatherIcon) || other.weatherIcon == weatherIcon)&&(identical(other.weatherDescription, weatherDescription) || other.weatherDescription == weatherDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timestamp,location,issuedAt,providerId,temperature,feelsLike,windSpeed,windGust,windDirection,precipitation,precipitationProbability,pressure,humidity,dewPoint,cloudCover,uvIndex,weatherIcon,weatherDescription);

@override
String toString() {
  return 'WeatherForecastDto(timestamp: $timestamp, location: $location, issuedAt: $issuedAt, providerId: $providerId, temperature: $temperature, feelsLike: $feelsLike, windSpeed: $windSpeed, windGust: $windGust, windDirection: $windDirection, precipitation: $precipitation, precipitationProbability: $precipitationProbability, pressure: $pressure, humidity: $humidity, dewPoint: $dewPoint, cloudCover: $cloudCover, uvIndex: $uvIndex, weatherIcon: $weatherIcon, weatherDescription: $weatherDescription)';
}


}

/// @nodoc
abstract mixin class $WeatherForecastDtoCopyWith<$Res>  {
  factory $WeatherForecastDtoCopyWith(WeatherForecastDto value, $Res Function(WeatherForecastDto) _then) = _$WeatherForecastDtoCopyWithImpl;
@useResult
$Res call({
 DateTime timestamp,@LatLngConverter() LatLng location, DateTime? issuedAt, int? providerId, double? temperature, double? feelsLike, double? windSpeed, double? windGust, double? windDirection, double? precipitation, double? precipitationProbability, double? pressure, double? humidity, double? dewPoint, double? cloudCover, double? uvIndex, String? weatherIcon, String? weatherDescription
});




}
/// @nodoc
class _$WeatherForecastDtoCopyWithImpl<$Res>
    implements $WeatherForecastDtoCopyWith<$Res> {
  _$WeatherForecastDtoCopyWithImpl(this._self, this._then);

  final WeatherForecastDto _self;
  final $Res Function(WeatherForecastDto) _then;

/// Create a copy of WeatherForecastDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timestamp = null,Object? location = null,Object? issuedAt = freezed,Object? providerId = freezed,Object? temperature = freezed,Object? feelsLike = freezed,Object? windSpeed = freezed,Object? windGust = freezed,Object? windDirection = freezed,Object? precipitation = freezed,Object? precipitationProbability = freezed,Object? pressure = freezed,Object? humidity = freezed,Object? dewPoint = freezed,Object? cloudCover = freezed,Object? uvIndex = freezed,Object? weatherIcon = freezed,Object? weatherDescription = freezed,}) {
  return _then(_self.copyWith(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,issuedAt: freezed == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,providerId: freezed == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [WeatherForecastDto].
extension WeatherForecastDtoPatterns on WeatherForecastDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherForecastDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherForecastDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherForecastDto value)  $default,){
final _that = this;
switch (_that) {
case _WeatherForecastDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherForecastDto value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherForecastDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime timestamp, @LatLngConverter()  LatLng location,  DateTime? issuedAt,  int? providerId,  double? temperature,  double? feelsLike,  double? windSpeed,  double? windGust,  double? windDirection,  double? precipitation,  double? precipitationProbability,  double? pressure,  double? humidity,  double? dewPoint,  double? cloudCover,  double? uvIndex,  String? weatherIcon,  String? weatherDescription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherForecastDto() when $default != null:
return $default(_that.timestamp,_that.location,_that.issuedAt,_that.providerId,_that.temperature,_that.feelsLike,_that.windSpeed,_that.windGust,_that.windDirection,_that.precipitation,_that.precipitationProbability,_that.pressure,_that.humidity,_that.dewPoint,_that.cloudCover,_that.uvIndex,_that.weatherIcon,_that.weatherDescription);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime timestamp, @LatLngConverter()  LatLng location,  DateTime? issuedAt,  int? providerId,  double? temperature,  double? feelsLike,  double? windSpeed,  double? windGust,  double? windDirection,  double? precipitation,  double? precipitationProbability,  double? pressure,  double? humidity,  double? dewPoint,  double? cloudCover,  double? uvIndex,  String? weatherIcon,  String? weatherDescription)  $default,) {final _that = this;
switch (_that) {
case _WeatherForecastDto():
return $default(_that.timestamp,_that.location,_that.issuedAt,_that.providerId,_that.temperature,_that.feelsLike,_that.windSpeed,_that.windGust,_that.windDirection,_that.precipitation,_that.precipitationProbability,_that.pressure,_that.humidity,_that.dewPoint,_that.cloudCover,_that.uvIndex,_that.weatherIcon,_that.weatherDescription);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime timestamp, @LatLngConverter()  LatLng location,  DateTime? issuedAt,  int? providerId,  double? temperature,  double? feelsLike,  double? windSpeed,  double? windGust,  double? windDirection,  double? precipitation,  double? precipitationProbability,  double? pressure,  double? humidity,  double? dewPoint,  double? cloudCover,  double? uvIndex,  String? weatherIcon,  String? weatherDescription)?  $default,) {final _that = this;
switch (_that) {
case _WeatherForecastDto() when $default != null:
return $default(_that.timestamp,_that.location,_that.issuedAt,_that.providerId,_that.temperature,_that.feelsLike,_that.windSpeed,_that.windGust,_that.windDirection,_that.precipitation,_that.precipitationProbability,_that.pressure,_that.humidity,_that.dewPoint,_that.cloudCover,_that.uvIndex,_that.weatherIcon,_that.weatherDescription);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeatherForecastDto implements WeatherForecastDto {
  const _WeatherForecastDto({required this.timestamp, @LatLngConverter() required this.location, this.issuedAt, this.providerId, this.temperature, this.feelsLike, this.windSpeed, this.windGust, this.windDirection, this.precipitation, this.precipitationProbability, this.pressure, this.humidity, this.dewPoint, this.cloudCover, this.uvIndex, this.weatherIcon, this.weatherDescription});
  factory _WeatherForecastDto.fromJson(Map<String, dynamic> json) => _$WeatherForecastDtoFromJson(json);

@override final  DateTime timestamp;
@override@LatLngConverter() final  LatLng location;
@override final  DateTime? issuedAt;
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

/// Create a copy of WeatherForecastDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherForecastDtoCopyWith<_WeatherForecastDto> get copyWith => __$WeatherForecastDtoCopyWithImpl<_WeatherForecastDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherForecastDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherForecastDto&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.feelsLike, feelsLike) || other.feelsLike == feelsLike)&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed)&&(identical(other.windGust, windGust) || other.windGust == windGust)&&(identical(other.windDirection, windDirection) || other.windDirection == windDirection)&&(identical(other.precipitation, precipitation) || other.precipitation == precipitation)&&(identical(other.precipitationProbability, precipitationProbability) || other.precipitationProbability == precipitationProbability)&&(identical(other.pressure, pressure) || other.pressure == pressure)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.dewPoint, dewPoint) || other.dewPoint == dewPoint)&&(identical(other.cloudCover, cloudCover) || other.cloudCover == cloudCover)&&(identical(other.uvIndex, uvIndex) || other.uvIndex == uvIndex)&&(identical(other.weatherIcon, weatherIcon) || other.weatherIcon == weatherIcon)&&(identical(other.weatherDescription, weatherDescription) || other.weatherDescription == weatherDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timestamp,location,issuedAt,providerId,temperature,feelsLike,windSpeed,windGust,windDirection,precipitation,precipitationProbability,pressure,humidity,dewPoint,cloudCover,uvIndex,weatherIcon,weatherDescription);

@override
String toString() {
  return 'WeatherForecastDto(timestamp: $timestamp, location: $location, issuedAt: $issuedAt, providerId: $providerId, temperature: $temperature, feelsLike: $feelsLike, windSpeed: $windSpeed, windGust: $windGust, windDirection: $windDirection, precipitation: $precipitation, precipitationProbability: $precipitationProbability, pressure: $pressure, humidity: $humidity, dewPoint: $dewPoint, cloudCover: $cloudCover, uvIndex: $uvIndex, weatherIcon: $weatherIcon, weatherDescription: $weatherDescription)';
}


}

/// @nodoc
abstract mixin class _$WeatherForecastDtoCopyWith<$Res> implements $WeatherForecastDtoCopyWith<$Res> {
  factory _$WeatherForecastDtoCopyWith(_WeatherForecastDto value, $Res Function(_WeatherForecastDto) _then) = __$WeatherForecastDtoCopyWithImpl;
@override @useResult
$Res call({
 DateTime timestamp,@LatLngConverter() LatLng location, DateTime? issuedAt, int? providerId, double? temperature, double? feelsLike, double? windSpeed, double? windGust, double? windDirection, double? precipitation, double? precipitationProbability, double? pressure, double? humidity, double? dewPoint, double? cloudCover, double? uvIndex, String? weatherIcon, String? weatherDescription
});




}
/// @nodoc
class __$WeatherForecastDtoCopyWithImpl<$Res>
    implements _$WeatherForecastDtoCopyWith<$Res> {
  __$WeatherForecastDtoCopyWithImpl(this._self, this._then);

  final _WeatherForecastDto _self;
  final $Res Function(_WeatherForecastDto) _then;

/// Create a copy of WeatherForecastDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timestamp = null,Object? location = null,Object? issuedAt = freezed,Object? providerId = freezed,Object? temperature = freezed,Object? feelsLike = freezed,Object? windSpeed = freezed,Object? windGust = freezed,Object? windDirection = freezed,Object? precipitation = freezed,Object? precipitationProbability = freezed,Object? pressure = freezed,Object? humidity = freezed,Object? dewPoint = freezed,Object? cloudCover = freezed,Object? uvIndex = freezed,Object? weatherIcon = freezed,Object? weatherDescription = freezed,}) {
  return _then(_WeatherForecastDto(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,issuedAt: freezed == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,providerId: freezed == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
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
