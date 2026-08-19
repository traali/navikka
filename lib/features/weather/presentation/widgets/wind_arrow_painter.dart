import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/features/weather/domain/entities/wind_field.dart';

/// Canvas painter for rendering tapered wind directional barbs with Night Captain color gradient.
class WindArrowPainter extends CustomPainter {
  const WindArrowPainter({
    required this.field,
    required this.camera,
  });

  final WindField field;
  final MapCamera camera;

  @override
  void paint(Canvas canvas, Size size) {
    if (field.points.isEmpty) return;

    for (final point in field.points) {
      final screenOffset = camera.latLngToScreenOffset(point.position);
      final dx = screenOffset.dx;
      final dy = screenOffset.dy;

      // Skip offscreen points
      if (dx < -30 ||
          dx > size.width + 30 ||
          dy < -30 ||
          dy > size.height + 30) {
        continue;
      }

      final color = _getWindColor(point.speedKnots);
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round;

      // Convert wind direction to vector angle (0° = North = points up)
      final rad = point.directionDegrees * (math.pi / 180.0);
      final arrowLen = (14.0 + (point.speedKnots * 0.4)).clamp(12.0, 32.0);

      final endX = dx + (arrowLen * math.sin(rad));
      final endY = dy - (arrowLen * math.cos(rad));

      // Draw main arrow shaft
      canvas.drawLine(Offset(dx, dy), Offset(endX, endY), paint);

      // Draw arrowhead fins
      final finRad1 = rad + (150.0 * (math.pi / 180.0));
      final finRad2 = rad - (150.0 * (math.pi / 180.0));
      const finLen = 7.0;

      canvas.drawLine(
        Offset(endX, endY),
        Offset(
          endX + (finLen * math.sin(finRad1)),
          endY - (finLen * math.cos(finRad1)),
        ),
        paint,
      );
      canvas.drawLine(
        Offset(endX, endY),
        Offset(
          endX + (finLen * math.sin(finRad2)),
          endY - (finLen * math.cos(finRad2)),
        ),
        paint,
      );
    }
  }

  /// Curated Night Captain HSL palette for wind speed (knots):
  /// 0–6kn: Soft Cyan, 6–12kn: Teal, 12–20kn: Amber, 20–28kn: Orange, 28kn+: Coral/Red.
  Color _getWindColor(double knots) {
    if (knots <= 6.0) return AppPalette.navikkaCyanGlow.withValues(alpha: 0.85);
    if (knots <= 12.0) return Colors.tealAccent.withValues(alpha: 0.9);
    if (knots <= 20.0) return AppPalette.warning;
    if (knots <= 28.0) return AppPalette.zoneBorderMediumHigh;
    return AppPalette.danger;
  }

  @override
  bool shouldRepaint(covariant WindArrowPainter oldDelegate) {
    return oldDelegate.field != field || oldDelegate.camera != camera;
  }
}
