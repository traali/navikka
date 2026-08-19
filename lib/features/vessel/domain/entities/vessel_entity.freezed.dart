// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vessel_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VesselEntity {

 int get id; String get name; VesselType get type; double get maxWindLimit; double get maxWaveLimit; bool get isSelected; double? get draftDepth; double get cruisingSpeedKmh; String? get hinCode; String? get engineManufacturer; String? get engineModel; String? get fuelType;
/// Create a copy of VesselEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VesselEntityCopyWith<VesselEntity> get copyWith => _$VesselEntityCopyWithImpl<VesselEntity>(this as VesselEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VesselEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.maxWindLimit, maxWindLimit) || other.maxWindLimit == maxWindLimit)&&(identical(other.maxWaveLimit, maxWaveLimit) || other.maxWaveLimit == maxWaveLimit)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected)&&(identical(other.draftDepth, draftDepth) || other.draftDepth == draftDepth)&&(identical(other.cruisingSpeedKmh, cruisingSpeedKmh) || other.cruisingSpeedKmh == cruisingSpeedKmh)&&(identical(other.hinCode, hinCode) || other.hinCode == hinCode)&&(identical(other.engineManufacturer, engineManufacturer) || other.engineManufacturer == engineManufacturer)&&(identical(other.engineModel, engineModel) || other.engineModel == engineModel)&&(identical(other.fuelType, fuelType) || other.fuelType == fuelType));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,type,maxWindLimit,maxWaveLimit,isSelected,draftDepth,cruisingSpeedKmh,hinCode,engineManufacturer,engineModel,fuelType);

@override
String toString() {
  return 'VesselEntity(id: $id, name: $name, type: $type, maxWindLimit: $maxWindLimit, maxWaveLimit: $maxWaveLimit, isSelected: $isSelected, draftDepth: $draftDepth, cruisingSpeedKmh: $cruisingSpeedKmh, hinCode: $hinCode, engineManufacturer: $engineManufacturer, engineModel: $engineModel, fuelType: $fuelType)';
}


}

/// @nodoc
abstract mixin class $VesselEntityCopyWith<$Res>  {
  factory $VesselEntityCopyWith(VesselEntity value, $Res Function(VesselEntity) _then) = _$VesselEntityCopyWithImpl;
@useResult
$Res call({
 int id, String name, VesselType type, double maxWindLimit, double maxWaveLimit, bool isSelected, double? draftDepth, double cruisingSpeedKmh, String? hinCode, String? engineManufacturer, String? engineModel, String? fuelType
});




}
/// @nodoc
class _$VesselEntityCopyWithImpl<$Res>
    implements $VesselEntityCopyWith<$Res> {
  _$VesselEntityCopyWithImpl(this._self, this._then);

  final VesselEntity _self;
  final $Res Function(VesselEntity) _then;

/// Create a copy of VesselEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? maxWindLimit = null,Object? maxWaveLimit = null,Object? isSelected = null,Object? draftDepth = freezed,Object? cruisingSpeedKmh = null,Object? hinCode = freezed,Object? engineManufacturer = freezed,Object? engineModel = freezed,Object? fuelType = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as VesselType,maxWindLimit: null == maxWindLimit ? _self.maxWindLimit : maxWindLimit // ignore: cast_nullable_to_non_nullable
as double,maxWaveLimit: null == maxWaveLimit ? _self.maxWaveLimit : maxWaveLimit // ignore: cast_nullable_to_non_nullable
as double,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,draftDepth: freezed == draftDepth ? _self.draftDepth : draftDepth // ignore: cast_nullable_to_non_nullable
as double?,cruisingSpeedKmh: null == cruisingSpeedKmh ? _self.cruisingSpeedKmh : cruisingSpeedKmh // ignore: cast_nullable_to_non_nullable
as double,hinCode: freezed == hinCode ? _self.hinCode : hinCode // ignore: cast_nullable_to_non_nullable
as String?,engineManufacturer: freezed == engineManufacturer ? _self.engineManufacturer : engineManufacturer // ignore: cast_nullable_to_non_nullable
as String?,engineModel: freezed == engineModel ? _self.engineModel : engineModel // ignore: cast_nullable_to_non_nullable
as String?,fuelType: freezed == fuelType ? _self.fuelType : fuelType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VesselEntity].
extension VesselEntityPatterns on VesselEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VesselEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VesselEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VesselEntity value)  $default,){
final _that = this;
switch (_that) {
case _VesselEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VesselEntity value)?  $default,){
final _that = this;
switch (_that) {
case _VesselEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  VesselType type,  double maxWindLimit,  double maxWaveLimit,  bool isSelected,  double? draftDepth,  double cruisingSpeedKmh,  String? hinCode,  String? engineManufacturer,  String? engineModel,  String? fuelType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VesselEntity() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.maxWindLimit,_that.maxWaveLimit,_that.isSelected,_that.draftDepth,_that.cruisingSpeedKmh,_that.hinCode,_that.engineManufacturer,_that.engineModel,_that.fuelType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  VesselType type,  double maxWindLimit,  double maxWaveLimit,  bool isSelected,  double? draftDepth,  double cruisingSpeedKmh,  String? hinCode,  String? engineManufacturer,  String? engineModel,  String? fuelType)  $default,) {final _that = this;
switch (_that) {
case _VesselEntity():
return $default(_that.id,_that.name,_that.type,_that.maxWindLimit,_that.maxWaveLimit,_that.isSelected,_that.draftDepth,_that.cruisingSpeedKmh,_that.hinCode,_that.engineManufacturer,_that.engineModel,_that.fuelType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  VesselType type,  double maxWindLimit,  double maxWaveLimit,  bool isSelected,  double? draftDepth,  double cruisingSpeedKmh,  String? hinCode,  String? engineManufacturer,  String? engineModel,  String? fuelType)?  $default,) {final _that = this;
switch (_that) {
case _VesselEntity() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.maxWindLimit,_that.maxWaveLimit,_that.isSelected,_that.draftDepth,_that.cruisingSpeedKmh,_that.hinCode,_that.engineManufacturer,_that.engineModel,_that.fuelType);case _:
  return null;

}
}

}

