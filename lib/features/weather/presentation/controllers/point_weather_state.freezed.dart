// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'point_weather_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PointWeatherState {

 DateTime get lastUpdated; WeatherData? get weather; WaveData? get wave; SeaLevel? get seaLevel; List<WeatherForecast> get forecast; List<WeatherAlert> get activeAlerts; List<LightningStrike> get lightningStrikes; double? get nearestLightningDistanceMeters; WaterQualityData? get waterQuality; AlgaeData? get algae; bool get isLoading; String? get error; String? get syncError; DateTime? get lastSuccessfulSync; bool get isSyncing; bool get isRadarVisible; List<DateTime> get radarTimestamps; int get currentTimestampIndex; bool get isAnimating;
/// Create a copy of PointWeatherState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PointWeatherStateCopyWith<PointWeatherState> get copyWith => _$PointWeatherStateCopyWithImpl<PointWeatherState>(this as PointWeatherState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PointWeatherState&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.weather, weather) || other.weather == weather)&&(identical(other.wave, wave) || other.wave == wave)&&(identical(other.seaLevel, seaLevel) || other.seaLevel == seaLevel)&&const DeepCollectionEquality().equals(other.forecast, forecast)&&const DeepCollectionEquality().equals(other.activeAlerts, activeAlerts)&&const DeepCollectionEquality().equals(other.lightningStrikes, lightningStrikes)&&(identical(other.nearestLightningDistanceMeters, nearestLightningDistanceMeters) || other.nearestLightningDistanceMeters == nearestLightningDistanceMeters)&&(identical(other.waterQuality, waterQuality) || other.waterQuality == waterQuality)&&(identical(other.algae, algae) || other.algae == algae)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.syncError, syncError) || other.syncError == syncError)&&(identical(other.lastSuccessfulSync, lastSuccessfulSync) || other.lastSuccessfulSync == lastSuccessfulSync)&&(identical(other.isSyncing, isSyncing) || other.isSyncing == isSyncing)&&(identical(other.isRadarVisible, isRadarVisible) || other.isRadarVisible == isRadarVisible)&&const DeepCollectionEquality().equals(other.radarTimestamps, radarTimestamps)&&(identical(other.currentTimestampIndex, currentTimestampIndex) || other.currentTimestampIndex == currentTimestampIndex)&&(identical(other.isAnimating, isAnimating) || other.isAnimating == isAnimating));
}


@override
int get hashCode => Object.hashAll([runtimeType,lastUpdated,weather,wave,seaLevel,const DeepCollectionEquality().hash(forecast),const DeepCollectionEquality().hash(activeAlerts),const DeepCollectionEquality().hash(lightningStrikes),nearestLightningDistanceMeters,waterQuality,algae,isLoading,error,syncError,lastSuccessfulSync,isSyncing,isRadarVisible,const DeepCollectionEquality().hash(radarTimestamps),currentTimestampIndex,isAnimating]);

@override
String toString() {
  return 'PointWeatherState(lastUpdated: $lastUpdated, weather: $weather, wave: $wave, seaLevel: $seaLevel, forecast: $forecast, activeAlerts: $activeAlerts, lightningStrikes: $lightningStrikes, nearestLightningDistanceMeters: $nearestLightningDistanceMeters, waterQuality: $waterQuality, algae: $algae, isLoading: $isLoading, error: $error, syncError: $syncError, lastSuccessfulSync: $lastSuccessfulSync, isSyncing: $isSyncing, isRadarVisible: $isRadarVisible, radarTimestamps: $radarTimestamps, currentTimestampIndex: $currentTimestampIndex, isAnimating: $isAnimating)';
}


}

