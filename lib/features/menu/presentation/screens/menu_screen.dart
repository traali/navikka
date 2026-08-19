import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sakkoja/core/settings/presentation/providers/ai_settings_provider.dart';
import 'package:sakkoja/core/settings/presentation/providers/unit_preferences_provider.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/core/utils/build_info.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/ai/presentation/providers/ai_providers.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_data_providers.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_mode_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/feature_flag_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_auto_follow_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/ui_layout_provider.dart';
import 'package:sakkoja/features/map/presentation/widgets/layer_toggle_list.dart';
import 'package:sakkoja/features/menu/presentation/widgets/build_info_bottom_sheet.dart';
import 'package:sakkoja/l10n/app_localizations.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({this.showAppBar = true, super.key});
  final bool showAppBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColors = context.colors;

    final content = ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionHeader('Kartta ja tasot'),
        LayerToggleList(
          titleStyle: AppTextStyles.body.copyWith(
            color: themeColors.textPrimary,
          ),
          subtitleStyle: AppTextStyles.caption.copyWith(
            color: themeColors.textSecondary,
          ),
          activeThumbColor: themeColors.primaryAction,
          includeMaritimeRestrictions: true,
        ),
        const SizedBox(height: 24),

        const _SectionHeader('Kalastus'),
        _FishingSection(),
        const SizedBox(height: 24),

        const _SectionHeader('Ulkoasu'),
        const _LayoutSelection(),
        const SizedBox(height: 24),

        const _SectionHeader('Teema'),
        const _ThemeSelection(),
        const SizedBox(height: 24),

        const _SectionHeader('Mittayksiköt'),
        const _UnitSelection(),
        const SizedBox(height: 24),

        const _SectionHeader('Navigointi'),
        Consumer(
          builder: (context, ref, _) {
            final is3dTilt = ref.watch(map3dTiltProvider);
            return SwitchListTile(
              title: Text(
                '3D-näkymän kallistus',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: themeColors.textPrimary,
                ),
              ),
              subtitle: Text(
                'Kallistaa merikarttaa perspektiiviin veneen takaa Kipparitilassa',
                style: AppTextStyles.bodySmall.copyWith(
                  color: themeColors.textSecondary,
                ),
              ),
              secondary: Icon(
                Icons.threed_rotation,
                color: themeColors.primaryAction,
              ),
              activeThumbColor: themeColors.primaryAction,
              value: is3dTilt,
              onChanged: (value) {
                SafeHaptics.light();
                ref.read(map3dTiltProvider.notifier).setTilt(value);
              },
            );
          },
        ),
        Consumer(
          builder: (context, ref, _) {
            final isRoughSea = ref.watch(roughSeaModeControllerProvider);
            return SwitchListTile(
              title: Text(
                'Kovan merenkäynnin tila (64px)',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: themeColors.textPrimary,
                ),
              ),
              subtitle: Text(
                'Suurentaa painikkeet 64px kokoon ja väljentää asettelua raskaaseen merenkäyntiin ja hansikkaille',
                style: AppTextStyles.bodySmall.copyWith(
                  color: themeColors.textSecondary,
                ),
              ),
              secondary: Icon(
                Icons.tsunami_outlined,
                color: themeColors.primaryAction,
              ),
              activeThumbColor: themeColors.primaryAction,
              value: isRoughSea,
              onChanged: (_) {
                SafeHaptics.light();
                ref.read(roughSeaModeControllerProvider.notifier).toggle();
              },
            );
          },
        ),
        ListTile(
          title: Text(
            AppLocalizations.of(context)!.routePlanner,
            style: AppTextStyles.bodyLarge.copyWith(
              color: themeColors.textPrimary,
            ),
          ),
          subtitle: Text(
            'Luo ja hallitse reittejä',
            style: AppTextStyles.bodySmall.copyWith(
              color: themeColors.textSecondary,
            ),
          ),
          leading: Icon(
            Icons.route_outlined,
            color: themeColors.primaryAction,
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: themeColors.textSecondary,
          ),
          onTap: () => context.push('/route-planner'),
        ),
        ListTile(
          title: Text(
            'Tallennetut reitit',
            style: AppTextStyles.bodyLarge.copyWith(
              color: themeColors.textPrimary,
            ),
          ),
          subtitle: Text(
            'Tarkastele kaikkia reittejä',
            style: AppTextStyles.bodySmall.copyWith(
              color: themeColors.textSecondary,
            ),
          ),
          leading: Icon(
            Icons.alt_route_outlined,
            color: themeColors.primaryAction,
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: themeColors.textSecondary,
          ),
          onTap: () => context.push('/routes'),
        ),
        ListTile(
          title: Text(
            'Hallitse alueita',
            style: AppTextStyles.bodyLarge.copyWith(
              color: themeColors.textPrimary,
            ),
          ),
          subtitle: Text(
            'Lataa karttoja offline-käyttöön',
            style: AppTextStyles.bodySmall.copyWith(
              color: themeColors.textSecondary,
            ),
          ),
          leading: Icon(
            Icons.download_for_offline_outlined,
            color: themeColors.primaryAction,
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: themeColors.textSecondary,
          ),
          onTap: () => context.push('/offline-regions'),
        ),
        ListTile(
          title: Text(
            'Satelliittinäkymä',
            style: AppTextStyles.bodyLarge.copyWith(
              color: themeColors.textPrimary,
            ),
          ),
          subtitle: Text(
            'Copernicus Sentinel-2 & FMI Sääsatelliitti',
            style: AppTextStyles.bodySmall.copyWith(
              color: themeColors.textSecondary,
            ),
          ),
          leading: Icon(
            Icons.satellite_alt_outlined,
            color: themeColors.primaryAction,
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: themeColors.textSecondary,
          ),
          onTap: () => context.push('/satellite'),
        ),

        const SizedBox(height: 24),
        const _SectionHeader('AI Kippari & Asetukset'),
        const _SettingsSection(),

        const SizedBox(height: 24),
        const _SectionHeader('Tietoja'),
        ListTile(
          title: Text(
            'Sakkoja - Yökapteeni',
            style: AppTextStyles.body.copyWith(
              color: themeColors.textPrimary,
            ),
          ),
          subtitle: Text(
            BuildInfo.versionLabel,
            style: AppTextStyles.caption.copyWith(
              color: themeColors.textSecondary,
            ),
          ),
          leading: Icon(Icons.anchor, color: themeColors.primaryAction),
          onTap: () {
            SafeHaptics.selection();
            BuildInfoBottomSheet.show(context);
          },
        ),
        ListTile(
          title: Text(
            'Lisenssit',
            style: AppTextStyles.body.copyWith(
              color: themeColors.textPrimary,
            ),
          ),
          onTap: () => showLicensePage(context: context),
          trailing: Icon(
            Icons.chevron_right,
            color: themeColors.textSecondary,
          ),
        ),
      ],
    );

    if (!showAppBar) {
      return Material(
        color: themeColors.canvas,
        child: SafeArea(child: content),
      );
    }

    return Scaffold(
      backgroundColor: themeColors.canvas,
      appBar: AppBar(
        title: const Text('VALIKKO'),
        backgroundColor: themeColors.surface,
        elevation: 0,
        centerTitle: true,
      ),
      body: content,
    );
  }
}

