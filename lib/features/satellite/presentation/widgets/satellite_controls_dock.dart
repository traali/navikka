import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/satellite/domain/entities/satellite_state.dart';
import 'package:sakkoja/features/satellite/presentation/providers/satellite_providers.dart';

class SatelliteControlsDock extends ConsumerWidget {
  const SatelliteControlsDock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final state = ref.watch(satelliteControllerProvider);
    final notifier = ref.read(satelliteControllerProvider.notifier);

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: colors.glassBackground,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: colors.glassBorder, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Preset Chips Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    if (state.mode == SatelliteMode.sentinel2)
                      ...SentinelPreset.values.map((preset) {
                        final isSelected = state.sentinelPreset == preset;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(preset.label),
                            selected: isSelected,
                            onSelected: (_) {
                              SafeHaptics.selection();
                              notifier.setSentinelPreset(preset);
                            },
                            selectedColor: colors.primaryAction.withValues(
                              alpha: 0.25,
                            ),
                            backgroundColor: AppPalette.navikkaCanvas
                                .withValues(alpha: 0.6),
                            side: BorderSide(
                              color: isSelected
                                  ? colors.primaryAction
                                  : colors.glassBorder,
                            ),
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? colors.textPrimary
                                  : colors.textSecondary,
                              fontSize: 11.5,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 4,
                            ),
                          ),
                        );
                      }),
                    if (state.mode == SatelliteMode.eumetsat)
                      ...EumetsatPreset.values.map((preset) {
                        final isSelected = state.eumetsatPreset == preset;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(preset.label),
                            selected: isSelected,
                            onSelected: (_) {
                              SafeHaptics.selection();
                              notifier.setEumetsatPreset(preset);
                            },
                            selectedColor: colors.primaryAction.withValues(
                              alpha: 0.25,
                            ),
                            backgroundColor: AppPalette.navikkaCanvas
                                .withValues(alpha: 0.6),
                            side: BorderSide(
                              color: isSelected
                                  ? colors.primaryAction
                                  : colors.glassBorder,
                            ),
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? colors.textPrimary
                                  : colors.textSecondary,
                              fontSize: 11.5,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 4,
                            ),
                          ),
                        );
                      }),
                    if (state.mode == SatelliteMode.highResBasemap)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppPalette.navikkaCanvas.withValues(
                            alpha: 0.6,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: colors.glassBorder),
                        ),
                        child: Text(
                          'Korkearesoluutioinen optinen taustakuva (Zoom 1-19)',
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 11.5,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // 2. EUMETSAT 15-min Time Scrubber
              if (state.mode == SatelliteMode.eumetsat &&
                  state.availableTimestamps.isNotEmpty) ...[
                const SizedBox(height: 10),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        state.isPlaying
                            ? Icons.pause_circle_filled_rounded
                            : Icons.play_circle_fill_rounded,
                        color: colors.primaryAction,
                        size: 32,
                      ),
                      tooltip: state.isPlaying ? 'Pysäytä' : 'Toista animaatio',
                      onPressed: () {
                        SafeHaptics.selection();
                        notifier.togglePlayAnimation();
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                    ),
                    Expanded(
                      child: SliderTheme(
                        data: SliderThemeData(
                          activeTrackColor: colors.primaryAction,
                          inactiveTrackColor: colors.glassBorder.withValues(
                            alpha: 0.5,
                          ),
                          thumbColor: colors.primaryAction,
                          trackHeight: 4,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 7,
                          ),
                        ),
                        child: Slider(
                          value: state.currentTimestampIndex.toDouble(),
                          max: (state.availableTimestamps.length - 1)
                              .toDouble(),
                          divisions: state.availableTimestamps.length - 1,
                          onChanged: (val) {
                            SafeHaptics.light();
                            notifier.setTimestampIndex(val.round());
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppPalette.navikkaCanvas.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: colors.glassBorder),
                      ),
                      child: Text(
                        () {
                          final time = state.currentTimestamp;
                          if (time == null) return '--:--';
                          final local = time.toLocal();
                          return "${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}";
                        }(),
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 8),

              // 3. Nautical Overlay Toggle & Opacity Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      SafeHaptics.light();
                      notifier.toggleNauticalOverlay();
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            state.showNauticalOverlay
                                ? Icons.check_box_rounded
                                : Icons.check_box_outline_blank_rounded,
                            color: state.showNauticalOverlay
                                ? colors.primaryAction
                                : colors.textSecondary,
                            size: 20,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '⚓ Väylät & Merimerkit',
                            style: TextStyle(
                              color: state.showNauticalOverlay
                                  ? colors.textPrimary
                                  : colors.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (state.showNauticalOverlay)
                    SizedBox(
                      width: 120,
                      child: SliderTheme(
                        data: SliderThemeData(
                          activeTrackColor: colors.primaryAction,
                          inactiveTrackColor: colors.glassBorder,
                          thumbColor: colors.primaryAction,
                          trackHeight: 3,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 5,
                          ),
                        ),
                        child: Slider(
                          value: state.nauticalOverlayOpacity,
                          min: 0.2,
                          onChanged: notifier.setNauticalOverlayOpacity,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
