// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'point_weather_alert_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PointWeatherAlertState {

 List<WeatherAlert> get activeAlerts; List<LightningStrike> get lightningStrikes; double? get nearestLightning;
/// Create a copy of PointWeatherAlertState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PointWeatherAlertStateCopyWith<PointWeatherAlertState> get copyWith => _$PointWeatherAlertStateCopyWithImpl<PointWeatherAlertState>(this as PointWeatherAlertState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PointWeatherAlertState&&const DeepCollectionEquality().equals(other.activeAlerts, activeAlerts)&&const DeepCollectionEquality().equals(other.lightningStrikes, lightningStrikes)&&(identical(other.nearestLightning, nearestLightning) || other.nearestLightning == nearestLightning));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(activeAlerts),const DeepCollectionEquality().hash(lightningStrikes),nearestLightning);

@override
String toString() {
  return 'PointWeatherAlertState(activeAlerts: $activeAlerts, lightningStrikes: $lightningStrikes, nearestLightning: $nearestLightning)';
}


}

/// @nodoc
abstract mixin class $PointWeatherAlertStateCopyWith<$Res>  {
  factory $PointWeatherAlertStateCopyWith(PointWeatherAlertState value, $Res Function(PointWeatherAlertState) _then) = _$PointWeatherAlertStateCopyWithImpl;
@useResult
$Res call({
 List<WeatherAlert> activeAlerts, List<LightningStrike> lightningStrikes, double? nearestLightning
});




}
/// @nodoc
class _$PointWeatherAlertStateCopyWithImpl<$Res>
    implements $PointWeatherAlertStateCopyWith<$Res> {
  _$PointWeatherAlertStateCopyWithImpl(this._self, this._then);

  final PointWeatherAlertState _self;
  final $Res Function(PointWeatherAlertState) _then;

/// Create a copy of PointWeatherAlertState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activeAlerts = null,Object? lightningStrikes = null,Object? nearestLightning = freezed,}) {
  return _then(_self.copyWith(
activeAlerts: null == activeAlerts ? _self.activeAlerts : activeAlerts // ignore: cast_nullable_to_non_nullable
as List<WeatherAlert>,lightningStrikes: null == lightningStrikes ? _self.lightningStrikes : lightningStrikes // ignore: cast_nullable_to_non_nullable
as List<LightningStrike>,nearestLightning: freezed == nearestLightning ? _self.nearestLightning : nearestLightning // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [PointWeatherAlertState].
extension PointWeatherAlertStatePatterns on PointWeatherAlertState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PointWeatherAlertState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PointWeatherAlertState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PointWeatherAlertState value)  $default,){
final _that = this;
switch (_that) {
case _PointWeatherAlertState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PointWeatherAlertState value)?  $default,){
final _that = this;
switch (_that) {
case _PointWeatherAlertState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<WeatherAlert> activeAlerts,  List<LightningStrike> lightningStrikes,  double? nearestLightning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PointWeatherAlertState() when $default != null:
return $default(_that.activeAlerts,_that.lightningStrikes,_that.nearestLightning);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<WeatherAlert> activeAlerts,  List<LightningStrike> lightningStrikes,  double? nearestLightning)  $default,) {final _that = this;
switch (_that) {
case _PointWeatherAlertState():
return $default(_that.activeAlerts,_that.lightningStrikes,_that.nearestLightning);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<WeatherAlert> activeAlerts,  List<LightningStrike> lightningStrikes,  double? nearestLightning)?  $default,) {final _that = this;
switch (_that) {
case _PointWeatherAlertState() when $default != null:
return $default(_that.activeAlerts,_that.lightningStrikes,_that.nearestLightning);case _:
  return null;

}
}

}

/// @nodoc


class _PointWeatherAlertState implements PointWeatherAlertState {
  const _PointWeatherAlertState({required final  List<WeatherAlert> activeAlerts, required final  List<LightningStrike> lightningStrikes, required this.nearestLightning}): _activeAlerts = activeAlerts,_lightningStrikes = lightningStrikes;
  

 final  List<WeatherAlert> _activeAlerts;
@override List<WeatherAlert> get activeAlerts {
  if (_activeAlerts is EqualUnmodifiableListView) return _activeAlerts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activeAlerts);
}

 final  List<LightningStrike> _lightningStrikes;
@override List<LightningStrike> get lightningStrikes {
  if (_lightningStrikes is EqualUnmodifiableListView) return _lightningStrikes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lightningStrikes);
}

@override final  double? nearestLightning;

/// Create a copy of PointWeatherAlertState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PointWeatherAlertStateCopyWith<_PointWeatherAlertState> get copyWith => __$PointWeatherAlertStateCopyWithImpl<_PointWeatherAlertState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PointWeatherAlertState&&const DeepCollectionEquality().equals(other._activeAlerts, _activeAlerts)&&const DeepCollectionEquality().equals(other._lightningStrikes, _lightningStrikes)&&(identical(other.nearestLightning, nearestLightning) || other.nearestLightning == nearestLightning));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_activeAlerts),const DeepCollectionEquality().hash(_lightningStrikes),nearestLightning);

@override
String toString() {
  return 'PointWeatherAlertState(activeAlerts: $activeAlerts, lightningStrikes: $lightningStrikes, nearestLightning: $nearestLightning)';
}


}

/// @nodoc
abstract mixin class _$PointWeatherAlertStateCopyWith<$Res> implements $PointWeatherAlertStateCopyWith<$Res> {
  factory _$PointWeatherAlertStateCopyWith(_PointWeatherAlertState value, $Res Function(_PointWeatherAlertState) _then) = __$PointWeatherAlertStateCopyWithImpl;
@override @useResult
$Res call({
 List<WeatherAlert> activeAlerts, List<LightningStrike> lightningStrikes, double? nearestLightning
});




}
/// @nodoc
class __$PointWeatherAlertStateCopyWithImpl<$Res>
    implements _$PointWeatherAlertStateCopyWith<$Res> {
  __$PointWeatherAlertStateCopyWithImpl(this._self, this._then);

  final _PointWeatherAlertState _self;
  final $Res Function(_PointWeatherAlertState) _then;

/// Create a copy of PointWeatherAlertState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activeAlerts = null,Object? lightningStrikes = null,Object? nearestLightning = freezed,}) {
  return _then(_PointWeatherAlertState(
activeAlerts: null == activeAlerts ? _self._activeAlerts : activeAlerts // ignore: cast_nullable_to_non_nullable
as List<WeatherAlert>,lightningStrikes: null == lightningStrikes ? _self._lightningStrikes : lightningStrikes // ignore: cast_nullable_to_non_nullable
as List<LightningStrike>,nearestLightning: freezed == nearestLightning ? _self.nearestLightning : nearestLightning // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