class _FishingSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fishingModeAsync = ref.watch(fishingModeControllerProvider);
    final availableCategoriesAsync = ref.watch(
      availableRestrictionTypesProvider,
    );

    return ExpansionTile(
      title: Text(
        'Kalastusrajoitukset',
        style: AppTextStyles.caption.copyWith(
          color: AppPalette.success,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        'Suodata kalastusrajoituksia',
        style: AppTextStyles.caption,
      ),
      children: fishingModeAsync.when(
        loading: () => [const Center(child: CircularProgressIndicator())],
        error: (e, _) => [Text('Virhe: $e')],
        data: (mode) => [
          SwitchListTile.adaptive(
            title: Text('Kalastusmoodi', style: AppTextStyles.bodySmall),
            value: mode.isEnabled,
            activeThumbColor: AppPalette.success,
            onChanged: (val) {
              SafeHaptics.selection();
              ref.read(fishingModeControllerProvider.notifier).toggle();
            },
          ),
          if (mode.isEnabled) ...[
            SwitchListTile.adaptive(
              title: Text(
                'Näytä kaikki tyypit',
                style: AppTextStyles.bodySmall,
              ),
              subtitle: Text(
                'Kun pois päältä, valitse tyyppi alasvetovalikosta',
                style: AppTextStyles.caption,
              ),
              value: mode.showAllCategories,
              activeThumbColor: AppPalette.success,
              onChanged: (val) {
                SafeHaptics.selection();
                ref
                    .read(fishingModeControllerProvider.notifier)
                    .toggleShowAllCategories();
              },
            ),
            SwitchListTile.adaptive(
              title: Text(
                'Näytä myös ei-aktiiviset',
                style: AppTextStyles.bodySmall,
              ),
              subtitle: Text(
                'Sisällytä myös tällä hetkellä voimassa olemattomat',
                style: AppTextStyles.caption,
              ),
              value: mode.showInactive,
              activeThumbColor: AppPalette.success,
              onChanged: (val) {
                SafeHaptics.selection();
                ref
                    .read(fishingModeControllerProvider.notifier)
                    .toggleShowInactive();
              },
            ),
            const Divider(color: AppPalette.surfaceHighlight),
            if (!mode.showAllCategories) ...[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: availableCategoriesAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (_, _) => const SizedBox.shrink(),
                  data: (categories) {
                    final selectedValue =
                        categories.contains(mode.selectedCategory)
                        ? mode.selectedCategory
                        : null;
                    final items = <DropdownMenuItem<String?>>[
                      const DropdownMenuItem<String?>(
                        child: Text('Kaikki tyypit'),
                      ),
                      ...categories.map(
                        (cat) => DropdownMenuItem<String?>(
                          value: cat,
                          child: Text(cat),
                        ),
                      ),
                    ];
                    return DropdownButtonFormField<String?>(
                      initialValue: selectedValue,
                      items: items,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Näytettävä tyyppi',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (val) {
                        SafeHaptics.selection();
                        ref
                            .read(fishingModeControllerProvider.notifier)
                            .setCategory(val);
                      },
                    );
                  },
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

class _SettingsSection extends ConsumerWidget {
  const _SettingsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(skipperSettingsControllerProvider);
    final aiSettings = ref.watch(aiSettingsProvider);
    final aiNotifier = ref.read(aiSettingsProvider.notifier);
    final colors = context.colors;

    return settingsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text('Virhe: $e'),
      data: (settings) {
        return Column(
          children: [
            // 1. Weather AI Toggle
            SwitchListTile.adaptive(
              title: Text(
                'Sää- ja Tilannekuva AI',
                style: AppTextStyles.body.copyWith(color: colors.textPrimary),
              ),
              subtitle: Text(
                'Reaaliaikainen sää- ja aallokkoanalyysi (On-device)',
                style: AppTextStyles.caption.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              value: aiSettings.weatherAiEnabled,
              activeThumbColor: colors.primaryAction,
              onChanged: (val) {
                SafeHaptics.light();
                aiNotifier.toggleWeatherAi(val);
              },
            ),

            // 2. Route AI Toggle
            SwitchListTile.adaptive(
              title: Text(
                'Reitti- ja Sääreititys AI',
                style: AppTextStyles.body.copyWith(color: colors.textPrimary),
              ),
              subtitle: Text(
                'Aallokkosuojatut väylät & syväystarkistus reittisuunnittelussa',
                style: AppTextStyles.caption.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              value: aiSettings.routeAiEnabled,
              activeThumbColor: colors.primaryAction,
              onChanged: (val) {
                SafeHaptics.light();
                aiNotifier.toggleRouteAi(val);
              },
            ),

            // 3. Acoustic AI Toggle
            // 4. Technical Copilot Toggle
            SwitchListTile.adaptive(
              title: Text(
                'Tekninen Moottoriopas & Copilot',
                style: AppTextStyles.body.copyWith(color: colors.textPrimary),
              ),
              subtitle: Text(
                'Offline-korjausohjeet Volvo, Yamaha, Yanmar, Mercury ym.',
                style: AppTextStyles.caption.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              value: aiSettings.technicalCopilotEnabled,
              activeThumbColor: colors.primaryAction,
              onChanged: (val) {
                SafeHaptics.light();
                aiNotifier.toggleTechnicalCopilot(val);
              },
            ),

            // 5. Voice Copilot Toggle
            SwitchListTile.adaptive(
              title: Text(
                'Käsivapaa Puheavustaja ("Hei Kippari")',
                style: AppTextStyles.body.copyWith(color: colors.textPrimary),
              ),
              subtitle: Text(
                'Äänikomennot suomeksi ja englanniksi kovaan keliin',
                style: AppTextStyles.caption.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              value: aiSettings.voiceCopilotEnabled,
              activeThumbColor: colors.primaryAction,
              onChanged: (val) {
                SafeHaptics.light();
                aiNotifier.toggleVoiceCopilot(val);
              },
            ),

            // 6. Logbook AI Toggle
            SwitchListTile.adaptive(
              title: Text(
                'Automaattinen Älykäs Matkaloki',
                style: AppTextStyles.body.copyWith(color: colors.textPrimary),
              ),
              subtitle: Text(
                'Luo automaattiset matkayhteenvedot ja kulutusarviot',
                style: AppTextStyles.caption.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              value: aiSettings.logbookAiEnabled,
              activeThumbColor: colors.primaryAction,
              onChanged: (val) {
                SafeHaptics.light();
                aiNotifier.toggleLogbookAi(val);
              },
            ),

            // 7. Wave Roughness & Slamming AI Toggle
            SwitchListTile.adaptive(
              title: Text(
                'Aallokon Iskut & Merenkäynti AI',
                style: AppTextStyles.body.copyWith(color: colors.textPrimary),
              ),
              subtitle: Text(
                'Mittaa puhelimen kiihtyvyysanturilla G-voimat, iskutaajuuden ja aallokkotyypin',
                style: AppTextStyles.caption.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              value: aiSettings.waveImpactAiEnabled,
              activeThumbColor: colors.primaryAction,
              onChanged: (val) {
                SafeHaptics.light();
                aiNotifier.toggleWaveImpactAi(val);
              },
            ),

            Divider(color: colors.glassBorder),

            // Navigation Links to AI Tools
            ListTile(
              leading: Icon(
                Icons.precision_manufacturing,
                color: colors.primaryAction,
              ),
              title: Text(
                'Avaa Moottoriopas & Vianmääritys',
                style: AppTextStyles.body.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Tarkastele moottorin huolto-ohjeita ja offline-manuaaleja',
                style: AppTextStyles.caption.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              trailing: Icon(Icons.chevron_right, color: colors.textSecondary),
              onTap: () => context.push('/technical-copilot'),
            ),

            ListTile(
              leading: Icon(
                Icons.directions_boat,
                color: colors.primaryAction,
              ),
              title: Text(
                'Veneen & Moottorin tiedot (VIN / HIN / Malli)',
                style: AppTextStyles.body.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Määritä runkonumero, moottorimerkki ja polttoainetyyppi',
                style: AppTextStyles.caption.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              trailing: Icon(Icons.chevron_right, color: colors.textSecondary),
              onTap: () => context.push('/vessel-settings'),
            ),

            Divider(color: colors.glassBorder),

            Consumer(
              builder: (context, ref, _) {
                final isWindWaveEnabled = ref.watch(
                  windWaveFeatureFlagProvider,
                );
                return SwitchListTile(
                  title: Text(
                    'Kokeelliset Tuuli & Aallokkokiinteistöt',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  subtitle: Text(
                    'Ota käyttöön dynaamiset tuulinuolet & 12h ennusteasteikko',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  value: isWindWaveEnabled,
                  activeThumbColor: colors.primaryAction,
                  onChanged: (_) {
                    SafeHaptics.selection();
                    ref.read(windWaveFeatureFlagProvider.notifier).toggle();
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            _SimpleSlider(
              label: 'Tuuli (Varoitus)',
              value: settings.thresholds.windOrangeMs,
              min: 5,
              max: 30,
              unit: 'm/s',
              onChanged: (v) {
                final newThresholds = settings.thresholds.copyWith(
                  windOrangeMs: v,
                );
                ref
                    .read(skipperSettingsControllerProvider.notifier)
                    .updateSettings(
                      settings.copyWith(thresholds: newThresholds),
                    );
              },
            ),
            ListTile(
              title: Text(
                'Veneen tiedot & syväys',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              subtitle: Text(
                'Aseta aluksen syväys ja mitat',
                style: AppTextStyles.bodySmall.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              leading: Icon(
                Icons.directions_boat_outlined,
                color: colors.primaryAction,
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: colors.textSecondary,
              ),
              onTap: () => context.push('/vessel-settings'),
            ),
            ListTile(
              title: Text(
                'Kipparin asetukset',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              subtitle: Text(
                'Muokkaa hälytysrajoja ja profiilia',
                style: AppTextStyles.bodySmall.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              leading: Icon(
                Icons.tune_outlined,
                color: colors.primaryAction,
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: colors.textSecondary,
              ),
              onTap: () => context.push('/skipper-settings'),
            ),
          ],
        );
      },
    );
  }
}

class _LayoutSelection extends ConsumerWidget {
  const _LayoutSelection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLayout = ref.watch(uiLayoutControllerProvider);
    final notifier = ref.read(uiLayoutControllerProvider.notifier);

    return Column(
      children: [
        _LayoutOption(
          title: 'Ghost (Minimalistinen)',
          subtitle: 'Maksimaalinen karttatila, ohuet HUD-elementit.',
          icon: Icons.auto_awesome_motion_outlined,
          isSelected: currentLayout == UiLayout.ghost,
          onTap: () => notifier.setLayout(UiLayout.ghost),
        ),
        _LayoutOption(
          title: 'Classic (Lasi)',
          subtitle: 'Perinteiset, selkeät HUD-laatikot.',
          icon: Icons.dashboard_customize_outlined,
          isSelected: currentLayout == UiLayout.classic,
          onTap: () => notifier.setLayout(UiLayout.classic),
        ),
        _LayoutOption(
          title: 'Command Bar (Yhtenäinen)',
          subtitle: 'Kaikki tieto yhdellä palkilla yläreunassa.',
          icon: Icons.view_headline_rounded,
          isSelected: currentLayout == UiLayout.commandBar,
          onTap: () => notifier.setLayout(UiLayout.commandBar),
        ),
        _LayoutOption(
          title: 'Horizon 3D (Horisonttikapteeni)',
          subtitle: 'Optimoitu 3D-perspektiivinäkymälle, avoin horisontti.',
          icon: Icons.threed_rotation,
          isSelected: currentLayout == UiLayout.horizon3D,
          onTap: () => notifier.setLayout(UiLayout.horizon3D),
        ),
        _LayoutOption(
          title: 'Omni (Tehokäyttäjä)',
          subtitle: 'Kelluva kerrosnappula + yhtenäinen hallintapaneeli.',
          icon: Icons.diamond_outlined,
          isSelected: currentLayout == UiLayout.omni,
          onTap: () => notifier.setLayout(UiLayout.omni),
        ),
      ],
    );
  }
}

class _LayoutOption extends StatelessWidget {
  const _LayoutOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? colors.primaryAction : colors.textSecondary,
      ),
      title: Text(
        title,
        style: AppTextStyles.body.copyWith(
          color: isSelected ? colors.primaryAction : colors.textPrimary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.caption.copyWith(color: colors.textSecondary),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: colors.primaryAction)
          : null,
      onTap: () {
        SafeHaptics.medium();
        onTap();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: isSelected
          ? colors.primaryAction.withValues(alpha: 0.08)
          : Colors.transparent,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Text(
        title.toUpperCase(),
        style: AppTextStyles.caption.copyWith(
          color: colors.primaryAction,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _SimpleSlider extends StatelessWidget {
  const _SimpleSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.unit,
    required this.onChanged,
  });
  final String label;
  final double value;
  final double min;
  final double max;
  final String unit;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppTextStyles.body.copyWith(color: colors.textPrimary),
              ),
              Text(
                '${value.toStringAsFixed(1)} $unit',
                style: AppTextStyles.mono.copyWith(color: colors.textPrimary),
              ),
            ],
          ),
        ),
        Slider.adaptive(
          value: value,
          min: min,
          max: max,
          activeColor: colors.primaryAction,
          inactiveColor: colors.surfaceHighlight,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _ThemeSelection extends ConsumerWidget {
  const _ThemeSelection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(appThemeControllerProvider);
    final notifier = ref.read(appThemeControllerProvider.notifier);

    return themeModeAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text('Virhe: $e'),
      data: (currentMode) {
        return Column(
          children: [
            _ThemeOption(
              title: 'Yökapteeni (OLED Tumma)',
              subtitle:
                  'Aito musta pohja, säästää akkua ja pimeänäköä pimeässä.',
              icon: Icons.brightness_3,
              iconColor: const Color(0xFF22D3EE),
              isSelected: currentMode == AppThemeMode.nightCaptain,
              onTap: () => notifier.setTheme(AppThemeMode.nightCaptain),
            ),
            _ThemeOption(
              title: 'Päivänpaiste (Häikäisysuoja)',
              subtitle:
                  'Ultrakorkea kontrasti suoraan auringonpaisteeseen vesillä.',
              icon: Icons.wb_sunny,
              iconColor: const Color(0xFFD97706),
              isSelected: currentMode == AppThemeMode.solarFlare,
              onTap: () => notifier.setTheme(AppThemeMode.solarFlare),
            ),
            _ThemeOption(
              title: 'Syvä meri (Kipparin Dashboard)',
              subtitle:
                  'Merellinen tummansininen karttaplotteriteema kuparilla.',
              icon: Icons.sailing,
              iconColor: const Color(0xFF0EA5E9),
              isSelected: currentMode == AppThemeMode.deepSea,
              onTap: () => notifier.setTheme(AppThemeMode.deepSea),
            ),
            _ThemeOption(
              title: 'Revontulet (Boreaali)',
              subtitle:
                  'Moderni lasiohjaamo, loistava revontulenvihreä ja pohjoinen pimeys.',
              icon: Icons.lens_blur,
              iconColor: const Color(0xFF10B981),
              isSelected: currentMode == AppThemeMode.borealAurora,
              onTap: () => notifier.setTheme(AppThemeMode.borealAurora),
            ),
            _ThemeOption(
              title: 'Punainen yövahti (IMO/IEC 62288)',
              subtitle:
                  'Matalaluminanssinen punainen yövalo kompassikannelle ja pimeään.',
              icon: Icons.nightlight_round,
              iconColor: const Color(0xFFEF4444),
              isSelected: currentMode == AppThemeMode.redWatch,
              onTap: () => notifier.setTheme(AppThemeMode.redWatch),
            ),
          ],
        );
      },
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final themeColors = context.colors;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? iconColor : themeColors.textSecondary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected
              ? themeColors.primaryAction
              : themeColors.textPrimary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: themeColors.textSecondary, fontSize: 11),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: themeColors.primaryAction)
          : null,
      onTap: () {
        SafeHaptics.medium();
        onTap();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: isSelected
          ? themeColors.primaryAction.withValues(alpha: 0.05)
          : Colors.transparent,
    );
  }
}

class _UnitSelection extends ConsumerWidget {
  const _UnitSelection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColors = context.colors;
    final UnitSettings unitSettings = ref.watch(unitPreferencesProvider);
    final UnitPreferencesNotifier notifier = ref.read(
      unitPreferencesProvider.notifier,
    );

    return Container(
      decoration: BoxDecoration(
        color: themeColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: themeColors.glassBorder),
      ),
      child: Column(
        children: [
          // Speed Unit
          ListTile(
            leading: Icon(Icons.speed, color: themeColors.primaryAction),
            title: Text(
              'Veneen nopeusyksikkö',
              style: AppTextStyles.body.copyWith(
                color: themeColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              unitSettings.speedUnit.label,
              style: AppTextStyles.caption.copyWith(
                color: themeColors.textSecondary,
              ),
            ),
            trailing: DropdownButton<SpeedUnit>(
              value: unitSettings.speedUnit,
              dropdownColor: themeColors.surface,
              underline: const SizedBox.shrink(),
              icon: Icon(
                Icons.arrow_drop_down,
                color: themeColors.primaryAction,
              ),
              items: SpeedUnit.values.map((unit) {
                return DropdownMenuItem(
                  value: unit,
                  child: Text(
                    unit.symbol,
                    style: TextStyle(
                      color: themeColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newUnit) {
                if (newUnit != null) {
                  SafeHaptics.light();
                  notifier.setSpeedUnit(newUnit);
                }
              },
            ),
          ),
          Divider(color: themeColors.glassBorder, height: 1),

          // Wind Speed Unit
          ListTile(
            leading: Icon(Icons.air, color: themeColors.primaryAction),
            title: Text(
              'Tuulen nopeusyksikkö',
              style: AppTextStyles.body.copyWith(
                color: themeColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              unitSettings.windSpeedUnit.label,
              style: AppTextStyles.caption.copyWith(
                color: themeColors.textSecondary,
              ),
            ),
            trailing: DropdownButton<WindSpeedUnit>(
              value: unitSettings.windSpeedUnit,
              dropdownColor: themeColors.surface,
              underline: const SizedBox.shrink(),
              icon: Icon(
                Icons.arrow_drop_down,
                color: themeColors.primaryAction,
              ),
              items: WindSpeedUnit.values.map((unit) {
                return DropdownMenuItem(
                  value: unit,
                  child: Text(
                    unit.symbol,
                    style: TextStyle(
                      color: themeColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newUnit) {
                if (newUnit != null) {
                  SafeHaptics.light();
                  notifier.setWindSpeedUnit(newUnit);
                }
              },
            ),
          ),
          Divider(color: themeColors.glassBorder, height: 1),

          // Depth Unit
          ListTile(
            leading: Icon(Icons.water, color: themeColors.primaryAction),
            title: Text(
              'Syvyysyksikkö',
              style: AppTextStyles.body.copyWith(
                color: themeColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              unitSettings.depthUnit.label,
              style: AppTextStyles.caption.copyWith(
                color: themeColors.textSecondary,
              ),
            ),
            trailing: DropdownButton<DepthUnit>(
              value: unitSettings.depthUnit,
              dropdownColor: themeColors.surface,
              underline: const SizedBox.shrink(),
              icon: Icon(
                Icons.arrow_drop_down,
                color: themeColors.primaryAction,
              ),
              items: DepthUnit.values.map((unit) {
                return DropdownMenuItem(
                  value: unit,
                  child: Text(
                    unit.symbol,
                    style: TextStyle(
                      color: themeColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newUnit) {
                if (newUnit != null) {
                  SafeHaptics.light();
                  notifier.setDepthUnit(newUnit);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
