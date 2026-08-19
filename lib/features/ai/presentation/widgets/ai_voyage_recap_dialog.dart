import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/features/ai/domain/services/ai_voyage_logbook_service.dart';

class AiVoyageRecapDialog extends StatelessWidget {
  const AiVoyageRecapDialog({
    required this.recap,
    super.key,
  });

  final VoyageLogbookSummary recap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AlertDialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colors.glassBorder),
      ),
      title: Row(
        children: [
          Icon(Icons.auto_awesome, color: colors.primaryAction, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Älykäs Matkaloki: ${recap.title}',
              style: AppTextStyles.h4.copyWith(color: colors.textPrimary),
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Stats Grid
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colors.surfaceHighlight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MATKA',
                          style: AppTextStyles.caption.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                        Text(
                          '${recap.distanceNm.toStringAsFixed(1)} NM',
                          style: AppTextStyles.h4.copyWith(
                            color: colors.primaryAction,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colors.surfaceHighlight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'KESTO',
                          style: AppTextStyles.caption.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                        Text(
                          '${recap.durationMinutes} min',
                          style: AppTextStyles.h4.copyWith(
                            color: colors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colors.surfaceHighlight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'KESKINOPEUS',
                          style: AppTextStyles.caption.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                        Text(
                          '${recap.avgSpeedKnots.toStringAsFixed(1)} kn',
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colors.surfaceHighlight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'POLTTOAINE',
                          style: AppTextStyles.caption.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                        Text(
                          '${recap.estimatedFuelLiters.toStringAsFixed(1)} L',
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Virstanpylväät:',
              style: TextStyle(
                color: colors.primaryAction,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 6),
            ...recap.milestones.map(
              (m) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: colors.primaryAction)),
                    Expanded(
                      child: Text(
                        m,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.canvas.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colors.glassBorder),
              ),
              child: Text(
                recap.narrativeRecap,
                style: AppTextStyles.nvXs.copyWith(
                  color: colors.textPrimary,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton.icon(
          icon: const Icon(Icons.copy, size: 16),
          label: const Text('Kopioi teksti'),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: recap.narrativeRecap));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Matkaloki kopioitu leikepöydälle')),
            );
          },
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: colors.primaryAction,
            foregroundColor: colors.canvas,
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Sulje'),
        ),
      ],
    );
  }
}
