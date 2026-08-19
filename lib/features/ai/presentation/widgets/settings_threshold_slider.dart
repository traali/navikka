import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';

/// A reusable threshold slider for settings screens.
class SettingsThresholdSlider extends StatelessWidget {
  const SettingsThresholdSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.unit,
    required this.onChanged,
    super.key,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final String unit;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(color: colors.textPrimary)),
            Text(
              '${value.toStringAsFixed(1)} $unit',
              style: AppTextStyles.mono.copyWith(
                color: colors.primaryAction,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: colors.primaryAction,
            inactiveTrackColor: colors.surfaceHighlight,
            thumbColor: colors.primaryAction,
            overlayColor: colors.primaryAction.withValues(alpha: 0.2),
          ),
          child: Slider.adaptive(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
