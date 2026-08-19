import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/settings/presentation/providers/unit_preferences_provider.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';

class RadialKnotmeterGauge extends ConsumerWidget {
  const RadialKnotmeterGauge({
    required this.speedKmh,
    required this.speedLimitKmh,
    this.size = 72,
    super.key,
  });

  final double speedKmh;
  final int speedLimitKmh;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final unitSettings = ref.watch(unitPreferencesProvider);
    final SpeedUnit unit = unitSettings.speedUnit;

    final double displaySpeed = unit.convertFromKmh(speedKmh).clamp(0.0, 99.9);
    final double limitDisplay = speedLimitKmh > 0
        ? unit.convertFromKmh(speedLimitKmh.toDouble())
        : 0.0;

    final isSpeeding = speedLimitKmh > 0 && speedKmh > speedLimitKmh;
    final isNearLimit =
        speedLimitKmh > 0 && speedKmh > (speedLimitKmh - 2.0) && !isSpeeding;

    // Gauge max scale
    final double maxScale = speedLimitKmh > 0
        ? math.max(limitDisplay * 1.4, 20)
        : 30.0;
    final double progress = (displaySpeed / maxScale).clamp(0.0, 1.0);

    final arcColor = isSpeeding
        ? colors.danger
        : isNearLimit
        ? colors.warning
        : colors.primaryAction;

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RadialKnotmeterPainter(
          progress: progress,
          arcColor: arcColor,
          trackColor: colors.surfaceHighlight.withValues(alpha: 0.5),
          isSpeeding: isSpeeding,
          limitProgress: speedLimitKmh > 0 ? (limitDisplay / maxScale) : null,
          limitColor: colors.danger,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                displaySpeed.toStringAsFixed(1),
                style: TextStyle(
                  color: isSpeeding ? colors.danger : colors.textPrimary,
                  fontSize: size * 0.28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                  height: 1,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                unit.symbol,
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: size * 0.14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RadialKnotmeterPainter extends CustomPainter {
  _RadialKnotmeterPainter({
    required this.progress,
    required this.arcColor,
    required this.trackColor,
    required this.isSpeeding,
    this.limitProgress,
    this.limitColor,
  });

  final double progress;
  final Color arcColor;
  final Color trackColor;
  final bool isSpeeding;
  final double? limitProgress;
  final Color? limitColor;

  static const double _startAngle = 150.0 * (math.pi / 180.0);
  static const double _sweepAngle = 240.0 * (math.pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 10) / 2;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      _startAngle,
      _sweepAngle,
      false,
      trackPaint,
    );

    // Active speed arc
    if (progress > 0.01) {
      final activePaint = Paint()
        ..color = arcColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5.5
        ..strokeCap = StrokeCap.round;

      if (isSpeeding) {
        // Glowing aura when speeding
        final glowPaint = Paint()
          ..color = arcColor.withValues(alpha: 0.35)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10.0
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          _startAngle,
          _sweepAngle * progress,
          false,
          glowPaint,
        );
      }

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        _startAngle,
        _sweepAngle * progress,
        false,
        activePaint,
      );
    }

    // Speed limit tick mark
    if (limitProgress != null && limitProgress! > 0 && limitColor != null) {
      final limitAngle =
          _startAngle + (_sweepAngle * limitProgress!.clamp(0.0, 1.0));
      final p1 = Offset(
        center.dx + (radius - 5) * math.cos(limitAngle),
        center.dy + (radius - 5) * math.sin(limitAngle),
      );
      final p2 = Offset(
        center.dx + (radius + 5) * math.cos(limitAngle),
        center.dy + (radius + 5) * math.sin(limitAngle),
      );

      final limitTickPaint = Paint()
        ..color = limitColor!
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(p1, p2, limitTickPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _RadialKnotmeterPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.arcColor != arcColor ||
        oldDelegate.isSpeeding != isSpeeding ||
        oldDelegate.limitProgress != limitProgress;
  }
}
