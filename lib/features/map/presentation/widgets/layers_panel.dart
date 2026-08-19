import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_mode_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/layer_filter_provider.dart';
import 'package:sakkoja/features/map/presentation/widgets/layer_toggle_list.dart';
import 'package:sakkoja/l10n/app_localizations.dart';

class LayersPanel extends ConsumerWidget {
  const LayersPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layerFilter = ref.watch(layerFilterProvider);
    final isFishingMode =
        ref.watch(fishingModeControllerProvider).value?.isEnabled ?? false;

    return layerFilter.when(
      data: (state) => _buildPanel(context, ref, state, isFishingMode),
      loading: () => _buildLoadingPanel(context),
      error: (e, s) =>
          _buildPanel(context, ref, LayerFilterState.initial(), isFishingMode),
    );
  }

  Widget _buildLoadingPanel(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Center(
        child: CircularProgressIndicator(color: colors.primaryAction),
      ),
    );
  }

  Widget _buildPanel(
    BuildContext context,
    WidgetRef ref,
    LayerFilterState state,
    bool isFishingMode,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final activeCount = _countActive(state);
    final colors = context.colors;

    return DraggableScrollableSheet(
      minChildSize: 0.3,
      maxChildSize: 0.85,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(
              top: BorderSide(color: colors.glassBorder),
            ),
          ),
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 4),
                child: Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colors.glassBorder,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Transform.rotate(
                          angle: 0.785398,
                          child: Icon(
                            Icons.diamond,
                            color: colors.primaryAction,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          l10n.layers.toUpperCase(),
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colors.primaryAction.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: colors.primaryAction.withValues(
                            alpha: 0.4,
                          ),
                        ),
                      ),
                      child: Text(
                        '$activeCount ${l10n.active}',
                        style: TextStyle(
                          color: colors.primaryAction,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: colors.textSecondary.withValues(alpha: 0.2),
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: LayerToggleList(
                  titleStyle: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 14,
                  ),
                  subtitleStyle: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 12,
                  ),
                  activeThumbColor: colors.primaryAction,
                  includeMaritimeRestrictions: true,
                  isPanelStyle: true,
                ),
              ),
              Divider(
                color: colors.textSecondary.withValues(alpha: 0.2),
                height: 1,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Material(
                  color: isFishingMode
                      ? colors.warning.withValues(alpha: 0.15)
                      : colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () {
                      SafeHaptics.medium();
                      ref.read(fishingModeControllerProvider.notifier).toggle();
                      Navigator.of(context).pop();
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isFishingMode
                              ? colors.warning.withValues(alpha: 0.4)
                              : colors.glassBorder,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isFishingMode
                                ? Icons.phishing_rounded
                                : Icons.phishing_outlined,
                            color: isFishingMode
                                ? colors.warning
                                : colors.textSecondary,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            l10n.fishingMode,
                            style: TextStyle(
                              color: colors.textPrimary,
                              fontSize: 14,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            isFishingMode ? l10n.on : l10n.off,
                            style: TextStyle(
                              color: isFishingMode
                                  ? colors.warning
                                  : colors.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: colors.textSecondary,
                  ),
                  child: Text(
                    l10n.close.toUpperCase(),
                    style: const TextStyle(fontSize: 12, letterSpacing: 2),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.paddingOf(context).bottom + 8),
            ],
          ),
        );
      },
    );
  }

  int _countActive(LayerFilterState state) {
    int count = 0;
    if (state.showWeatherRadar) count++;
    if (state.showAlgaeLayer) count++;
    if (state.showNavigationAids) count++;
    if (state.showBoatingLines) count++;
    if (state.showSpeedLimits) count++;
    if (state.showMaritimeRestrictions) count++;
    if (state.showAisLayer) count++;
    if (state.showHarborsLayer) count++;
    return count;
  }
}