/// @nodoc
abstract mixin class $PointWeatherStateCopyWith<$Res>  {
  factory $PointWeatherStateCopyWith(PointWeatherState value, $Res Function(PointWeatherState) _then) = _$PointWeatherStateCopyWithImpl;
@useResult
$Res call({
 DateTime lastUpdated, WeatherData? weather, WaveData? wave, SeaLevel? seaLevel, List<WeatherForecast> forecast, List<WeatherAlert> activeAlerts, List<LightningStrike> lightningStrikes, double? nearestLightningDistanceMeters, WaterQualityData? waterQuality, AlgaeData? algae, bool isLoading, String? error, String? syncError, DateTime? lastSuccessfulSync, bool isSyncing, bool isRadarVisible, List<DateTime> radarTimestamps, int currentTimestampIndex, bool isAnimating
});


$WeatherDataCopyWith<$Res>? get weather;$WaveDataCopyWith<$Res>? get wave;$SeaLevelCopyWith<$Res>? get seaLevel;$WaterQualityDataCopyWith<$Res>? get waterQuality;$AlgaeDataCopyWith<$Res>? get algae;

}
/// @nodoc
class _$PointWeatherStateCopyWithImpl<$Res>
    implements $PointWeatherStateCopyWith<$Res> {
  _$PointWeatherStateCopyWithImpl(this._self, this._then);

  final PointWeatherState _self;
  final $Res Function(PointWeatherState) _then;

/// Create a copy of PointWeatherState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lastUpdated = null,Object? weather = freezed,Object? wave = freezed,Object? seaLevel = freezed,Object? forecast = null,Object? activeAlerts = null,Object? lightningStrikes = null,Object? nearestLightningDistanceMeters = freezed,Object? waterQuality = freezed,Object? algae = freezed,Object? isLoading = null,Object? error = freezed,Object? syncError = freezed,Object? lastSuccessfulSync = freezed,Object? isSyncing = null,Object? isRadarVisible = null,Object? radarTimestamps = null,Object? currentTimestampIndex = null,Object? isAnimating = null,}) {
  return _then(_self.copyWith(
lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,weather: freezed == weather ? _self.weather : weather // ignore: cast_nullable_to_non_nullable
as WeatherData?,wave: freezed == wave ? _self.wave : wave // ignore: cast_nullable_to_non_nullable
as WaveData?,seaLevel: freezed == seaLevel ? _self.seaLevel : seaLevel // ignore: cast_nullable_to_non_nullable
as SeaLevel?,forecast: null == forecast ? _self.forecast : forecast // ignore: cast_nullable_to_non_nullable
as List<WeatherForecast>,activeAlerts: null == activeAlerts ? _self.activeAlerts : activeAlerts // ignore: cast_nullable_to_non_nullable
as List<WeatherAlert>,lightningStrikes: null == lightningStrikes ? _self.lightningStrikes : lightningStrikes // ignore: cast_nullable_to_non_nullable
as List<LightningStrike>,nearestLightningDistanceMeters: freezed == nearestLightningDistanceMeters ? _self.nearestLightningDistanceMeters : nearestLightningDistanceMeters // ignore: cast_nullable_to_non_nullable
as double?,waterQuality: freezed == waterQuality ? _self.waterQuality : waterQuality // ignore: cast_nullable_to_non_nullable
as WaterQualityData?,algae: freezed == algae ? _self.algae : algae // ignore: cast_nullable_to_non_nullable
as AlgaeData?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,syncError: freezed == syncError ? _self.syncError : syncError // ignore: cast_nullable_to_non_nullable
as String?,lastSuccessfulSync: freezed == lastSuccessfulSync ? _self.lastSuccessfulSync : lastSuccessfulSync // ignore: cast_nullable_to_non_nullable
as DateTime?,isSyncing: null == isSyncing ? _self.isSyncing : isSyncing // ignore: cast_nullable_to_non_nullable
as bool,isRadarVisible: null == isRadarVisible ? _self.isRadarVisible : isRadarVisible // ignore: cast_nullable_to_non_nullable
as bool,radarTimestamps: null == radarTimestamps ? _self.radarTimestamps : radarTimestamps // ignore: cast_nullable_to_non_nullable
as List<DateTime>,currentTimestampIndex: null == currentTimestampIndex ? _self.currentTimestampIndex : currentTimestampIndex // ignore: cast_nullable_to_non_nullable
as int,isAnimating: null == isAnimating ? _self.isAnimating : isAnimating // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of PointWeatherState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeatherDataCopyWith<$Res>? get weather {
    if (_self.weather == null) {
    return null;
  }

  return $WeatherDataCopyWith<$Res>(_self.weather!, (value) {
    return _then(_self.copyWith(weather: value));
  });
}/// Create a copy of PointWeatherState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WaveDataCopyWith<$Res>? get wave {
    if (_self.wave == null) {
    return null;
  }

  return $WaveDataCopyWith<$Res>(_self.wave!, (value) {
    return _then(_self.copyWith(wave: value));
  });
}/// Create a copy of PointWeatherState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeaLevelCopyWith<$Res>? get seaLevel {
    if (_self.seaLevel == null) {
    return null;
  }

  return $SeaLevelCopyWith<$Res>(_self.seaLevel!, (value) {
    return _then(_self.copyWith(seaLevel: value));
  });
}/// Create a copy of PointWeatherState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WaterQualityDataCopyWith<$Res>? get waterQuality {
    if (_self.waterQuality == null) {
    return null;
  }

  return $WaterQualityDataCopyWith<$Res>(_self.waterQuality!, (value) {
    return _then(_self.copyWith(waterQuality: value));
  });
}/// Create a copy of PointWeatherState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AlgaeDataCopyWith<$Res>? get algae {
    if (_self.algae == null) {
    return null;
  }

  return $AlgaeDataCopyWith<$Res>(_self.algae!, (value) {
    return _then(_self.copyWith(algae: value));
  });
}
}


