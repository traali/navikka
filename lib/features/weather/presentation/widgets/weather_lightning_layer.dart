import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/features/weather/domain/entities/lightning_strike.dart';

/// Premium lightning strikes map layer with pulsating concentric danger zones.
class WeatherLightningLayer extends StatelessWidget {
  const WeatherLightningLayer({required this.strikes, super.key});
  final List<LightningStrike> strikes;

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: strikes.map((strike) {
        final age = strike.ageMinutes;
        final opacity = (60 - age).clamp(0, 60) / 60.0;

        return Marker(
          point: strike.location,
          width: 64, // Expanded to allow concentric pulsating rings
          height: 64,
          child: _LightningMarker(
            peakCurrent: strike.peakCurrent,
            opacity: opacity,
            showRings:
                strike.ageMinutes <
                15, // Only animate recent active strikes (15 mins)
          ),
        );
      }).toList(),
    );
  }
}

class _LightningMarker extends StatelessWidget {
  const _LightningMarker({
    required this.peakCurrent,
    required this.opacity,
    required this.showRings,
  });
  final double peakCurrent;
  final double opacity;
  final bool showRings;

  @override
  Widget build(BuildContext context) {
    final isStrong = peakCurrent.abs() > 50;
    // Strong current (>50kA) utilizes danger crimson; normal utilizes warm caution yellow
    final alertColor = isStrong ? AppPalette.danger : AppPalette.warning;

    return Stack(
      alignment: Alignment.center,
      children: [
        if (showRings) ...[
          // Concentric Pulsating Outer Hazard Rings (Night Captain aesthetics)
          Animate(
            onPlay: (controller) => controller.repeat(),
            effects: [
              const ScaleEffect(
                begin: Offset(0.8, 0.8),
                end: Offset(3.2, 3.2),
                duration: Duration(milliseconds: 2200),
                curve: Curves.easeOutCirc,
              ),
              FadeEffect(
                begin: 0.65 * opacity,
                end: 0,
                duration: const Duration(milliseconds: 2200),
                curve: Curves.easeOutCirc,
              ),
            ],
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  color: alertColor.withValues(alpha: 0.55),
                  width: 1.5,
                ),
              ),
            ),
          ),

          // Double ring effect for high-fidelity technical UI
          Animate(
            onPlay: (controller) => controller.repeat(),
            effects: [
              const ScaleEffect(
                begin: Offset(0.6, 0.6),
                end: Offset(2.2, 2.2),
                delay: Duration(milliseconds: 700),
                duration: Duration(milliseconds: 1800),
                curve: Curves.easeOutCirc,
              ),
              FadeEffect(
                begin: 0.5 * opacity,
                end: 0,
                delay: const Duration(milliseconds: 700),
                duration: const Duration(milliseconds: 1800),
                curve: Curves.easeOutCirc,
              ),
            ],
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  color: alertColor.withValues(alpha: 0.45),
                  width: 1.2,
                ),
              ),
            ),
          ),
        ],

        // Solid core bolt marker with custom glow shadow
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: alertColor.withValues(alpha: 0.15),
            boxShadow: [
              BoxShadow(
                color: alertColor.withValues(alpha: 0.4 * opacity),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Icon(
            Icons.bolt,
            color: alertColor.withValues(alpha: opacity),
            size: 18,
          ),
        ),
      ],
    );
  }
}
