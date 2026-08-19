// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fish_catch.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FishCatch {

/// Unique identifier (UUID).
 String get id;/// Species of fish caught.
 FishSpecies get species;/// Timestamp when the catch was recorded.
 DateTime get timestamp;/// GPS location where the fish was caught.
@JsonKey(fromJson: _latLngFromJson, toJson: _latLngToJson) LatLng get location;/// Weight in grams (optional).
 int? get weightGrams;/// Length in centimeters (optional).
 double? get lengthCm;/// Lure or bait used (optional).
 String? get lure;/// Fishing method used (optional).
 FishingMethod? get method;/// Free-form notes (optional).
 String? get notes;/// Temperature at time of catch (optional).
 double? get weatherTemp;/// Wind speed at time of catch (optional).
 double? get weatherWindSpeed;/// Wind direction at time of catch (optional).
 double? get weatherWindDir;/// Weather description at time of catch (optional).
 String? get weatherDesc;/// Weather icon code at time of catch (optional).
 String? get weatherIcon;
/// Create a copy of FishCatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FishCatchCopyWith<FishCatch> get copyWith => _$FishCatchCopyWithImpl<FishCatch>(this as FishCatch, _$identity);

  /// Serializes this FishCatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FishCatch&&(identical(other.id, id) || other.id == id)&&(identical(other.species, species) || other.species == species)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.weightGrams, weightGrams) || other.weightGrams == weightGrams)&&(identical(other.lengthCm, lengthCm) || other.lengthCm == lengthCm)&&(identical(other.lure, lure) || other.lure == lure)&&(identical(other.method, method) || other.method == method)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.weatherTemp, weatherTemp) || other.weatherTemp == weatherTemp)&&(identical(other.weatherWindSpeed, weatherWindSpeed) || other.weatherWindSpeed == weatherWindSpeed)&&(identical(other.weatherWindDir, weatherWindDir) || other.weatherWindDir == weatherWindDir)&&(identical(other.weatherDesc, weatherDesc) || other.weatherDesc == weatherDesc)&&(identical(other.weatherIcon, weatherIcon) || other.weatherIcon == weatherIcon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,species,timestamp,location,weightGrams,lengthCm,lure,method,notes,weatherTemp,weatherWindSpeed,weatherWindDir,weatherDesc,weatherIcon);

@override
String toString() {
  return 'FishCatch(id: $id, species: $species, timestamp: $timestamp, location: $location, weightGrams: $weightGrams, lengthCm: $lengthCm, lure: $lure, method: $method, notes: $notes, weatherTemp: $weatherTemp, weatherWindSpeed: $weatherWindSpeed, weatherWindDir: $weatherWindDir, weatherDesc: $weatherDesc, weatherIcon: $weatherIcon)';
}


}

