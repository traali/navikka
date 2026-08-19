// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MapState {

 LatLng get userLocation; bool get hasLocation; bool get isLocationFresh; DateTime? get lastPositionAt; double get currentSpeedKmh; double get heading; LatLng? get projectedCenter; SpeedLimitZone? get currentZone; List<SpeedLimitZone> get visibleZones; LocationPermissionStatus get locationPermissionStatus;
/// Create a copy of MapState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapStateCopyWith<MapState> get copyWith => _$MapStateCopyWithImpl<MapState>(this as MapState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapState&&(identical(other.userLocation, userLocation) || other.userLocation == userLocation)&&(identical(other.hasLocation, hasLocation) || other.hasLocation == hasLocation)&&(identical(other.isLocationFresh, isLocationFresh) || other.isLocationFresh == isLocationFresh)&&(identical(other.lastPositionAt, lastPositionAt) || other.lastPositionAt == lastPositionAt)&&(identical(other.currentSpeedKmh, currentSpeedKmh) || other.currentSpeedKmh == currentSpeedKmh)&&(identical(other.heading, heading) || other.heading == heading)&&(identical(other.projectedCenter, projectedCenter) || other.projectedCenter == projectedCenter)&&(identical(other.currentZone, currentZone) || other.currentZone == currentZone)&&const DeepCollectionEquality().equals(other.visibleZones, visibleZones)&&(identical(other.locationPermissionStatus, locationPermissionStatus) || other.locationPermissionStatus == locationPermissionStatus));
}


@override
int get hashCode => Object.hash(runtimeType,userLocation,hasLocation,isLocationFresh,lastPositionAt,currentSpeedKmh,heading,projectedCenter,currentZone,const DeepCollectionEquality().hash(visibleZones),locationPermissionStatus);

@override
String toString() {
  return 'MapState(userLocation: $userLocation, hasLocation: $hasLocation, isLocationFresh: $isLocationFresh, lastPositionAt: $lastPositionAt, currentSpeedKmh: $currentSpeedKmh, heading: $heading, projectedCenter: $projectedCenter, currentZone: $currentZone, visibleZones: $visibleZones, locationPermissionStatus: $locationPermissionStatus)';
}


}

