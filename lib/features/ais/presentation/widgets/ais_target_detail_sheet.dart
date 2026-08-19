import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/widgets/nova_glass_card.dart';
import 'package:sakkoja/features/ais/domain/entities/ais_target.dart';

/// Glass modal bottom sheet displaying full AIS vessel details on tap.
class AisTargetDetailSheet extends StatelessWidget {
  const AisTargetDetailSheet({
    required this.target,
    super.key,
  });

  final AisTarget target;

  @override
  Widget build(BuildContext context) {
    final speedKmh = target.speedKnots * 1.852;
    final headingDeg = target.effectiveHeading.round() % 360;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppPalette.navikkaCanvas.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppPalette.navikkaCyanGlow.withValues(alpha: 0.35),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppPalette.navikkaCyanGlow.withValues(
                          alpha: 0.15,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.directions_boat_filled,
                        color: AppPalette.navikkaCyanGlow,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            target.name.isNotEmpty
                                ? target.name
                                : 'TUNTEMATON ALUS',
                            style: AppTextStyles.nvXl.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'MMSI: ${target.mmsi} · ${_getCategoryTitle(target.category)}',
                            style: AppTextStyles.nvXs.copyWith(
                              color: AppPalette.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white70),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Telemetry Bento Row
                Row(
                  children: [
                    Expanded(
                      child: NovaGlassCard(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'NOPEUS (SOG)',
                              style: AppTextStyles.nvXs.copyWith(
                                color: AppPalette.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${target.speedKnots.toStringAsFixed(1)} kn',
                              style: AppTextStyles.nvLg.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppPalette.navikkaCyanGlow,
                              ),
                            ),
                            Text(
                              '(${speedKmh.toStringAsFixed(0)} km/h)',
                              style: AppTextStyles.nvXs.copyWith(
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: NovaGlassCard(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SUUNTA (COG)',
                              style: AppTextStyles.nvXs.copyWith(
                                color: AppPalette.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${headingDeg.toString().padLeft(3, '0')}° (${target.compassDirection.split(' ')[0]})',
                              style: AppTextStyles.nvLg.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              target.isMooredOrAnchored
                                  ? 'Ankkurissa / Laiturissa'
                                  : 'Kulussa · ${target.compassDirection}',
                              style: AppTextStyles.nvXs.copyWith(
                                color: Colors.white54,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Destination / Heading Banner
                NovaGlassCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.navigation_outlined,
                        color: AppPalette.navikkaCyanGlow,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'KULKUSUUNTA JA MÄÄRÄNPÄÄ',
                              style: AppTextStyles.nvXs.copyWith(
                                color: AppPalette.textSecondary,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              target.destination != null &&
                                      target.destination!.isNotEmpty
                                  ? 'Määränpää: ${target.destination}'
                                  : 'Kulkee suuntaan ${target.compassDirection}',
                              style: AppTextStyles.nvSm.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Safety Disclaimer Footer
                const Text(
                  'AIS-tilannetieto: Digitraffic avoin data · Ei ensisijaiseen tähystykseen (COLREG Sääntö 5)',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getCategoryTitle(ShipCategory category) {
    switch (category) {
      case ShipCategory.passenger:
        return 'Matkustaja-alus';
      case ShipCategory.cargo:
        return 'Rahtialus';
      case ShipCategory.tanker:
        return 'Tankkialus';
      case ShipCategory.tug:
        return 'Hinaaja';
      case ShipCategory.sailing:
        return 'Purjealus';
      case ShipCategory.pleasure:
        return 'Huvivene';
      case ShipCategory.fishing:
        return 'Kalastusalus';
      case ShipCategory.unknown:
        return 'Alus';
    }
  }
}
