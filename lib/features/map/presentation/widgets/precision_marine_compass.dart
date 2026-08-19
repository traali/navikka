import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/features/map/domain/services/magnetic_declination_service.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';

class PrecisionMarineCompass extends ConsumerWidget {
  const PrecisionMarineCompass({
    this.height = 38,
    super.key,
  });

  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final mapState = ref.watch(mapProvider);

    final heading = mapState.heading;
    final declination = MagneticDeclinationService.calculateDeclination(
      mapState.userLocation.latitude,
      mapState.userLocation.longitude,
    );

    final headingRounded = heading.round() % 360;
    final cardinal = _getCardinal(headingRounded);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading & Leeway Header Row
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.explore,
              size: 15,
              color: colors.primaryAction,
            ),
            const SizedBox(width: 4),
            Text(
              '${headingRounded.toString().padLeft(3, '0')}°',
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                fontFamily: 'JetBrains Mono',
              ),
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: colors.primaryAction.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                cardinal,
                style: TextStyle(
                  color: colors.primaryAction,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              'Var ${declination >= 0 ? '+' : ''}${declination.toStringAsFixed(1)}°',
              style: TextStyle(
                color: colors.textSecondary.withValues(alpha: 0.6),
                fontSize: 9,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),

        // Horizontal Lubber-Line Heading Tape
        SizedBox(
          height: 18,
          width: 140,
          child: CustomPaint(
            painter: _CompassTapePainter(
              heading: heading,
              primaryColor: colors.primaryAction,
              textColor: colors.textSecondary,
              lineColor: colors.glassBorder,
            ),
          ),
        ),
      ],
    );
  }

  String _getCardinal(int deg) {
    if (deg >= 338 || deg < 23) return 'N';
    if (deg < 68) return 'NE';
    if (deg < 113) return 'E';
    if (deg < 158) return 'SE';
    if (deg < 203) return 'S';
    if (deg < 248) return 'SW';
    if (deg < 293) return 'W';
    return 'NW';
  }
}

class _CompassTapePainter extends CustomPainter {
  _CompassTapePainter({
    required this.heading,
    required this.primaryColor,
    required this.textColor,
    required this.lineColor,
  });

  final double heading;
  final Color primaryColor;
  final Color textColor;
  final Color lineColor;

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    const pixelsPerDegree = 1.4;

    final tickPaint = Paint()
      ..color = lineColor
      ..strokeWidth = 1.0;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    // Draw ticks -45° to +45° around current heading
    for (int deg = -45; deg <= 45; deg += 5) {
      final actualDeg = ((heading + deg) % 360 + 360) % 360;
      final x = centerX + (deg * pixelsPerDegree);

      if (x < 0 || x > size.width) continue;

      final isMajor = actualDeg % 15 == 0;
      final isCardinal = actualDeg % 90 == 0;
      final tickHeight = isCardinal ? 8.0 : (isMajor ? 6.0 : 3.0);

      canvas.drawLine(
        Offset(x, size.height),
        Offset(x, size.height - tickHeight),
        isCardinal
            ? (Paint()
                ..color = primaryColor
                ..strokeWidth = 1.5)
            : tickPaint,
      );

      if (isCardinal) {
        String label = 'N';
        if (actualDeg == 90) label = 'E';
        if (actualDeg == 180) label = 'S';
        if (actualDeg == 270) label = 'W';

        textPainter.text = TextSpan(
          text: label,
          style: TextStyle(
            color: primaryColor,
            fontSize: 8.5,
            fontWeight: FontWeight.w900,
          ),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(x - (textPainter.width / 2), 0),
        );
      }
    }

    // Lubber line (Center marker)
    final lubberPaint = Paint()
      ..color = primaryColor
      ..strokeWidth = 2.0;

    canvas.drawLine(
      Offset(centerX, 0),
      Offset(centerX, size.height),
      lubberPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CompassTapePainter oldDelegate) {
    return oldDelegate.heading != heading;
  }
}