/// Adds pattern-matching-related methods to [PointWeatherState].
extension PointWeatherStatePatterns on PointWeatherState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PointWeatherState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PointWeatherState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PointWeatherState value)  $default,){
final _that = this;
switch (_that) {
case _PointWeatherState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PointWeatherState value)?  $default,){
final _that = this;
switch (_that) {
case _PointWeatherState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime lastUpdated,  WeatherData? weather,  WaveData? wave,  SeaLevel? seaLevel,  List<WeatherForecast> forecast,  List<WeatherAlert> activeAlerts,  List<LightningStrike> lightningStrikes,  double? nearestLightningDistanceMeters,  WaterQualityData? waterQuality,  AlgaeData? algae,  bool isLoading,  String? error,  String? syncError,  DateTime? lastSuccessfulSync,  bool isSyncing,  bool isRadarVisible,  List<DateTime> radarTimestamps,  int currentTimestampIndex,  bool isAnimating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PointWeatherState() when $default != null:
return $default(_that.lastUpdated,_that.weather,_that.wave,_that.seaLevel,_that.forecast,_that.activeAlerts,_that.lightningStrikes,_that.nearestLightningDistanceMeters,_that.waterQuality,_that.algae,_that.isLoading,_that.error,_that.syncError,_that.lastSuccessfulSync,_that.isSyncing,_that.isRadarVisible,_that.radarTimestamps,_that.currentTimestampIndex,_that.isAnimating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime lastUpdated,  WeatherData? weather,  WaveData? wave,  SeaLevel? seaLevel,  List<WeatherForecast> forecast,  List<WeatherAlert> activeAlerts,  List<LightningStrike> lightningStrikes,  double? nearestLightningDistanceMeters,  WaterQualityData? waterQuality,  AlgaeData? algae,  bool isLoading,  String? error,  String? syncError,  DateTime? lastSuccessfulSync,  bool isSyncing,  bool isRadarVisible,  List<DateTime> radarTimestamps,  int currentTimestampIndex,  bool isAnimating)  $default,) {final _that = this;
switch (_that) {
case _PointWeatherState():
return $default(_that.lastUpdated,_that.weather,_that.wave,_that.seaLevel,_that.forecast,_that.activeAlerts,_that.lightningStrikes,_that.nearestLightningDistanceMeters,_that.waterQuality,_that.algae,_that.isLoading,_that.error,_that.syncError,_that.lastSuccessfulSync,_that.isSyncing,_that.isRadarVisible,_that.radarTimestamps,_that.currentTimestampIndex,_that.isAnimating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime lastUpdated,  WeatherData? weather,  WaveData? wave,  SeaLevel? seaLevel,  List<WeatherForecast> forecast,  List<WeatherAlert> activeAlerts,  List<LightningStrike> lightningStrikes,  double? nearestLightningDistanceMeters,  WaterQualityData? waterQuality,  AlgaeData? algae,  bool isLoading,  String? error,  String? syncError,  DateTime? lastSuccessfulSync,  bool isSyncing,  bool isRadarVisible,  List<DateTime> radarTimestamps,  int currentTimestampIndex,  bool isAnimating)?  $default,) {final _that = this;
switch (_that) {
case _PointWeatherState() when $default != null:
return $default(_that.lastUpdated,_that.weather,_that.wave,_that.seaLevel,_that.forecast,_that.activeAlerts,_that.lightningStrikes,_that.nearestLightningDistanceMeters,_that.waterQuality,_that.algae,_that.isLoading,_that.error,_that.syncError,_that.lastSuccessfulSync,_that.isSyncing,_that.isRadarVisible,_that.radarTimestamps,_that.currentTimestampIndex,_that.isAnimating);case _:
  return null;

}
}

}

/// @nodoc


class _PointWeatherState implements PointWeatherState {
  const _PointWeatherState({required this.lastUpdated, this.weather, this.wave, this.seaLevel, final  List<WeatherForecast> forecast = const [], final  List<WeatherAlert> activeAlerts = const [], final  List<LightningStrike> lightningStrikes = const [], this.nearestLightningDistanceMeters, this.waterQuality, this.algae, this.isLoading = false, this.error, this.syncError, this.lastSuccessfulSync, this.isSyncing = false, this.isRadarVisible = false, final  List<DateTime> radarTimestamps = const [], this.currentTimestampIndex = 0, this.isAnimating = false}): _forecast = forecast,_activeAlerts = activeAlerts,_lightningStrikes = lightningStrikes,_radarTimestamps = radarTimestamps;
  

@override final  DateTime lastUpdated;
@override final  WeatherData? weather;
@override final  WaveData? wave;
@override final  SeaLevel? seaLevel;
 final  List<WeatherForecast> _forecast;
@override@JsonKey() List<WeatherForecast> get forecast {
  if (_forecast is EqualUnmodifiableListView) return _forecast;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_forecast);
}

 final  List<WeatherAlert> _activeAlerts;
@override@JsonKey() List<WeatherAlert> get activeAlerts {
  if (_activeAlerts is EqualUnmodifiableListView) return _activeAlerts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activeAlerts);
}

 final  List<LightningStrike> _lightningStrikes;
