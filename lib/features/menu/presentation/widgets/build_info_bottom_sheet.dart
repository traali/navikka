import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/utils/build_info.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';

class BuildInfoBottomSheet extends StatelessWidget {
  const BuildInfoBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const BuildInfoBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppPalette.surface.withValues(alpha: 0.95),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: AppPalette.glassBorder()),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppPalette.surfaceHighlight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(
                Icons.anchor,
                color: AppPalette.primaryAction,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text('SAKKOJA', style: AppTextStyles.h2),
            ],
          ),
          const SizedBox(height: 32),
          _BuildInfoGrid(),
        ],
      ),
    );
  }
}

class _BuildInfoGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _InfoRow(label: 'Versio', value: BuildInfo.versionLabel),
        const Divider(color: AppPalette.surfaceHighlight),
        _InfoRow(
          label: 'Commit',
          value: BuildInfo.hash.length > 7
              ? BuildInfo.hash.substring(0, 7)
              : BuildInfo.hash,
          onCopy: () => BuildInfo.hash,
        ),
        const Divider(color: AppPalette.surfaceHighlight),
        const _InfoRow(label: 'Haara', value: BuildInfo.branch),
        const Divider(color: AppPalette.surfaceHighlight),
        const _InfoRow(label: 'Aikaleima', value: BuildInfo.buildTime),
        const Divider(color: AppPalette.surfaceHighlight),
        _InfoRow(
          label: 'Ympäristö',
          value: BuildInfo.environment.toUpperCase(),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.onCopy,
  });

  final String label;
  final String value;
  final String Function()? onCopy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodySmall),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: AppTextStyles.mono.copyWith(
                  color: AppPalette.textPrimary,
                ),
              ),
              if (onCopy != null) ...[
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.copy_rounded, size: 16),
                  color: AppPalette.primaryAction,
                  onPressed: () {
                    SafeHaptics.light();
                    Clipboard.setData(ClipboardData(text: onCopy!()));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Kopioitu: $value'),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: AppPalette.surfaceHighlight,
                      ),
                    );
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
