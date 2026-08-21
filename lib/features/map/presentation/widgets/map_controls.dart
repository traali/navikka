import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sakkoja/core/settings/presentation/providers/ui_element_preferences_provider.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/app_theme.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_mode_provider.dart';
import 'package:sakkoja/features/fishing/presentation/widgets/catch_entry_sheet.dart';
import 'package:sakkoja/features/map/presentation/providers/map_auto_follow_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/ui_layout_provider.dart';
import 'package:sakkoja/features/map/presentation/widgets/glass_icon_button.dart';
import 'package:sakkoja/features/map/presentation/widgets/layers_fab.dart';
import 'package:sakkoja/features/map/presentation/widgets/zoom_controls.dart';
import 'package:sakkoja/features/tracking/presentation/providers/active_track_provider.dart';
import 'package:sakkoja/features/tracking/presentation/widgets/voyage_save_dialog.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';
import 'package:sakkoja/features/weather/presentation/providers/wave_layer_provider.dart';
import 'package:sakkoja/l10n/app_localizations.dart';

class MapControls extends ConsumerWidget {
  const MapControls({
    required this.mapController,
    required this.entranceController,
    super.key,
  });
  final MapController mapController;
  final AnimationController entranceController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(uiLayoutControllerProvider);

    switch (layout) {
      case UiLayout.ghost:
      case UiLayout.vortex:
      case UiLayout.horizon3D:
        return _GhostMapControls(
          mapController: mapController,
          entranceController: entranceController,
        );
      case UiLayout.classic:
      case UiLayout.commandBar:
      case UiLayout.omni:
        return _ClassicMapControls(
          mapController: mapController,
          entranceController: entranceController,
        );
    }
  }
}

class _GhostMapControls extends ConsumerWidget {
  const _GhostMapControls({
    required this.mapController,
    required this.entranceController,
  });
  final MapController mapController;
  final AnimationController entranceController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapAutoFollow = ref.watch(mapAutoFollowProvider);
    final isRadarVisible = ref.watch(
      pointWeatherControllerProvider.select((s) => s.isRadarVisible),
    );
    final isFishingMode = ref.watch(
      fishingModeControllerProvider.select((s) => s.value?.isEnabled ?? false),
    );

    final navMode = ref.watch(mapNavigationModeProvider);

