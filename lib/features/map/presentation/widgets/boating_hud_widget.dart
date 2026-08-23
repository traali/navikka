import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/map/presentation/providers/map_auto_follow_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/ui_layout_provider.dart';
import 'package:sakkoja/features/navigation/presentation/controllers/navigation_controller.dart';

/// Active Boating / Navigation HUD displaying telemetry, heading, and route metrics.
class BoatingHudWidget extends ConsumerWidget {
  const BoatingHudWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final layout = ref.watch(uiLayoutControllerProvider);
    if (layout == UiLayout.horizon3D || layout == UiLayout.ghost) {
      return const SizedBox.shrink();
    }

    final navMode = ref.watch(mapNavigationModeProvider);
    if (navMode != MapNavigationMode.boatingHeadingUp) {
      return const SizedBox.shrink();
    }

    final mapState = ref.watch(mapProvider);
    if (!mapState.hasLocation) {
      return const SizedBox.shrink();
    }
    final navStateAsync = ref.watch(navigationControllerProvider);
    final navState = navStateAsync.value;

    final speedKmh = mapState.currentSpeedKmh;
    final speedKnots = (speedKmh * 0.539957).clamp(0.0, 99.9);
    final headingDeg = mapState.heading.round() % 360;

    final topOffset = MediaQuery.paddingOf(context).top + 60;

    return Positioned(
      top: topOffset,
      left: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: colors.glassBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colors.primaryAction.withValues(alpha: 0.6),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: colors.primaryAction.withValues(alpha: 0.2),
              blurRadius: 16,
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: Colors.black38,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // 1. Heading & Speed Telemetry Cluster
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.navigation_rounded,
                      color: colors.primaryAction,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'HDG ${headingDeg.toString().padLeft(3, '0')}°',
                      style: TextStyle(
                        color: colors.primaryAction,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${speedKnots.toStringAsFixed(1)} kts (${speedKmh.toStringAsFixed(1)} km/h)',
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            const Spacer(),

            // 2. Active Route Target Metrics (if navigating)
            if (navState != null && navState.isActive) ...[
              Container(
                height: 30,
                width: 1,
                color: colors.glassBorder,
                margin: const EdgeInsets.symmetric(horizontal: 12),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'SEURAAVA WP (${navState.currentLegIndex + 1}/${navState.totalLegs + 1})',
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${((navState.distanceToNextWpMeters ?? 0.0) / 1852.0).toStringAsFixed(2)} NM',
                    style: TextStyle(
                      color: colors.warning,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(width: 8),

            // 3. Quick Recenter / Mode Status Icon
            IconButton(
              icon: Icon(
                Icons.explore_rounded,
                color: colors.primaryAction,
                size: 24,
              ),
              tooltip: 'Pohjoissuunta (Palaatilaan)',
              onPressed: () {
                SafeHaptics.light();
                ref.read(mapNavigationModeProvider.notifier).toggle();
              },
            ),
          ],
        ),
      ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.3, end: 0),
    );
  }
}
