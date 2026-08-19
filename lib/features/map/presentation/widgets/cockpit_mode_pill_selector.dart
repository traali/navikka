import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_mode_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/cockpit_mode_provider.dart';

class CockpitModePillSelector extends ConsumerWidget {
  const CockpitModePillSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final cockpitState = ref.watch(cockpitModeProvider);
    final notifier = ref.read(cockpitModeProvider.notifier);

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(
            color: colors.glassBackground,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: colors.glassBorder),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: context.isDarkMode ? 0.35 : 0.1,
                ),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: CockpitMode.values.map((mode) {
              final isSelected = cockpitState.mode == mode;
              final modeColor = mode == CockpitMode.emergency
                  ? colors.danger
                  : mode == CockpitMode.fishing
                  ? const Color(0xFF10B981) // Emerald
                  : mode == CockpitMode.harbor
                  ? const Color(0xFF38BDF8) // Sky blue
                  : colors.primaryAction;

              return GestureDetector(
                onTap: () {
                  SafeHaptics.medium();
                  notifier.setMode(mode);

                  final isFishingEnabled =
                      ref
                          .read(fishingModeControllerProvider)
                          .value
                          ?.isEnabled ??
                      false;
                  if (mode == CockpitMode.fishing && !isFishingEnabled) {
                    ref.read(fishingModeControllerProvider.notifier).toggle();
                  } else if (mode != CockpitMode.fishing && isFishingEnabled) {
                    ref.read(fishingModeControllerProvider.notifier).toggle();
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? modeColor.withValues(alpha: 0.22)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isSelected
                          ? modeColor.withValues(alpha: 0.7)
                          : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        mode.icon,
                        size: 14,
                        color: isSelected ? modeColor : colors.textSecondary,
                      ),
                      if (isSelected) ...[
                        const SizedBox(width: 5),
                        Text(
                          mode.label,
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                        if (cockpitState.isAutoTriggered) ...[
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: modeColor.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'AUTO',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ],
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
