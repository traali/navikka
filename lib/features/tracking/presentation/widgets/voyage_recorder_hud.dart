import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/tracking/presentation/providers/active_track_provider.dart';
import 'package:sakkoja/features/tracking/presentation/widgets/voyage_save_dialog.dart';

/// Floating live HUD displayed while recording a voyage (GPS Track Recording).
class VoyageRecorderHud extends ConsumerStatefulWidget {
  const VoyageRecorderHud({super.key});

  @override
  ConsumerState<VoyageRecorderHud> createState() => _VoyageRecorderHudState();
}

class _VoyageRecorderHudState extends ConsumerState<VoyageRecorderHud> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && ref.read(activeTrackProvider).isRecording) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes % 60;
    final seconds = d.inSeconds % 60;
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final trackState = ref.watch(activeTrackProvider);
    if (!trackState.isRecording) return const SizedBox.shrink();

    final colors = context.colors;
    final startTime = trackState.startTime ?? DateTime.now();
    final elapsed = DateTime.now().difference(startTime);
    final distanceNm = trackState.totalDistance / 1852.0;

    return Positioned(
      top: MediaQuery.paddingOf(context).top + 54,
      left: 12,
      right: 56, // zoom +/- column on iPhone Chrome
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 420),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppPalette.navikkaSurface.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppPalette.danger.withValues(alpha: 0.7),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppPalette.danger.withValues(alpha: 0.25),
                blurRadius: 14,
                spreadRadius: 1,
              ),
              const BoxShadow(
                color: Colors.black45,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Pulsing Recording Indicator Dot
              Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: AppPalette.danger,
                      shape: BoxShape.circle,
                    ),
                  )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1.3, 1.3),
                    duration: 700.ms,
                  )
                  .fadeIn(duration: 300.ms),
              const SizedBox(width: 8),

              // "REC" Label & Elapsed Timer
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'REC',
                        style: TextStyle(
                          color: AppPalette.danger,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatDuration(elapsed),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${distanceNm.toStringAsFixed(2)} NM (${(trackState.totalDistance / 1000).toStringAsFixed(1)} km)',
                    style: TextStyle(
                      color: colors.primaryAction,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Stop & Save Button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPalette.danger,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  minimumSize: const Size(0, 34),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                onPressed: () {
                  SafeHaptics.medium();
                  showDialog<void>(
                    context: context,
                    builder: (_) => VoyageSaveDialog(trackState: trackState),
                  );
                },
                icon: const Icon(Icons.stop_rounded, size: 16),
                label: const Text(
                  'Lopeta',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 250.ms).slideY(begin: -0.3, end: 0);
  }
}