/// @nodoc
abstract mixin class $MapStateCopyWith<$Res>  {
  factory $MapStateCopyWith(MapState value, $Res Function(MapState) _then) = _$MapStateCopyWithImpl;
@useResult
$Res call({
 LatLng userLocation, bool hasLocation, bool isLocationFresh, DateTime? lastPositionAt, double currentSpeedKmh, double heading, LatLng? projectedCenter, SpeedLimitZone? currentZone, List<SpeedLimitZone> visibleZones, LocationPermissionStatus locationPermissionStatus
});




}
/// @nodoc
class _$MapStateCopyWithImpl<$Res>
    implements $MapStateCopyWith<$Res> {
  _$MapStateCopyWithImpl(this._self, this._then);

  final MapState _self;
  final $Res Function(MapState) _then;

/// Create a copy of MapState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userLocation = null,Object? hasLocation = null,Object? isLocationFresh = null,Object? lastPositionAt = freezed,Object? currentSpeedKmh = null,Object? heading = null,Object? projectedCenter = freezed,Object? currentZone = freezed,Object? visibleZones = null,Object? locationPermissionStatus = null,}) {
  return _then(_self.copyWith(
userLocation: null == userLocation ? _self.userLocation : userLocation // ignore: cast_nullable_to_non_nullable
as LatLng,hasLocation: null == hasLocation ? _self.hasLocation : hasLocation // ignore: cast_nullable_to_non_nullable
as bool,isLocationFresh: null == isLocationFresh ? _self.isLocationFresh : isLocationFresh // ignore: cast_nullable_to_non_nullable
as bool,lastPositionAt: freezed == lastPositionAt ? _self.lastPositionAt : lastPositionAt // ignore: cast_nullable_to_non_nullable
as DateTime?,currentSpeedKmh: null == currentSpeedKmh ? _self.currentSpeedKmh : currentSpeedKmh // ignore: cast_nullable_to_non_nullable
as double,heading: null == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as double,projectedCenter: freezed == projectedCenter ? _self.projectedCenter : projectedCenter // ignore: cast_nullable_to_non_nullable
as LatLng?,currentZone: freezed == currentZone ? _self.currentZone : currentZone // ignore: cast_nullable_to_non_nullable
as SpeedLimitZone?,visibleZones: null == visibleZones ? _self.visibleZones : visibleZones // ignore: cast_nullable_to_non_nullable
as List<SpeedLimitZone>,locationPermissionStatus: null == locationPermissionStatus ? _self.locationPermissionStatus : locationPermissionStatus // ignore: cast_nullable_to_non_nullable
as LocationPermissionStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [MapState].
extension MapStatePatterns on MapState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapState value)  $default,){
final _that = this;
switch (_that) {
case _MapState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapState value)?  $default,){
final _that = this;
switch (_that) {
case _MapState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LatLng userLocation,  bool hasLocation,  bool isLocationFresh,  DateTime? lastPositionAt,  double currentSpeedKmh,  double heading,  LatLng? projectedCenter,  SpeedLimitZone? currentZone,  List<SpeedLimitZone> visibleZones,  LocationPermissionStatus locationPermissionStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapState() when $default != null:
return $default(_that.userLocation,_that.hasLocation,_that.isLocationFresh,_that.lastPositionAt,_that.currentSpeedKmh,_that.heading,_that.projectedCenter,_that.currentZone,_that.visibleZones,_that.locationPermissionStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LatLng userLocation,  bool hasLocation,  bool isLocationFresh,  DateTime? lastPositionAt,  double currentSpeedKmh,  double heading,  LatLng? projectedCenter,  SpeedLimitZone? currentZone,  List<SpeedLimitZone> visibleZones,  LocationPermissionStatus locationPermissionStatus)  $default,) {final _that = this;
switch (_that) {
case _MapState():
return $default(_that.userLocation,_that.hasLocation,_that.isLocationFresh,_that.lastPositionAt,_that.currentSpeedKmh,_that.heading,_that.projectedCenter,_that.currentZone,_that.visibleZones,_that.locationPermissionStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LatLng userLocation,  bool hasLocation,  bool isLocationFresh,  DateTime? lastPositionAt,  double currentSpeedKmh,  double heading,  LatLng? projectedCenter,  SpeedLimitZone? currentZone,  List<SpeedLimitZone> visibleZones,  LocationPermissionStatus locationPermissionStatus)?  $default,) {final _that = this;
switch (_that) {
case _MapState() when $default != null:
return $default(_that.userLocation,_that.hasLocation,_that.isLocationFresh,_that.lastPositionAt,_that.currentSpeedKmh,_that.heading,_that.projectedCenter,_that.currentZone,_that.visibleZones,_that.locationPermissionStatus);case _:
  return null;

}
}

}

/// @nodoc


class _MapState implements MapState {
  const _MapState({required this.userLocation, this.hasLocation = false, this.isLocationFresh = false, this.lastPositionAt, this.currentSpeedKmh = 0.0, this.heading = 0.0, this.projectedCenter, this.currentZone, final  List<SpeedLimitZone> visibleZones = const [], this.locationPermissionStatus = LocationPermissionStatus.unknown}): _visibleZones = visibleZones;
  

@override final  LatLng userLocation;
@override@JsonKey() final  bool hasLocation;
@override@JsonKey() final  bool isLocationFresh;
@override final  DateTime? lastPositionAt;
@override@JsonKey() final  double currentSpeedKmh;
@override@JsonKey() final  double heading;
@override final  LatLng? projectedCenter;
@override final  SpeedLimitZone? currentZone;
 final  List<SpeedLimitZone> _visibleZones;
@override@JsonKey() List<SpeedLimitZone> get visibleZones {
  if (_visibleZones is EqualUnmodifiableListView) return _visibleZones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_visibleZones);
}

@override@JsonKey() final  LocationPermissionStatus locationPermissionStatus;

/// Create a copy of MapState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapStateCopyWith<_MapState> get copyWith => __$MapStateCopyWithImpl<_MapState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapState&&(identical(other.userLocation, userLocation) || other.userLocation == userLocation)&&(identical(other.hasLocation, hasLocation) || other.hasLocation == hasLocation)&&(identical(other.isLocationFresh, isLocationFresh) || other.isLocationFresh == isLocationFresh)&&(identical(other.lastPositionAt, lastPositionAt) || other.lastPositionAt == lastPositionAt)&&(identical(other.currentSpeedKmh, currentSpeedKmh) || other.currentSpeedKmh == currentSpeedKmh)&&(identical(other.heading, heading) || other.heading == heading)&&(identical(other.projectedCenter, projectedCenter) || other.projectedCenter == projectedCenter)&&(identical(other.currentZone, currentZone) || other.currentZone == currentZone)&&const DeepCollectionEquality().equals(other._visibleZones, _visibleZones)&&(identical(other.locationPermissionStatus, locationPermissionStatus) || other.locationPermissionStatus == locationPermissionStatus));
}


@override
int get hashCode => Object.hash(runtimeType,userLocation,hasLocation,isLocationFresh,lastPositionAt,currentSpeedKmh,heading,projectedCenter,currentZone,const DeepCollectionEquality().hash(_visibleZones),locationPermissionStatus);

@override
String toString() {
  return 'MapState(userLocation: $userLocation, hasLocation: $hasLocation, isLocationFresh: $isLocationFresh, lastPositionAt: $lastPositionAt, currentSpeedKmh: $currentSpeedKmh, heading: $heading, projectedCenter: $projectedCenter, currentZone: $currentZone, visibleZones: $visibleZones, locationPermissionStatus: $locationPermissionStatus)';
}


}

