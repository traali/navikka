import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/map/presentation/providers/layer_filter_provider.dart';
import 'package:sakkoja/l10n/app_localizations.dart';

/// Shared layer toggle list widget used by both [MenuScreen] and [LayersPanel].
///
/// Renders the 5 standard layer toggles (WeatherRadar, AlgaeLayer,
/// NavigationAids, BoatingLines, SpeedLimits) plus an expandable
/// MaritimeRestrictions section with restriction-type checkboxes.
///
/// [titleStyle], [subtitleStyle], and [activeThumbColor] allow each
/// consumer to adapt the visual presentation to its context.
///
/// When [isPanelStyle] is true, renders with section headers and icon-based
/// toggle rows suited for the sliding panel overlay. When false (default),
/// renders as simple SwitchListTile items suited for the menu screen.
class LayerToggleList extends ConsumerWidget {
  final TextStyle titleStyle;
  final Color activeThumbColor;
  final TextStyle? subtitleStyle;
  final bool includeMaritimeRestrictions;
  final bool isPanelStyle;

  const LayerToggleList({
    required this.titleStyle,
    required this.activeThumbColor,
    this.subtitleStyle,
    this.isPanelStyle = false,
    this.includeMaritimeRestrictions = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterStateAsync = ref.watch(layerFilterProvider);
    final filterState = filterStateAsync.value ?? LayerFilterState.initial();
    final notifier = ref.read(layerFilterProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    if (isPanelStyle) {
      return _buildPanelStyle(context, filterState, notifier, l10n);
    }
    return _buildMenuStyle(context, filterState, notifier, l10n);
  }

  Widget _buildMenuStyle(
    BuildContext context,
    LayerFilterState state,
    LayerFilter notifier,
    AppLocalizations l10n,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildToggle(
          context,
          title: l10n.radar,
          subtitle: l10n.radarSubtitle,
          value: state.showWeatherRadar,
          onChanged: (_) => notifier.toggleWeatherRadar(),
        ),
        _buildToggle(
          context,
          title: l10n.algae,
          subtitle: l10n.algaeSubtitle,
          value: state.showAlgaeLayer,
          onChanged: (_) => notifier.toggleAlgaeLayer(),
        ),
        _buildToggle(
          context,
          title: l10n.navAids,
          subtitle: l10n.navAidsSubtitle,
          value: state.showNavigationAids,
          onChanged: (_) => notifier.toggleNavigationAids(),
        ),
        _buildToggle(
          context,
          title: l10n.boatingLines,
          subtitle: l10n.boatingLinesSubtitle,
          value: state.showBoatingLines,
          onChanged: (_) => notifier.toggleBoatingLines(),
        ),
        _buildToggle(
          context,
          title: l10n.speedLimits,
          subtitle: l10n.speedLimitsSubtitle,
          value: state.showSpeedLimits,
          onChanged: (_) => notifier.toggleSpeedLimits(),
        ),
        _buildToggle(
          context,
          title: l10n.ais,
          subtitle: l10n.aisSubtitle,
          value: state.showAisLayer,
          onChanged: (_) => notifier.toggleAisLayer(),
        ),
        _buildToggle(
          context,
          title: 'Karttapohja: OpenStreetMap',
          subtitle:
              'Käytä OpenStreetMapia (oletus: Traficom merikartta, rasteri — ei S-57 ENC)',
          value: state.showOsmBasemap,
          onChanged: (_) => notifier.toggleOsmBasemap(),
        ),
        _buildToggle(
          context,
          title: 'Tuulivektorit & Ennuste',
          subtitle: 'Reaaliaikaiset tuulinuolet ja 0-12h ennusteasteikko',
          value: state.showWindLayer,
          onChanged: (_) => notifier.toggleWindLayer(),
        ),
        _buildToggle(
          context,
          title: l10n.harbors,
          subtitle: l10n.harborsSubtitle,
          value: state.showHarborsLayer,
          onChanged: (_) => notifier.toggleHarborsLayer(),
        ),
        if (includeMaritimeRestrictions) ...[
          const Divider(color: AppPalette.surfaceHighlight),
          _buildMaritimeSection(context, state, notifier),
          const Divider(color: AppPalette.surfaceHighlight),
        ],
      ],
    );
  }

