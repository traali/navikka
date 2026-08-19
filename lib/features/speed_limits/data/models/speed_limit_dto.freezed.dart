// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'speed_limit_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpeedLimitDto {

 String get id; int get limit; List<List<List<double>>> get rings; String? get type; String? get code;
/// Create a copy of SpeedLimitDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeedLimitDtoCopyWith<SpeedLimitDto> get copyWith => _$SpeedLimitDtoCopyWithImpl<SpeedLimitDto>(this as SpeedLimitDto, _$identity);

  /// Serializes this SpeedLimitDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeedLimitDto&&(identical(other.id, id) || other.id == id)&&(identical(other.limit, limit) || other.limit == limit)&&const DeepCollectionEquality().equals(other.rings, rings)&&(identical(other.type, type) || other.type == type)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,limit,const DeepCollectionEquality().hash(rings),type,code);

@override
String toString() {
  return 'SpeedLimitDto(id: $id, limit: $limit, rings: $rings, type: $type, code: $code)';
}


}

/// @nodoc
abstract mixin class $SpeedLimitDtoCopyWith<$Res>  {
  factory $SpeedLimitDtoCopyWith(SpeedLimitDto value, $Res Function(SpeedLimitDto) _then) = _$SpeedLimitDtoCopyWithImpl;
@useResult
$Res call({
 String id, int limit, List<List<List<double>>> rings, String? type, String? code
});




}
/// @nodoc
class _$SpeedLimitDtoCopyWithImpl<$Res>
    implements $SpeedLimitDtoCopyWith<$Res> {
  _$SpeedLimitDtoCopyWithImpl(this._self, this._then);

  final SpeedLimitDto _self;
  final $Res Function(SpeedLimitDto) _then;

/// Create a copy of SpeedLimitDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? limit = null,Object? rings = null,Object? type = freezed,Object? code = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,rings: null == rings ? _self.rings : rings // ignore: cast_nullable_to_non_nullable
as List<List<List<double>>>,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SpeedLimitDto].
extension SpeedLimitDtoPatterns on SpeedLimitDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpeedLimitDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpeedLimitDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpeedLimitDto value)  $default,){
final _that = this;
switch (_that) {
case _SpeedLimitDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpeedLimitDto value)?  $default,){
final _that = this;
switch (_that) {
case _SpeedLimitDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int limit,  List<List<List<double>>> rings,  String? type,  String? code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpeedLimitDto() when $default != null:
return $default(_that.id,_that.limit,_that.rings,_that.type,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int limit,  List<List<List<double>>> rings,  String? type,  String? code)  $default,) {final _that = this;
switch (_that) {
case _SpeedLimitDto():
return $default(_that.id,_that.limit,_that.rings,_that.type,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int limit,  List<List<List<double>>> rings,  String? type,  String? code)?  $default,) {final _that = this;
switch (_that) {
case _SpeedLimitDto() when $default != null:
return $default(_that.id,_that.limit,_that.rings,_that.type,_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpeedLimitDto implements SpeedLimitDto {
  const _SpeedLimitDto({required this.id, required this.limit, required final  List<List<List<double>>> rings, this.type, this.code}): _rings = rings;
  factory _SpeedLimitDto.fromJson(Map<String, dynamic> json) => _$SpeedLimitDtoFromJson(json);

@override final  String id;
@override final  int limit;
 final  List<List<List<double>>> _rings;
@override List<List<List<double>>> get rings {
  if (_rings is EqualUnmodifiableListView) return _rings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rings);
}

@override final  String? type;
@override final  String? code;

/// Create a copy of SpeedLimitDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeedLimitDtoCopyWith<_SpeedLimitDto> get copyWith => __$SpeedLimitDtoCopyWithImpl<_SpeedLimitDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpeedLimitDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpeedLimitDto&&(identical(other.id, id) || other.id == id)&&(identical(other.limit, limit) || other.limit == limit)&&const DeepCollectionEquality().equals(other._rings, _rings)&&(identical(other.type, type) || other.type == type)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,limit,const DeepCollectionEquality().hash(_rings),type,code);

@override
String toString() {
  return 'SpeedLimitDto(id: $id, limit: $limit, rings: $rings, type: $type, code: $code)';
}


}

/// @nodoc
abstract mixin class _$SpeedLimitDtoCopyWith<$Res> implements $SpeedLimitDtoCopyWith<$Res> {
  factory _$SpeedLimitDtoCopyWith(_SpeedLimitDto value, $Res Function(_SpeedLimitDto) _then) = __$SpeedLimitDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, int limit, List<List<List<double>>> rings, String? type, String? code
});




}
/// @nodoc
class __$SpeedLimitDtoCopyWithImpl<$Res>
    implements _$SpeedLimitDtoCopyWith<$Res> {
  __$SpeedLimitDtoCopyWithImpl(this._self, this._then);

  final _SpeedLimitDto _self;
  final $Res Function(_SpeedLimitDto) _then;

/// Create a copy of SpeedLimitDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? limit = null,Object? rings = null,Object? type = freezed,Object? code = freezed,}) {
  return _then(_SpeedLimitDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,rings: null == rings ? _self._rings : rings // ignore: cast_nullable_to_non_nullable
as List<List<List<double>>>,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