    return Stack(
      children: [
        // GPS / Auto-Follow Center Button & Recenter Banner (Bottom Left)
        Positioned(
          left: 12,
          bottom: 60, // Above bottom bar
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _GhostIconButton(
                color: mapAutoFollow
                    ? context.colors.primaryAction
                    : context.colors.textPrimary.withValues(alpha: 0.7),
                iconWidget: SvgPicture.asset(
                  'assets/icons/nautical/gps_reticle.svg',
                  colorFilter: ColorFilter.mode(
                    mapAutoFollow
                        ? context.colors.primaryAction
                        : context.colors.textPrimary,
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24,
                ),
                onPressed: () {
                  SafeHaptics.medium();
                  ref.read(mapAutoFollowProvider.notifier).enable();
                },
              ),
              if (!mapAutoFollow) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    SafeHaptics.medium();
                    ref.read(mapAutoFollowProvider.notifier).enable();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.primaryAction,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: context.colors.primaryAction.withValues(
                            alpha: 0.4,
                          ),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.navigation_rounded,
                          size: 16,
                          color: context.colors.canvas,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Palaa veneeseen',
                          style: TextStyle(
                            color: context.colors.canvas,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ).animate().fadeIn().scale(),

        // Corner Cluster (Top Right)
        Positioned(
          top: 60,
          right: 12,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ZoomControls(
                onZoomIn: () {
                  SafeHaptics.light();
                  mapController.move(
                    mapController.camera.center,
                    mapController.camera.zoom + 1,
                  );
                },
                onZoomOut: () {
                  SafeHaptics.light();
                  mapController.move(
                    mapController.camera.center,
                    mapController.camera.zoom - 1,
                  );
                },
              ),
              const SizedBox(height: 16),
              const LayersFab(isFloating: false),
              const SizedBox(height: 16),
              _GhostIconButton(
                tooltip: navMode == MapNavigationMode.boatingHeadingUp
                    ? 'Veneilytila (Kulkusuunta)'
                    : 'Pohjoissuunta',
                icon: navMode == MapNavigationMode.boatingHeadingUp
                    ? Icons.navigation_rounded
                    : Icons.explore_outlined,
                color: navMode == MapNavigationMode.boatingHeadingUp
                    ? context.colors.primaryAction
                    : context.colors.textPrimary.withValues(alpha: 0.7),
                onPressed: () {
                  SafeHaptics.light();
                  ref.read(mapNavigationModeProvider.notifier).toggle();
                },
              ),
              const SizedBox(height: 16),
              _GhostIconButton(
                tooltip: 'Säätutka',
                icon: isRadarVisible
                    ? Icons.radar_rounded
                    : Icons.radar_outlined,
                color: isRadarVisible
                    ? context.colors.primaryAction
                    : context.colors.textPrimary.withValues(alpha: 0.7),
                onPressed: () => ref
                    .read(pointWeatherControllerProvider.notifier)
                    .toggleRadar(),
              ),
              const SizedBox(height: 16),
              _GhostIconButton(
                tooltip: 'Kalastustila',
                icon: isFishingMode
                    ? Icons.phishing_rounded
                    : Icons.phishing_outlined,
                color: isFishingMode
                    ? context.colors.warning
                    : context.colors.textPrimary.withValues(alpha: 0.7),
                onPressed: () =>
                    ref.read(fishingModeControllerProvider.notifier).toggle(),
              ),
              const SizedBox(height: 16),
              Consumer(
                builder: (context, ref, _) {
                  final trackState = ref.watch(activeTrackProvider);
                  final isRecording = trackState.isRecording;
                  return _GhostIconButton(
                    tooltip: isRecording
                        ? 'Päätä veneily & tallenna'
                        : 'Aloita veneily (Tallenna reitti)',
                    icon: isRecording
                        ? Icons.stop_circle_rounded
                        : Icons.fiber_manual_record_rounded,
                    color: isRecording
                        ? AppPalette.danger
                        : context.colors.textPrimary.withValues(alpha: 0.8),
                    onPressed: () {
                      SafeHaptics.medium();
                      if (isRecording) {
                        showDialog<void>(
                          context: context,
                          builder: (_) =>
                              VoyageSaveDialog(trackState: trackState),
                        );
                      } else {
                        ref.read(activeTrackProvider.notifier).startRecording();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              '🔴 Veneilyn reittitallennus aloitettu!',
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              _GhostIconButton(
                tooltip: 'Valikko',
                icon: Icons.menu_rounded,
                color: context.colors.primaryAction,
                onPressed: () {
                  SafeHaptics.medium();
                  context.go('/menu');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GhostIconButton extends StatelessWidget {
  const _GhostIconButton({
    required this.onPressed,
    this.icon,
    this.iconWidget,
    this.color,
    this.tooltip,
  });

  final IconData? icon;
  final Widget? iconWidget;
  final VoidCallback onPressed;
  final Color? color;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final iconColor = color ?? colors.textPrimary;
    final isActive =
        color != null && color != colors.textPrimary.withValues(alpha: 0.7);

    return Container(
      decoration: BoxDecoration(
        color: isActive
            ? AppPalette.navikkaSurface.withValues(alpha: 0.9)
            : AppPalette.navikkaCanvas.withValues(alpha: 0.75),
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive
              ? (color ?? AppPalette.navikkaCyanGlow).withValues(alpha: 0.8)
              : colors.glassBorder,
          width: isActive ? 1.5 : 1.0,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: (color ?? AppPalette.navikkaCyanGlow).withValues(
                    alpha: 0.35,
                  ),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: IconButton(
        tooltip: tooltip,
        icon: iconWidget ?? Icon(icon, color: iconColor, size: 22),
        onPressed: () {
          SafeHaptics.light();
          onPressed();
        },
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      ),
    );
  }
}

class _ClassicMapControls extends ConsumerWidget {
  const _ClassicMapControls({
    required this.mapController,
    required this.entranceController,
  });
  final MapController mapController;
  final AnimationController entranceController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRadarVisible = ref.watch(
      pointWeatherControllerProvider.select((s) => s.isRadarVisible),
    );
    final isAnimating = ref.watch(
      pointWeatherControllerProvider.select((s) => s.isAnimating),
    );
    final radarTimestamps = ref.watch(
      pointWeatherControllerProvider.select((s) => s.radarTimestamps),
    );
    final currentIndex = ref.watch(
      pointWeatherControllerProvider.select((s) => s.currentTimestampIndex),
    );
    final mapAutoFollow = ref.watch(mapAutoFollowProvider);
    final isFishingMode = ref.watch(
      fishingModeControllerProvider.select((s) => s.value?.isEnabled ?? false),
    );
    final uiPrefs = ref.watch(uiElementPreferencesProvider);

    return Stack(
      children: [
        // 1. Tool Actions Rail (Upper Right - Scrollable if constrained)
        if (uiPrefs.showToolDock)
          Positioned(
            top: MediaQuery.paddingOf(context).top + 68,
            bottom: 124, // Clear separation above zoom controls
            right: 12,
            child: FadeTransition(
              opacity: entranceController,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GlassIconButton(
                      activeColor: mapAutoFollow
                          ? context.colors.primaryAction
                          : null,
                      iconWidget: SvgPicture.asset(
                        'assets/icons/nautical/gps_reticle.svg',
                        colorFilter: ColorFilter.mode(
                          mapAutoFollow
                              ? context.colors.primaryAction
                              : context.colors.textPrimary,
                          BlendMode.srcIn,
                        ),
                        width: 20,
                        height: 20,
                      ),
                      tooltip: AppLocalizations.of(context)!.recenter,
                      onPressed: () =>
                          ref.read(mapAutoFollowProvider.notifier).enable(),
                    ),
                    const SizedBox(height: 8),
                    Consumer(
                      builder: (context, ref, _) {
                        final navMode = ref.watch(mapNavigationModeProvider);
                        final isHeadingUp =
                            navMode == MapNavigationMode.boatingHeadingUp;
                        return GlassIconButton(
                          icon: isHeadingUp
                              ? Icons.navigation_rounded
                              : Icons.explore_outlined,
                          tooltip: isHeadingUp
                              ? 'Veneilytila (Kulkusuunta)'
                              : 'Pohjoissuunta',
                          activeColor: isHeadingUp
                              ? context.colors.primaryAction
                              : null,
                          onPressed: () {
                            SafeHaptics.medium();
                            ref
                                .read(mapNavigationModeProvider.notifier)
                                .toggle();
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    Consumer(
                      builder: (context, ref, _) {
                        final isWaveActive = ref.watch(waveLayerProvider);
                        return GlassIconButton(
                          icon: Icons.waves,
                          tooltip: 'Aallokkokartta',
                          activeColor: isWaveActive
                              ? context.colors.primaryAction
                              : null,
                          onPressed: () {
                            SafeHaptics.selection();
                            ref.read(waveLayerProvider.notifier).toggle();
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    if (!isFishingMode &&
                        isRadarVisible &&
                        radarTimestamps.isNotEmpty) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: context.colors.surface.withValues(
                            alpha: 0.7,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: context.colors.glassBorder,
                          ),
                        ),
                        child: Text(
                          () {
                            final time = radarTimestamps[currentIndex];
                            final localTime = time.toLocal();
                            return "${localTime.hour}:${localTime.minute.toString().padLeft(2, '0')}";
                          }(),
                          style: AppTheme.kData.copyWith(
                            color: context.colors.textPrimary,
                            fontSize: 12,
                            fontFeatures: const [
                              FontFeature.tabularFigures(),
                            ],
                          ),
                        ),
                      ).animate().fadeIn(duration: 200.ms).slideX(begin: 0.2, end: 0),
                      const SizedBox(height: 6),
                      GlassIconButton(
                        icon: isAnimating
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        tooltip: isAnimating
                            ? AppLocalizations.of(context)!.pause
                            : AppLocalizations.of(context)!.play,
                        onPressed: () => ref
                            .read(pointWeatherControllerProvider.notifier)
                            .toggleAnimation(),
                      ),
                      const SizedBox(height: 6),
                    ],
                    if (isFishingMode) ...[
                      GlassIconButton(
                        icon: Icons.add_circle_rounded,
                        tooltip: 'Lisää saalis',
                        iconColor: context.colors.textPrimary,
                        activeColor: context.colors.warning,
                        onPressed: () {
                          SafeHaptics.medium();
                          final location = ref.read(mapProvider).userLocation;
                          showModalBottomSheet<void>(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (context) =>
                                CatchEntrySheet(location: location),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                    ],
                    GlassIconButton(
                      icon: Icons.phishing_rounded,
                      tooltip: AppLocalizations.of(context)!.fishingMode,
                      activeColor: isFishingMode
                          ? context.colors.primaryAction
                          : null,
                      onPressed: () {
                        SafeHaptics.medium();
                        ref
                            .read(fishingModeControllerProvider.notifier)
                            .toggle();
                      },
                    ),
                    const SizedBox(height: 8),
                    if (uiPrefs.showVoyageRecordButton) ...[
                      Consumer(
                        builder: (context, ref, _) {
                          final trackState = ref.watch(activeTrackProvider);
                          final isRecording = trackState.isRecording;
                          return GlassIconButton(
                            icon: isRecording
                                ? Icons.stop_circle_rounded
                                : Icons.fiber_manual_record_rounded,
                            tooltip: isRecording
                                ? 'Päätä veneily & tallenna'
                                : 'Aloita veneily (Tallenna reitti)',
                            iconColor: isRecording
                                ? AppPalette.danger
                                : context.colors.textPrimary,
                            activeColor: isRecording ? AppPalette.danger : null,
                            onPressed: () {
                              SafeHaptics.medium();
                              if (isRecording) {
                                showDialog<void>(
                                  context: context,
                                  builder: (_) =>
                                      VoyageSaveDialog(trackState: trackState),
                                );
                              } else {
                                ref
                                    .read(activeTrackProvider.notifier)
                                    .startRecording();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      '🔴 Veneilyn reittitallennus aloitettu!',
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                    ],
                    GlassIconButton(
                      icon: Icons.route_rounded,
                      tooltip: AppLocalizations.of(context)!.routePlanner,
                      onPressed: () {
                        SafeHaptics.medium();
                        context.push('/route-planner');
                      },
                    ),
                    const SizedBox(height: 6),
                    GlassIconButton(
                      icon: Icons.radar_rounded,
                      tooltip: AppLocalizations.of(context)!.radar,
                      activeColor: isRadarVisible
                          ? context.colors.primaryAction
                          : null,
                      onPressed: () => ref
                          .read(pointWeatherControllerProvider.notifier)
                          .toggleRadar(),
                    ),
                    const SizedBox(height: 6),
                    const LayersFab(isFloating: false),
                  ],
                ),
              ),
            ),
          ),

        // 2. Fixed Zoom Controls (Bottom Right - Never covered)
        if (uiPrefs.showZoomButtons)
          Positioned(
            bottom: 16,
            right: 12,
            child: FadeTransition(
              opacity: entranceController,
              child: ZoomControls(
                onZoomIn: () {
                  SafeHaptics.light();
                  mapController.move(
                    mapController.camera.center,
                    mapController.camera.zoom + 1,
                  );
                },
                onZoomOut: () {
                  SafeHaptics.light();
                  mapController.move(
                    mapController.camera.center,
                    mapController.camera.zoom - 1,
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
