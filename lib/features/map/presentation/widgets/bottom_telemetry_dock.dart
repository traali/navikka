import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/features/ais/presentation/providers/ais_targets_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/cockpit_mode_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/map/presentation/widgets/precision_marine_compass.dart';
import 'package:sakkoja/features/map/presentation/widgets/radial_knotmeter_gauge.dart';

/// Ergonomic floating glass telemetry dock positioned above the bottom bar.
/// Houses radial knotmeter, speed limit badge, precision compass, and AIS status.
class BottomTelemetryDock extends ConsumerWidget {
  const BottomTelemetryDock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final mapState = ref.watch(mapProvider);
    final aisTargets = ref.watch(aisTargetsProvider).value ?? [];
    final cockpitState = ref.watch(cockpitModeProvider);

    final speedKmh = mapState.currentSpeedKmh;
    final currentLimit = mapState.currentZone?.speedLimitKmh ?? 0;
    final isSpeeding = currentLimit > 0 && speedKmh > currentLimit;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: colors.glassBackground,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSpeeding ? colors.danger : colors.glassBorder,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: context.isDarkMode ? 0.35 : 0.1,
                ),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Telemetry Readouts Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 1. Radial Knotmeter Gauge
                  RadialKnotmeterGauge(
                    speedKmh: speedKmh,
                    speedLimitKmh: currentLimit,
                    size: 68,
                  ),

                  // 2. Speed Limit Sign (if inside limit zone)
                  if (currentLimit > 0)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSpeeding
                              ? colors.danger
                              : Colors.red.shade700,
                          width: 2.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Text(
                        '$currentLimit',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),

                  // 3. Precision Marine Compass
                  const PrecisionMarineCompass(),
                ],
              ),

              const SizedBox(height: 6),

              // Cockpit Mode Sub-label & AIS Status Watermark (Non-occluding)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TILA: ${cockpitState.mode.label.toUpperCase()}',
                    style: TextStyle(
                      color: colors.primaryAction.withValues(alpha: 0.9),
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    aisTargets.isNotEmpty
                        ? 'AIS (${aisTargets.length} alusta) · COLREG R5'
                        : 'AIS valvonta · COLREG R5',
                    style: TextStyle(
                      color: colors.textSecondary.withValues(alpha: 0.75),
                      fontSize: 9.5,
                      fontWeight: FontWeight.w500,
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
