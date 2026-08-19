import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_catch.dart';
import 'package:sakkoja/features/fishing/presentation/utils/fishing_presentation_utils.dart';

/// A gorgeous glassmorphic sheet showing complete details of a specific catch.
///
/// Integrates species design palettes, clean layout, and recorded weather details.
class CatchDetailSheet extends StatelessWidget {
  const CatchDetailSheet({required this.catchItem, super.key});

  final FishCatch catchItem;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEEE, d. MMMM yyyy, HH:mm');
    final speciesColor = FishingPresentationUtils.getSpeciesColor(
      catchItem.species,
    );
    final speciesGradient = FishingPresentationUtils.getSpeciesGradient(
      catchItem.species,
    );

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF0B1329).withValues(alpha: 0.95),
                const Color(0xFF0F172A).withValues(alpha: 0.9),
              ],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            border: Border.all(
              color: AppPalette.textPrimary.withValues(alpha: 0.1),
            ),
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Pull/drag indicator bar
                  Center(
                    child: Container(
                      width: 44,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        color: AppPalette.textPrimary.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),

                  // Species Premium Gradient Header
                  Container(
                    decoration: BoxDecoration(
                      gradient: speciesGradient,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: speciesColor.withValues(alpha: 0.35),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            catchItem.species.emoji,
                            style: const TextStyle(fontSize: 40),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                catchItem.species.displayName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                dateFormat.format(catchItem.timestamp),
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.85),
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Details Bento Grid
                  Row(
                    children: [
                      // Weight Card
                      Expanded(
                        child: _buildBentoCard(
                          context: context,
                          icon: Icons.scale_outlined,
                          title: 'Paino',
                          value: catchItem.weightGrams != null
                              ? '${(catchItem.weightGrams! / 1000).toStringAsFixed(2)} kg'
                              : '—',
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Length Card
                      Expanded(
                        child: _buildBentoCard(
                          context: context,
                          icon: Icons.straighten_outlined,
                          title: 'Pituus',
                          value: catchItem.lengthCm != null
                              ? '${catchItem.lengthCm} cm'
                              : '—',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      // Method Card
                      Expanded(
                        child: _buildBentoCard(
                          context: context,
                          icon: Icons.phishing_outlined,
                          title: 'Kalastustapa',
                          value: catchItem.method?.displayName ?? 'Muu',
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Lure Card
                      Expanded(
                        child: _buildBentoCard(
                          context: context,
                          icon: Icons.anchor_outlined,
                          title: 'Viehe / Syötti',
                          value: catchItem.lure ?? '—',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Weather Card (If recorded)
                  if (catchItem.weatherTemp != null) ...[
                    _buildWeatherSection(context),
                    const SizedBox(height: 24),
                  ],

                  // Notes Card (If present)
                  if (catchItem.notes != null &&
                      catchItem.notes!.isNotEmpty) ...[
                    _buildNotesCard(context),
                    const SizedBox(height: 24),
                  ],

                  // Location Footer Card
                  _buildLocationCard(context),
                  const SizedBox(height: 24),

                  // Close button
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: 0.08),
                      foregroundColor: AppPalette.textPrimary,
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Sulje tiedot',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBentoCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: AppPalette.primaryAction.withValues(alpha: 0.8),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: AppPalette.textSecondary.withValues(alpha: 0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: AppPalette.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherSection(BuildContext context) {
    final emoji = FishingPresentationUtils.getWeatherEmoji(
      catchItem.weatherIcon,
    );

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppPalette.primaryAction.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppPalette.primaryAction.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.thermostat_outlined,
                size: 20,
                color: AppPalette.primaryAction,
              ),
              const SizedBox(width: 8),
              Text(
                'Sääolosuhteet saalishetkellä',
                style: TextStyle(
                  color: AppPalette.primaryAction.withValues(alpha: 0.9),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              // Temp & Description
              Expanded(
                child: Row(
                  children: [
                    Text(
                      emoji,
                      style: const TextStyle(fontSize: 36),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${catchItem.weatherTemp!.toStringAsFixed(1)} °C',
                          style: const TextStyle(
                            color: AppPalette.textPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        if (catchItem.weatherDesc != null)
                          Text(
                            catchItem.weatherDesc!,
                            style: const TextStyle(
                              color: AppPalette.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              // Wind Indicator
              if (catchItem.weatherWindSpeed != null) ...[
                Container(
                  height: 48,
                  width: 1,
                  color: Colors.white.withValues(alpha: 0.1),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (catchItem.weatherWindDir != null) ...[
                          Transform.rotate(
                            angle:
                                catchItem.weatherWindDir! *
                                (math.pi /
                                    180), // rotate to point to wind destination
                            child: const Icon(
                              Icons.arrow_downward,
                              size: 18,
                              color: AppPalette.primaryAction,
                            ),
                          ),
                          const SizedBox(width: 4),
                        ],
                        Text(
                          '${catchItem.weatherWindSpeed!.toStringAsFixed(1)} m/s',
                          style: const TextStyle(
                            color: AppPalette.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      catchItem.weatherWindDir != null
                          ? 'Tuuli (${catchItem.weatherWindDir!.toStringAsFixed(0)}°)'
                          : 'Tuuli',
                      style: const TextStyle(
                        color: AppPalette.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotesCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.sticky_note_2_outlined,
                size: 18,
                color: AppPalette.textSecondary.withValues(alpha: 0.8),
              ),
              const SizedBox(width: 8),
              const Text(
                'Muistiinpanot',
                style: TextStyle(
                  color: AppPalette.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            catchItem.notes!,
            style: const TextStyle(
              color: AppPalette.textPrimary,
              fontSize: 14.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppPalette.primaryAction.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.location_on_outlined,
              color: AppPalette.primaryAction,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Saalispaikka',
                  style: TextStyle(
                    color: AppPalette.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${catchItem.location.latitude.toStringAsFixed(6)}, ${catchItem.location.longitude.toStringAsFixed(6)}',
                  style: const TextStyle(
                    color: AppPalette.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
