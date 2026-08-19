import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/cockpit_mode_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';

/// Tactical high-precision maneuvering overlay for Harbor & Berthing Mode.
/// Displays 10m, 25m, 50m distance rings, wind drift leeway vector, and berth indicators.
class BerthingTacticalGridLayer extends ConsumerWidget {
  const BerthingTacticalGridLayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final cockpitState = ref.watch(cockpitModeProvider);
    if (cockpitState.mode != CockpitMode.harbor) {
      return const SizedBox.shrink();
    }

    final mapState = ref.watch(mapProvider);
    if (!mapState.hasLocation) return const SizedBox.shrink();

    final windData = ref.watch(
      pointWeatherControllerProvider.select((s) => s.weather),
    );
    final windSpeed = windData?.windSpeed ?? 0.0;
    final windDir = windData?.windDirection ?? 0.0;

    return MarkerLayer(
      markers: [
        Marker(
          point: mapState.userLocation,
          width: 220,
          height: 220,
          child: CustomPaint(
            painter: _BerthingGridPainter(
              heading: mapState.heading,
              windSpeedMs: windSpeed,
              windDirectionDeg: windDir,
              gridColor: colors.primaryAction.withValues(alpha: 0.45),
              accentColor: colors.primaryAction,
              windColor: const Color(0xFF38BDF8),
            ),
          ),
        ),
      ],
    );
  }
}

class _BerthingGridPainter extends CustomPainter {
  _BerthingGridPainter({
    required this.heading,
    required this.windSpeedMs,
    required this.windDirectionDeg,
    required this.gridColor,
    required this.accentColor,
    required this.windColor,
  });

  final double heading;
  final double windSpeedMs;
  final double windDirectionDeg;
  final Color gridColor;
  final Color accentColor;
  final Color windColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final ringPaint = Paint()
      ..color = gridColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final dashPaint = Paint()
      ..color = gridColor.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    // 10m, 25m, 50m tactical proximity rings (scaled to marker dimensions)
    const radii = [28.0, 60.0, 95.0];
    const labels = ['10m', '25m', '50m'];

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    for (int i = 0; i < radii.length; i++) {
      final r = radii[i];
      canvas.drawCircle(center, r, ringPaint);

      // Distance label
      textPainter.text = TextSpan(
        text: labels[i],
        style: TextStyle(
          color: gridColor,
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(center.dx + r - textPainter.width - 2, center.dy - 10),
      );
    }

    // Crosshair alignment lines
    canvas.drawLine(
      Offset(center.dx - 100, center.dy),
      Offset(center.dx + 100, center.dy),
      dashPaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - 100),
      Offset(center.dx, center.dy + 100),
      dashPaint,
    );

    // Wind Leeway Vector Arrow (shows direction & strength pushing the vessel)
    if (windSpeedMs > 0.5) {
      final windRad =
          (windDirectionDeg - 180) * (math.pi / 180); // Blowing towards
      final arrowLen = (windSpeedMs * 4.0).clamp(18.0, 50.0);
      final arrowEnd = Offset(
        center.dx + arrowLen * math.sin(windRad),
        center.dy - arrowLen * math.cos(windRad),
      );

      final windPaint = Paint()
        ..color = windColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(center, arrowEnd, windPaint);

      // Arrowhead
      final headAngle1 = windRad + (150 * math.pi / 180);
      final headAngle2 = windRad - (150 * math.pi / 180);
      const headLen = 8.0;

      canvas.drawLine(
        arrowEnd,
        Offset(
          arrowEnd.dx + headLen * math.sin(headAngle1),
          arrowEnd.dy - headLen * math.cos(headAngle1),
        ),
        windPaint,
      );
      canvas.drawLine(
        arrowEnd,
        Offset(
          arrowEnd.dx + headLen * math.sin(headAngle2),
          arrowEnd.dy - headLen * math.cos(headAngle2),
        ),
        windPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BerthingGridPainter oldDelegate) {
    return oldDelegate.heading != heading ||
        oldDelegate.windSpeedMs != windSpeedMs ||
        oldDelegate.windDirectionDeg != windDirectionDeg;
  }
}
