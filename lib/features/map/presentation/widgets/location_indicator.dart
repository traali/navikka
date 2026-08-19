import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_palette.dart';

class LocationIndicator extends StatelessWidget {
  const LocationIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IgnorePointer(
        child: SizedBox(
          width: 40,
          height: 40,
          child: CustomPaint(painter: _CrosshairPainter()),
        ),
      ),
    );
  }
}

class _CrosshairPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppPalette.textPrimary.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final cx = size.width / 2;
    final cy = size.height / 2;
    const len = 10.0;

    // Horizontal
    canvas.drawLine(Offset(cx - len, cy), Offset(cx + len, cy), paint);
    // Vertical
    canvas.drawLine(Offset(cx, cy - len), Offset(cx, cy + len), paint);

    // Center dot
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx, cy), 1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
