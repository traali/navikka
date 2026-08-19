// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_feature_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiFeatureSettings {

/// Master toggle for weather and situational awareness AI.
 bool get weatherAiEnabled;/// Master toggle for intelligent route analysis and weather routing.
 bool get routeAiEnabled;/// Master toggle for offline technical marine copilot and engine troubleshooting.
 bool get technicalCopilotEnabled;/// Master toggle for hands-free voice marine copilot ("Hei Kippari" / "Hey Skipper").
 bool get voiceCopilotEnabled;/// Master toggle for automated AI voyage recap and smart logbook.
 bool get logbookAiEnabled;/// Master toggle for IMU accelerometer wave slamming & sea roughness AI.
 bool get waveImpactAiEnabled;
/// Create a copy of AiFeatureSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiFeatureSettingsCopyWith<AiFeatureSettings> get copyWith => _$AiFeatureSettingsCopyWithImpl<AiFeatureSettings>(this as AiFeatureSettings, _$identity);

  /// Serializes this AiFeatureSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiFeatureSettings&&(identical(other.weatherAiEnabled, weatherAiEnabled) || other.weatherAiEnabled == weatherAiEnabled)&&(identical(other.routeAiEnabled, routeAiEnabled) || other.routeAiEnabled == routeAiEnabled)&&(identical(other.technicalCopilotEnabled, technicalCopilotEnabled) || other.technicalCopilotEnabled == technicalCopilotEnabled)&&(identical(other.voiceCopilotEnabled, voiceCopilotEnabled) || other.voiceCopilotEnabled == voiceCopilotEnabled)&&(identical(other.logbookAiEnabled, logbookAiEnabled) || other.logbookAiEnabled == logbookAiEnabled)&&(identical(other.waveImpactAiEnabled, waveImpactAiEnabled) || other.waveImpactAiEnabled == waveImpactAiEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weatherAiEnabled,routeAiEnabled,technicalCopilotEnabled,voiceCopilotEnabled,logbookAiEnabled,waveImpactAiEnabled);

@override
String toString() {
  return 'AiFeatureSettings(weatherAiEnabled: $weatherAiEnabled, routeAiEnabled: $routeAiEnabled, technicalCopilotEnabled: $technicalCopilotEnabled, voiceCopilotEnabled: $voiceCopilotEnabled, logbookAiEnabled: $logbookAiEnabled, waveImpactAiEnabled: $waveImpactAiEnabled)';
}


}

