import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_mode_provider.dart';
import 'package:sakkoja/features/fishing/presentation/widgets/catch_entry_sheet.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';

class FishingScreen extends ConsumerWidget {
  const FishingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final isFishingMode =
        ref.watch(fishingModeControllerProvider).value?.isEnabled ?? false;

    return Scaffold(
      backgroundColor: colors.canvas,
      appBar: AppBar(
        title: Text(
          'KALASTUS',
          style: TextStyle(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: colors.surface,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Big Toggle Card
            _FishingModeCard(
              isEnabled: isFishingMode,
              onToggle: () =>
                  ref.read(fishingModeControllerProvider.notifier).toggle(),
            ),

            const SizedBox(height: 24),

            // Primary Action: Log Catch
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primaryAction,
                  foregroundColor: colors.canvas,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  final mapState = ref.read(mapProvider);
                  if (mapState.hasLocation) {
                    showModalBottomSheet<void>(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) =>
                          CatchEntrySheet(location: mapState.userLocation),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Sijaintia ei saatu - odota GPS-signaalia',
                        ),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.add_circle_outline, size: 28),
                label: Text(
                  'KIRJAA SAALIS',
                  style: AppTextStyles.button.copyWith(
                    fontSize: 18,
                    color: colors.canvas,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Recent Catches Header
            Row(
              children: [
                Icon(Icons.history, color: colors.textSecondary),
                const SizedBox(width: 8),
                Text(
                  'Viimeisimmät saaliit',
                  style: AppTextStyles.h4.copyWith(color: colors.textPrimary),
                ),
              ],
            ),
            Divider(color: colors.glassBorder),

            // Placeholder List
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phishing,
                      size: 64,
                      color: colors.textSecondary.withValues(alpha: 0.3),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Ei viimeaikaisia saaliita',
                      style: AppTextStyles.body.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FishingModeCard extends StatelessWidget {
  const _FishingModeCard({required this.isEnabled, required this.onToggle});
  final bool isEnabled;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Card(
      color: isEnabled ? colors.surface : colors.surface.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isEnabled
            ? BorderSide(color: colors.primaryAction, width: 2)
            : BorderSide(color: colors.glassBorder),
      ),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          'Kalastusmoodi',
          style: AppTextStyles.h4.copyWith(
            color: isEnabled ? colors.primaryAction : colors.textPrimary,
          ),
        ),
        subtitle: Text(
          'Näytä kalastusrajoitukset kartalla',
          style: TextStyle(color: colors.textSecondary),
        ),
        value: isEnabled,
        activeThumbColor: colors.primaryAction,
        onChanged: (_) => onToggle(),
      ),
    );
  }
}
