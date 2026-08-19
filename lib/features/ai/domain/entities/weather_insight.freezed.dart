// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_insight.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeatherInsight {

 SafetyStatus get status; String get advice; DateTime get timestamp; bool get isAIInference; String? get insightId; List<String> get reasons; int get riskScore;
/// Create a copy of WeatherInsight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherInsightCopyWith<WeatherInsight> get copyWith => _$WeatherInsightCopyWithImpl<WeatherInsight>(this as WeatherInsight, _$identity);

  /// Serializes this WeatherInsight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherInsight&&(identical(other.status, status) || other.status == status)&&(identical(other.advice, advice) || other.advice == advice)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isAIInference, isAIInference) || other.isAIInference == isAIInference)&&(identical(other.insightId, insightId) || other.insightId == insightId)&&const DeepCollectionEquality().equals(other.reasons, reasons)&&(identical(other.riskScore, riskScore) || other.riskScore == riskScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,advice,timestamp,isAIInference,insightId,const DeepCollectionEquality().hash(reasons),riskScore);

@override
String toString() {
  return 'WeatherInsight(status: $status, advice: $advice, timestamp: $timestamp, isAIInference: $isAIInference, insightId: $insightId, reasons: $reasons, riskScore: $riskScore)';
}


}

/// @nodoc
abstract mixin class $WeatherInsightCopyWith<$Res>  {
  factory $WeatherInsightCopyWith(WeatherInsight value, $Res Function(WeatherInsight) _then) = _$WeatherInsightCopyWithImpl;
@useResult
$Res call({
 SafetyStatus status, String advice, DateTime timestamp, bool isAIInference, String? insightId, List<String> reasons, int riskScore
});




}
/// @nodoc
class _$WeatherInsightCopyWithImpl<$Res>
    implements $WeatherInsightCopyWith<$Res> {
  _$WeatherInsightCopyWithImpl(this._self, this._then);

  final WeatherInsight _self;
  final $Res Function(WeatherInsight) _then;

/// Create a copy of WeatherInsight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? advice = null,Object? timestamp = null,Object? isAIInference = null,Object? insightId = freezed,Object? reasons = null,Object? riskScore = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SafetyStatus,advice: null == advice ? _self.advice : advice // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,isAIInference: null == isAIInference ? _self.isAIInference : isAIInference // ignore: cast_nullable_to_non_nullable
as bool,insightId: freezed == insightId ? _self.insightId : insightId // ignore: cast_nullable_to_non_nullable
as String?,reasons: null == reasons ? _self.reasons : reasons // ignore: cast_nullable_to_non_nullable
as List<String>,riskScore: null == riskScore ? _self.riskScore : riskScore // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherInsight].
extension WeatherInsightPatterns on WeatherInsight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherInsight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherInsight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherInsight value)  $default,){
final _that = this;
switch (_that) {
case _WeatherInsight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherInsight value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherInsight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SafetyStatus status,  String advice,  DateTime timestamp,  bool isAIInference,  String? insightId,  List<String> reasons,  int riskScore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherInsight() when $default != null:
return $default(_that.status,_that.advice,_that.timestamp,_that.isAIInference,_that.insightId,_that.reasons,_that.riskScore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SafetyStatus status,  String advice,  DateTime timestamp,  bool isAIInference,  String? insightId,  List<String> reasons,  int riskScore)  $default,) {final _that = this;
switch (_that) {
case _WeatherInsight():
return $default(_that.status,_that.advice,_that.timestamp,_that.isAIInference,_that.insightId,_that.reasons,_that.riskScore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SafetyStatus status,  String advice,  DateTime timestamp,  bool isAIInference,  String? insightId,  List<String> reasons,  int riskScore)?  $default,) {final _that = this;
switch (_that) {
case _WeatherInsight() when $default != null:
return $default(_that.status,_that.advice,_that.timestamp,_that.isAIInference,_that.insightId,_that.reasons,_that.riskScore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeatherInsight implements WeatherInsight {
  const _WeatherInsight({required this.status, required this.advice, required this.timestamp, this.isAIInference = false, this.insightId, final  List<String> reasons = const [], this.riskScore = 0}): _reasons = reasons;
  factory _WeatherInsight.fromJson(Map<String, dynamic> json) => _$WeatherInsightFromJson(json);

@override final  SafetyStatus status;
@override final  String advice;
@override final  DateTime timestamp;
@override@JsonKey() final  bool isAIInference;
@override final  String? insightId;
 final  List<String> _reasons;
@override@JsonKey() List<String> get reasons {
  if (_reasons is EqualUnmodifiableListView) return _reasons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reasons);
}

@override@JsonKey() final  int riskScore;

/// Create a copy of WeatherInsight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherInsightCopyWith<_WeatherInsight> get copyWith => __$WeatherInsightCopyWithImpl<_WeatherInsight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherInsightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherInsight&&(identical(other.status, status) || other.status == status)&&(identical(other.advice, advice) || other.advice == advice)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isAIInference, isAIInference) || other.isAIInference == isAIInference)&&(identical(other.insightId, insightId) || other.insightId == insightId)&&const DeepCollectionEquality().equals(other._reasons, _reasons)&&(identical(other.riskScore, riskScore) || other.riskScore == riskScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,advice,timestamp,isAIInference,insightId,const DeepCollectionEquality().hash(_reasons),riskScore);

@override
String toString() {
  return 'WeatherInsight(status: $status, advice: $advice, timestamp: $timestamp, isAIInference: $isAIInference, insightId: $insightId, reasons: $reasons, riskScore: $riskScore)';
}


}

/// @nodoc
abstract mixin class _$WeatherInsightCopyWith<$Res> implements $WeatherInsightCopyWith<$Res> {
  factory _$WeatherInsightCopyWith(_WeatherInsight value, $Res Function(_WeatherInsight) _then) = __$WeatherInsightCopyWithImpl;
@override @useResult
$Res call({
 SafetyStatus status, String advice, DateTime timestamp, bool isAIInference, String? insightId, List<String> reasons, int riskScore
});




}
/// @nodoc
class __$WeatherInsightCopyWithImpl<$Res>
    implements _$WeatherInsightCopyWith<$Res> {
  __$WeatherInsightCopyWithImpl(this._self, this._then);

  final _WeatherInsight _self;
  final $Res Function(_WeatherInsight) _then;

/// Create a copy of WeatherInsight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? advice = null,Object? timestamp = null,Object? isAIInference = null,Object? insightId = freezed,Object? reasons = null,Object? riskScore = null,}) {
  return _then(_WeatherInsight(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SafetyStatus,advice: null == advice ? _self.advice : advice // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,isAIInference: null == isAIInference ? _self.isAIInference : isAIInference // ignore: cast_nullable_to_non_nullable
as bool,insightId: freezed == insightId ? _self.insightId : insightId // ignore: cast_nullable_to_non_nullable
as String?,reasons: null == reasons ? _self._reasons : reasons // ignore: cast_nullable_to_non_nullable
as List<String>,riskScore: null == riskScore ? _self.riskScore : riskScore // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SkipperSettings {

 bool get isAIEnabled; bool get hasAcknowledgedAISafety; int get forecastWindowHours; SkipperThresholds get thresholds; String? get aiApiKey; String get aiModelId;
/// Create a copy of SkipperSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkipperSettingsCopyWith<SkipperSettings> get copyWith => _$SkipperSettingsCopyWithImpl<SkipperSettings>(this as SkipperSettings, _$identity);

  /// Serializes this SkipperSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkipperSettings&&(identical(other.isAIEnabled, isAIEnabled) || other.isAIEnabled == isAIEnabled)&&(identical(other.hasAcknowledgedAISafety, hasAcknowledgedAISafety) || other.hasAcknowledgedAISafety == hasAcknowledgedAISafety)&&(identical(other.forecastWindowHours, forecastWindowHours) || other.forecastWindowHours == forecastWindowHours)&&(identical(other.thresholds, thresholds) || other.thresholds == thresholds)&&(identical(other.aiApiKey, aiApiKey) || other.aiApiKey == aiApiKey)&&(identical(other.aiModelId, aiModelId) || other.aiModelId == aiModelId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isAIEnabled,hasAcknowledgedAISafety,forecastWindowHours,thresholds,aiApiKey,aiModelId);

@override
String toString() {
  return 'SkipperSettings(isAIEnabled: $isAIEnabled, hasAcknowledgedAISafety: $hasAcknowledgedAISafety, forecastWindowHours: $forecastWindowHours, thresholds: $thresholds, aiApiKey: $aiApiKey, aiModelId: $aiModelId)';
}


}

/// @nodoc
abstract mixin class $SkipperSettingsCopyWith<$Res>  {
  factory $SkipperSettingsCopyWith(SkipperSettings value, $Res Function(SkipperSettings) _then) = _$SkipperSettingsCopyWithImpl;
@useResult
$Res call({
 bool isAIEnabled, bool hasAcknowledgedAISafety, int forecastWindowHours, SkipperThresholds thresholds, String? aiApiKey, String aiModelId
});


$SkipperThresholdsCopyWith<$Res> get thresholds;

}
/// @nodoc
class _$SkipperSettingsCopyWithImpl<$Res>
    implements $SkipperSettingsCopyWith<$Res> {
  _$SkipperSettingsCopyWithImpl(this._self, this._then);

  final SkipperSettings _self;
  final $Res Function(SkipperSettings) _then;

/// Create a copy of SkipperSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isAIEnabled = null,Object? hasAcknowledgedAISafety = null,Object? forecastWindowHours = null,Object? thresholds = null,Object? aiApiKey = freezed,Object? aiModelId = null,}) {
  return _then(_self.copyWith(
isAIEnabled: null == isAIEnabled ? _self.isAIEnabled : isAIEnabled // ignore: cast_nullable_to_non_nullable
as bool,hasAcknowledgedAISafety: null == hasAcknowledgedAISafety ? _self.hasAcknowledgedAISafety : hasAcknowledgedAISafety // ignore: cast_nullable_to_non_nullable
as bool,forecastWindowHours: null == forecastWindowHours ? _self.forecastWindowHours : forecastWindowHours // ignore: cast_nullable_to_non_nullable
as int,thresholds: null == thresholds ? _self.thresholds : thresholds // ignore: cast_nullable_to_non_nullable
as SkipperThresholds,aiApiKey: freezed == aiApiKey ? _self.aiApiKey : aiApiKey // ignore: cast_nullable_to_non_nullable
as String?,aiModelId: null == aiModelId ? _self.aiModelId : aiModelId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of SkipperSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SkipperThresholdsCopyWith<$Res> get thresholds {
  
  return $SkipperThresholdsCopyWith<$Res>(_self.thresholds, (value) {
    return _then(_self.copyWith(thresholds: value));
  });
}
}


/// Adds pattern-matching-related methods to [SkipperSettings].
extension SkipperSettingsPatterns on SkipperSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkipperSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkipperSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkipperSettings value)  $default,){
final _that = this;
switch (_that) {
case _SkipperSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkipperSettings value)?  $default,){
final _that = this;
switch (_that) {
case _SkipperSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isAIEnabled,  bool hasAcknowledgedAISafety,  int forecastWindowHours,  SkipperThresholds thresholds,  String? aiApiKey,  String aiModelId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkipperSettings() when $default != null:
return $default(_that.isAIEnabled,_that.hasAcknowledgedAISafety,_that.forecastWindowHours,_that.thresholds,_that.aiApiKey,_that.aiModelId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isAIEnabled,  bool hasAcknowledgedAISafety,  int forecastWindowHours,  SkipperThresholds thresholds,  String? aiApiKey,  String aiModelId)  $default,) {final _that = this;
switch (_that) {
case _SkipperSettings():
return $default(_that.isAIEnabled,_that.hasAcknowledgedAISafety,_that.forecastWindowHours,_that.thresholds,_that.aiApiKey,_that.aiModelId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isAIEnabled,  bool hasAcknowledgedAISafety,  int forecastWindowHours,  SkipperThresholds thresholds,  String? aiApiKey,  String aiModelId)?  $default,) {final _that = this;
switch (_that) {
case _SkipperSettings() when $default != null:
return $default(_that.isAIEnabled,_that.hasAcknowledgedAISafety,_that.forecastWindowHours,_that.thresholds,_that.aiApiKey,_that.aiModelId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SkipperSettings implements SkipperSettings {
  const _SkipperSettings({this.isAIEnabled = true, this.hasAcknowledgedAISafety = false, this.forecastWindowHours = 3, this.thresholds = const SkipperThresholds(), this.aiApiKey, this.aiModelId = 'meta-llama/llama-3.3-70b-instruct:free'});
  factory _SkipperSettings.fromJson(Map<String, dynamic> json) => _$SkipperSettingsFromJson(json);

@override@JsonKey() final  bool isAIEnabled;
@override@JsonKey() final  bool hasAcknowledgedAISafety;
@override@JsonKey() final  int forecastWindowHours;
@override@JsonKey() final  SkipperThresholds thresholds;
@override final  String? aiApiKey;
@override@JsonKey() final  String aiModelId;

/// Create a copy of SkipperSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkipperSettingsCopyWith<_SkipperSettings> get copyWith => __$SkipperSettingsCopyWithImpl<_SkipperSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SkipperSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkipperSettings&&(identical(other.isAIEnabled, isAIEnabled) || other.isAIEnabled == isAIEnabled)&&(identical(other.hasAcknowledgedAISafety, hasAcknowledgedAISafety) || other.hasAcknowledgedAISafety == hasAcknowledgedAISafety)&&(identical(other.forecastWindowHours, forecastWindowHours) || other.forecastWindowHours == forecastWindowHours)&&(identical(other.thresholds, thresholds) || other.thresholds == thresholds)&&(identical(other.aiApiKey, aiApiKey) || other.aiApiKey == aiApiKey)&&(identical(other.aiModelId, aiModelId) || other.aiModelId == aiModelId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isAIEnabled,hasAcknowledgedAISafety,forecastWindowHours,thresholds,aiApiKey,aiModelId);

@override
String toString() {
  return 'SkipperSettings(isAIEnabled: $isAIEnabled, hasAcknowledgedAISafety: $hasAcknowledgedAISafety, forecastWindowHours: $forecastWindowHours, thresholds: $thresholds, aiApiKey: $aiApiKey, aiModelId: $aiModelId)';
}


}

/// @nodoc
abstract mixin class _$SkipperSettingsCopyWith<$Res> implements $SkipperSettingsCopyWith<$Res> {
  factory _$SkipperSettingsCopyWith(_SkipperSettings value, $Res Function(_SkipperSettings) _then) = __$SkipperSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool isAIEnabled, bool hasAcknowledgedAISafety, int forecastWindowHours, SkipperThresholds thresholds, String? aiApiKey, String aiModelId
});


@override $SkipperThresholdsCopyWith<$Res> get thresholds;

}
/// @nodoc
class __$SkipperSettingsCopyWithImpl<$Res>
    implements _$SkipperSettingsCopyWith<$Res> {
  __$SkipperSettingsCopyWithImpl(this._self, this._then);

  final _SkipperSettings _self;
  final $Res Function(_SkipperSettings) _then;

/// Create a copy of SkipperSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isAIEnabled = null,Object? hasAcknowledgedAISafety = null,Object? forecastWindowHours = null,Object? thresholds = null,Object? aiApiKey = freezed,Object? aiModelId = null,}) {
  return _then(_SkipperSettings(
isAIEnabled: null == isAIEnabled ? _self.isAIEnabled : isAIEnabled // ignore: cast_nullable_to_non_nullable
as bool,hasAcknowledgedAISafety: null == hasAcknowledgedAISafety ? _self.hasAcknowledgedAISafety : hasAcknowledgedAISafety // ignore: cast_nullable_to_non_nullable
as bool,forecastWindowHours: null == forecastWindowHours ? _self.forecastWindowHours : forecastWindowHours // ignore: cast_nullable_to_non_nullable
as int,thresholds: null == thresholds ? _self.thresholds : thresholds // ignore: cast_nullable_to_non_nullable
as SkipperThresholds,aiApiKey: freezed == aiApiKey ? _self.aiApiKey : aiApiKey // ignore: cast_nullable_to_non_nullable
as String?,aiModelId: null == aiModelId ? _self.aiModelId : aiModelId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of SkipperSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SkipperThresholdsCopyWith<$Res> get thresholds {
  
  return $SkipperThresholdsCopyWith<$Res>(_self.thresholds, (value) {
    return _then(_self.copyWith(thresholds: value));
  });
}
}


/// @nodoc
mixin _$SkipperThresholds {

 double get windYellowMs; double get windOrangeMs; double get windRedMs; double get waveYellowM; double get waveOrangeM; double get waveRedM; double get pressureDropThresholdHpa;
/// Create a copy of SkipperThresholds
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkipperThresholdsCopyWith<SkipperThresholds> get copyWith => _$SkipperThresholdsCopyWithImpl<SkipperThresholds>(this as SkipperThresholds, _$identity);

  /// Serializes this SkipperThresholds to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkipperThresholds&&(identical(other.windYellowMs, windYellowMs) || other.windYellowMs == windYellowMs)&&(identical(other.windOrangeMs, windOrangeMs) || other.windOrangeMs == windOrangeMs)&&(identical(other.windRedMs, windRedMs) || other.windRedMs == windRedMs)&&(identical(other.waveYellowM, waveYellowM) || other.waveYellowM == waveYellowM)&&(identical(other.waveOrangeM, waveOrangeM) || other.waveOrangeM == waveOrangeM)&&(identical(other.waveRedM, waveRedM) || other.waveRedM == waveRedM)&&(identical(other.pressureDropThresholdHpa, pressureDropThresholdHpa) || other.pressureDropThresholdHpa == pressureDropThresholdHpa));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,windYellowMs,windOrangeMs,windRedMs,waveYellowM,waveOrangeM,waveRedM,pressureDropThresholdHpa);

@override
String toString() {
  return 'SkipperThresholds(windYellowMs: $windYellowMs, windOrangeMs: $windOrangeMs, windRedMs: $windRedMs, waveYellowM: $waveYellowM, waveOrangeM: $waveOrangeM, waveRedM: $waveRedM, pressureDropThresholdHpa: $pressureDropThresholdHpa)';
}


}

/// @nodoc
abstract mixin class $SkipperThresholdsCopyWith<$Res>  {
  factory $SkipperThresholdsCopyWith(SkipperThresholds value, $Res Function(SkipperThresholds) _then) = _$SkipperThresholdsCopyWithImpl;
@useResult
$Res call({
 double windYellowMs, double windOrangeMs, double windRedMs, double waveYellowM, double waveOrangeM, double waveRedM, double pressureDropThresholdHpa
});




}
/// @nodoc
class _$SkipperThresholdsCopyWithImpl<$Res>
    implements $SkipperThresholdsCopyWith<$Res> {
  _$SkipperThresholdsCopyWithImpl(this._self, this._then);

  final SkipperThresholds _self;
  final $Res Function(SkipperThresholds) _then;

/// Create a copy of SkipperThresholds
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? windYellowMs = null,Object? windOrangeMs = null,Object? windRedMs = null,Object? waveYellowM = null,Object? waveOrangeM = null,Object? waveRedM = null,Object? pressureDropThresholdHpa = null,}) {
  return _then(_self.copyWith(
windYellowMs: null == windYellowMs ? _self.windYellowMs : windYellowMs // ignore: cast_nullable_to_non_nullable
as double,windOrangeMs: null == windOrangeMs ? _self.windOrangeMs : windOrangeMs // ignore: cast_nullable_to_non_nullable
as double,windRedMs: null == windRedMs ? _self.windRedMs : windRedMs // ignore: cast_nullable_to_non_nullable
as double,waveYellowM: null == waveYellowM ? _self.waveYellowM : waveYellowM // ignore: cast_nullable_to_non_nullable
as double,waveOrangeM: null == waveOrangeM ? _self.waveOrangeM : waveOrangeM // ignore: cast_nullable_to_non_nullable
as double,waveRedM: null == waveRedM ? _self.waveRedM : waveRedM // ignore: cast_nullable_to_non_nullable
as double,pressureDropThresholdHpa: null == pressureDropThresholdHpa ? _self.pressureDropThresholdHpa : pressureDropThresholdHpa // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SkipperThresholds].
extension SkipperThresholdsPatterns on SkipperThresholds {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkipperThresholds value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkipperThresholds() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkipperThresholds value)  $default,){
final _that = this;
switch (_that) {
case _SkipperThresholds():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkipperThresholds value)?  $default,){
final _that = this;
switch (_that) {
case _SkipperThresholds() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double windYellowMs,  double windOrangeMs,  double windRedMs,  double waveYellowM,  double waveOrangeM,  double waveRedM,  double pressureDropThresholdHpa)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkipperThresholds() when $default != null:
return $default(_that.windYellowMs,_that.windOrangeMs,_that.windRedMs,_that.waveYellowM,_that.waveOrangeM,_that.waveRedM,_that.pressureDropThresholdHpa);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double windYellowMs,  double windOrangeMs,  double windRedMs,  double waveYellowM,  double waveOrangeM,  double waveRedM,  double pressureDropThresholdHpa)  $default,) {final _that = this;
switch (_that) {
case _SkipperThresholds():
return $default(_that.windYellowMs,_that.windOrangeMs,_that.windRedMs,_that.waveYellowM,_that.waveOrangeM,_that.waveRedM,_that.pressureDropThresholdHpa);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double windYellowMs,  double windOrangeMs,  double windRedMs,  double waveYellowM,  double waveOrangeM,  double waveRedM,  double pressureDropThresholdHpa)?  $default,) {final _that = this;
switch (_that) {
case _SkipperThresholds() when $default != null:
return $default(_that.windYellowMs,_that.windOrangeMs,_that.windRedMs,_that.waveYellowM,_that.waveOrangeM,_that.waveRedM,_that.pressureDropThresholdHpa);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SkipperThresholds implements SkipperThresholds {
  const _SkipperThresholds({this.windYellowMs = 10.0, this.windOrangeMs = 12.0, this.windRedMs = 14.0, this.waveYellowM = 1.0, this.waveOrangeM = 1.5, this.waveRedM = 2.5, this.pressureDropThresholdHpa = 2.0});
  factory _SkipperThresholds.fromJson(Map<String, dynamic> json) => _$SkipperThresholdsFromJson(json);

@override@JsonKey() final  double windYellowMs;
@override@JsonKey() final  double windOrangeMs;
@override@JsonKey() final  double windRedMs;
@override@JsonKey() final  double waveYellowM;
@override@JsonKey() final  double waveOrangeM;
@override@JsonKey() final  double waveRedM;
@override@JsonKey() final  double pressureDropThresholdHpa;

/// Create a copy of SkipperThresholds
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkipperThresholdsCopyWith<_SkipperThresholds> get copyWith => __$SkipperThresholdsCopyWithImpl<_SkipperThresholds>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SkipperThresholdsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkipperThresholds&&(identical(other.windYellowMs, windYellowMs) || other.windYellowMs == windYellowMs)&&(identical(other.windOrangeMs, windOrangeMs) || other.windOrangeMs == windOrangeMs)&&(identical(other.windRedMs, windRedMs) || other.windRedMs == windRedMs)&&(identical(other.waveYellowM, waveYellowM) || other.waveYellowM == waveYellowM)&&(identical(other.waveOrangeM, waveOrangeM) || other.waveOrangeM == waveOrangeM)&&(identical(other.waveRedM, waveRedM) || other.waveRedM == waveRedM)&&(identical(other.pressureDropThresholdHpa, pressureDropThresholdHpa) || other.pressureDropThresholdHpa == pressureDropThresholdHpa));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,windYellowMs,windOrangeMs,windRedMs,waveYellowM,waveOrangeM,waveRedM,pressureDropThresholdHpa);

@override
String toString() {
  return 'SkipperThresholds(windYellowMs: $windYellowMs, windOrangeMs: $windOrangeMs, windRedMs: $windRedMs, waveYellowM: $waveYellowM, waveOrangeM: $waveOrangeM, waveRedM: $waveRedM, pressureDropThresholdHpa: $pressureDropThresholdHpa)';
}


}

/// @nodoc
abstract mixin class _$SkipperThresholdsCopyWith<$Res> implements $SkipperThresholdsCopyWith<$Res> {
  factory _$SkipperThresholdsCopyWith(_SkipperThresholds value, $Res Function(_SkipperThresholds) _then) = __$SkipperThresholdsCopyWithImpl;
@override @useResult
$Res call({
 double windYellowMs, double windOrangeMs, double windRedMs, double waveYellowM, double waveOrangeM, double waveRedM, double pressureDropThresholdHpa
});




}
/// @nodoc
class __$SkipperThresholdsCopyWithImpl<$Res>
    implements _$SkipperThresholdsCopyWith<$Res> {
  __$SkipperThresholdsCopyWithImpl(this._self, this._then);

  final _SkipperThresholds _self;
  final $Res Function(_SkipperThresholds) _then;

/// Create a copy of SkipperThresholds
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? windYellowMs = null,Object? windOrangeMs = null,Object? windRedMs = null,Object? waveYellowM = null,Object? waveOrangeM = null,Object? waveRedM = null,Object? pressureDropThresholdHpa = null,}) {
  return _then(_SkipperThresholds(
windYellowMs: null == windYellowMs ? _self.windYellowMs : windYellowMs // ignore: cast_nullable_to_non_nullable
as double,windOrangeMs: null == windOrangeMs ? _self.windOrangeMs : windOrangeMs // ignore: cast_nullable_to_non_nullable
as double,windRedMs: null == windRedMs ? _self.windRedMs : windRedMs // ignore: cast_nullable_to_non_nullable
as double,waveYellowM: null == waveYellowM ? _self.waveYellowM : waveYellowM // ignore: cast_nullable_to_non_nullable
as double,waveOrangeM: null == waveOrangeM ? _self.waveOrangeM : waveOrangeM // ignore: cast_nullable_to_non_nullable
as double,waveRedM: null == waveRedM ? _self.waveRedM : waveRedM // ignore: cast_nullable_to_non_nullable
as double,pressureDropThresholdHpa: null == pressureDropThresholdHpa ? _self.pressureDropThresholdHpa : pressureDropThresholdHpa // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
