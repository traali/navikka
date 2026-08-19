import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/features/map/presentation/widgets/course_hud_widget.dart';
import 'package:sakkoja/features/map/presentation/widgets/speed_hud_widget.dart';
import 'package:sakkoja/features/weather/presentation/widgets/weather_hud_v2.dart';

class VortexAdaptiveDashboard extends StatelessWidget {
  const VortexAdaptiveDashboard({
    required this.currentSpeedKmh,
    required this.heading,
    required this.speedLimitKmh,
    required this.hasLocation,
    super.key,
  });

  final double currentSpeedKmh;
  final double heading;
  final double speedLimitKmh;
  final bool hasLocation;

  @override
  Widget build(BuildContext context) {
    // Threshold: 10 km/h
    final isCruising = currentSpeedKmh >= 10.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: isCruising ? 0.4 : 0.6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isCruising
              ? AppPalette.primaryAction.withValues(alpha: 0.2)
              : AppPalette.glassBorder(),
        ),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: isCruising
            ? _CruisingHud(
                currentSpeedKmh: currentSpeedKmh,
                heading: heading,
                hasLocation: hasLocation,
              )
            : _StationaryHud(
                currentSpeedKmh: currentSpeedKmh,
                heading: heading,
                speedLimitKmh: speedLimitKmh,
                hasLocation: hasLocation,
              ),
      ),
    );
  }
}

class _CruisingHud extends StatelessWidget {
  const _CruisingHud({
    required this.currentSpeedKmh,
    required this.heading,
    required this.hasLocation,
  });

  final double currentSpeedKmh;
  final double heading;
  final bool hasLocation;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'SOG',
              style: TextStyle(
                color: AppPalette.primaryAction.withValues(alpha: 0.7),
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  currentSpeedKmh.toStringAsFixed(1),
                  style: const TextStyle(
                    color: AppPalette.textPrimary,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'km/h',
                  style: TextStyle(
                    color: AppPalette.textPrimary.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 24),
        if (hasLocation) ...[
          Container(
            width: 1,
            height: 32,
            color: AppPalette.textSecondary.withValues(alpha: 0.2),
          ),
          const SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'COG',
                style: TextStyle(
                  color: AppPalette.textSecondary.withValues(alpha: 0.6),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              Text(
                '${heading.round()}°',
                style: const TextStyle(
                  color: AppPalette.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _StationaryHud extends StatelessWidget {
  const _StationaryHud({
    required this.currentSpeedKmh,
    required this.heading,
    required this.speedLimitKmh,
    required this.hasLocation,
  });

  final double currentSpeedKmh;
  final double heading;
  final double speedLimitKmh;
  final bool hasLocation;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SpeedHudWidget(
              hasLocation: hasLocation,
              currentSpeedKmh: currentSpeedKmh,
              speedLimitKmh: speedLimitKmh.round(),
            ),
            const SizedBox(width: 16),
            if (hasLocation) CourseHudWidget(heading: heading),
          ],
        ),
        const SizedBox(height: 12),
        const WeatherHudV2(),
      ],
    );
  }
}
