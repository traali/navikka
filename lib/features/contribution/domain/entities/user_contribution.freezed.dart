// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_contribution.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserContribution {

 String get id; ContributionType get type;@JsonKey(fromJson: _latLngFromJson, toJson: _latLngToJson) LatLng get location;/// For Speed Limit: the limit in km/h (e.g., 30)
/// For Traffic Sign: the type code or description
 String get value; DateTime get createdAt; bool get isSynced;
/// Create a copy of UserContribution
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserContributionCopyWith<UserContribution> get copyWith => _$UserContributionCopyWithImpl<UserContribution>(this as UserContribution, _$identity);

  /// Serializes this UserContribution to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserContribution&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.location, location) || other.location == location)&&(identical(other.value, value) || other.value == value)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,location,value,createdAt,isSynced);

@override
String toString() {
  return 'UserContribution(id: $id, type: $type, location: $location, value: $value, createdAt: $createdAt, isSynced: $isSynced)';
}


}

/// @nodoc
abstract mixin class $UserContributionCopyWith<$Res>  {
  factory $UserContributionCopyWith(UserContribution value, $Res Function(UserContribution) _then) = _$UserContributionCopyWithImpl;
@useResult
$Res call({
 String id, ContributionType type,@JsonKey(fromJson: _latLngFromJson, toJson: _latLngToJson) LatLng location, String value, DateTime createdAt, bool isSynced
});




}
/// @nodoc
class _$UserContributionCopyWithImpl<$Res>
    implements $UserContributionCopyWith<$Res> {
  _$UserContributionCopyWithImpl(this._self, this._then);

  final UserContribution _self;
  final $Res Function(UserContribution) _then;

/// Create a copy of UserContribution
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? location = null,Object? value = null,Object? createdAt = null,Object? isSynced = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ContributionType,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UserContribution].
extension UserContributionPatterns on UserContribution {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserContribution value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserContribution() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserContribution value)  $default,){
final _that = this;
switch (_that) {
case _UserContribution():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserContribution value)?  $default,){
final _that = this;
switch (_that) {
case _UserContribution() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ContributionType type, @JsonKey(fromJson: _latLngFromJson, toJson: _latLngToJson)  LatLng location,  String value,  DateTime createdAt,  bool isSynced)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserContribution() when $default != null:
return $default(_that.id,_that.type,_that.location,_that.value,_that.createdAt,_that.isSynced);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ContributionType type, @JsonKey(fromJson: _latLngFromJson, toJson: _latLngToJson)  LatLng location,  String value,  DateTime createdAt,  bool isSynced)  $default,) {final _that = this;
switch (_that) {
case _UserContribution():
return $default(_that.id,_that.type,_that.location,_that.value,_that.createdAt,_that.isSynced);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ContributionType type, @JsonKey(fromJson: _latLngFromJson, toJson: _latLngToJson)  LatLng location,  String value,  DateTime createdAt,  bool isSynced)?  $default,) {final _that = this;
switch (_that) {
case _UserContribution() when $default != null:
return $default(_that.id,_that.type,_that.location,_that.value,_that.createdAt,_that.isSynced);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserContribution implements UserContribution {
  const _UserContribution({required this.id, required this.type, @JsonKey(fromJson: _latLngFromJson, toJson: _latLngToJson) required this.location, required this.value, required this.createdAt, this.isSynced = false});
  factory _UserContribution.fromJson(Map<String, dynamic> json) => _$UserContributionFromJson(json);

@override final  String id;
@override final  ContributionType type;
@override@JsonKey(fromJson: _latLngFromJson, toJson: _latLngToJson) final  LatLng location;
/// For Speed Limit: the limit in km/h (e.g., 30)
/// For Traffic Sign: the type code or description
@override final  String value;
@override final  DateTime createdAt;
@override@JsonKey() final  bool isSynced;

/// Create a copy of UserContribution
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserContributionCopyWith<_UserContribution> get copyWith => __$UserContributionCopyWithImpl<_UserContribution>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserContributionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserContribution&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.location, location) || other.location == location)&&(identical(other.value, value) || other.value == value)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,location,value,createdAt,isSynced);

@override
String toString() {
  return 'UserContribution(id: $id, type: $type, location: $location, value: $value, createdAt: $createdAt, isSynced: $isSynced)';
}


}

/// @nodoc
abstract mixin class _$UserContributionCopyWith<$Res> implements $UserContributionCopyWith<$Res> {
  factory _$UserContributionCopyWith(_UserContribution value, $Res Function(_UserContribution) _then) = __$UserContributionCopyWithImpl;
@override @useResult
$Res call({
 String id, ContributionType type,@JsonKey(fromJson: _latLngFromJson, toJson: _latLngToJson) LatLng location, String value, DateTime createdAt, bool isSynced
});




}
/// @nodoc
class __$UserContributionCopyWithImpl<$Res>
    implements _$UserContributionCopyWith<$Res> {
  __$UserContributionCopyWithImpl(this._self, this._then);

  final _UserContribution _self;
  final $Res Function(_UserContribution) _then;

/// Create a copy of UserContribution
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? location = null,Object? value = null,Object? createdAt = null,Object? isSynced = null,}) {
  return _then(_UserContribution(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ContributionType,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