/// @nodoc
abstract mixin class $AiFeatureSettingsCopyWith<$Res>  {
  factory $AiFeatureSettingsCopyWith(AiFeatureSettings value, $Res Function(AiFeatureSettings) _then) = _$AiFeatureSettingsCopyWithImpl;
@useResult
$Res call({
 bool weatherAiEnabled, bool routeAiEnabled, bool technicalCopilotEnabled, bool voiceCopilotEnabled, bool logbookAiEnabled, bool waveImpactAiEnabled
});




}
/// @nodoc
class _$AiFeatureSettingsCopyWithImpl<$Res>
    implements $AiFeatureSettingsCopyWith<$Res> {
  _$AiFeatureSettingsCopyWithImpl(this._self, this._then);

  final AiFeatureSettings _self;
  final $Res Function(AiFeatureSettings) _then;

/// Create a copy of AiFeatureSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weatherAiEnabled = null,Object? routeAiEnabled = null,Object? technicalCopilotEnabled = null,Object? voiceCopilotEnabled = null,Object? logbookAiEnabled = null,Object? waveImpactAiEnabled = null,}) {
  return _then(_self.copyWith(
weatherAiEnabled: null == weatherAiEnabled ? _self.weatherAiEnabled : weatherAiEnabled // ignore: cast_nullable_to_non_nullable
as bool,routeAiEnabled: null == routeAiEnabled ? _self.routeAiEnabled : routeAiEnabled // ignore: cast_nullable_to_non_nullable
as bool,technicalCopilotEnabled: null == technicalCopilotEnabled ? _self.technicalCopilotEnabled : technicalCopilotEnabled // ignore: cast_nullable_to_non_nullable
as bool,voiceCopilotEnabled: null == voiceCopilotEnabled ? _self.voiceCopilotEnabled : voiceCopilotEnabled // ignore: cast_nullable_to_non_nullable
as bool,logbookAiEnabled: null == logbookAiEnabled ? _self.logbookAiEnabled : logbookAiEnabled // ignore: cast_nullable_to_non_nullable
as bool,waveImpactAiEnabled: null == waveImpactAiEnabled ? _self.waveImpactAiEnabled : waveImpactAiEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AiFeatureSettings].
extension AiFeatureSettingsPatterns on AiFeatureSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiFeatureSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiFeatureSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiFeatureSettings value)  $default,){
final _that = this;
switch (_that) {
case _AiFeatureSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiFeatureSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AiFeatureSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool weatherAiEnabled,  bool routeAiEnabled,  bool technicalCopilotEnabled,  bool voiceCopilotEnabled,  bool logbookAiEnabled,  bool waveImpactAiEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiFeatureSettings() when $default != null:
return $default(_that.weatherAiEnabled,_that.routeAiEnabled,_that.technicalCopilotEnabled,_that.voiceCopilotEnabled,_that.logbookAiEnabled,_that.waveImpactAiEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool weatherAiEnabled,  bool routeAiEnabled,  bool technicalCopilotEnabled,  bool voiceCopilotEnabled,  bool logbookAiEnabled,  bool waveImpactAiEnabled)  $default,) {final _that = this;
switch (_that) {
case _AiFeatureSettings():
return $default(_that.weatherAiEnabled,_that.routeAiEnabled,_that.technicalCopilotEnabled,_that.voiceCopilotEnabled,_that.logbookAiEnabled,_that.waveImpactAiEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool weatherAiEnabled,  bool routeAiEnabled,  bool technicalCopilotEnabled,  bool voiceCopilotEnabled,  bool logbookAiEnabled,  bool waveImpactAiEnabled)?  $default,) {final _that = this;
switch (_that) {
case _AiFeatureSettings() when $default != null:
return $default(_that.weatherAiEnabled,_that.routeAiEnabled,_that.technicalCopilotEnabled,_that.voiceCopilotEnabled,_that.logbookAiEnabled,_that.waveImpactAiEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiFeatureSettings implements AiFeatureSettings {
  const _AiFeatureSettings({this.weatherAiEnabled = true, this.routeAiEnabled = true, this.technicalCopilotEnabled = true, this.voiceCopilotEnabled = true, this.logbookAiEnabled = true, this.waveImpactAiEnabled = true});
  factory _AiFeatureSettings.fromJson(Map<String, dynamic> json) => _$AiFeatureSettingsFromJson(json);

/// Master toggle for weather and situational awareness AI.
@override@JsonKey() final  bool weatherAiEnabled;
/// Master toggle for intelligent route analysis and weather routing.
@override@JsonKey() final  bool routeAiEnabled;
/// Master toggle for offline technical marine copilot and engine troubleshooting.
@override@JsonKey() final  bool technicalCopilotEnabled;
/// Master toggle for hands-free voice marine copilot ("Hei Kippari" / "Hey Skipper").
@override@JsonKey() final  bool voiceCopilotEnabled;
/// Master toggle for automated AI voyage recap and smart logbook.
@override@JsonKey() final  bool logbookAiEnabled;
/// Master toggle for IMU accelerometer wave slamming & sea roughness AI.
@override@JsonKey() final  bool waveImpactAiEnabled;

/// Create a copy of AiFeatureSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiFeatureSettingsCopyWith<_AiFeatureSettings> get copyWith => __$AiFeatureSettingsCopyWithImpl<_AiFeatureSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiFeatureSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiFeatureSettings&&(identical(other.weatherAiEnabled, weatherAiEnabled) || other.weatherAiEnabled == weatherAiEnabled)&&(identical(other.routeAiEnabled, routeAiEnabled) || other.routeAiEnabled == routeAiEnabled)&&(identical(other.technicalCopilotEnabled, technicalCopilotEnabled) || other.technicalCopilotEnabled == technicalCopilotEnabled)&&(identical(other.voiceCopilotEnabled, voiceCopilotEnabled) || other.voiceCopilotEnabled == voiceCopilotEnabled)&&(identical(other.logbookAiEnabled, logbookAiEnabled) || other.logbookAiEnabled == logbookAiEnabled)&&(identical(other.waveImpactAiEnabled, waveImpactAiEnabled) || other.waveImpactAiEnabled == waveImpactAiEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weatherAiEnabled,routeAiEnabled,technicalCopilotEnabled,voiceCopilotEnabled,logbookAiEnabled,waveImpactAiEnabled);

@override
String toString() {
  return 'AiFeatureSettings(weatherAiEnabled: $weatherAiEnabled, routeAiEnabled: $routeAiEnabled, technicalCopilotEnabled: $technicalCopilotEnabled, voiceCopilotEnabled: $voiceCopilotEnabled, logbookAiEnabled: $logbookAiEnabled, waveImpactAiEnabled: $waveImpactAiEnabled)';
}


}

/// @nodoc
abstract mixin class _$AiFeatureSettingsCopyWith<$Res> implements $AiFeatureSettingsCopyWith<$Res> {
  factory _$AiFeatureSettingsCopyWith(_AiFeatureSettings value, $Res Function(_AiFeatureSettings) _then) = __$AiFeatureSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool weatherAiEnabled, bool routeAiEnabled, bool technicalCopilotEnabled, bool voiceCopilotEnabled, bool logbookAiEnabled, bool waveImpactAiEnabled
});




}
/// @nodoc
class __$AiFeatureSettingsCopyWithImpl<$Res>
    implements _$AiFeatureSettingsCopyWith<$Res> {
  __$AiFeatureSettingsCopyWithImpl(this._self, this._then);

  final _AiFeatureSettings _self;
  final $Res Function(_AiFeatureSettings) _then;

/// Create a copy of AiFeatureSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weatherAiEnabled = null,Object? routeAiEnabled = null,Object? technicalCopilotEnabled = null,Object? voiceCopilotEnabled = null,Object? logbookAiEnabled = null,Object? waveImpactAiEnabled = null,}) {
  return _then(_AiFeatureSettings(
weatherAiEnabled: null == weatherAiEnabled ? _self.weatherAiEnabled : weatherAiEnabled // ignore: cast_nullable_to_non_nullable
as bool,routeAiEnabled: null == routeAiEnabled ? _self.routeAiEnabled : routeAiEnabled // ignore: cast_nullable_to_non_nullable
as bool,technicalCopilotEnabled: null == technicalCopilotEnabled ? _self.technicalCopilotEnabled : technicalCopilotEnabled // ignore: cast_nullable_to_non_nullable
as bool,voiceCopilotEnabled: null == voiceCopilotEnabled ? _self.voiceCopilotEnabled : voiceCopilotEnabled // ignore: cast_nullable_to_non_nullable
as bool,logbookAiEnabled: null == logbookAiEnabled ? _self.logbookAiEnabled : logbookAiEnabled // ignore: cast_nullable_to_non_nullable
as bool,waveImpactAiEnabled: null == waveImpactAiEnabled ? _self.waveImpactAiEnabled : waveImpactAiEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
