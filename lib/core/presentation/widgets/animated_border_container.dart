import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/app_theme.dart';

/// A container with a rotating gradient border, used for "Active" states.
class AnimatedBorderContainer extends StatelessWidget {
  const AnimatedBorderContainer({
    required this.child,
    super.key,
    this.duration = const Duration(seconds: 3),
    this.gradientColors = const [
      AppPalette.primaryAction,
      Colors.transparent,
      Colors.transparent,
      AppPalette.primaryAction,
    ],
    this.borderWidth = 2.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  });
  final Widget child;
  final Duration duration;
  final List<Color> gradientColors;
  final double borderWidth;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Revised Approach: Use a Container with a heavily blur-animated background behind the child,
        // clipped to form a border?
        // Or just using Animate.custom to rotate a gradient.
        Animate(
          onPlay: (controller) => controller.repeat(),
          effects: [
            CustomEffect(
              builder: (context, value, child) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    gradient: SweepGradient(
                      colors: gradientColors,
                      transform: GradientRotation(value * 6.28), // 2*PI
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(borderWidth),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.kSurfaceColor, // Mask the inside
                        borderRadius: borderRadius.subtract(
                          BorderRadius.circular(borderWidth),
                        ),
                      ),
                    ),
                  ),
                );
              },
              duration: duration,
            ),
          ],
        ),

        // Content
        Padding(padding: EdgeInsets.all(borderWidth), child: child),
      ],
    );
  }
}
