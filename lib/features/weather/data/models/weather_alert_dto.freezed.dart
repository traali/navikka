// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_alert_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeatherAlertDto {

 String get id; String get event; String get description; String get severity; DateTime get onset; DateTime get expires;@LatLngListConverter() List<LatLng> get polygon; String get areaDescription; DateTime? get issued;
/// Create a copy of WeatherAlertDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherAlertDtoCopyWith<WeatherAlertDto> get copyWith => _$WeatherAlertDtoCopyWithImpl<WeatherAlertDto>(this as WeatherAlertDto, _$identity);

  /// Serializes this WeatherAlertDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherAlertDto&&(identical(other.id, id) || other.id == id)&&(identical(other.event, event) || other.event == event)&&(identical(other.description, description) || other.description == description)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.onset, onset) || other.onset == onset)&&(identical(other.expires, expires) || other.expires == expires)&&const DeepCollectionEquality().equals(other.polygon, polygon)&&(identical(other.areaDescription, areaDescription) || other.areaDescription == areaDescription)&&(identical(other.issued, issued) || other.issued == issued));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,event,description,severity,onset,expires,const DeepCollectionEquality().hash(polygon),areaDescription,issued);

@override
String toString() {
  return 'WeatherAlertDto(id: $id, event: $event, description: $description, severity: $severity, onset: $onset, expires: $expires, polygon: $polygon, areaDescription: $areaDescription, issued: $issued)';
}


}