/// @nodoc


class _VesselEntity implements VesselEntity {
  const _VesselEntity({required this.id, required this.name, required this.type, required this.maxWindLimit, required this.maxWaveLimit, required this.isSelected, this.draftDepth, this.cruisingSpeedKmh = 15.0, this.hinCode, this.engineManufacturer, this.engineModel, this.fuelType});
  

@override final  int id;
@override final  String name;
@override final  VesselType type;
@override final  double maxWindLimit;
@override final  double maxWaveLimit;
@override final  bool isSelected;
@override final  double? draftDepth;
@override@JsonKey() final  double cruisingSpeedKmh;
@override final  String? hinCode;
@override final  String? engineManufacturer;
@override final  String? engineModel;
@override final  String? fuelType;

/// Create a copy of VesselEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VesselEntityCopyWith<_VesselEntity> get copyWith => __$VesselEntityCopyWithImpl<_VesselEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VesselEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.maxWindLimit, maxWindLimit) || other.maxWindLimit == maxWindLimit)&&(identical(other.maxWaveLimit, maxWaveLimit) || other.maxWaveLimit == maxWaveLimit)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected)&&(identical(other.draftDepth, draftDepth) || other.draftDepth == draftDepth)&&(identical(other.cruisingSpeedKmh, cruisingSpeedKmh) || other.cruisingSpeedKmh == cruisingSpeedKmh)&&(identical(other.hinCode, hinCode) || other.hinCode == hinCode)&&(identical(other.engineManufacturer, engineManufacturer) || other.engineManufacturer == engineManufacturer)&&(identical(other.engineModel, engineModel) || other.engineModel == engineModel)&&(identical(other.fuelType, fuelType) || other.fuelType == fuelType));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,type,maxWindLimit,maxWaveLimit,isSelected,draftDepth,cruisingSpeedKmh,hinCode,engineManufacturer,engineModel,fuelType);

@override
String toString() {
  return 'VesselEntity(id: $id, name: $name, type: $type, maxWindLimit: $maxWindLimit, maxWaveLimit: $maxWaveLimit, isSelected: $isSelected, draftDepth: $draftDepth, cruisingSpeedKmh: $cruisingSpeedKmh, hinCode: $hinCode, engineManufacturer: $engineManufacturer, engineModel: $engineModel, fuelType: $fuelType)';
}


}

/// @nodoc
abstract mixin class _$VesselEntityCopyWith<$Res> implements $VesselEntityCopyWith<$Res> {
  factory _$VesselEntityCopyWith(_VesselEntity value, $Res Function(_VesselEntity) _then) = __$VesselEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, VesselType type, double maxWindLimit, double maxWaveLimit, bool isSelected, double? draftDepth, double cruisingSpeedKmh, String? hinCode, String? engineManufacturer, String? engineModel, String? fuelType
});




}
/// @nodoc
class __$VesselEntityCopyWithImpl<$Res>
    implements _$VesselEntityCopyWith<$Res> {
  __$VesselEntityCopyWithImpl(this._self, this._then);

  final _VesselEntity _self;
  final $Res Function(_VesselEntity) _then;

/// Create a copy of VesselEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? maxWindLimit = null,Object? maxWaveLimit = null,Object? isSelected = null,Object? draftDepth = freezed,Object? cruisingSpeedKmh = null,Object? hinCode = freezed,Object? engineManufacturer = freezed,Object? engineModel = freezed,Object? fuelType = freezed,}) {
  return _then(_VesselEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as VesselType,maxWindLimit: null == maxWindLimit ? _self.maxWindLimit : maxWindLimit // ignore: cast_nullable_to_non_nullable
as double,maxWaveLimit: null == maxWaveLimit ? _self.maxWaveLimit : maxWaveLimit // ignore: cast_nullable_to_non_nullable
as double,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,draftDepth: freezed == draftDepth ? _self.draftDepth : draftDepth // ignore: cast_nullable_to_non_nullable
as double?,cruisingSpeedKmh: null == cruisingSpeedKmh ? _self.cruisingSpeedKmh : cruisingSpeedKmh // ignore: cast_nullable_to_non_nullable
as double,hinCode: freezed == hinCode ? _self.hinCode : hinCode // ignore: cast_nullable_to_non_nullable
as String?,engineManufacturer: freezed == engineManufacturer ? _self.engineManufacturer : engineManufacturer // ignore: cast_nullable_to_non_nullable
as String?,engineModel: freezed == engineModel ? _self.engineModel : engineModel // ignore: cast_nullable_to_non_nullable
as String?,fuelType: freezed == fuelType ? _self.fuelType : fuelType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