@override@JsonKey() List<LightningStrike> get lightningStrikes {
  if (_lightningStrikes is EqualUnmodifiableListView) return _lightningStrikes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lightningStrikes);
}

@override final  double? nearestLightningDistanceMeters;
@override final  WaterQualityData? waterQuality;
@override final  AlgaeData? algae;
@override@JsonKey() final  bool isLoading;
@override final  String? error;
@override final  String? syncError;
@override final  DateTime? lastSuccessfulSync;
@override@JsonKey() final  bool isSyncing;
@override@JsonKey() final  bool isRadarVisible;
 final  List<DateTime> _radarTimestamps;
@override@JsonKey() List<DateTime> get radarTimestamps {
  if (_radarTimestamps is EqualUnmodifiableListView) return _radarTimestamps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_radarTimestamps);
}

@override@JsonKey() final  int currentTimestampIndex;
@override@JsonKey() final  bool isAnimating;

/// Create a copy of PointWeatherState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PointWeatherStateCopyWith<_PointWeatherState> get copyWith => __$PointWeatherStateCopyWithImpl<_PointWeatherState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PointWeatherState&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.weather, weather) || other.weather == weather)&&(identical(other.wave, wave) || other.wave == wave)&&(identical(other.seaLevel, seaLevel) || other.seaLevel == seaLevel)&&const DeepCollectionEquality().equals(other._forecast, _forecast)&&const DeepCollectionEquality().equals(other._activeAlerts, _activeAlerts)&&const DeepCollectionEquality().equals(other._lightningStrikes, _lightningStrikes)&&(identical(other.nearestLightningDistanceMeters, nearestLightningDistanceMeters) || other.nearestLightningDistanceMeters == nearestLightningDistanceMeters)&&(identical(other.waterQuality, waterQuality) || other.waterQuality == waterQuality)&&(identical(other.algae, algae) || other.algae == algae)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.syncError, syncError) || other.syncError == syncError)&&(identical(other.lastSuccessfulSync, lastSuccessfulSync) || other.lastSuccessfulSync == lastSuccessfulSync)&&(identical(other.isSyncing, isSyncing) || other.isSyncing == isSyncing)&&(identical(other.isRadarVisible, isRadarVisible) || other.isRadarVisible == isRadarVisible)&&const DeepCollectionEquality().equals(other._radarTimestamps, _radarTimestamps)&&(identical(other.currentTimestampIndex, currentTimestampIndex) || other.currentTimestampIndex == currentTimestampIndex)&&(identical(other.isAnimating, isAnimating) || other.isAnimating == isAnimating));
}


