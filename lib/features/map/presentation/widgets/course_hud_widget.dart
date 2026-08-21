import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:sakkoja/core/presentation/widgets/animated_border_container.dart';
import 'package:sakkoja/core/presentation/widgets/glass_container.dart';
import 'package:sakkoja/core/providers/logging_provider.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_mode_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/ui_layout_provider.dart';

class CourseHudWidget extends ConsumerWidget {
  const CourseHudWidget({
    required this.heading,
    super.key,
    this.isActive = false,
  });
  final double heading;
  final bool isActive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(uiLayoutControllerProvider);
    final isFishingMode =
        ref.watch(fishingModeControllerProvider).value?.isEnabled ?? false;

    Widget content;
    switch (layout) {
      case UiLayout.ghost:
      case UiLayout.vortex:
      case UiLayout.horizon3D:
        content = _GhostCourseHud(
          heading: heading,
          isFishingMode: isFishingMode,
        );
      case UiLayout.classic:
      case UiLayout.commandBar:
      case UiLayout.omni:
        content = _ClassicCourseHud(
          heading: heading,
          ref: ref,
          isFishingMode: isFishingMode,
        );
    }

    if (isActive && layout == UiLayout.classic) {
      return AnimatedBorderContainer(child: content);
    }

    return content;
  }
}

class _GhostCourseHud extends StatelessWidget {
  const _GhostCourseHud({
    required this.heading,
    this.isFishingMode = false,
  });
  final double heading;
  final bool isFishingMode;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AnimatedOpacity(
      opacity: isFishingMode ? 0.3 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          // Subtle Legibility Vignette
          Positioned(
            right: -10,
            top: -5,
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    colors.canvas.withValues(alpha: 0.4),
                    Colors.transparent,
                  ],
                  center: const Alignment(0.5, 0),
                  radius: 0.8,
                ),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${heading.round().toString().padLeft(3, '0')}°",
                style: TextStyle(
                  fontFamily: 'JetBrains Mono',
                  color: colors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  shadows: context.isDarkMode
                      ? const [Shadow(blurRadius: 4, color: Colors.black87)]
                      : null,
                ),
              ),
              const SizedBox(width: 6),
              Transform.rotate(
                angle: heading * (3.14159 / 180),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: colors.glassBackground,
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.glassBorder),
                  ),
                  child: Icon(
                    Icons.navigation_rounded,
                    color: colors.textPrimary,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ClassicCourseHud extends StatelessWidget {
  const _ClassicCourseHud({
    required this.heading,
    required this.ref,
    this.isFishingMode = false,
  });
  final double heading;
  final WidgetRef ref;
  final bool isFishingMode;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AnimatedOpacity(
      opacity: isFishingMode ? 0.3 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onLongPress: () {
          ref.read(logLevelProvider.notifier).toggle();
          final newLevel = ref.read(logLevelProvider);
          final isDebug = newLevel == Level.debug;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isDebug ? 'Debug-loki paalla' : 'Debug-loki pois paalta',
              ),
              backgroundColor: colors.primaryAction,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
            ),
          );
        },
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Pida pohjassa kytkeaksesi debug-lokin'),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 1),
            ),
          );
        },
        child: GlassContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.rotate(
                      angle: heading * (3.14159 / 180),
                      child: Icon(
                        Icons.navigation,
                        color: colors.textPrimary.withValues(alpha: 0.7),
                        size: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'SUUNTA',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "${heading.round().toString().padLeft(3, '0')}°",
                  style: TextStyle(
                    fontFamily: 'JetBrains Mono',
                    color: colors.textPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