/// @nodoc
abstract mixin class $WeatherAlertDtoCopyWith<$Res>  {
  factory $WeatherAlertDtoCopyWith(WeatherAlertDto value, $Res Function(WeatherAlertDto) _then) = _$WeatherAlertDtoCopyWithImpl;
@useResult
$Res call({
 String id, String event, String description, String severity, DateTime onset, DateTime expires,@LatLngListConverter() List<LatLng> polygon, String areaDescription, DateTime? issued
});




}
/// @nodoc
class _$WeatherAlertDtoCopyWithImpl<$Res>
    implements $WeatherAlertDtoCopyWith<$Res> {
  _$WeatherAlertDtoCopyWithImpl(this._self, this._then);

  final WeatherAlertDto _self;
  final $Res Function(WeatherAlertDto) _then;

/// Create a copy of WeatherAlertDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? event = null,Object? description = null,Object? severity = null,Object? onset = null,Object? expires = null,Object? polygon = null,Object? areaDescription = null,Object? issued = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,onset: null == onset ? _self.onset : onset // ignore: cast_nullable_to_non_nullable
as DateTime,expires: null == expires ? _self.expires : expires // ignore: cast_nullable_to_non_nullable
as DateTime,polygon: null == polygon ? _self.polygon : polygon // ignore: cast_nullable_to_non_nullable
as List<LatLng>,areaDescription: null == areaDescription ? _self.areaDescription : areaDescription // ignore: cast_nullable_to_non_nullable
as String,issued: freezed == issued ? _self.issued : issued // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherAlertDto].
extension WeatherAlertDtoPatterns on WeatherAlertDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherAlertDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherAlertDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherAlertDto value)  $default,){
final _that = this;
switch (_that) {
case _WeatherAlertDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherAlertDto value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherAlertDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String event,  String description,  String severity,  DateTime onset,  DateTime expires, @LatLngListConverter()  List<LatLng> polygon,  String areaDescription,  DateTime? issued)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherAlertDto() when $default != null:
return $default(_that.id,_that.event,_that.description,_that.severity,_that.onset,_that.expires,_that.polygon,_that.areaDescription,_that.issued);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String event,  String description,  String severity,  DateTime onset,  DateTime expires, @LatLngListConverter()  List<LatLng> polygon,  String areaDescription,  DateTime? issued)  $default,) {final _that = this;
switch (_that) {
case _WeatherAlertDto():
return $default(_that.id,_that.event,_that.description,_that.severity,_that.onset,_that.expires,_that.polygon,_that.areaDescription,_that.issued);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String event,  String description,  String severity,  DateTime onset,  DateTime expires, @LatLngListConverter()  List<LatLng> polygon,  String areaDescription,  DateTime? issued)?  $default,) {final _that = this;
switch (_that) {
case _WeatherAlertDto() when $default != null:
return $default(_that.id,_that.event,_that.description,_that.severity,_that.onset,_that.expires,_that.polygon,_that.areaDescription,_that.issued);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeatherAlertDto implements WeatherAlertDto {
  const _WeatherAlertDto({required this.id, required this.event, required this.description, required this.severity, required this.onset, required this.expires, @LatLngListConverter() required final  List<LatLng> polygon, required this.areaDescription, this.issued}): _polygon = polygon;
  factory _WeatherAlertDto.fromJson(Map<String, dynamic> json) => _$WeatherAlertDtoFromJson(json);

@override final  String id;
@override final  String event;
@override final  String description;
@override final  String severity;
@override final  DateTime onset;
@override final  DateTime expires;
 final  List<LatLng> _polygon;
@override@LatLngListConverter() List<LatLng> get polygon {
  if (_polygon is EqualUnmodifiableListView) return _polygon;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_polygon);
}

@override final  String areaDescription;
@override final  DateTime? issued;

/// Create a copy of WeatherAlertDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherAlertDtoCopyWith<_WeatherAlertDto> get copyWith => __$WeatherAlertDtoCopyWithImpl<_WeatherAlertDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherAlertDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherAlertDto&&(identical(other.id, id) || other.id == id)&&(identical(other.event, event) || other.event == event)&&(identical(other.description, description) || other.description == description)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.onset, onset) || other.onset == onset)&&(identical(other.expires, expires) || other.expires == expires)&&const DeepCollectionEquality().equals(other._polygon, _polygon)&&(identical(other.areaDescription, areaDescription) || other.areaDescription == areaDescription)&&(identical(other.issued, issued) || other.issued == issued));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,event,description,severity,onset,expires,const DeepCollectionEquality().hash(_polygon),areaDescription,issued);

@override
String toString() {
  return 'WeatherAlertDto(id: $id, event: $event, description: $description, severity: $severity, onset: $onset, expires: $expires, polygon: $polygon, areaDescription: $areaDescription, issued: $issued)';
}


}

/// @nodoc
abstract mixin class _$WeatherAlertDtoCopyWith<$Res> implements $WeatherAlertDtoCopyWith<$Res> {
  factory _$WeatherAlertDtoCopyWith(_WeatherAlertDto value, $Res Function(_WeatherAlertDto) _then) = __$WeatherAlertDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String event, String description, String severity, DateTime onset, DateTime expires,@LatLngListConverter() List<LatLng> polygon, String areaDescription, DateTime? issued
});




}
/// @nodoc
class __$WeatherAlertDtoCopyWithImpl<$Res>
    implements _$WeatherAlertDtoCopyWith<$Res> {
  __$WeatherAlertDtoCopyWithImpl(this._self, this._then);

  final _WeatherAlertDto _self;
  final $Res Function(_WeatherAlertDto) _then;

/// Create a copy of WeatherAlertDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? event = null,Object? description = null,Object? severity = null,Object? onset = null,Object? expires = null,Object? polygon = null,Object? areaDescription = null,Object? issued = freezed,}) {
  return _then(_WeatherAlertDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,onset: null == onset ? _self.onset : onset // ignore: cast_nullable_to_non_nullable
as DateTime,expires: null == expires ? _self.expires : expires // ignore: cast_nullable_to_non_nullable
as DateTime,polygon: null == polygon ? _self._polygon : polygon // ignore: cast_nullable_to_non_nullable
as List<LatLng>,areaDescription: null == areaDescription ? _self.areaDescription : areaDescription // ignore: cast_nullable_to_non_nullable
as String,issued: freezed == issued ? _self.issued : issued // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
