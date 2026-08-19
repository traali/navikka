import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';
import 'package:sakkoja/features/ai/presentation/providers/ai_providers.dart';

/// Action buttons for the skipper settings screen.
class SettingsActionButtons extends ConsumerStatefulWidget {
  const SettingsActionButtons({
    required this.isAIEnabled,
    required this.forecastWindow,
    required this.windYellow,
    required this.windOrange,
    required this.windRed,
    required this.waveYellow,
    required this.waveOrange,
    required this.waveRed,
    required this.pressureDrop,
    required this.hasAcknowledgedSafety,
    required this.aiApiKey,
    required this.aiModelId,
    required this.onReset,
    super.key,
  });

  final bool isAIEnabled;
  final int forecastWindow;
  final double windYellow;
  final double windOrange;
  final double windRed;
  final double waveYellow;
  final double waveOrange;
  final double waveRed;
  final double pressureDrop;
  final bool hasAcknowledgedSafety;
  final String? aiApiKey;
  final String? aiModelId;
  final VoidCallback onReset;

  @override
  ConsumerState<SettingsActionButtons> createState() =>
      _SettingsActionButtonsState();
}

class _SettingsActionButtonsState extends ConsumerState<SettingsActionButtons> {
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: colors.primaryAction,
              foregroundColor: colors.canvas,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _isSaving ? null : _saveSettings,
            child: _isSaving
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colors.canvas,
                    ),
                  )
                : Text(
                    'TALLENNA ASETUKSET',
                    style: TextStyle(
                      color: colors.canvas,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: _isSaving ? null : widget.onReset,
          child: Text(
            'PALAUTA OLETUSASETUKSET',
            style: TextStyle(
              color: colors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _saveSettings() async {
    setState(() => _isSaving = true);

    try {
      final newSettings = SkipperSettings(
        isAIEnabled: widget.isAIEnabled,
        forecastWindowHours: widget.forecastWindow,
        thresholds: SkipperThresholds(
          windYellowMs: widget.windYellow,
          windOrangeMs: widget.windOrange,
          windRedMs: widget.windRed,
          waveYellowM: widget.waveYellow,
          waveOrangeM: widget.waveOrange,
          waveRedM: widget.waveRed,
          pressureDropThresholdHpa: widget.pressureDrop,
        ),
        hasAcknowledgedAISafety: widget.hasAcknowledgedSafety,
        aiApiKey: widget.aiApiKey,
        aiModelId: widget.aiModelId ?? 'meta-llama/llama-3.3-70b-instruct:free',
      );

      await ref
          .read(skipperSettingsControllerProvider.notifier)
          .updateSettings(newSettings);

      final controllerState = ref.read(skipperSettingsControllerProvider);
      if (mounted && !controllerState.hasError) {
        context.pop();
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }
}
