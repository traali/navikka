// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fish_catch_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FishCatchDTO {

 String get id; String get species; int get timestampMs; double get latitude; double get longitude; int? get weightGrams; double? get lengthCm; String? get lure; String? get method; String? get notes; double? get weatherTemp; double? get weatherWindSpeed; double? get weatherWindDir; String? get weatherDesc; String? get weatherIcon;
/// Create a copy of FishCatchDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FishCatchDTOCopyWith<FishCatchDTO> get copyWith => _$FishCatchDTOCopyWithImpl<FishCatchDTO>(this as FishCatchDTO, _$identity);

  /// Serializes this FishCatchDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FishCatchDTO&&(identical(other.id, id) || other.id == id)&&(identical(other.species, species) || other.species == species)&&(identical(other.timestampMs, timestampMs) || other.timestampMs == timestampMs)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.weightGrams, weightGrams) || other.weightGrams == weightGrams)&&(identical(other.lengthCm, lengthCm) || other.lengthCm == lengthCm)&&(identical(other.lure, lure) || other.lure == lure)&&(identical(other.method, method) || other.method == method)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.weatherTemp, weatherTemp) || other.weatherTemp == weatherTemp)&&(identical(other.weatherWindSpeed, weatherWindSpeed) || other.weatherWindSpeed == weatherWindSpeed)&&(identical(other.weatherWindDir, weatherWindDir) || other.weatherWindDir == weatherWindDir)&&(identical(other.weatherDesc, weatherDesc) || other.weatherDesc == weatherDesc)&&(identical(other.weatherIcon, weatherIcon) || other.weatherIcon == weatherIcon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,species,timestampMs,latitude,longitude,weightGrams,lengthCm,lure,method,notes,weatherTemp,weatherWindSpeed,weatherWindDir,weatherDesc,weatherIcon);

@override
String toString() {
  return 'FishCatchDTO(id: $id, species: $species, timestampMs: $timestampMs, latitude: $latitude, longitude: $longitude, weightGrams: $weightGrams, lengthCm: $lengthCm, lure: $lure, method: $method, notes: $notes, weatherTemp: $weatherTemp, weatherWindSpeed: $weatherWindSpeed, weatherWindDir: $weatherWindDir, weatherDesc: $weatherDesc, weatherIcon: $weatherIcon)';
}


}

