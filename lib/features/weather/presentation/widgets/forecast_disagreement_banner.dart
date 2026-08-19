import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/features/weather/domain/entities/forecast_snapshot.dart';
import 'package:sakkoja/features/weather/presentation/providers/forecast_intelligence_provider.dart';
import 'package:sakkoja/features/weather/presentation/widgets/forecast_feedback_sheet.dart';

/// Banner displaying location-anchored forecast revision alerts and model spread ranges.
class ForecastDisagreementBanner extends ConsumerWidget {
  const ForecastDisagreementBanner({
    required this.locationName,
    super.key,
  });

  final String locationName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(forecastIntelligenceEngineProvider);

    if (!state.hasActiveAlert) return const SizedBox.shrink();

    final alertMessage =
        state.revisionEvent?.message ?? state.disagreementEvent?.message ?? '';
    final isOrange =
        state.revisionEvent?.severity == ForecastAlertSeverity.orange ||
        state.disagreementEvent?.severity == ForecastAlertSeverity.orange;

    final borderColor = isOrange
        ? AppPalette.warning
        : AppPalette.navikkaCyanGlow;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: borderColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: borderColor.withValues(alpha: 0.6),
                width: 1.2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      isOrange
                          ? Icons.warning_amber_rounded
                          : Icons.info_outline,
                      color: borderColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        alertMessage,
                        style: AppTextStyles.nvSm.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: AppPalette.navikkaCyanGlow,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: AppPalette.navikkaCyanGlow.withValues(
                            alpha: 0.4,
                          ),
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.rate_review_outlined, size: 16),
                    label: const Text(
                      'Arvioi ennuste',
                      style: TextStyle(fontSize: 12),
                    ),
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (ctx) =>
                            ForecastFeedbackSheet(locationName: locationName),
                      );
                    },
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
