import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_palette.dart';

class BoatMarker extends StatelessWidget {
  const BoatMarker({
    super.key,
    this.size = 24.0,
    this.color = AppPalette.surfaceHighlight,
    this.accentColor = const Color(0xFF14B8A6), // Teal accent
  });
  final double size;
  final Color color;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 1.58, // Sleek 24x38 aspect ratio
      child: CustomPaint(
        painter: _BoatPainter(
          color: color,
          accentColor: accentColor,
          onSurface: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

class _BoatPainter extends CustomPainter {
  _BoatPainter({
    required this.color,
    required this.accentColor,
    required this.onSurface,
  });
  final Color color;
  final Color accentColor;
  final Color onSurface;

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    // Midnight dark hull gradient
    const Gradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF0F172A), // Slate-900
        Color(0xFF1E293B), // Slate-800
      ],
    );

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradientPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;

    // --- Sleek Aerodynamic Boat Hull Path ---
    final path = Path();
    path.moveTo(size.width * 0.5, 0); // Sharp Bow Tip

    // Right bow curve
    path.quadraticBezierTo(
      size.width * 0.85,
      size.height * 0.25,
      size.width * 0.85,
      size.height * 0.6,
    );

    // Right stern side
    path.lineTo(size.width * 0.8, size.height * 0.92);

    // Stern transom
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 1.0,
      size.width * 0.2,
      size.height * 0.92,
    );

    // Left stern side
    path.lineTo(size.width * 0.15, size.height * 0.6);

    // Left bow curve
    path.quadraticBezierTo(
      size.width * 0.15,
      size.height * 0.25,
      size.width * 0.5,
      0,
    );

    path.close();

    // Draw Shadow
    canvas.drawPath(path.shift(const Offset(1, 2)), shadowPaint);

    // Draw Hull
    canvas.drawPath(path, gradientPaint);
    canvas.drawPath(path, borderPaint);

    // --- Glowing Keel / Bow Indicator Line ---
    final keelPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;

    final keelPath = Path();
    keelPath.moveTo(size.width * 0.5, size.height * 0.1);
    keelPath.lineTo(size.width * 0.5, size.height * 0.45);
    canvas.drawPath(keelPath, keelPaint);

    // Glowing Bow Point Light
    final bowLightPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.1),
      2,
      bowLightPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
