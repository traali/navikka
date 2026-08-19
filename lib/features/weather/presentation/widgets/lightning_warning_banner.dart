import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/app_theme.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';
import 'package:sakkoja/features/weather/presentation/providers/lightning_dismissal_provider.dart';

/// A premium, glassmorphic warning banner for active lightning threats.
///
/// Prominently displays distance, threat severity, and a "sign-off" dismiss
/// button. Alerts only reappear if newer strikes are detected.
class LightningWarningBanner extends ConsumerWidget {
  const LightningWarningBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(pointWeatherControllerProvider);
    final dismissedTime = ref.watch(lightningDismissalProvider);

    // If no active alarm or no strikes, hide banner
    final alarmLevel = weatherState.lightningAlarmLevel;
    if (alarmLevel == LightningAlarmLevel.none ||
        weatherState.nearestLightningDistanceMeters == null ||
        weatherState.lightningStrikes.isEmpty) {
      return const SizedBox.shrink();
    }

    // Safely extract the latest strike time
    final strikes = weatherState.lightningStrikes;
    final latestStrike = strikes.reduce(
      (a, b) => a.time.isAfter(b.time) ? a : b,
    );
    final latestTime = latestStrike.time;

    // Sign-off gating: if skipper already signed off on this strike, hide
    if (dismissedTime != null && !latestTime.isAfter(dismissedTime)) {
      return const SizedBox.shrink();
    }

    final distanceKm = weatherState.nearestLightningDistanceMeters! / 1000.0;
    final isDanger = alarmLevel == LightningAlarmLevel.danger;

    // OLED night-vision friendly theme colors
    final alertColor = isDanger ? AppPalette.danger : AppPalette.warning;
    final alertLabel = isDanger
        ? 'UKKOSTA HAVAITTU (KRIITTINEN)'
        : 'UKKOSTA ALUEELLA';
    final actionLabel = isDanger
        ? 'Hakeudu välittömästi suojasatamaan!'
        : 'Seuraa ukkosrintaman kehittymistä.';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.kNeonGlow(alertColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: alertColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: alertColor.withValues(alpha: 0.35),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                // Bolt Threat Icon with entrance pulse
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: alertColor.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.bolt,
                    color: alertColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),

                // Detailed alert info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        alertLabel,
                        style: TextStyle(
                          color: alertColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Lähin salama: ${distanceKm.toStringAsFixed(1)} km',
                        style: const TextStyle(
                          color: AppPalette.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        actionLabel,
                        style: TextStyle(
                          color: AppPalette.textSecondary.withValues(
                            alpha: 0.9,
                          ),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Sign-Off (Dismiss) Button
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    SafeHaptics.medium();
                    ref
                        .read(lightningDismissalProvider.notifier)
                        .dismissLightning(latestTime);
                  },
                  tooltip: 'Kuittaa hälytys',
                  icon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.12),
                      ),
                    ),
                    child: Icon(
                      Icons.check,
                      color: alertColor.withValues(alpha: 0.85),
                      size: 18,
                    ),
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
