// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'point_weather_data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PointWeatherDataState {

 List<WeatherData> get observations; List<WeatherForecast> get forecast; List<WaveData> get waves; List<SeaLevel> get seaLevels; List<WaterQualityData> get waterQuality; List<AlgaeData> get algae;
/// Create a copy of PointWeatherDataState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PointWeatherDataStateCopyWith<PointWeatherDataState> get copyWith => _$PointWeatherDataStateCopyWithImpl<PointWeatherDataState>(this as PointWeatherDataState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PointWeatherDataState&&const DeepCollectionEquality().equals(other.observations, observations)&&const DeepCollectionEquality().equals(other.forecast, forecast)&&const DeepCollectionEquality().equals(other.waves, waves)&&const DeepCollectionEquality().equals(other.seaLevels, seaLevels)&&const DeepCollectionEquality().equals(other.waterQuality, waterQuality)&&const DeepCollectionEquality().equals(other.algae, algae));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(observations),const DeepCollectionEquality().hash(forecast),const DeepCollectionEquality().hash(waves),const DeepCollectionEquality().hash(seaLevels),const DeepCollectionEquality().hash(waterQuality),const DeepCollectionEquality().hash(algae));

@override
String toString() {
  return 'PointWeatherDataState(observations: $observations, forecast: $forecast, waves: $waves, seaLevels: $seaLevels, waterQuality: $waterQuality, algae: $algae)';
}


}

/// @nodoc
abstract mixin class $PointWeatherDataStateCopyWith<$Res>  {
  factory $PointWeatherDataStateCopyWith(PointWeatherDataState value, $Res Function(PointWeatherDataState) _then) = _$PointWeatherDataStateCopyWithImpl;
@useResult
$Res call({
 List<WeatherData> observations, List<WeatherForecast> forecast, List<WaveData> waves, List<SeaLevel> seaLevels, List<WaterQualityData> waterQuality, List<AlgaeData> algae
});




}
/// @nodoc
class _$PointWeatherDataStateCopyWithImpl<$Res>
    implements $PointWeatherDataStateCopyWith<$Res> {
  _$PointWeatherDataStateCopyWithImpl(this._self, this._then);

  final PointWeatherDataState _self;
  final $Res Function(PointWeatherDataState) _then;

/// Create a copy of PointWeatherDataState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? observations = null,Object? forecast = null,Object? waves = null,Object? seaLevels = null,Object? waterQuality = null,Object? algae = null,}) {
  return _then(_self.copyWith(
observations: null == observations ? _self.observations : observations // ignore: cast_nullable_to_non_nullable
as List<WeatherData>,forecast: null == forecast ? _self.forecast : forecast // ignore: cast_nullable_to_non_nullable
as List<WeatherForecast>,waves: null == waves ? _self.waves : waves // ignore: cast_nullable_to_non_nullable
as List<WaveData>,seaLevels: null == seaLevels ? _self.seaLevels : seaLevels // ignore: cast_nullable_to_non_nullable
as List<SeaLevel>,waterQuality: null == waterQuality ? _self.waterQuality : waterQuality // ignore: cast_nullable_to_non_nullable
as List<WaterQualityData>,algae: null == algae ? _self.algae : algae // ignore: cast_nullable_to_non_nullable
as List<AlgaeData>,
  ));
}

}


/// Adds pattern-matching-related methods to [PointWeatherDataState].
extension PointWeatherDataStatePatterns on PointWeatherDataState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PointWeatherDataState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PointWeatherDataState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PointWeatherDataState value)  $default,){
final _that = this;
switch (_that) {
case _PointWeatherDataState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PointWeatherDataState value)?  $default,){
final _that = this;
switch (_that) {
case _PointWeatherDataState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<WeatherData> observations,  List<WeatherForecast> forecast,  List<WaveData> waves,  List<SeaLevel> seaLevels,  List<WaterQualityData> waterQuality,  List<AlgaeData> algae)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PointWeatherDataState() when $default != null:
return $default(_that.observations,_that.forecast,_that.waves,_that.seaLevels,_that.waterQuality,_that.algae);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<WeatherData> observations,  List<WeatherForecast> forecast,  List<WaveData> waves,  List<SeaLevel> seaLevels,  List<WaterQualityData> waterQuality,  List<AlgaeData> algae)  $default,) {final _that = this;
switch (_that) {
case _PointWeatherDataState():
return $default(_that.observations,_that.forecast,_that.waves,_that.seaLevels,_that.waterQuality,_that.algae);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<WeatherData> observations,  List<WeatherForecast> forecast,  List<WaveData> waves,  List<SeaLevel> seaLevels,  List<WaterQualityData> waterQuality,  List<AlgaeData> algae)?  $default,) {final _that = this;
switch (_that) {
case _PointWeatherDataState() when $default != null:
return $default(_that.observations,_that.forecast,_that.waves,_that.seaLevels,_that.waterQuality,_that.algae);case _:
  return null;

}
}

}

