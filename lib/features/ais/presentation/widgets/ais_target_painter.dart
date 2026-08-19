import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' hide Path;
import 'package:sakkoja/features/ais/domain/entities/ais_target.dart';

class AisTargetPainter extends CustomPainter {
  final List<AisTarget> targets;
  final MapCamera camera;
  final double currentZoom;

  AisTargetPainter({
    required this.targets,
    required this.camera,
    required this.currentZoom,
  });

  static final Path _vesselGlyphPath = Path()
    ..moveTo(0, -9) // Bow (Front)
    ..lineTo(5, 7) // Starboard Stern
    ..lineTo(-5, 7) // Port Stern
    ..close();

  final Paint _linePaint = Paint()
    ..strokeWidth = 2.0
    ..style = PaintingStyle.stroke;

  final Paint _vesselPaint = Paint()..style = PaintingStyle.fill;
  final Paint _vesselStrokePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.5
    ..color = const Color(0xFF0F172A);

  @override
  void paint(Canvas canvas, Size size) {
    for (final target in targets) {
      // Project LatLng position to current canvas screen coordinates
      final screenOffset = camera.latLngToScreenOffset(target.position);

      // Cull targets outside visible viewport bounds (with 30px buffer)
      if (screenOffset.dx < -30 ||
          screenOffset.dx > size.width + 30 ||
          screenOffset.dy < -30 ||
          screenOffset.dy > size.height + 30) {
        continue;
      }

      // Pick category color
      final Color color = _getCategoryColor(target.category);
      _vesselPaint.color = color;
      _linePaint.color = color.withValues(alpha: 0.8);

      // 1. Draw 10-Minute Velocity Predictor Vector (if moving > 1 knot)
      if (target.speedKnots > 1.0) {
        final distNmIn10Min = target.speedKnots * (10.0 / 60.0);
        final endPos = _projectLatLng(
          target.position,
          distNmIn10Min,
          target.courseDegrees,
        );
        final endScreenOffset = camera.latLngToScreenOffset(endPos);

        canvas.drawLine(screenOffset, endScreenOffset, _linePaint);
      }

      // 2. Draw Rotated Vessel Triangle Symbol
      canvas.save();
      canvas.translate(screenOffset.dx, screenOffset.dy);

      // Rotate canvas by effective heading minus camera rotation for Course-up / Head-up mode
      final rotationRad =
          (target.effectiveHeading - camera.rotation) * (math.pi / 180.0);
      canvas.rotate(rotationRad);

      canvas.drawPath(_vesselGlyphPath, _vesselPaint);
      canvas.drawPath(_vesselGlyphPath, _vesselStrokePaint);
      canvas.restore();
    }
  }

  Color _getCategoryColor(ShipCategory category) {
    switch (category) {
      case ShipCategory.passenger:
        return const Color(0xFF2196F3); // Blue (Ferries)
      case ShipCategory.cargo:
        return const Color(0xFFFF9800); // Orange (Cargo)
      case ShipCategory.tanker:
        return const Color(0xFFF44336); // Red (Hazardous)
      case ShipCategory.tug:
        return const Color(0xFF9C27B0); // Purple
      case ShipCategory.sailing:
        return const Color(0xFF4CAF50); // Green
      case ShipCategory.pleasure:
        return const Color(0xFF00BCD4); // Cyan
      case ShipCategory.fishing:
        return const Color(0xFF8BC34A); // Light Green
      case ShipCategory.unknown:
        return const Color(0xFF9E9E9E); // Grey
    }
  }

  LatLng _projectLatLng(LatLng origin, double distanceNm, double bearingDeg) {
    final distRad = distanceNm / 3440.065;
    final lat1 = origin.latitude * (math.pi / 180.0);
    final lon1 = origin.longitude * (math.pi / 180.0);
    final brng = bearingDeg * (math.pi / 180.0);

    final lat2 = math.asin(
      math.sin(lat1) * math.cos(distRad) +
          math.cos(lat1) * math.sin(distRad) * math.cos(brng),
    );
    final lon2 =
        lon1 +
        math.atan2(
          math.sin(brng) * math.sin(distRad) * math.cos(lat1),
          math.cos(distRad) - math.sin(lat1) * math.sin(lat2),
        );

    return LatLng(lat2 * (180.0 / math.pi), lon2 * (180.0 / math.pi));
  }

  @override
  bool shouldRepaint(covariant AisTargetPainter oldDelegate) =>
      oldDelegate.targets != targets || oldDelegate.camera != camera;
}
