import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_field.dart';

/// Canvas painter rendering translucent continuous contour tiles for significant wave height ($H_s$).
class WaveHeightPainter extends CustomPainter {
  const WaveHeightPainter({
    required this.field,
    required this.camera,
  });

  final WaveField field;
  final MapCamera camera;

  @override
  void paint(Canvas canvas, Size size) {
    if (field.points.isEmpty) return;

    final paint = Paint()..style = PaintingStyle.fill;

    for (final point in field.points) {
      final centerOffset = camera.latLngToScreenOffset(point.position);
      final cx = centerOffset.dx;
      final cy = centerOffset.dy;

      // Skip offscreen points
      if (cx < -60 ||
          cx > size.width + 60 ||
          cy < -60 ||
          cy > size.height + 60) {
        continue;
      }

      final color = _getWaveColor(point.waveHeightMeters);
      final radius = (35.0 + (point.waveHeightMeters * 15.0)).clamp(30.0, 90.0);
      final center = Offset(cx, cy);
      final rect = Rect.fromCircle(center: center, radius: radius);

      paint.shader = RadialGradient(
        colors: [color, color.withValues(alpha: 0)],
      ).createShader(rect);

      canvas.drawCircle(center, radius, paint);
    }
  }

  /// Curated Night Captain translucent palette for significant wave height ($H_s$ in meters):
  /// 0–0.5m: Soft Teal/Blue (0.25 alpha)
  /// 0.5–1.2m: Cyan (0.35 alpha)
  /// 1.2–2.0m: Amber (0.45 alpha)
  /// 2.0m+: Deep Purple / Coral (0.55 alpha)
  Color _getWaveColor(double meters) {
    if (meters <= 0.5) {
      return Colors.teal.withValues(alpha: 0.25);
    }
    if (meters <= 1.2) {
      return AppPalette.navikkaCyanGlow.withValues(alpha: 0.35);
    }
    if (meters <= 2.0) {
      return AppPalette.warning.withValues(alpha: 0.45);
    }
    return AppPalette.danger.withValues(alpha: 0.55);
  }

  @override
  bool shouldRepaint(covariant WaveHeightPainter oldDelegate) {
    return oldDelegate.field != field || oldDelegate.camera != camera;
  }
}