/// @nodoc


class _PointWeatherDataState implements PointWeatherDataState {
  const _PointWeatherDataState({required final  List<WeatherData> observations, required final  List<WeatherForecast> forecast, required final  List<WaveData> waves, required final  List<SeaLevel> seaLevels, required final  List<WaterQualityData> waterQuality, required final  List<AlgaeData> algae}): _observations = observations,_forecast = forecast,_waves = waves,_seaLevels = seaLevels,_waterQuality = waterQuality,_algae = algae;
  

 final  List<WeatherData> _observations;
@override List<WeatherData> get observations {
  if (_observations is EqualUnmodifiableListView) return _observations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_observations);
}

 final  List<WeatherForecast> _forecast;
@override List<WeatherForecast> get forecast {
  if (_forecast is EqualUnmodifiableListView) return _forecast;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_forecast);
}

 final  List<WaveData> _waves;
@override List<WaveData> get waves {
  if (_waves is EqualUnmodifiableListView) return _waves;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_waves);
}

 final  List<SeaLevel> _seaLevels;
@override List<SeaLevel> get seaLevels {
  if (_seaLevels is EqualUnmodifiableListView) return _seaLevels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_seaLevels);
}

 final  List<WaterQualityData> _waterQuality;
@override List<WaterQualityData> get waterQuality {
  if (_waterQuality is EqualUnmodifiableListView) return _waterQuality;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_waterQuality);
}

 final  List<AlgaeData> _algae;
@override List<AlgaeData> get algae {
  if (_algae is EqualUnmodifiableListView) return _algae;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_algae);
}


/// Create a copy of PointWeatherDataState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PointWeatherDataStateCopyWith<_PointWeatherDataState> get copyWith => __$PointWeatherDataStateCopyWithImpl<_PointWeatherDataState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PointWeatherDataState&&const DeepCollectionEquality().equals(other._observations, _observations)&&const DeepCollectionEquality().equals(other._forecast, _forecast)&&const DeepCollectionEquality().equals(other._waves, _waves)&&const DeepCollectionEquality().equals(other._seaLevels, _seaLevels)&&const DeepCollectionEquality().equals(other._waterQuality, _waterQuality)&&const DeepCollectionEquality().equals(other._algae, _algae));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_observations),const DeepCollectionEquality().hash(_forecast),const DeepCollectionEquality().hash(_waves),const DeepCollectionEquality().hash(_seaLevels),const DeepCollectionEquality().hash(_waterQuality),const DeepCollectionEquality().hash(_algae));

@override
String toString() {
  return 'PointWeatherDataState(observations: $observations, forecast: $forecast, waves: $waves, seaLevels: $seaLevels, waterQuality: $waterQuality, algae: $algae)';
}


}

/// @nodoc
abstract mixin class _$PointWeatherDataStateCopyWith<$Res> implements $PointWeatherDataStateCopyWith<$Res> {
  factory _$PointWeatherDataStateCopyWith(_PointWeatherDataState value, $Res Function(_PointWeatherDataState) _then) = __$PointWeatherDataStateCopyWithImpl;
@override @useResult
$Res call({
 List<WeatherData> observations, List<WeatherForecast> forecast, List<WaveData> waves, List<SeaLevel> seaLevels, List<WaterQualityData> waterQuality, List<AlgaeData> algae
});




}
/// @nodoc
class __$PointWeatherDataStateCopyWithImpl<$Res>
    implements _$PointWeatherDataStateCopyWith<$Res> {
  __$PointWeatherDataStateCopyWithImpl(this._self, this._then);

  final _PointWeatherDataState _self;
  final $Res Function(_PointWeatherDataState) _then;

/// Create a copy of PointWeatherDataState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? observations = null,Object? forecast = null,Object? waves = null,Object? seaLevels = null,Object? waterQuality = null,Object? algae = null,}) {
  return _then(_PointWeatherDataState(
observations: null == observations ? _self._observations : observations // ignore: cast_nullable_to_non_nullable
as List<WeatherData>,forecast: null == forecast ? _self._forecast : forecast // ignore: cast_nullable_to_non_nullable
as List<WeatherForecast>,waves: null == waves ? _self._waves : waves // ignore: cast_nullable_to_non_nullable
as List<WaveData>,seaLevels: null == seaLevels ? _self._seaLevels : seaLevels // ignore: cast_nullable_to_non_nullable
as List<SeaLevel>,waterQuality: null == waterQuality ? _self._waterQuality : waterQuality // ignore: cast_nullable_to_non_nullable
as List<WaterQualityData>,algae: null == algae ? _self._algae : algae // ignore: cast_nullable_to_non_nullable
as List<AlgaeData>,
  ));
}


}

// dart format on