/// @nodoc
abstract mixin class $FishCatchCopyWith<$Res>  {
  factory $FishCatchCopyWith(FishCatch value, $Res Function(FishCatch) _then) = _$FishCatchCopyWithImpl;
@useResult
$Res call({
 String id, FishSpecies species, DateTime timestamp,@JsonKey(fromJson: _latLngFromJson, toJson: _latLngToJson) LatLng location, int? weightGrams, double? lengthCm, String? lure, FishingMethod? method, String? notes, double? weatherTemp, double? weatherWindSpeed, double? weatherWindDir, String? weatherDesc, String? weatherIcon
});




}
/// @nodoc
class _$FishCatchCopyWithImpl<$Res>
    implements $FishCatchCopyWith<$Res> {
  _$FishCatchCopyWithImpl(this._self, this._then);

  final FishCatch _self;
  final $Res Function(FishCatch) _then;

/// Create a copy of FishCatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? species = null,Object? timestamp = null,Object? location = null,Object? weightGrams = freezed,Object? lengthCm = freezed,Object? lure = freezed,Object? method = freezed,Object? notes = freezed,Object? weatherTemp = freezed,Object? weatherWindSpeed = freezed,Object? weatherWindDir = freezed,Object? weatherDesc = freezed,Object? weatherIcon = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as FishSpecies,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,weightGrams: freezed == weightGrams ? _self.weightGrams : weightGrams // ignore: cast_nullable_to_non_nullable
as int?,lengthCm: freezed == lengthCm ? _self.lengthCm : lengthCm // ignore: cast_nullable_to_non_nullable
as double?,lure: freezed == lure ? _self.lure : lure // ignore: cast_nullable_to_non_nullable
as String?,method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as FishingMethod?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,weatherTemp: freezed == weatherTemp ? _self.weatherTemp : weatherTemp // ignore: cast_nullable_to_non_nullable
as double?,weatherWindSpeed: freezed == weatherWindSpeed ? _self.weatherWindSpeed : weatherWindSpeed // ignore: cast_nullable_to_non_nullable
as double?,weatherWindDir: freezed == weatherWindDir ? _self.weatherWindDir : weatherWindDir // ignore: cast_nullable_to_non_nullable
as double?,weatherDesc: freezed == weatherDesc ? _self.weatherDesc : weatherDesc // ignore: cast_nullable_to_non_nullable
as String?,weatherIcon: freezed == weatherIcon ? _self.weatherIcon : weatherIcon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FishCatch].
extension FishCatchPatterns on FishCatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FishCatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FishCatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FishCatch value)  $default,){
final _that = this;
switch (_that) {
case _FishCatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FishCatch value)?  $default,){
final _that = this;
switch (_that) {
case _FishCatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  FishSpecies species,  DateTime timestamp, @JsonKey(fromJson: _latLngFromJson, toJson: _latLngToJson)  LatLng location,  int? weightGrams,  double? lengthCm,  String? lure,  FishingMethod? method,  String? notes,  double? weatherTemp,  double? weatherWindSpeed,  double? weatherWindDir,  String? weatherDesc,  String? weatherIcon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FishCatch() when $default != null:
return $default(_that.id,_that.species,_that.timestamp,_that.location,_that.weightGrams,_that.lengthCm,_that.lure,_that.method,_that.notes,_that.weatherTemp,_that.weatherWindSpeed,_that.weatherWindDir,_that.weatherDesc,_that.weatherIcon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  FishSpecies species,  DateTime timestamp, @JsonKey(fromJson: _latLngFromJson, toJson: _latLngToJson)  LatLng location,  int? weightGrams,  double? lengthCm,  String? lure,  FishingMethod? method,  String? notes,  double? weatherTemp,  double? weatherWindSpeed,  double? weatherWindDir,  String? weatherDesc,  String? weatherIcon)  $default,) {final _that = this;
switch (_that) {
case _FishCatch():
return $default(_that.id,_that.species,_that.timestamp,_that.location,_that.weightGrams,_that.lengthCm,_that.lure,_that.method,_that.notes,_that.weatherTemp,_that.weatherWindSpeed,_that.weatherWindDir,_that.weatherDesc,_that.weatherIcon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  FishSpecies species,  DateTime timestamp, @JsonKey(fromJson: _latLngFromJson, toJson: _latLngToJson)  LatLng location,  int? weightGrams,  double? lengthCm,  String? lure,  FishingMethod? method,  String? notes,  double? weatherTemp,  double? weatherWindSpeed,  double? weatherWindDir,  String? weatherDesc,  String? weatherIcon)?  $default,) {final _that = this;
switch (_that) {
case _FishCatch() when $default != null:
return $default(_that.id,_that.species,_that.timestamp,_that.location,_that.weightGrams,_that.lengthCm,_that.lure,_that.method,_that.notes,_that.weatherTemp,_that.weatherWindSpeed,_that.weatherWindDir,_that.weatherDesc,_that.weatherIcon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FishCatch implements FishCatch {
  const _FishCatch({required this.id, required this.species, required this.timestamp, @JsonKey(fromJson: _latLngFromJson, toJson: _latLngToJson) required this.location, this.weightGrams, this.lengthCm, this.lure, this.method, this.notes, this.weatherTemp, this.weatherWindSpeed, this.weatherWindDir, this.weatherDesc, this.weatherIcon}): assert(weightGrams == null || weightGrams > 0, 'Weight must be positive'),assert(lengthCm == null || lengthCm > 0, 'Length must be positive');
  factory _FishCatch.fromJson(Map<String, dynamic> json) => _$FishCatchFromJson(json);

/// Unique identifier (UUID).
@override final  String id;
/// Species of fish caught.
@override final  FishSpecies species;
/// Timestamp when the catch was recorded.
@override final  DateTime timestamp;
/// GPS location where the fish was caught.
@override@JsonKey(fromJson: _latLngFromJson, toJson: _latLngToJson) final  LatLng location;
/// Weight in grams (optional).
@override final  int? weightGrams;
/// Length in centimeters (optional).
@override final  double? lengthCm;
/// Lure or bait used (optional).
@override final  String? lure;
/// Fishing method used (optional).
@override final  FishingMethod? method;
/// Free-form notes (optional).
@override final  String? notes;
/// Temperature at time of catch (optional).
@override final  double? weatherTemp;
/// Wind speed at time of catch (optional).
@override final  double? weatherWindSpeed;
/// Wind direction at time of catch (optional).
@override final  double? weatherWindDir;
/// Weather description at time of catch (optional).
@override final  String? weatherDesc;
/// Weather icon code at time of catch (optional).
@override final  String? weatherIcon;

/// Create a copy of FishCatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FishCatchCopyWith<_FishCatch> get copyWith => __$FishCatchCopyWithImpl<_FishCatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FishCatchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FishCatch&&(identical(other.id, id) || other.id == id)&&(identical(other.species, species) || other.species == species)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.location, location) || other.location == location)&&(identical(other.weightGrams, weightGrams) || other.weightGrams == weightGrams)&&(identical(other.lengthCm, lengthCm) || other.lengthCm == lengthCm)&&(identical(other.lure, lure) || other.lure == lure)&&(identical(other.method, method) || other.method == method)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.weatherTemp, weatherTemp) || other.weatherTemp == weatherTemp)&&(identical(other.weatherWindSpeed, weatherWindSpeed) || other.weatherWindSpeed == weatherWindSpeed)&&(identical(other.weatherWindDir, weatherWindDir) || other.weatherWindDir == weatherWindDir)&&(identical(other.weatherDesc, weatherDesc) || other.weatherDesc == weatherDesc)&&(identical(other.weatherIcon, weatherIcon) || other.weatherIcon == weatherIcon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,species,timestamp,location,weightGrams,lengthCm,lure,method,notes,weatherTemp,weatherWindSpeed,weatherWindDir,weatherDesc,weatherIcon);

@override
String toString() {
  return 'FishCatch(id: $id, species: $species, timestamp: $timestamp, location: $location, weightGrams: $weightGrams, lengthCm: $lengthCm, lure: $lure, method: $method, notes: $notes, weatherTemp: $weatherTemp, weatherWindSpeed: $weatherWindSpeed, weatherWindDir: $weatherWindDir, weatherDesc: $weatherDesc, weatherIcon: $weatherIcon)';
}


}

/// @nodoc
abstract mixin class _$FishCatchCopyWith<$Res> implements $FishCatchCopyWith<$Res> {
  factory _$FishCatchCopyWith(_FishCatch value, $Res Function(_FishCatch) _then) = __$FishCatchCopyWithImpl;
@override @useResult
$Res call({
 String id, FishSpecies species, DateTime timestamp,@JsonKey(fromJson: _latLngFromJson, toJson: _latLngToJson) LatLng location, int? weightGrams, double? lengthCm, String? lure, FishingMethod? method, String? notes, double? weatherTemp, double? weatherWindSpeed, double? weatherWindDir, String? weatherDesc, String? weatherIcon
});




}
/// @nodoc
class __$FishCatchCopyWithImpl<$Res>
    implements _$FishCatchCopyWith<$Res> {
  __$FishCatchCopyWithImpl(this._self, this._then);

  final _FishCatch _self;
  final $Res Function(_FishCatch) _then;

/// Create a copy of FishCatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? species = null,Object? timestamp = null,Object? location = null,Object? weightGrams = freezed,Object? lengthCm = freezed,Object? lure = freezed,Object? method = freezed,Object? notes = freezed,Object? weatherTemp = freezed,Object? weatherWindSpeed = freezed,Object? weatherWindDir = freezed,Object? weatherDesc = freezed,Object? weatherIcon = freezed,}) {
  return _then(_FishCatch(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as FishSpecies,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,weightGrams: freezed == weightGrams ? _self.weightGrams : weightGrams // ignore: cast_nullable_to_non_nullable
as int?,lengthCm: freezed == lengthCm ? _self.lengthCm : lengthCm // ignore: cast_nullable_to_non_nullable
as double?,lure: freezed == lure ? _self.lure : lure // ignore: cast_nullable_to_non_nullable
as String?,method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as FishingMethod?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,weatherTemp: freezed == weatherTemp ? _self.weatherTemp : weatherTemp // ignore: cast_nullable_to_non_nullable
as double?,weatherWindSpeed: freezed == weatherWindSpeed ? _self.weatherWindSpeed : weatherWindSpeed // ignore: cast_nullable_to_non_nullable
as double?,weatherWindDir: freezed == weatherWindDir ? _self.weatherWindDir : weatherWindDir // ignore: cast_nullable_to_non_nullable
as double?,weatherDesc: freezed == weatherDesc ? _self.weatherDesc : weatherDesc // ignore: cast_nullable_to_non_nullable
as String?,weatherIcon: freezed == weatherIcon ? _self.weatherIcon : weatherIcon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
