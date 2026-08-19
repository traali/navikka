import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_palette.dart';

/// Smoothly animated wind direction arrow widget.
///
/// Prevents the reset-to-0° spinning artifact on parent rebuilds by maintaining
/// a persistent State and animating smoothly from the previous angle to the target angle.
class AnimatedWindArrow extends StatefulWidget {
  const AnimatedWindArrow({
    required this.directionDegrees,
    super.key,
    this.size = 24.0,
    this.color = AppPalette.textPrimary,
  });

  final double directionDegrees;
  final double size;
  final Color color;

  @override
  State<AnimatedWindArrow> createState() => _AnimatedWindArrowState();
}

class _AnimatedWindArrowState extends State<AnimatedWindArrow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _currentAngle = 0;

  @override
  void initState() {
    super.initState();
    _currentAngle = widget.directionDegrees;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = AlwaysStoppedAnimation(_currentAngle);
  }

  @override
  void didUpdateWidget(AnimatedWindArrow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.directionDegrees != widget.directionDegrees) {
      if (_controller.isAnimating) {
        _currentAngle = _animation.value;
      }
      final start = _currentAngle;
      final target = widget.directionDegrees;

      // Handle 360-degree angle wrapping (shortest path rotation)
      double diff = (target - start) % 360;
      if (diff > 180) diff -= 360;
      if (diff < -180) diff += 360;

      final end = start + diff;

      _animation = Tween<double>(begin: start, end: end).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );

      _controller.forward(from: 0).then((_) {
        if (mounted) {
          setState(() {
            _currentAngle = end % 360;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final degrees = _animation.value;
        final radians = (degrees * math.pi) / 180;
        // Icons.navigation points UP (North).
        // Wind direction is "coming from" degrees -> add 180° (pi rad) to point in blowing direction.
        return Transform.rotate(
          angle: radians + math.pi,
          child: Icon(
            Icons.navigation,
            size: widget.size,
            color: widget.color,
          ),
        );
      },
    );
  }
}
