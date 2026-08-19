import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/satellite/domain/entities/satellite_state.dart';
import 'package:sakkoja/features/satellite/presentation/providers/satellite_providers.dart';

class SatelliteTopCapsule extends ConsumerWidget {
  const SatelliteTopCapsule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final satelliteState = ref.watch(satelliteControllerProvider);
    final notifier = ref.read(satelliteControllerProvider.notifier);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: colors.glassBackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colors.glassBorder, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Row: Back button, Title & Mode switcher
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: colors.textPrimary,
                      size: 18,
                    ),
                    tooltip: 'Takaisin',
                    onPressed: () {
                      SafeHaptics.light();
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go('/');
                      }
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: SatelliteMode.values.map((mode) {
                          final isSelected = satelliteState.mode == mode;
                          return Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: InkWell(
                              onTap: () {
                                SafeHaptics.selection();
                                notifier.setMode(mode);
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? colors.primaryAction.withValues(
                                          alpha: 0.25,
                                        )
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? colors.primaryAction
                                        : colors.glassBorder,
                                    width: isSelected ? 1.5 : 1.0,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _getModeIcon(mode),
                                      size: 14,
                                      color: isSelected
                                          ? colors.primaryAction
                                          : colors.textSecondary,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      mode.label,
                                      style: TextStyle(
                                        color: isSelected
                                            ? colors.textPrimary
                                            : colors.textSecondary,
                                        fontSize: 12,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              // Metadata subtitle pill
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppPalette.navikkaCanvas.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _getMetadataText(satelliteState),
                      style: TextStyle(
                        color: colors.primaryAction.withValues(alpha: 0.9),
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                    Text(
                      _getSourceLabel(satelliteState.mode),
                      style: TextStyle(
                        color: colors.textSecondary.withValues(alpha: 0.75),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getModeIcon(SatelliteMode mode) {
    switch (mode) {
      case SatelliteMode.sentinel2:
        return Icons.satellite_alt_rounded;
      case SatelliteMode.eumetsat:
        return Icons.cloud_sync_rounded;
      case SatelliteMode.highResBasemap:
        return Icons.public_rounded;
    }
  }

  String _getMetadataText(SatelliteState state) {
    switch (state.mode) {
      case SatelliteMode.sentinel2:
        return '🛰️ Tuorein ylilento · 10m optinen RGB';
      case SatelliteMode.eumetsat:
        final time = state.currentTimestamp;
        if (time != null) {
          final local = time.toLocal();
          final formatted =
              "${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}";
          return '⛈️ Sääsatelliitti klo $formatted (15 min päivitys)';
        }
        return '⛈️ Sääsatelliitti (15 min päivitys)';
      case SatelliteMode.highResBasemap:
        return '🌍 Korkearesoluutioinen ortokuva';
    }
  }

  String _getSourceLabel(SatelliteMode mode) {
    switch (mode) {
      case SatelliteMode.sentinel2:
        return 'ESA / Copernicus';
      case SatelliteMode.eumetsat:
        return 'FMI / EUMETSAT';
      case SatelliteMode.highResBasemap:
        return 'ESRI / Maxar';
    }
  }
}
