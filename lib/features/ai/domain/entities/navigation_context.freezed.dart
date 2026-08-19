// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation_context.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NavigationContext {

 VesselType get vesselType; double? get draftDepth; bool get hasActiveRoute; String? get activeRouteName; List<LatLng>? get routePoints; List<String>? get detectedHazards; bool get isNearingCoast;
/// Create a copy of NavigationContext
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NavigationContextCopyWith<NavigationContext> get copyWith => _$NavigationContextCopyWithImpl<NavigationContext>(this as NavigationContext, _$identity);

  /// Serializes this NavigationContext to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NavigationContext&&(identical(other.vesselType, vesselType) || other.vesselType == vesselType)&&(identical(other.draftDepth, draftDepth) || other.draftDepth == draftDepth)&&(identical(other.hasActiveRoute, hasActiveRoute) || other.hasActiveRoute == hasActiveRoute)&&(identical(other.activeRouteName, activeRouteName) || other.activeRouteName == activeRouteName)&&const DeepCollectionEquality().equals(other.routePoints, routePoints)&&const DeepCollectionEquality().equals(other.detectedHazards, detectedHazards)&&(identical(other.isNearingCoast, isNearingCoast) || other.isNearingCoast == isNearingCoast));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vesselType,draftDepth,hasActiveRoute,activeRouteName,const DeepCollectionEquality().hash(routePoints),const DeepCollectionEquality().hash(detectedHazards),isNearingCoast);

@override
String toString() {
  return 'NavigationContext(vesselType: $vesselType, draftDepth: $draftDepth, hasActiveRoute: $hasActiveRoute, activeRouteName: $activeRouteName, routePoints: $routePoints, detectedHazards: $detectedHazards, isNearingCoast: $isNearingCoast)';
}


}