  Widget _buildPanelStyle(
    BuildContext context,
    LayerFilterState state,
    LayerFilter notifier,
    AppLocalizations l10n,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Weather section
        _PanelSectionHeader(
          icon: Icons.cloud_outlined,
          title: l10n.weather.toUpperCase(),
          color: AppPalette.primaryAction,
        ),
        const SizedBox(height: 8),
        _PanelToggleRow(
          label: l10n.radar,
          icon: Icons.radar_rounded,
          isActive: state.showWeatherRadar,
          onTap: () => notifier.toggleWeatherRadar(),
          activeThumbColor: activeThumbColor,
        ),
        _PanelToggleRow(
          label: l10n.algae,
          icon: Icons.eco_outlined,
          isActive: state.showAlgaeLayer,
          onTap: () => notifier.toggleAlgaeLayer(),
          activeThumbColor: activeThumbColor,
        ),
        const SizedBox(height: 16),
        // Navigation section
        _PanelSectionHeader(
          icon: Icons.explore_outlined,
          title: l10n.navigation.toUpperCase(),
          color: AppPalette.warning,
        ),
        const SizedBox(height: 8),
        _PanelToggleRow(
          label: l10n.navAids,
          icon: Icons.sailing_outlined,
          isActive: state.showNavigationAids,
          onTap: () => notifier.toggleNavigationAids(),
          activeThumbColor: activeThumbColor,
        ),
        _PanelToggleRow(
          label: l10n.boatingLines,
          icon: Icons.route_outlined,
          isActive: state.showBoatingLines,
          onTap: () => notifier.toggleBoatingLines(),
          activeThumbColor: activeThumbColor,
        ),
        _PanelToggleRow(
          label: l10n.speedLimits,
          icon: Icons.speed_outlined,
          isActive: state.showSpeedLimits,
          onTap: () => notifier.toggleSpeedLimits(),
          activeThumbColor: activeThumbColor,
        ),
        _PanelToggleRow(
          label: l10n.ais,
          icon: Icons.directions_boat_outlined,
          isActive: state.showAisLayer,
          onTap: () => notifier.toggleAisLayer(),
          activeThumbColor: activeThumbColor,
        ),
        _PanelToggleRow(
          label: l10n.harbors,
          icon: Icons.anchor_outlined,
          isActive: state.showHarborsLayer,
          onTap: () => notifier.toggleHarborsLayer(),
          activeThumbColor: activeThumbColor,
        ),
        // Safety section
        if (includeMaritimeRestrictions) ...[
          const SizedBox(height: 16),
          _PanelSectionHeader(
            icon: Icons.warning_outlined,
            title: l10n.safety.toUpperCase(),
            color: AppPalette.danger,
          ),
          const SizedBox(height: 8),
          _PanelToggleRow(
            label: l10n.maritimeRestrictions,
            icon: Icons.rule_outlined,
            isActive: state.showMaritimeRestrictions,
            onTap: () => notifier.toggleMaritimeRestrictions(),
            activeThumbColor: activeThumbColor,
          ),
        ],
      ],
    );
  }

  Widget _buildToggle(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return SwitchListTile.adaptive(
      title: Text(title, style: titleStyle),
      subtitle: subtitleStyle != null
          ? Text(subtitle, style: subtitleStyle)
          : null,
      value: value,
      activeThumbColor: activeThumbColor,
      onChanged: (val) {
        SafeHaptics.selection();
        onChanged(val);
      },
    );
  }

  Widget _buildMaritimeSection(
    BuildContext context,
    LayerFilterState state,
    LayerFilter notifier,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return ExpansionTile(
      title: Text(
        l10n.maritimeRestrictions,
        style: titleStyle.copyWith(
          color: activeThumbColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        l10n.restrictionSubtitle,
        style: subtitleStyle ?? titleStyle,
      ),
      children: [
        SwitchListTile.adaptive(
          title: Text(
            l10n.showRestrictionAreas,
            style: subtitleStyle ?? titleStyle,
          ),
          value: state.showMaritimeRestrictions,
          activeThumbColor: activeThumbColor,
          onChanged: (val) {
            SafeHaptics.selection();
            notifier.toggleMaritimeRestrictions();
          },
        ),
        ...allRestrictionTypes.map((type) {
          final isVisible = state.visibleTypes.contains(type.code);
          return CheckboxListTile(
            title: Text(type.finnishName, style: subtitleStyle ?? titleStyle),
            value: isVisible,
            activeColor: activeThumbColor,
            onChanged: state.showMaritimeRestrictions
                ? (val) {
                    SafeHaptics.selection();
                    notifier.toggleType(type.code);
                  }
                : null,
          );
        }),
      ],
    );
  }
}

class _PanelSectionHeader extends StatelessWidget {
  const _PanelSectionHeader({
    required this.icon,
    required this.title,
    required this.color,
  });
  final IconData icon;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 14),
        const SizedBox(width: 6),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}

class _PanelToggleRow extends StatelessWidget {
  const _PanelToggleRow({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
    required this.activeThumbColor,
  });
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  final Color activeThumbColor;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      toggled: isActive,
      button: true,
      label: '$label layer',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            SafeHaptics.light();
            onTap();
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: isActive
                  ? AppPalette.textPrimary.withValues(alpha: 0.08)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isActive
                      ? AppPalette.textPrimary.withValues(alpha: 0.7)
                      : AppPalette.textSecondary.withValues(alpha: 0.6),
                  size: 18,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: isActive
                          ? AppPalette.textPrimary
                          : AppPalette.textSecondary,
                      fontSize: 14,
                      fontWeight: isActive
                          ? FontWeight.w500
                          : FontWeight.normal,
                    ),
                  ),
                ),
                Switch(
                  value: isActive,
                  onChanged: (_) {
                    SafeHaptics.light();
                    onTap();
                  },
                  activeThumbColor: activeThumbColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
