import 'package:equatable/equatable.dart';

class CpaResult extends Equatable {
  final int targetMmsi;
  final double cpaNauticalMiles;
  final double tcpaMinutes;
  final bool isDangerous;

  const CpaResult({
    required this.targetMmsi,
    required this.cpaNauticalMiles,
    required this.tcpaMinutes,
    required this.isDangerous,
  });

  @override
  List<Object?> get props => [
    targetMmsi,
    cpaNauticalMiles,
    tcpaMinutes,
    isDangerous,
  ];
}
