import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/weather/presentation/providers/wind_wave_providers.dart';

/// Floating glassmorphic forecast time slider (Now, +3h, +6h, +9h, +12h).
/// Features 64px touch targets for glove mode / rough seas ergonomics.
class WeatherTimeSlider extends ConsumerWidget {
  const WeatherTimeSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentOffset = ref.watch(forecastTimeOffsetProvider);
    const steps = [0, 3, 6, 9, 12];

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppPalette.navikkaCanvas.withValues(alpha: 0.88),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppPalette.navikkaCyanGlow.withValues(alpha: 0.35),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: steps.map((offset) {
              final isSelected = currentOffset == offset;
              final label = offset == 0 ? 'NYT' : '+$offset h';

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      SafeHaptics.selection();
                      ref
                          .read(forecastTimeOffsetProvider.notifier)
                          .setOffset(offset);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 52,
                        minHeight: 44,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppPalette.navikkaCyanGlow.withValues(alpha: 0.25)
                            : Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? AppPalette.navikkaCyanGlow
                              : Colors.white12,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          label,
                          style: AppTextStyles.nvXs.copyWith(
                            color: isSelected
                                ? AppPalette.navikkaCyanGlow
                                : Colors.white70,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
