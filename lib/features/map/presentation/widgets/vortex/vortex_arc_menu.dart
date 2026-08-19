import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/tracking/presentation/providers/active_track_provider.dart';

class VortexArcMenu extends ConsumerWidget {
  const VortexArcMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Container(
      width: 220,
      height: 220,
      margin: EdgeInsets.only(bottom: bottomPadding),
      child: Stack(
        children: [
          // The Curved Background
          Positioned(
            right: -60,
            bottom: -60,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppPalette.surface.withValues(alpha: 0.8),
                    AppPalette.surface.withValues(alpha: 0),
                  ],
                  stops: const [0.6, 1],
                ),
              ),
            ),
          ),

          // Arc Buttons
          _ArcButton(
            angle: -math.pi / 2, // Top
            icon: Icons.phishing_rounded,
            label: 'FISH',
            onTap: () => context.go('/fishing'),
          ),
          _ArcButton(
            angle: -math.pi / 2.7,
            icon: Icons.wb_sunny_rounded,
            label: 'WEATHER',
            onTap: () => context.go('/weather'),
          ),
          _ArcButton(
            angle: -math.pi / 4.5,
            icon: Icons.route_outlined,
            label: 'ROUTE',
            onTap: () => context.push('/route-planner'),
          ),
          _ArcButton(
            angle: -math.pi / 12, // Right side
            icon: Icons.menu_rounded,
            label: 'MENU',
            onTap: () => context.go('/menu'),
          ),

          // Primary Start Button in the corner
          Positioned(
            right: 16,
            bottom: 16,
            child: Consumer(
              builder: (context, ref, _) {
                final isRecording = ref.watch(
                  activeTrackProvider.select((s) => s.isRecording),
                );
                return GestureDetector(
                  onTap: () {
                    SafeHaptics.medium();
                    if (isRecording) {
                      ref.read(activeTrackProvider.notifier).stopRecording();
                    } else {
                      ref.read(activeTrackProvider.notifier).startRecording();
                    }
                  },
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isRecording
                          ? AppPalette.danger
                          : AppPalette.primaryAction,
                      boxShadow: [
                        BoxShadow(
                          color:
                              (isRecording
                                      ? AppPalette.danger
                                      : AppPalette.primaryAction)
                                  .withValues(alpha: 0.4),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      isRecording
                          ? Icons.stop_rounded
                          : Icons.play_arrow_rounded,
                      color: isRecording
                          ? AppPalette.textPrimary
                          : AppPalette.canvas,
                      size: 32,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ArcButton extends StatelessWidget {
  const _ArcButton({
    required this.angle,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final double angle;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const double radius = 130;
    final double x = radius * math.cos(angle);
    final double y = radius * math.sin(angle);

    return Positioned(
      right: 32 - x,
      bottom: 32 - y,
      child: GestureDetector(
        onTap: () {
          SafeHaptics.light();
          onTap();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: 0.5),
                border: Border.all(color: AppPalette.glassBorder()),
              ),
              child: Icon(icon, color: AppPalette.textPrimary, size: 20),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: AppPalette.textPrimary.withValues(alpha: 0.7),
                fontSize: 9,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