/// @nodoc
abstract mixin class $NavigationContextCopyWith<$Res>  {
  factory $NavigationContextCopyWith(NavigationContext value, $Res Function(NavigationContext) _then) = _$NavigationContextCopyWithImpl;
@useResult
$Res call({
 VesselType vesselType, double? draftDepth, bool hasActiveRoute, String? activeRouteName, List<LatLng>? routePoints, List<String>? detectedHazards, bool isNearingCoast
});




}
/// @nodoc
class _$NavigationContextCopyWithImpl<$Res>
    implements $NavigationContextCopyWith<$Res> {
  _$NavigationContextCopyWithImpl(this._self, this._then);

  final NavigationContext _self;
  final $Res Function(NavigationContext) _then;

/// Create a copy of NavigationContext
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vesselType = null,Object? draftDepth = freezed,Object? hasActiveRoute = null,Object? activeRouteName = freezed,Object? routePoints = freezed,Object? detectedHazards = freezed,Object? isNearingCoast = null,}) {
  return _then(_self.copyWith(
vesselType: null == vesselType ? _self.vesselType : vesselType // ignore: cast_nullable_to_non_nullable
as VesselType,draftDepth: freezed == draftDepth ? _self.draftDepth : draftDepth // ignore: cast_nullable_to_non_nullable
as double?,hasActiveRoute: null == hasActiveRoute ? _self.hasActiveRoute : hasActiveRoute // ignore: cast_nullable_to_non_nullable
as bool,activeRouteName: freezed == activeRouteName ? _self.activeRouteName : activeRouteName // ignore: cast_nullable_to_non_nullable
as String?,routePoints: freezed == routePoints ? _self.routePoints : routePoints // ignore: cast_nullable_to_non_nullable
as List<LatLng>?,detectedHazards: freezed == detectedHazards ? _self.detectedHazards : detectedHazards // ignore: cast_nullable_to_non_nullable
as List<String>?,isNearingCoast: null == isNearingCoast ? _self.isNearingCoast : isNearingCoast // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NavigationContext].
extension NavigationContextPatterns on NavigationContext {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NavigationContext value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NavigationContext() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NavigationContext value)  $default,){
final _that = this;
switch (_that) {
case _NavigationContext():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NavigationContext value)?  $default,){
final _that = this;
switch (_that) {
case _NavigationContext() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( VesselType vesselType,  double? draftDepth,  bool hasActiveRoute,  String? activeRouteName,  List<LatLng>? routePoints,  List<String>? detectedHazards,  bool isNearingCoast)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NavigationContext() when $default != null:
return $default(_that.vesselType,_that.draftDepth,_that.hasActiveRoute,_that.activeRouteName,_that.routePoints,_that.detectedHazards,_that.isNearingCoast);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( VesselType vesselType,  double? draftDepth,  bool hasActiveRoute,  String? activeRouteName,  List<LatLng>? routePoints,  List<String>? detectedHazards,  bool isNearingCoast)  $default,) {final _that = this;
switch (_that) {
case _NavigationContext():
return $default(_that.vesselType,_that.draftDepth,_that.hasActiveRoute,_that.activeRouteName,_that.routePoints,_that.detectedHazards,_that.isNearingCoast);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( VesselType vesselType,  double? draftDepth,  bool hasActiveRoute,  String? activeRouteName,  List<LatLng>? routePoints,  List<String>? detectedHazards,  bool isNearingCoast)?  $default,) {final _that = this;
switch (_that) {
case _NavigationContext() when $default != null:
return $default(_that.vesselType,_that.draftDepth,_that.hasActiveRoute,_that.activeRouteName,_that.routePoints,_that.detectedHazards,_that.isNearingCoast);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NavigationContext implements NavigationContext {
  const _NavigationContext({required this.vesselType, this.draftDepth, this.hasActiveRoute = false, this.activeRouteName, final  List<LatLng>? routePoints, final  List<String>? detectedHazards, this.isNearingCoast = false}): _routePoints = routePoints,_detectedHazards = detectedHazards;
  factory _NavigationContext.fromJson(Map<String, dynamic> json) => _$NavigationContextFromJson(json);

@override final  VesselType vesselType;
@override final  double? draftDepth;
@override@JsonKey() final  bool hasActiveRoute;
@override final  String? activeRouteName;
 final  List<LatLng>? _routePoints;
@override List<LatLng>? get routePoints {
  final value = _routePoints;
  if (value == null) return null;
  if (_routePoints is EqualUnmodifiableListView) return _routePoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _detectedHazards;
@override List<String>? get detectedHazards {
  final value = _detectedHazards;
  if (value == null) return null;
  if (_detectedHazards is EqualUnmodifiableListView) return _detectedHazards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  bool isNearingCoast;

/// Create a copy of NavigationContext
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NavigationContextCopyWith<_NavigationContext> get copyWith => __$NavigationContextCopyWithImpl<_NavigationContext>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NavigationContextToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NavigationContext&&(identical(other.vesselType, vesselType) || other.vesselType == vesselType)&&(identical(other.draftDepth, draftDepth) || other.draftDepth == draftDepth)&&(identical(other.hasActiveRoute, hasActiveRoute) || other.hasActiveRoute == hasActiveRoute)&&(identical(other.activeRouteName, activeRouteName) || other.activeRouteName == activeRouteName)&&const DeepCollectionEquality().equals(other._routePoints, _routePoints)&&const DeepCollectionEquality().equals(other._detectedHazards, _detectedHazards)&&(identical(other.isNearingCoast, isNearingCoast) || other.isNearingCoast == isNearingCoast));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vesselType,draftDepth,hasActiveRoute,activeRouteName,const DeepCollectionEquality().hash(_routePoints),const DeepCollectionEquality().hash(_detectedHazards),isNearingCoast);

@override
String toString() {
  return 'NavigationContext(vesselType: $vesselType, draftDepth: $draftDepth, hasActiveRoute: $hasActiveRoute, activeRouteName: $activeRouteName, routePoints: $routePoints, detectedHazards: $detectedHazards, isNearingCoast: $isNearingCoast)';
}


}

/// @nodoc
abstract mixin class _$NavigationContextCopyWith<$Res> implements $NavigationContextCopyWith<$Res> {
  factory _$NavigationContextCopyWith(_NavigationContext value, $Res Function(_NavigationContext) _then) = __$NavigationContextCopyWithImpl;
@override @useResult
$Res call({
 VesselType vesselType, double? draftDepth, bool hasActiveRoute, String? activeRouteName, List<LatLng>? routePoints, List<String>? detectedHazards, bool isNearingCoast
});




}
/// @nodoc
class __$NavigationContextCopyWithImpl<$Res>
    implements _$NavigationContextCopyWith<$Res> {
  __$NavigationContextCopyWithImpl(this._self, this._then);

  final _NavigationContext _self;
  final $Res Function(_NavigationContext) _then;

/// Create a copy of NavigationContext
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vesselType = null,Object? draftDepth = freezed,Object? hasActiveRoute = null,Object? activeRouteName = freezed,Object? routePoints = freezed,Object? detectedHazards = freezed,Object? isNearingCoast = null,}) {
  return _then(_NavigationContext(
vesselType: null == vesselType ? _self.vesselType : vesselType // ignore: cast_nullable_to_non_nullable
as VesselType,draftDepth: freezed == draftDepth ? _self.draftDepth : draftDepth // ignore: cast_nullable_to_non_nullable
as double?,hasActiveRoute: null == hasActiveRoute ? _self.hasActiveRoute : hasActiveRoute // ignore: cast_nullable_to_non_nullable
as bool,activeRouteName: freezed == activeRouteName ? _self.activeRouteName : activeRouteName // ignore: cast_nullable_to_non_nullable
as String?,routePoints: freezed == routePoints ? _self._routePoints : routePoints // ignore: cast_nullable_to_non_nullable
as List<LatLng>?,detectedHazards: freezed == detectedHazards ? _self._detectedHazards : detectedHazards // ignore: cast_nullable_to_non_nullable
as List<String>?,isNearingCoast: null == isNearingCoast ? _self.isNearingCoast : isNearingCoast // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
