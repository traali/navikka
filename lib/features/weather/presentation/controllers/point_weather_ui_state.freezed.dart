// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'point_weather_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PointWeatherUiState {

 bool get isRadarVisible; List<DateTime> get radarTimestamps; int get currentTimestampIndex; bool get isAnimating;
/// Create a copy of PointWeatherUiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PointWeatherUiStateCopyWith<PointWeatherUiState> get copyWith => _$PointWeatherUiStateCopyWithImpl<PointWeatherUiState>(this as PointWeatherUiState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PointWeatherUiState&&(identical(other.isRadarVisible, isRadarVisible) || other.isRadarVisible == isRadarVisible)&&const DeepCollectionEquality().equals(other.radarTimestamps, radarTimestamps)&&(identical(other.currentTimestampIndex, currentTimestampIndex) || other.currentTimestampIndex == currentTimestampIndex)&&(identical(other.isAnimating, isAnimating) || other.isAnimating == isAnimating));
}


@override
int get hashCode => Object.hash(runtimeType,isRadarVisible,const DeepCollectionEquality().hash(radarTimestamps),currentTimestampIndex,isAnimating);

@override
String toString() {
  return 'PointWeatherUiState(isRadarVisible: $isRadarVisible, radarTimestamps: $radarTimestamps, currentTimestampIndex: $currentTimestampIndex, isAnimating: $isAnimating)';
}


}

/// @nodoc
abstract mixin class $PointWeatherUiStateCopyWith<$Res>  {
  factory $PointWeatherUiStateCopyWith(PointWeatherUiState value, $Res Function(PointWeatherUiState) _then) = _$PointWeatherUiStateCopyWithImpl;
@useResult
$Res call({
 bool isRadarVisible, List<DateTime> radarTimestamps, int currentTimestampIndex, bool isAnimating
});




}
/// @nodoc
class _$PointWeatherUiStateCopyWithImpl<$Res>
    implements $PointWeatherUiStateCopyWith<$Res> {
  _$PointWeatherUiStateCopyWithImpl(this._self, this._then);

  final PointWeatherUiState _self;
  final $Res Function(PointWeatherUiState) _then;

/// Create a copy of PointWeatherUiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isRadarVisible = null,Object? radarTimestamps = null,Object? currentTimestampIndex = null,Object? isAnimating = null,}) {
  return _then(_self.copyWith(
isRadarVisible: null == isRadarVisible ? _self.isRadarVisible : isRadarVisible // ignore: cast_nullable_to_non_nullable
as bool,radarTimestamps: null == radarTimestamps ? _self.radarTimestamps : radarTimestamps // ignore: cast_nullable_to_non_nullable
as List<DateTime>,currentTimestampIndex: null == currentTimestampIndex ? _self.currentTimestampIndex : currentTimestampIndex // ignore: cast_nullable_to_non_nullable
as int,isAnimating: null == isAnimating ? _self.isAnimating : isAnimating // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PointWeatherUiState].
extension PointWeatherUiStatePatterns on PointWeatherUiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PointWeatherUiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PointWeatherUiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PointWeatherUiState value)  $default,){
final _that = this;
switch (_that) {
case _PointWeatherUiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PointWeatherUiState value)?  $default,){
final _that = this;
switch (_that) {
case _PointWeatherUiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isRadarVisible,  List<DateTime> radarTimestamps,  int currentTimestampIndex,  bool isAnimating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PointWeatherUiState() when $default != null:
return $default(_that.isRadarVisible,_that.radarTimestamps,_that.currentTimestampIndex,_that.isAnimating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isRadarVisible,  List<DateTime> radarTimestamps,  int currentTimestampIndex,  bool isAnimating)  $default,) {final _that = this;
switch (_that) {
case _PointWeatherUiState():
return $default(_that.isRadarVisible,_that.radarTimestamps,_that.currentTimestampIndex,_that.isAnimating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isRadarVisible,  List<DateTime> radarTimestamps,  int currentTimestampIndex,  bool isAnimating)?  $default,) {final _that = this;
switch (_that) {
case _PointWeatherUiState() when $default != null:
return $default(_that.isRadarVisible,_that.radarTimestamps,_that.currentTimestampIndex,_that.isAnimating);case _:
  return null;

}
}

}

/// @nodoc


class _PointWeatherUiState implements PointWeatherUiState {
  const _PointWeatherUiState({this.isRadarVisible = false, final  List<DateTime> radarTimestamps = const [], this.currentTimestampIndex = 0, this.isAnimating = false}): _radarTimestamps = radarTimestamps;
  

@override@JsonKey() final  bool isRadarVisible;
 final  List<DateTime> _radarTimestamps;
@override@JsonKey() List<DateTime> get radarTimestamps {
  if (_radarTimestamps is EqualUnmodifiableListView) return _radarTimestamps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_radarTimestamps);
}

@override@JsonKey() final  int currentTimestampIndex;
@override@JsonKey() final  bool isAnimating;

/// Create a copy of PointWeatherUiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PointWeatherUiStateCopyWith<_PointWeatherUiState> get copyWith => __$PointWeatherUiStateCopyWithImpl<_PointWeatherUiState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PointWeatherUiState&&(identical(other.isRadarVisible, isRadarVisible) || other.isRadarVisible == isRadarVisible)&&const DeepCollectionEquality().equals(other._radarTimestamps, _radarTimestamps)&&(identical(other.currentTimestampIndex, currentTimestampIndex) || other.currentTimestampIndex == currentTimestampIndex)&&(identical(other.isAnimating, isAnimating) || other.isAnimating == isAnimating));
}


@override
int get hashCode => Object.hash(runtimeType,isRadarVisible,const DeepCollectionEquality().hash(_radarTimestamps),currentTimestampIndex,isAnimating);

@override
String toString() {
  return 'PointWeatherUiState(isRadarVisible: $isRadarVisible, radarTimestamps: $radarTimestamps, currentTimestampIndex: $currentTimestampIndex, isAnimating: $isAnimating)';
}


}

/// @nodoc
abstract mixin class _$PointWeatherUiStateCopyWith<$Res> implements $PointWeatherUiStateCopyWith<$Res> {
  factory _$PointWeatherUiStateCopyWith(_PointWeatherUiState value, $Res Function(_PointWeatherUiState) _then) = __$PointWeatherUiStateCopyWithImpl;
@override @useResult
$Res call({
 bool isRadarVisible, List<DateTime> radarTimestamps, int currentTimestampIndex, bool isAnimating
});




}
/// @nodoc
class __$PointWeatherUiStateCopyWithImpl<$Res>
    implements _$PointWeatherUiStateCopyWith<$Res> {
  __$PointWeatherUiStateCopyWithImpl(this._self, this._then);

  final _PointWeatherUiState _self;
  final $Res Function(_PointWeatherUiState) _then;

/// Create a copy of PointWeatherUiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isRadarVisible = null,Object? radarTimestamps = null,Object? currentTimestampIndex = null,Object? isAnimating = null,}) {
  return _then(_PointWeatherUiState(
isRadarVisible: null == isRadarVisible ? _self.isRadarVisible : isRadarVisible // ignore: cast_nullable_to_non_nullable
as bool,radarTimestamps: null == radarTimestamps ? _self._radarTimestamps : radarTimestamps // ignore: cast_nullable_to_non_nullable
as List<DateTime>,currentTimestampIndex: null == currentTimestampIndex ? _self.currentTimestampIndex : currentTimestampIndex // ignore: cast_nullable_to_non_nullable
as int,isAnimating: null == isAnimating ? _self.isAnimating : isAnimating // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
