import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/features/navigation/domain/entities/navigation_state.dart';
import 'package:sakkoja/features/navigation/presentation/controllers/navigation_controller.dart';

class NavigationGuidanceHud extends ConsumerWidget {
  const NavigationGuidanceHud({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigation = ref.watch(navigationControllerProvider);
    return navigation.maybeWhen(
      data: (state) {
        if (!state.isActive) return const SizedBox.shrink();
        return _GuidancePanel(state: state);
      },
      error: (_, _) => const _StatusPanel(
        icon: Icons.error_outline,
        color: AppPalette.danger,
        message: 'Navigation unavailable',
      ),
      orElse: SizedBox.shrink,
    );
  }
}

class _GuidancePanel extends StatelessWidget {
  const _GuidancePanel({required this.state});

  final NavigationState state;

  @override
  Widget build(BuildContext context) {
    if (!state.isPositionFresh) {
      return const _StatusPanel(
        icon: Icons.gps_off,
        color: AppPalette.danger,
        message: 'GPS signal lost - guidance paused',
      );
    }

    final bearing = state.bearingToNextWp;
    final distance = state.distanceToNextWpMeters;
    if (bearing == null || distance == null) {
      return const _StatusPanel(
        icon: Icons.route,
        color: AppPalette.warning,
        message: 'Waiting for route guidance',
      );
    }

    final bearingText = bearing.round().toString().padLeft(3, '0');
    final distanceText = distance < 1000
        ? '${distance.round()} m'
        : '${(distance / 1852).toStringAsFixed(1)} NM';
    final eta = state.etaDestination;
    final etaText = eta == null
        ? '--:--'
        : '${eta.hour.toString().padLeft(2, '0')}:'
              '${eta.minute.toString().padLeft(2, '0')}';

    return Semantics(
      liveRegion: true,
      label:
          'Next waypoint bearing $bearingText degrees, distance '
          '$distanceText, arrival $etaText',
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420, minHeight: 64),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppPalette.surface.withValues(alpha: 0.94),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: state.isOffCourse
                ? AppPalette.danger
                : AppPalette.primaryAction.withValues(alpha: 0.7),
          ),
        ),
        child: Row(
          children: [
            Icon(
              state.isOffCourse
                  ? Icons.warning_amber_rounded
                  : Icons.navigation_rounded,
              color: state.isOffCourse
                  ? AppPalette.danger
                  : AppPalette.primaryAction,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _Datum(label: 'COURSE', value: '$bearingText°'),
            ),
            Expanded(
              child: _Datum(label: 'NEXT', value: distanceText),
            ),
            Expanded(
              child: _Datum(label: 'ETA', value: etaText),
            ),
          ],
        ),
      ),
    );
  }
}

class _Datum extends StatelessWidget {
  const _Datum({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppPalette.textSecondary,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.fade,
          softWrap: false,
          style: const TextStyle(
            color: AppPalette.textPrimary,
            fontFamily: 'JetBrains Mono',
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _StatusPanel extends StatelessWidget {
  const _StatusPanel({
    required this.icon,
    required this.color,
    required this.message,
  });

  final IconData icon;
  final Color color;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      label: message,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420, minHeight: 48),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppPalette.surface.withValues(alpha: 0.94),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                message,
                style: const TextStyle(
                  color: AppPalette.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
