import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/ai/domain/services/ai_voyage_logbook_service.dart';
import 'package:sakkoja/features/tracking/domain/entities/track_state.dart';
import 'package:sakkoja/features/tracking/presentation/providers/active_track_provider.dart';

class VoyageSaveDialog extends ConsumerStatefulWidget {
  const VoyageSaveDialog({
    required this.trackState,
    super.key,
  });

  final TrackState trackState;

  @override
  ConsumerState<VoyageSaveDialog> createState() => _VoyageSaveDialogState();
}

class _VoyageSaveDialogState extends ConsumerState<VoyageSaveDialog> {
  late final TextEditingController _nameController;
  late final VoyageLogbookSummary _recap;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final dateStr = DateFormat('d.M. klo HH:mm').format(now);
    final defaultName = widget.trackState.trackName ?? 'Veneily $dateStr';
    _nameController = TextEditingController(text: defaultName);

    final duration = widget.trackState.startTime != null
        ? now.difference(widget.trackState.startTime!)
        : Duration.zero;
    final totalDurationSec = duration.inSeconds.clamp(1, 86400 * 7);

    final avgSpeedKmh = totalDurationSec > 0
        ? (widget.trackState.totalDistance / totalDurationSec) * 3.6
        : 0.0;

    _recap = AiVoyageLogbookService.generateRecap(
      tripName: defaultName,
      totalDistanceMeters: widget.trackState.totalDistance,
      totalDurationSeconds: totalDurationSec,
      maxSpeedKmh: widget.trackState.maxSpeedKmh,
      avgSpeedKmh: avgSpeedKmh,
      maxWindSpeedMs: null,
      fuelType: 'Bensiini',
      engineDisplacementLiters: null,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);
    SafeHaptics.medium();

    final name = _nameController.text.trim().isEmpty
        ? 'Veneily ${DateFormat('d.M. HH:mm').format(DateTime.now())}'
        : _nameController.text.trim();

    final routeId = await ref
        .read(activeTrackProvider.notifier)
        .saveAsRoute(name: name);

    if (mounted) {
      Navigator.of(context).pop();
      if (routeId != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Reitti "$name" tallennettu onnistuneesti!'),
            backgroundColor: AppPalette.success,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _handleDiscard() async {
    SafeHaptics.light();
    await ref.read(activeTrackProvider.notifier).stopRecording();
    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veneilyjälki hylätty'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Dialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: colors.glassBorder, width: 1.2),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppPalette.danger.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.stop_circle_rounded,
                      color: AppPalette.danger,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Päätä veneily & tallenna',
                          style: AppTextStyles.h4.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'AI-matkaloki ja reittitallennus',
                          style: AppTextStyles.caption.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Route Name Input
              TextField(
                controller: _nameController,
                style: AppTextStyles.body.copyWith(color: colors.textPrimary),
                decoration: InputDecoration(
                  labelText: 'Reitin / matkan nimi',
                  labelStyle: TextStyle(color: colors.primaryAction),
                  filled: true,
                  fillColor: colors.surfaceHighlight,
                  prefixIcon: Icon(
                    Icons.edit_road_rounded,
                    color: colors.primaryAction,
                    size: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors.glassBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colors.primaryAction,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Metrics Grid
              Row(
                children: [
                  Expanded(
                    child: _MetricCard(
                      label: 'MATKA',
                      value: '${_recap.distanceNm.toStringAsFixed(2)} NM',
                      subvalue:
                          '(${(widget.trackState.totalDistance / 1000).toStringAsFixed(1)} km)',
                      valueColor: colors.primaryAction,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _MetricCard(
                      label: 'AJOAIKA',
                      value: '${_recap.durationMinutes} min',
                      subvalue:
                          '${(_recap.durationMinutes / 60).toStringAsFixed(1)} h',
                      valueColor: colors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _MetricCard(
                      label: 'HUIPPUNOPEUS',
                      value: '${_recap.maxSpeedKnots.toStringAsFixed(1)} kn',
                      subvalue:
                          '(${widget.trackState.maxSpeedKmh.toStringAsFixed(1)} km/h)',
                      valueColor: colors.warning,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _MetricCard(
                      label: 'POLTTOAINE (EST.)',
                      value:
                          '${_recap.estimatedFuelLiters.toStringAsFixed(1)} L',
                      subvalue: 'Bensiini ~1.1 L/NM',
                      valueColor: colors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // AI Logbook Narrative Box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colors.canvas.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colors.glassBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          color: colors.primaryAction,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Älykäs matkayhteenveto',
                          style: TextStyle(
                            color: colors.primaryAction,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(text: _recap.narrativeRecap),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Kopioitu leikepöydälle'),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.copy_rounded,
                            size: 16,
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _recap.narrativeRecap,
                      style: AppTextStyles.nvXs.copyWith(
                        color: colors.textPrimary,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Action Buttons
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: colors.primaryAction,
                  foregroundColor: colors.canvas,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _isSaving ? null : _handleSave,
                icon: _isSaving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.bookmark_add_rounded, size: 20),
                label: Text(
                  _isSaving ? 'Tallennetaan...' : 'Tallenna reitteihin & lokiin',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colors.danger,
                        side: BorderSide(
                          color: colors.danger.withValues(alpha: 0.5),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _handleDiscard,
                      child: const Text('Hylkää jälki'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: colors.textSecondary,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Jatka ajoa'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.subvalue,
    required this.valueColor,
  });

  final String label;
  final String value;
  final String subvalue;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
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
            label,
            style: AppTextStyles.caption.copyWith(
              color: colors.textSecondary,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTextStyles.h4.copyWith(
              color: valueColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subvalue,
            style: TextStyle(color: colors.textSecondary, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