/// @nodoc
abstract mixin class $FishCatchDTOCopyWith<$Res>  {
  factory $FishCatchDTOCopyWith(FishCatchDTO value, $Res Function(FishCatchDTO) _then) = _$FishCatchDTOCopyWithImpl;
@useResult
$Res call({
 String id, String species, int timestampMs, double latitude, double longitude, int? weightGrams, double? lengthCm, String? lure, String? method, String? notes, double? weatherTemp, double? weatherWindSpeed, double? weatherWindDir, String? weatherDesc, String? weatherIcon
});




}
/// @nodoc
class _$FishCatchDTOCopyWithImpl<$Res>
    implements $FishCatchDTOCopyWith<$Res> {
  _$FishCatchDTOCopyWithImpl(this._self, this._then);

  final FishCatchDTO _self;
  final $Res Function(FishCatchDTO) _then;

/// Create a copy of FishCatchDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? species = null,Object? timestampMs = null,Object? latitude = null,Object? longitude = null,Object? weightGrams = freezed,Object? lengthCm = freezed,Object? lure = freezed,Object? method = freezed,Object? notes = freezed,Object? weatherTemp = freezed,Object? weatherWindSpeed = freezed,Object? weatherWindDir = freezed,Object? weatherDesc = freezed,Object? weatherIcon = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String,timestampMs: null == timestampMs ? _self.timestampMs : timestampMs // ignore: cast_nullable_to_non_nullable
as int,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,weightGrams: freezed == weightGrams ? _self.weightGrams : weightGrams // ignore: cast_nullable_to_non_nullable
as int?,lengthCm: freezed == lengthCm ? _self.lengthCm : lengthCm // ignore: cast_nullable_to_non_nullable
as double?,lure: freezed == lure ? _self.lure : lure // ignore: cast_nullable_to_non_nullable
as String?,method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,weatherTemp: freezed == weatherTemp ? _self.weatherTemp : weatherTemp // ignore: cast_nullable_to_non_nullable
as double?,weatherWindSpeed: freezed == weatherWindSpeed ? _self.weatherWindSpeed : weatherWindSpeed // ignore: cast_nullable_to_non_nullable
as double?,weatherWindDir: freezed == weatherWindDir ? _self.weatherWindDir : weatherWindDir // ignore: cast_nullable_to_non_nullable
as double?,weatherDesc: freezed == weatherDesc ? _self.weatherDesc : weatherDesc // ignore: cast_nullable_to_non_nullable
as String?,weatherIcon: freezed == weatherIcon ? _self.weatherIcon : weatherIcon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FishCatchDTO].
extension FishCatchDTOPatterns on FishCatchDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FishCatchDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FishCatchDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FishCatchDTO value)  $default,){
final _that = this;
switch (_that) {
case _FishCatchDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FishCatchDTO value)?  $default,){
final _that = this;
switch (_that) {
case _FishCatchDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String species,  int timestampMs,  double latitude,  double longitude,  int? weightGrams,  double? lengthCm,  String? lure,  String? method,  String? notes,  double? weatherTemp,  double? weatherWindSpeed,  double? weatherWindDir,  String? weatherDesc,  String? weatherIcon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FishCatchDTO() when $default != null:
return $default(_that.id,_that.species,_that.timestampMs,_that.latitude,_that.longitude,_that.weightGrams,_that.lengthCm,_that.lure,_that.method,_that.notes,_that.weatherTemp,_that.weatherWindSpeed,_that.weatherWindDir,_that.weatherDesc,_that.weatherIcon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String species,  int timestampMs,  double latitude,  double longitude,  int? weightGrams,  double? lengthCm,  String? lure,  String? method,  String? notes,  double? weatherTemp,  double? weatherWindSpeed,  double? weatherWindDir,  String? weatherDesc,  String? weatherIcon)  $default,) {final _that = this;
switch (_that) {
case _FishCatchDTO():
return $default(_that.id,_that.species,_that.timestampMs,_that.latitude,_that.longitude,_that.weightGrams,_that.lengthCm,_that.lure,_that.method,_that.notes,_that.weatherTemp,_that.weatherWindSpeed,_that.weatherWindDir,_that.weatherDesc,_that.weatherIcon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String species,  int timestampMs,  double latitude,  double longitude,  int? weightGrams,  double? lengthCm,  String? lure,  String? method,  String? notes,  double? weatherTemp,  double? weatherWindSpeed,  double? weatherWindDir,  String? weatherDesc,  String? weatherIcon)?  $default,) {final _that = this;
switch (_that) {
case _FishCatchDTO() when $default != null:
return $default(_that.id,_that.species,_that.timestampMs,_that.latitude,_that.longitude,_that.weightGrams,_that.lengthCm,_that.lure,_that.method,_that.notes,_that.weatherTemp,_that.weatherWindSpeed,_that.weatherWindDir,_that.weatherDesc,_that.weatherIcon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FishCatchDTO extends FishCatchDTO {
  const _FishCatchDTO({required this.id, required this.species, required this.timestampMs, required this.latitude, required this.longitude, this.weightGrams, this.lengthCm, this.lure, this.method, this.notes, this.weatherTemp, this.weatherWindSpeed, this.weatherWindDir, this.weatherDesc, this.weatherIcon}): super._();
  factory _FishCatchDTO.fromJson(Map<String, dynamic> json) => _$FishCatchDTOFromJson(json);

@override final  String id;
@override final  String species;
@override final  int timestampMs;
@override final  double latitude;
@override final  double longitude;
@override final  int? weightGrams;
@override final  double? lengthCm;
@override final  String? lure;
@override final  String? method;
@override final  String? notes;
@override final  double? weatherTemp;
@override final  double? weatherWindSpeed;
@override final  double? weatherWindDir;
@override final  String? weatherDesc;
@override final  String? weatherIcon;

/// Create a copy of FishCatchDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FishCatchDTOCopyWith<_FishCatchDTO> get copyWith => __$FishCatchDTOCopyWithImpl<_FishCatchDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FishCatchDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FishCatchDTO&&(identical(other.id, id) || other.id == id)&&(identical(other.species, species) || other.species == species)&&(identical(other.timestampMs, timestampMs) || other.timestampMs == timestampMs)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.weightGrams, weightGrams) || other.weightGrams == weightGrams)&&(identical(other.lengthCm, lengthCm) || other.lengthCm == lengthCm)&&(identical(other.lure, lure) || other.lure == lure)&&(identical(other.method, method) || other.method == method)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.weatherTemp, weatherTemp) || other.weatherTemp == weatherTemp)&&(identical(other.weatherWindSpeed, weatherWindSpeed) || other.weatherWindSpeed == weatherWindSpeed)&&(identical(other.weatherWindDir, weatherWindDir) || other.weatherWindDir == weatherWindDir)&&(identical(other.weatherDesc, weatherDesc) || other.weatherDesc == weatherDesc)&&(identical(other.weatherIcon, weatherIcon) || other.weatherIcon == weatherIcon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,species,timestampMs,latitude,longitude,weightGrams,lengthCm,lure,method,notes,weatherTemp,weatherWindSpeed,weatherWindDir,weatherDesc,weatherIcon);

@override
String toString() {
  return 'FishCatchDTO(id: $id, species: $species, timestampMs: $timestampMs, latitude: $latitude, longitude: $longitude, weightGrams: $weightGrams, lengthCm: $lengthCm, lure: $lure, method: $method, notes: $notes, weatherTemp: $weatherTemp, weatherWindSpeed: $weatherWindSpeed, weatherWindDir: $weatherWindDir, weatherDesc: $weatherDesc, weatherIcon: $weatherIcon)';
}


}

/// @nodoc
abstract mixin class _$FishCatchDTOCopyWith<$Res> implements $FishCatchDTOCopyWith<$Res> {
  factory _$FishCatchDTOCopyWith(_FishCatchDTO value, $Res Function(_FishCatchDTO) _then) = __$FishCatchDTOCopyWithImpl;
@override @useResult
$Res call({
 String id, String species, int timestampMs, double latitude, double longitude, int? weightGrams, double? lengthCm, String? lure, String? method, String? notes, double? weatherTemp, double? weatherWindSpeed, double? weatherWindDir, String? weatherDesc, String? weatherIcon
});




}
/// @nodoc
class __$FishCatchDTOCopyWithImpl<$Res>
    implements _$FishCatchDTOCopyWith<$Res> {
  __$FishCatchDTOCopyWithImpl(this._self, this._then);

  final _FishCatchDTO _self;
  final $Res Function(_FishCatchDTO) _then;

/// Create a copy of FishCatchDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? species = null,Object? timestampMs = null,Object? latitude = null,Object? longitude = null,Object? weightGrams = freezed,Object? lengthCm = freezed,Object? lure = freezed,Object? method = freezed,Object? notes = freezed,Object? weatherTemp = freezed,Object? weatherWindSpeed = freezed,Object? weatherWindDir = freezed,Object? weatherDesc = freezed,Object? weatherIcon = freezed,}) {
  return _then(_FishCatchDTO(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String,timestampMs: null == timestampMs ? _self.timestampMs : timestampMs // ignore: cast_nullable_to_non_nullable
as int,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,weightGrams: freezed == weightGrams ? _self.weightGrams : weightGrams // ignore: cast_nullable_to_non_nullable
as int?,lengthCm: freezed == lengthCm ? _self.lengthCm : lengthCm // ignore: cast_nullable_to_non_nullable
as double?,lure: freezed == lure ? _self.lure : lure // ignore: cast_nullable_to_non_nullable
as String?,method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
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
