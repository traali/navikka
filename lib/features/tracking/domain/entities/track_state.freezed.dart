// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'track_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrackState {

 int? get activeTrackId; String? get trackName; bool get isRecording; List<TrackPointEntity> get points; double get totalDistance; DateTime? get startTime; double get maxSpeedKmh;
/// Create a copy of TrackState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrackStateCopyWith<TrackState> get copyWith => _$TrackStateCopyWithImpl<TrackState>(this as TrackState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrackState&&(identical(other.activeTrackId, activeTrackId) || other.activeTrackId == activeTrackId)&&(identical(other.trackName, trackName) || other.trackName == trackName)&&(identical(other.isRecording, isRecording) || other.isRecording == isRecording)&&const DeepCollectionEquality().equals(other.points, points)&&(identical(other.totalDistance, totalDistance) || other.totalDistance == totalDistance)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.maxSpeedKmh, maxSpeedKmh) || other.maxSpeedKmh == maxSpeedKmh));
}


@override
int get hashCode => Object.hash(runtimeType,activeTrackId,trackName,isRecording,const DeepCollectionEquality().hash(points),totalDistance,startTime,maxSpeedKmh);

@override
String toString() {
  return 'TrackState(activeTrackId: $activeTrackId, trackName: $trackName, isRecording: $isRecording, points: $points, totalDistance: $totalDistance, startTime: $startTime, maxSpeedKmh: $maxSpeedKmh)';
}


}

/// @nodoc
abstract mixin class $TrackStateCopyWith<$Res>  {
  factory $TrackStateCopyWith(TrackState value, $Res Function(TrackState) _then) = _$TrackStateCopyWithImpl;
@useResult
$Res call({
 int? activeTrackId, String? trackName, bool isRecording, List<TrackPointEntity> points, double totalDistance, DateTime? startTime, double maxSpeedKmh
});




}
/// @nodoc
class _$TrackStateCopyWithImpl<$Res>
    implements $TrackStateCopyWith<$Res> {
  _$TrackStateCopyWithImpl(this._self, this._then);

  final TrackState _self;
  final $Res Function(TrackState) _then;

/// Create a copy of TrackState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activeTrackId = freezed,Object? trackName = freezed,Object? isRecording = null,Object? points = null,Object? totalDistance = null,Object? startTime = freezed,Object? maxSpeedKmh = null,}) {
  return _then(_self.copyWith(
activeTrackId: freezed == activeTrackId ? _self.activeTrackId : activeTrackId // ignore: cast_nullable_to_non_nullable
as int?,trackName: freezed == trackName ? _self.trackName : trackName // ignore: cast_nullable_to_non_nullable
as String?,isRecording: null == isRecording ? _self.isRecording : isRecording // ignore: cast_nullable_to_non_nullable
as bool,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<TrackPointEntity>,totalDistance: null == totalDistance ? _self.totalDistance : totalDistance // ignore: cast_nullable_to_non_nullable
as double,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,maxSpeedKmh: null == maxSpeedKmh ? _self.maxSpeedKmh : maxSpeedKmh // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TrackState].
extension TrackStatePatterns on TrackState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrackState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrackState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrackState value)  $default,){
final _that = this;
switch (_that) {
case _TrackState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrackState value)?  $default,){
final _that = this;
switch (_that) {
case _TrackState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? activeTrackId,  String? trackName,  bool isRecording,  List<TrackPointEntity> points,  double totalDistance,  DateTime? startTime,  double maxSpeedKmh)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrackState() when $default != null:
return $default(_that.activeTrackId,_that.trackName,_that.isRecording,_that.points,_that.totalDistance,_that.startTime,_that.maxSpeedKmh);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? activeTrackId,  String? trackName,  bool isRecording,  List<TrackPointEntity> points,  double totalDistance,  DateTime? startTime,  double maxSpeedKmh)  $default,) {final _that = this;
switch (_that) {
case _TrackState():
return $default(_that.activeTrackId,_that.trackName,_that.isRecording,_that.points,_that.totalDistance,_that.startTime,_that.maxSpeedKmh);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? activeTrackId,  String? trackName,  bool isRecording,  List<TrackPointEntity> points,  double totalDistance,  DateTime? startTime,  double maxSpeedKmh)?  $default,) {final _that = this;
switch (_that) {
case _TrackState() when $default != null:
return $default(_that.activeTrackId,_that.trackName,_that.isRecording,_that.points,_that.totalDistance,_that.startTime,_that.maxSpeedKmh);case _:
  return null;

}
}

}

