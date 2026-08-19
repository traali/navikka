import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/map/presentation/providers/map_auto_follow_provider.dart';
import 'package:sakkoja/features/map/presentation/widgets/course_hud_widget.dart';
import 'package:sakkoja/features/map/presentation/widgets/speed_hud_widget.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';
import 'package:sakkoja/features/weather/presentation/widgets/weather_alert_badge.dart';

/// Dedicated HUD Assembly for the Horizon 3D Layout.
/// Keeps the top-center 3D perspective horizon 100% open while providing
/// dual side-wing telemetry cards and 48px tactile marine touch targets.
class Horizon3dHudAssembly extends ConsumerWidget {
  const Horizon3dHudAssembly({
    required this.hasLocation,
    required this.currentSpeed,
    required this.currentZone,
    required this.heading,
    required this.isFishingMode,
    required this.entranceController,
    this.onRequestGps,
    super.key,
  });

  final bool hasLocation;
  final double currentSpeed;
  final SpeedLimitZone? currentZone;
  final double heading;
  final bool isFishingMode;
  final AnimationController entranceController;
  final VoidCallback? onRequestGps;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topPadding = MediaQuery.paddingOf(context).top;
    final is3dTilt = ref.watch(map3dTiltProvider);

    return Stack(
      children: [
        // 1. Telemetry Dock (Top left in 2D mode, Bottom stern dock in 3D tilt mode)
        if (!is3dTilt)
          Positioned(
            top: topPadding + 12,
            left: 12,
            child: FadeTransition(
              opacity: entranceController,
              child: SpeedHudWidget(
                hasLocation: hasLocation,
                currentSpeedKmh: currentSpeed,
                speedLimitKmh: currentZone?.speedLimitKmh ?? 0,
                onRequestGps: onRequestGps,
              ),
            ),
          )
        else
          // Stern Dashboard Dock under vessel in 3D perspective mode
          Positioned(
            bottom: 28,
            left: 12,
            right: 84,
            child: FadeTransition(
              opacity: entranceController,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SpeedHudWidget(
                    hasLocation: hasLocation,
                    currentSpeedKmh: currentSpeed,
                    speedLimitKmh: currentZone?.speedLimitKmh ?? 0,
                    onRequestGps: onRequestGps,
                  ),
                  if (hasLocation) CourseHudWidget(heading: heading),
                ],
              ),
            ),
          ),

        // 2. Right Top Controls (Heading in 2D, Weather Alert & 3D Tilt Toggle)
        Positioned(
          top: topPadding + 12,
          right: 12,
          child: FadeTransition(
            opacity: entranceController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (hasLocation && !is3dTilt) CourseHudWidget(heading: heading),
                if (!is3dTilt) const SizedBox(height: 8),
                const WeatherAlertBadge(),
                const SizedBox(height: 8),

                // Quick 3D Perspective Tilt Pill
                GestureDetector(
                  onTap: () {
                    SafeHaptics.medium();
                    ref.read(map3dTiltProvider.notifier).toggle();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: is3dTilt
                          ? AppPalette.navikkaSurface.withValues(alpha: 0.9)
                          : AppPalette.navikkaCanvas.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: is3dTilt
                            ? AppPalette.navikkaCyanGlow
                            : AppPalette.navikkaSurface,
                        width: is3dTilt ? 1.5 : 1.0,
                      ),
                      boxShadow: is3dTilt
                          ? [
                              BoxShadow(
                                color: AppPalette.navikkaCyanGlow.withValues(
                                  alpha: 0.3,
                                ),
                                blurRadius: 10,
                              ),
                            ]
                          : null,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.threed_rotation,
                          size: 16,
                          color: is3dTilt
                              ? AppPalette.navikkaCyanGlow
                              : AppPalette.textSecondary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          is3dTilt ? '3D TILT' : '2D FLAT',
                          style: TextStyle(
                            color: is3dTilt
                                ? AppPalette.textPrimary
                                : AppPalette.textSecondary,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
