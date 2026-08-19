// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation_line_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NavigationLineDto {

 String get id; List<LatLng> get points; String? get name; double? get navigationDepth; double? get sweptDepth; String? get fairwayClass; bool get isBoatingRoute;
/// Create a copy of NavigationLineDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NavigationLineDtoCopyWith<NavigationLineDto> get copyWith => _$NavigationLineDtoCopyWithImpl<NavigationLineDto>(this as NavigationLineDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NavigationLineDto&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.points, points)&&(identical(other.name, name) || other.name == name)&&(identical(other.navigationDepth, navigationDepth) || other.navigationDepth == navigationDepth)&&(identical(other.sweptDepth, sweptDepth) || other.sweptDepth == sweptDepth)&&(identical(other.fairwayClass, fairwayClass) || other.fairwayClass == fairwayClass)&&(identical(other.isBoatingRoute, isBoatingRoute) || other.isBoatingRoute == isBoatingRoute));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(points),name,navigationDepth,sweptDepth,fairwayClass,isBoatingRoute);

@override
String toString() {
  return 'NavigationLineDto(id: $id, points: $points, name: $name, navigationDepth: $navigationDepth, sweptDepth: $sweptDepth, fairwayClass: $fairwayClass, isBoatingRoute: $isBoatingRoute)';
}


}

/// @nodoc
abstract mixin class $NavigationLineDtoCopyWith<$Res>  {
  factory $NavigationLineDtoCopyWith(NavigationLineDto value, $Res Function(NavigationLineDto) _then) = _$NavigationLineDtoCopyWithImpl;
@useResult
$Res call({
 String id, List<LatLng> points, String? name, double? navigationDepth, double? sweptDepth, String? fairwayClass, bool isBoatingRoute
});




}
/// @nodoc
class _$NavigationLineDtoCopyWithImpl<$Res>
    implements $NavigationLineDtoCopyWith<$Res> {
  _$NavigationLineDtoCopyWithImpl(this._self, this._then);

  final NavigationLineDto _self;
  final $Res Function(NavigationLineDto) _then;

/// Create a copy of NavigationLineDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? points = null,Object? name = freezed,Object? navigationDepth = freezed,Object? sweptDepth = freezed,Object? fairwayClass = freezed,Object? isBoatingRoute = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<LatLng>,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,navigationDepth: freezed == navigationDepth ? _self.navigationDepth : navigationDepth // ignore: cast_nullable_to_non_nullable
as double?,sweptDepth: freezed == sweptDepth ? _self.sweptDepth : sweptDepth // ignore: cast_nullable_to_non_nullable
as double?,fairwayClass: freezed == fairwayClass ? _self.fairwayClass : fairwayClass // ignore: cast_nullable_to_non_nullable
as String?,isBoatingRoute: null == isBoatingRoute ? _self.isBoatingRoute : isBoatingRoute // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NavigationLineDto].
extension NavigationLineDtoPatterns on NavigationLineDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NavigationLineDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NavigationLineDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NavigationLineDto value)  $default,){
final _that = this;
switch (_that) {
case _NavigationLineDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NavigationLineDto value)?  $default,){
final _that = this;
switch (_that) {
case _NavigationLineDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  List<LatLng> points,  String? name,  double? navigationDepth,  double? sweptDepth,  String? fairwayClass,  bool isBoatingRoute)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NavigationLineDto() when $default != null:
return $default(_that.id,_that.points,_that.name,_that.navigationDepth,_that.sweptDepth,_that.fairwayClass,_that.isBoatingRoute);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  List<LatLng> points,  String? name,  double? navigationDepth,  double? sweptDepth,  String? fairwayClass,  bool isBoatingRoute)  $default,) {final _that = this;
switch (_that) {
case _NavigationLineDto():
return $default(_that.id,_that.points,_that.name,_that.navigationDepth,_that.sweptDepth,_that.fairwayClass,_that.isBoatingRoute);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  List<LatLng> points,  String? name,  double? navigationDepth,  double? sweptDepth,  String? fairwayClass,  bool isBoatingRoute)?  $default,) {final _that = this;
switch (_that) {
case _NavigationLineDto() when $default != null:
return $default(_that.id,_that.points,_that.name,_that.navigationDepth,_that.sweptDepth,_that.fairwayClass,_that.isBoatingRoute);case _:
  return null;

}
}

}

/// @nodoc


class _NavigationLineDto implements NavigationLineDto {
  const _NavigationLineDto({required this.id, required final  List<LatLng> points, this.name, this.navigationDepth, this.sweptDepth, this.fairwayClass, this.isBoatingRoute = false}): _points = points;
  

@override final  String id;
 final  List<LatLng> _points;
@override List<LatLng> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

@override final  String? name;
@override final  double? navigationDepth;
@override final  double? sweptDepth;
@override final  String? fairwayClass;
@override@JsonKey() final  bool isBoatingRoute;

/// Create a copy of NavigationLineDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NavigationLineDtoCopyWith<_NavigationLineDto> get copyWith => __$NavigationLineDtoCopyWithImpl<_NavigationLineDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NavigationLineDto&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._points, _points)&&(identical(other.name, name) || other.name == name)&&(identical(other.navigationDepth, navigationDepth) || other.navigationDepth == navigationDepth)&&(identical(other.sweptDepth, sweptDepth) || other.sweptDepth == sweptDepth)&&(identical(other.fairwayClass, fairwayClass) || other.fairwayClass == fairwayClass)&&(identical(other.isBoatingRoute, isBoatingRoute) || other.isBoatingRoute == isBoatingRoute));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_points),name,navigationDepth,sweptDepth,fairwayClass,isBoatingRoute);

@override
String toString() {
  return 'NavigationLineDto(id: $id, points: $points, name: $name, navigationDepth: $navigationDepth, sweptDepth: $sweptDepth, fairwayClass: $fairwayClass, isBoatingRoute: $isBoatingRoute)';
}


}

/// @nodoc
abstract mixin class _$NavigationLineDtoCopyWith<$Res> implements $NavigationLineDtoCopyWith<$Res> {
  factory _$NavigationLineDtoCopyWith(_NavigationLineDto value, $Res Function(_NavigationLineDto) _then) = __$NavigationLineDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, List<LatLng> points, String? name, double? navigationDepth, double? sweptDepth, String? fairwayClass, bool isBoatingRoute
});




}
/// @nodoc
class __$NavigationLineDtoCopyWithImpl<$Res>
    implements _$NavigationLineDtoCopyWith<$Res> {
  __$NavigationLineDtoCopyWithImpl(this._self, this._then);

  final _NavigationLineDto _self;
  final $Res Function(_NavigationLineDto) _then;

/// Create a copy of NavigationLineDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? points = null,Object? name = freezed,Object? navigationDepth = freezed,Object? sweptDepth = freezed,Object? fairwayClass = freezed,Object? isBoatingRoute = null,}) {
  return _then(_NavigationLineDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<LatLng>,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,navigationDepth: freezed == navigationDepth ? _self.navigationDepth : navigationDepth // ignore: cast_nullable_to_non_nullable
as double?,sweptDepth: freezed == sweptDepth ? _self.sweptDepth : sweptDepth // ignore: cast_nullable_to_non_nullable
as double?,fairwayClass: freezed == fairwayClass ? _self.fairwayClass : fairwayClass // ignore: cast_nullable_to_non_nullable
as String?,isBoatingRoute: null == isBoatingRoute ? _self.isBoatingRoute : isBoatingRoute // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