/// @nodoc
abstract mixin class _$MapStateCopyWith<$Res> implements $MapStateCopyWith<$Res> {
  factory _$MapStateCopyWith(_MapState value, $Res Function(_MapState) _then) = __$MapStateCopyWithImpl;
@override @useResult
$Res call({
 LatLng userLocation, bool hasLocation, bool isLocationFresh, DateTime? lastPositionAt, double currentSpeedKmh, double heading, LatLng? projectedCenter, SpeedLimitZone? currentZone, List<SpeedLimitZone> visibleZones, LocationPermissionStatus locationPermissionStatus
});




}
/// @nodoc
class __$MapStateCopyWithImpl<$Res>
    implements _$MapStateCopyWith<$Res> {
  __$MapStateCopyWithImpl(this._self, this._then);

  final _MapState _self;
  final $Res Function(_MapState) _then;

/// Create a copy of MapState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userLocation = null,Object? hasLocation = null,Object? isLocationFresh = null,Object? lastPositionAt = freezed,Object? currentSpeedKmh = null,Object? heading = null,Object? projectedCenter = freezed,Object? currentZone = freezed,Object? visibleZones = null,Object? locationPermissionStatus = null,}) {
  return _then(_MapState(
userLocation: null == userLocation ? _self.userLocation : userLocation // ignore: cast_nullable_to_non_nullable
as LatLng,hasLocation: null == hasLocation ? _self.hasLocation : hasLocation // ignore: cast_nullable_to_non_nullable
as bool,isLocationFresh: null == isLocationFresh ? _self.isLocationFresh : isLocationFresh // ignore: cast_nullable_to_non_nullable
as bool,lastPositionAt: freezed == lastPositionAt ? _self.lastPositionAt : lastPositionAt // ignore: cast_nullable_to_non_nullable
as DateTime?,currentSpeedKmh: null == currentSpeedKmh ? _self.currentSpeedKmh : currentSpeedKmh // ignore: cast_nullable_to_non_nullable
as double,heading: null == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as double,projectedCenter: freezed == projectedCenter ? _self.projectedCenter : projectedCenter // ignore: cast_nullable_to_non_nullable
as LatLng?,currentZone: freezed == currentZone ? _self.currentZone : currentZone // ignore: cast_nullable_to_non_nullable
as SpeedLimitZone?,visibleZones: null == visibleZones ? _self._visibleZones : visibleZones // ignore: cast_nullable_to_non_nullable
as List<SpeedLimitZone>,locationPermissionStatus: null == locationPermissionStatus ? _self.locationPermissionStatus : locationPermissionStatus // ignore: cast_nullable_to_non_nullable
as LocationPermissionStatus,
  ));
}


}

// dart format on
