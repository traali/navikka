import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/features/weather/domain/entities/wind_field.dart';

/// Single dynamic particle stream line in the wind flow layer.
class WindParticle {
  WindParticle({
    required this.position,
    required this.speed,
    required this.angle,
    required this.life,
    required this.maxLife,
  });

  Offset position;
  double speed;
  double angle;
  double life;
  double maxLife;
}

/// Canvas painter rendering glowing animated particle flow stream lines over the map.
class WindParticlePainter extends CustomPainter {
  WindParticlePainter({
    required this.field,
    required this.camera,
    required this.progress,
  });

  final WindField field;
  final MapCamera camera;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    if (field.points.isEmpty) return;

    final paint = Paint()
      ..color = AppPalette.navikkaCyanGlow.withValues(alpha: 0.4)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < field.points.length; i++) {
      final point = field.points[i];
      final startOffset = camera.latLngToScreenOffset(point.position);
      final sx = startOffset.dx;
      final sy = startOffset.dy;

      if (sx < -40 ||
          sx > size.width + 40 ||
          sy < -40 ||
          sy > size.height + 40) {
        continue;
      }

      final rad = point.directionDegrees * (math.pi / 180.0);
      final speedFactor = (point.speedKnots * 0.8).clamp(8.0, 30.0);

      final offsetPhase = (progress * 50.0 + (i * 12.0)) % speedFactor;
      final p1x = sx + (offsetPhase * math.sin(rad));
      final p1y = sy - (offsetPhase * math.cos(rad));

      const trailLen = 12.0;
      final p2x = p1x - (trailLen * math.sin(rad));
      final p2y = p1y + (trailLen * math.cos(rad));

      canvas.drawLine(Offset(p1x, p1y), Offset(p2x, p2y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant WindParticlePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.field != field ||
        oldDelegate.camera != camera;
  }
}