@override
int get hashCode => Object.hashAll([runtimeType,lastUpdated,weather,wave,seaLevel,const DeepCollectionEquality().hash(_forecast),const DeepCollectionEquality().hash(_activeAlerts),const DeepCollectionEquality().hash(_lightningStrikes),nearestLightningDistanceMeters,waterQuality,algae,isLoading,error,syncError,lastSuccessfulSync,isSyncing,isRadarVisible,const DeepCollectionEquality().hash(_radarTimestamps),currentTimestampIndex,isAnimating]);

@override
String toString() {
  return 'PointWeatherState(lastUpdated: $lastUpdated, weather: $weather, wave: $wave, seaLevel: $seaLevel, forecast: $forecast, activeAlerts: $activeAlerts, lightningStrikes: $lightningStrikes, nearestLightningDistanceMeters: $nearestLightningDistanceMeters, waterQuality: $waterQuality, algae: $algae, isLoading: $isLoading, error: $error, syncError: $syncError, lastSuccessfulSync: $lastSuccessfulSync, isSyncing: $isSyncing, isRadarVisible: $isRadarVisible, radarTimestamps: $radarTimestamps, currentTimestampIndex: $currentTimestampIndex, isAnimating: $isAnimating)';
}


}

/// @nodoc
abstract mixin class _$PointWeatherStateCopyWith<$Res> implements $PointWeatherStateCopyWith<$Res> {
  factory _$PointWeatherStateCopyWith(_PointWeatherState value, $Res Function(_PointWeatherState) _then) = __$PointWeatherStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime lastUpdated, WeatherData? weather, WaveData? wave, SeaLevel? seaLevel, List<WeatherForecast> forecast, List<WeatherAlert> activeAlerts, List<LightningStrike> lightningStrikes, double? nearestLightningDistanceMeters, WaterQualityData? waterQuality, AlgaeData? algae, bool isLoading, String? error, String? syncError, DateTime? lastSuccessfulSync, bool isSyncing, bool isRadarVisible, List<DateTime> radarTimestamps, int currentTimestampIndex, bool isAnimating
});


