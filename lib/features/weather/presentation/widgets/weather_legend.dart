import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';

/// Floating glass legend displaying the wind speed color scale in knots.
class WeatherLegend extends StatelessWidget {
  const WeatherLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppPalette.navikkaCanvas.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPill('0-6kn', AppPalette.navikkaCyanGlow),
              const SizedBox(width: 4),
              _buildPill('6-12kn', Colors.tealAccent),
              const SizedBox(width: 4),
              _buildPill('12-20kn', AppPalette.warning),
              const SizedBox(width: 4),
              _buildPill('20-28kn', AppPalette.zoneBorderMediumHigh),
              const SizedBox(width: 4),
              _buildPill('28kn+', AppPalette.danger),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPill(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: AppTextStyles.nvXs.copyWith(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