/// @nodoc


class _TrackState implements TrackState {
  const _TrackState({this.activeTrackId, this.trackName, this.isRecording = false, final  List<TrackPointEntity> points = const [], this.totalDistance = 0.0, this.startTime, this.maxSpeedKmh = 0.0}): _points = points;
  

@override final  int? activeTrackId;
@override final  String? trackName;
@override@JsonKey() final  bool isRecording;
 final  List<TrackPointEntity> _points;
@override@JsonKey() List<TrackPointEntity> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

@override@JsonKey() final  double totalDistance;
@override final  DateTime? startTime;
@override@JsonKey() final  double maxSpeedKmh;

/// Create a copy of TrackState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrackStateCopyWith<_TrackState> get copyWith => __$TrackStateCopyWithImpl<_TrackState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrackState&&(identical(other.activeTrackId, activeTrackId) || other.activeTrackId == activeTrackId)&&(identical(other.trackName, trackName) || other.trackName == trackName)&&(identical(other.isRecording, isRecording) || other.isRecording == isRecording)&&const DeepCollectionEquality().equals(other._points, _points)&&(identical(other.totalDistance, totalDistance) || other.totalDistance == totalDistance)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.maxSpeedKmh, maxSpeedKmh) || other.maxSpeedKmh == maxSpeedKmh));
}


@override
int get hashCode => Object.hash(runtimeType,activeTrackId,trackName,isRecording,const DeepCollectionEquality().hash(_points),totalDistance,startTime,maxSpeedKmh);

@override
String toString() {
  return 'TrackState(activeTrackId: $activeTrackId, trackName: $trackName, isRecording: $isRecording, points: $points, totalDistance: $totalDistance, startTime: $startTime, maxSpeedKmh: $maxSpeedKmh)';
}


}

/// @nodoc
abstract mixin class _$TrackStateCopyWith<$Res> implements $TrackStateCopyWith<$Res> {
  factory _$TrackStateCopyWith(_TrackState value, $Res Function(_TrackState) _then) = __$TrackStateCopyWithImpl;
@override @useResult
$Res call({
 int? activeTrackId, String? trackName, bool isRecording, List<TrackPointEntity> points, double totalDistance, DateTime? startTime, double maxSpeedKmh
});




}
/// @nodoc
class __$TrackStateCopyWithImpl<$Res>
    implements _$TrackStateCopyWith<$Res> {
  __$TrackStateCopyWithImpl(this._self, this._then);

  final _TrackState _self;
  final $Res Function(_TrackState) _then;

/// Create a copy of TrackState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activeTrackId = freezed,Object? trackName = freezed,Object? isRecording = null,Object? points = null,Object? totalDistance = null,Object? startTime = freezed,Object? maxSpeedKmh = null,}) {
  return _then(_TrackState(
activeTrackId: freezed == activeTrackId ? _self.activeTrackId : activeTrackId // ignore: cast_nullable_to_non_nullable
as int?,trackName: freezed == trackName ? _self.trackName : trackName // ignore: cast_nullable_to_non_nullable
as String?,isRecording: null == isRecording ? _self.isRecording : isRecording // ignore: cast_nullable_to_non_nullable
as bool,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<TrackPointEntity>,totalDistance: null == totalDistance ? _self.totalDistance : totalDistance // ignore: cast_nullable_to_non_nullable
as double,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,maxSpeedKmh: null == maxSpeedKmh ? _self.maxSpeedKmh : maxSpeedKmh // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