@override $WeatherDataCopyWith<$Res>? get weather;@override $WaveDataCopyWith<$Res>? get wave;@override $SeaLevelCopyWith<$Res>? get seaLevel;@override $WaterQualityDataCopyWith<$Res>? get waterQuality;@override $AlgaeDataCopyWith<$Res>? get algae;

}
/// @nodoc
class __$PointWeatherStateCopyWithImpl<$Res>
    implements _$PointWeatherStateCopyWith<$Res> {
  __$PointWeatherStateCopyWithImpl(this._self, this._then);

  final _PointWeatherState _self;
  final $Res Function(_PointWeatherState) _then;

/// Create a copy of PointWeatherState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastUpdated = null,Object? weather = freezed,Object? wave = freezed,Object? seaLevel = freezed,Object? forecast = null,Object? activeAlerts = null,Object? lightningStrikes = null,Object? nearestLightningDistanceMeters = freezed,Object? waterQuality = freezed,Object? algae = freezed,Object? isLoading = null,Object? error = freezed,Object? syncError = freezed,Object? lastSuccessfulSync = freezed,Object? isSyncing = null,Object? isRadarVisible = null,Object? radarTimestamps = null,Object? currentTimestampIndex = null,Object? isAnimating = null,}) {
  return _then(_PointWeatherState(
lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,weather: freezed == weather ? _self.weather : weather // ignore: cast_nullable_to_non_nullable
as WeatherData?,wave: freezed == wave ? _self.wave : wave // ignore: cast_nullable_to_non_nullable
as WaveData?,seaLevel: freezed == seaLevel ? _self.seaLevel : seaLevel // ignore: cast_nullable_to_non_nullable
as SeaLevel?,forecast: null == forecast ? _self._forecast : forecast // ignore: cast_nullable_to_non_nullable
as List<WeatherForecast>,activeAlerts: null == activeAlerts ? _self._activeAlerts : activeAlerts // ignore: cast_nullable_to_non_nullable
as List<WeatherAlert>,lightningStrikes: null == lightningStrikes ? _self._lightningStrikes : lightningStrikes // ignore: cast_nullable_to_non_nullable
as List<LightningStrike>,nearestLightningDistanceMeters: freezed == nearestLightningDistanceMeters ? _self.nearestLightningDistanceMeters : nearestLightningDistanceMeters // ignore: cast_nullable_to_non_nullable
as double?,waterQuality: freezed == waterQuality ? _self.waterQuality : waterQuality // ignore: cast_nullable_to_non_nullable
as WaterQualityData?,algae: freezed == algae ? _self.algae : algae // ignore: cast_nullable_to_non_nullable
as AlgaeData?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,syncError: freezed == syncError ? _self.syncError : syncError // ignore: cast_nullable_to_non_nullable
as String?,lastSuccessfulSync: freezed == lastSuccessfulSync ? _self.lastSuccessfulSync : lastSuccessfulSync // ignore: cast_nullable_to_non_nullable
as DateTime?,isSyncing: null == isSyncing ? _self.isSyncing : isSyncing // ignore: cast_nullable_to_non_nullable
as bool,isRadarVisible: null == isRadarVisible ? _self.isRadarVisible : isRadarVisible // ignore: cast_nullable_to_non_nullable
as bool,radarTimestamps: null == radarTimestamps ? _self._radarTimestamps : radarTimestamps // ignore: cast_nullable_to_non_nullable
as List<DateTime>,currentTimestampIndex: null == currentTimestampIndex ? _self.currentTimestampIndex : currentTimestampIndex // ignore: cast_nullable_to_non_nullable
as int,isAnimating: null == isAnimating ? _self.isAnimating : isAnimating // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of PointWeatherState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeatherDataCopyWith<$Res>? get weather {
    if (_self.weather == null) {
    return null;
  }

  return $WeatherDataCopyWith<$Res>(_self.weather!, (value) {
    return _then(_self.copyWith(weather: value));
  });
}/// Create a copy of PointWeatherState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WaveDataCopyWith<$Res>? get wave {
    if (_self.wave == null) {
    return null;
  }

  return $WaveDataCopyWith<$Res>(_self.wave!, (value) {
    return _then(_self.copyWith(wave: value));
  });
}/// Create a copy of PointWeatherState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeaLevelCopyWith<$Res>? get seaLevel {
    if (_self.seaLevel == null) {
    return null;
  }

  return $SeaLevelCopyWith<$Res>(_self.seaLevel!, (value) {
    return _then(_self.copyWith(seaLevel: value));
  });
}/// Create a copy of PointWeatherState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WaterQualityDataCopyWith<$Res>? get waterQuality {
    if (_self.waterQuality == null) {
    return null;
  }

  return $WaterQualityDataCopyWith<$Res>(_self.waterQuality!, (value) {
    return _then(_self.copyWith(waterQuality: value));
  });
}/// Create a copy of PointWeatherState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AlgaeDataCopyWith<$Res>? get algae {
    if (_self.algae == null) {
    return null;
  }

  return $AlgaeDataCopyWith<$Res>(_self.algae!, (value) {
    return _then(_self.copyWith(algae: value));
  });
}
}

// dart format on
