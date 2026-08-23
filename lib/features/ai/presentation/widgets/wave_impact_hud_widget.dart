import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/features/ai/domain/services/wave_impact_ai_service.dart';
import 'package:sakkoja/features/ai/presentation/providers/wave_impact_provider.dart';

class WaveImpactHudWidget extends ConsumerWidget {
  const WaveImpactHudWidget({super.key});

  Color _getSeverityColor(SlamSeverity severity, AppThemeColors colors) {
    switch (severity) {
      case SlamSeverity.smooth:
        return colors.success;
      case SlamSeverity.moderate:
        return colors.primaryAction;
      case SlamSeverity.hard:
        return colors.warning;
      case SlamSeverity.severe:
        return colors.danger;
    }
  }

  void _showAdvisorySheet(BuildContext context, WaveImpactState state) {
    final colors = context.colors;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        final color = _getSeverityColor(state.severity, colors);
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: colors.glassBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.waves, color: color, size: 22),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'AALLOKON ISKUT & MERENKÄYNTI AI',
                      style: AppTextStyles.h4.copyWith(
                        color: colors.primaryAction,
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: colors.textSecondary,
                      size: 20,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Metrics Row
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: colors.surfaceHighlight,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: color.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'G-VOIMA',
                            style: AppTextStyles.caption.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                          Text(
                            state.hasSensorSamples
                                ? '${state.currentGForce.toStringAsFixed(1)}g'
                                : '—',
                            style: AppTextStyles.h4.copyWith(color: color),
                          ),
                          Text(
                            state.hasSensorSamples
                                ? 'Huippu: ${state.peakGForceLastMinute.toStringAsFixed(1)}g'
                                : 'Ei anturidataa',
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 10,
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
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: colors.glassBorder),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ISKUTAAJUUS',
                            style: AppTextStyles.caption.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                          Text(
                            state.hasSensorSamples
                                ? '${state.hitsPerMinute} /min'
                                : '— /min',
                            style: AppTextStyles.h4.copyWith(
                              color: colors.textPrimary,
                            ),
                          ),
                          Text(
                            state.hasSensorSamples
                                ? state.attackDirection.label
                                : 'Ei anturidataa',
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 10,
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
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: colors.glassBorder),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ARVIOITU Hs',
                            style: AppTextStyles.caption.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                          Text(
                            state.hasSensorSamples
                                ? '${state.estimatedWaveHeightM.toStringAsFixed(1)} m'
                                : '—',
                            style: AppTextStyles.h4.copyWith(
                              color: colors.textPrimary,
                            ),
                          ),
                          Text(
                            'Aallon korkeus',
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Skipper Advice Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: color.withValues(alpha: 0.4)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.shield_outlined, color: color, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        state.skipperAdvice,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 12,
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // iOS Sensor Activation Button
              Consumer(
                builder: (context, ref, _) {
                  return SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.sensors, size: 16),
                      label: const Text('Aktivoi aallokkomittari (iOS)'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colors.primaryAction,
                        side: BorderSide(
                          color: colors.primaryAction.withValues(alpha: 0.5),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        final granted = await ref
                            .read(waveImpactAiServiceProvider)
                            .requestPermissionAndStart();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                granted
                                    ? 'Liiketunnistimet aktivoitu onnistuneesti!'
                                    : 'Lupaa liiketunnistimiin ei myönnetty.',
                              ),
                              backgroundColor: granted
                                  ? colors.success
                                  : colors.danger,
                              duration: const Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final stateAsync = ref.watch(waveImpactStateProvider);
    final state =
        stateAsync.value ?? ref.watch(waveImpactAiServiceProvider).currentState;

    final color = _getSeverityColor(state.severity, colors);

    return GestureDetector(
      onTap: () {
        ref.read(waveImpactAiServiceProvider).requestPermissionAndStart();
        _showAdvisorySheet(context, state);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: colors.surface.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: state.isOutlierWave
                ? colors.danger
                : color.withValues(alpha: 0.6),
            width: state.isOutlierWave ? 2.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              state.isOutlierWave ? Icons.warning_amber : Icons.waves,
              color: color,
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              state.hasSensorSamples
                  ? '${state.currentGForce.toStringAsFixed(1)}g'
                  : '— g',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 6),
            Container(width: 1, height: 12, color: colors.glassBorder),
            const SizedBox(width: 6),
            Text(
              state.hasSensorSamples ? '${state.hitsPerMinute}/min' : '—/min',
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (state.hasSensorSamples && state.hitsPerMinute > 0) ...[
              const SizedBox(width: 4),
              Text(
                '• ${state.attackDirection.label}',
                style: TextStyle(color: colors.textSecondary, fontSize: 10),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
