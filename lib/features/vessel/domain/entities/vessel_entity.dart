import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sakkoja/features/vessel/data/tables.dart';

part 'vessel_entity.freezed.dart';

@freezed
abstract class VesselEntity with _$VesselEntity {
  const factory VesselEntity({
    required int id,
    required String name,
    required VesselType type,
    required double maxWindLimit,
    required double maxWaveLimit,
    required bool isSelected,
    double? draftDepth,
    @Default(15.0) double cruisingSpeedKmh,
    String? hinCode,
    String? engineManufacturer,
    String? engineModel,
    String? fuelType,
  }) = _VesselEntity;
}
