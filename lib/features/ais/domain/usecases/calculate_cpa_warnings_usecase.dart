import 'dart:math' as math;
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/ais/domain/entities/ais_target.dart';
import 'package:sakkoja/features/ais/domain/entities/cpa_result.dart';

class CalculateCpaWarningsUseCase {
  CpaResult execute({
    required LatLng ownPos,
    required double ownSogKnots,
    required double ownCogDegrees,
    required AisTarget target,
  }) {
    // Convert COG to radians for Navigation axis (0° North, 90° East)
    // Vx = SOG * sin(COG), Vy = SOG * cos(COG)
    final ownCogRad = _degToRad(ownCogDegrees);
    final targetCogRad = _degToRad(target.courseDegrees);

    final ownVx = ownSogKnots * math.sin(ownCogRad);
    final ownVy = ownSogKnots * math.cos(ownCogRad);
    final tgtVx = target.speedKnots * math.sin(targetCogRad);
    final tgtVy = target.speedKnots * math.cos(targetCogRad);

    // Relative velocity (target vector minus own boat vector)
    final dVx = tgtVx - ownVx;
    final dVy = tgtVy - ownVy;
    final relSpeedSq = (dVx * dVx) + (dVy * dVy);

    // Position delta in Nautical Miles (East = X, North = Y)
    final dX =
        (target.position.longitude - ownPos.longitude) *
        math.cos(_degToRad(ownPos.latitude)) *
        60;
    final dY = (target.position.latitude - ownPos.latitude) * 60;
    final distanceNm = math.sqrt((dX * dX) + (dY * dY));

    if (relSpeedSq < 0.001) {
      final isDangerous = distanceNm <= 0.5;
      return CpaResult(
        targetMmsi: target.mmsi,
        cpaNauticalMiles: distanceNm,
        tcpaMinutes: 0,
        isDangerous: isDangerous,
      );
    }

    // Time to Closest Point of Approach (hours -> minutes)
    final tcpaHours = -((dX * dVx) + (dY * dVy)) / relSpeedSq;
    final tcpaMinutes = tcpaHours * 60;

    // Projected position delta at TCPA
    final cpaX = dX + (dVx * tcpaHours);
    final cpaY = dY + (dVy * tcpaHours);
    final cpaNm = math.sqrt((cpaX * cpaX) + (cpaY * cpaY));

    final bool isClosing = tcpaHours > 0;
    final bool isInsideSafetyPerimeter = distanceNm <= 0.5;

    final bool isDangerous =
        (isClosing || isInsideSafetyPerimeter) &&
        (relSpeedSq > 0.001 || isInsideSafetyPerimeter) &&
        cpaNm <= 0.5 &&
        (tcpaMinutes <= 10.0 || isInsideSafetyPerimeter);

    return CpaResult(
      targetMmsi: target.mmsi,
      cpaNauticalMiles: cpaNm,
      tcpaMinutes: tcpaMinutes,
      isDangerous: isDangerous,
    );
  }

  static double _degToRad(double deg) => deg * (math.pi / 180.0);
}
