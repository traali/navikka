import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:sakkoja/core/providers/logging_provider.dart';
import 'package:sakkoja/core/settings/presentation/providers/ai_settings_provider.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/utils/build_info.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/core/utils/web_helper.dart';
import 'package:sakkoja/core/widgets/debug_log_box.dart';
import 'package:sakkoja/features/ai/presentation/widgets/voice_copilot_mic_button.dart';
import 'package:sakkoja/features/ai/presentation/widgets/wave_impact_hud_widget.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_data_providers.dart';
import 'package:sakkoja/features/fishing/presentation/widgets/fishing_hud.dart';
import 'package:sakkoja/features/map/presentation/controllers/offline_download_controller.dart';
import 'package:sakkoja/features/map/presentation/providers/feature_flag_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/layer_filter_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/offline_selection_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/ui_layout_provider.dart';
import 'package:sakkoja/features/map/presentation/widgets/area_selection_overlay.dart';
import 'package:sakkoja/features/map/presentation/widgets/boating_hud_widget.dart';
import 'package:sakkoja/features/map/presentation/widgets/bottom_telemetry_dock.dart';
import 'package:sakkoja/features/map/presentation/widgets/debug_bbox_widget.dart';
import 'package:sakkoja/features/map/presentation/widgets/location_indicator.dart';
import 'package:sakkoja/features/map/presentation/widgets/map_content.dart';
import 'package:sakkoja/features/map/presentation/widgets/map_controls.dart';
import 'package:sakkoja/features/map/presentation/widgets/map_hud_layer.dart';
import 'package:sakkoja/features/map/presentation/widgets/map_version_overlay.dart';
import 'package:sakkoja/features/map/presentation/widgets/unified_top_capsule.dart';
import 'package:sakkoja/features/weather/presentation/widgets/weather_legend.dart';
import 'package:sakkoja/features/weather/presentation/widgets/weather_time_slider.dart';
import 'package:sakkoja/l10n/app_localizations.dart';

// DEVIATION: Using ConsumerStatefulWidget to manage AnimationController and MapController lifecycle.
// Clean alternative would require excessive boilerplate with no practical benefit.
class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({
    super.key,
    this.tileProvider,
    this.showDebugOverlay = kDebugMode,
  });
  final TileProvider? tileProvider;
  final bool showDebugOverlay;

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen>
    with TickerProviderStateMixin {
  final MapController _mapController = MapController();

  // Animation controllers for entrance effects
  late AnimationController _entranceController;
  late Animation<double> _entranceAnimation;

  // Version visibility state
  bool _showVersion = kDebugMode;
  int _logoTapCount = 0;
  DateTime? _lastLogoTap;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _entranceAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutBack,
    );

    if (WebHelper.isLocal() || kDebugMode) {
      _showVersion = true;
    }

    BuildInfo.printToConsole();

    // Pre-warm fishing data after first frame is rendered
    // (much faster than arbitrary 2-second delay)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        try {
          ref.read(hybridFishingRestrictionsProvider);
          Log.d('Pre-warming fishing restrictions data...');
        } catch (e, s) {
          Log.w('Failed to pre-warm fishing data', e, s);
        }
      }
    });
  }

  @override
  void dispose() {
    _mapController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  void _handleLogoTap() {
    final now = DateTime.now();
    if (_lastLogoTap == null ||
        now.difference(_lastLogoTap!) > const Duration(milliseconds: 500)) {
      _logoTapCount = 1;
    } else {
      _logoTapCount++;
    }
    _lastLogoTap = now;

    if (_logoTapCount >= 3) {
      setState(() {
        _showVersion = !_showVersion;
        _logoTapCount = 0;
      });
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.buildInfo(_showVersion ? 'ON' : 'OFF')),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSelectingArea = ref.watch(offlineSelectionModeProvider);
    final selectionBounds = ref.watch(selectionBoundsProvider);

    // Onboarding for Ghost Layout & Console Logging for Ulkoasu Changes
    ref.listen(uiLayoutControllerProvider, (previous, next) {
      Log.i('[Ulkoasu] Map UI layout changed: $previous -> $next');
      if (next == UiLayout.ghost && previous != UiLayout.ghost) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Ghost HUD aktivoitu. Voit muuttaa ulkoasua valikosta.',
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.9),

            action: SnackBarAction(
              label: 'VALIKKO',
              textColor: AppPalette.textPrimary,
              onPressed: () => context.go('/menu'),
            ),
          ),
        );
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          // 1. Map Content
          MapContent(
            mapController: _mapController,
            tileProvider: widget.tileProvider,
          ),

          // Center Crosshair
          const LocationIndicator(),

          // 2. Fishing HUD
          const FishingHUD(),

          // 2b. Boating Navigation HUD
          const BoatingHudWidget(),

          // 3. HUD Layer
          MapHudLayer(
            entranceController: _entranceController,
            entranceAnimation: _entranceAnimation,
          ),

          // 4. Controls Layer
          MapControls(
            mapController: _mapController,
            entranceController: _entranceController,
          ),

          // 4b. Single Unified Top Header Capsule (Collision-free)
          Consumer(
            builder: (context, ref, _) {
              final layout = ref.watch(uiLayoutControllerProvider);
              if (layout == UiLayout.ghost || layout == UiLayout.commandBar) {
                return const SizedBox.shrink();
              }
              return Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: UnifiedTopCapsule(
                  onSelectLocation: (target) {
                    _mapController.move(target, 14.5);
                  },
                ),
              );
            },
          ),

          // 4c. Floating Bottom Telemetry & AIS Watermark Dock (Non-occluding)
          Consumer(
            builder: (context, ref, _) {
              final layout = ref.watch(uiLayoutControllerProvider);
              if (layout == UiLayout.ghost || layout == UiLayout.commandBar) {
                return const SizedBox.shrink();
              }
              return const Positioned(
                bottom: 72,
                left: 12,
                right: 72, // Leave space for FAB rail
                child: BottomTelemetryDock(),
              );
            },
          ),

          // 4c-2. Voice Marine Copilot ("Hei Kippari") FAB
          Consumer(
            builder: (context, ref, _) {
              final isVoiceEnabled = ref.watch(
                aiSettingsProvider.select((s) => s.voiceCopilotEnabled),
              );
              if (!isVoiceEnabled) return const SizedBox.shrink();
              return const Positioned(
                bottom: 140,
                right: 14,
                child: VoiceCopilotMicButton(),
              );
            },
          ),

          // 4c-3. Wave Roughness & Hull Slamming AI HUD Pill
          Consumer(
            builder: (context, ref, _) {
              final isWaveImpactEnabled = ref.watch(
                aiSettingsProvider.select((s) => s.waveImpactAiEnabled),
              );
              if (!isWaveImpactEnabled) return const SizedBox.shrink();
              return const Positioned(
                bottom: 140,
                left: 14,
                child: WaveImpactHudWidget(),
              );
            },
          ),

          // 4d. Floating Forecast Time Slider (when Wind/Wave Feature Flag is enabled)
          Consumer(
            builder: (context, ref, _) {
              final isFlagEnabled = ref.watch(windWaveFeatureFlagProvider);
              final layerFilter = ref.watch(layerFilterProvider).value;
              final isWindOrWaveActive =
                  isFlagEnabled &&
                  (layerFilter?.showWindLayer == true ||
                      layerFilter?.showWaveLayer == true);

              if (!isWindOrWaveActive) return const SizedBox.shrink();

              return const Positioned(
                bottom: 165,
                left: 12,
                right: 72,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WeatherLegend(),
                    SizedBox(height: 6),
                    WeatherTimeSlider(),
                  ],
                ),
              );
            },
          ),

          // 5. Debug Overlays
          if (widget.showDebugOverlay)
            Positioned(
              top: 60,
              left: 16,
              right: 16,
              child: Consumer(
                builder: (context, ref, _) {
                  final loc = ref.watch(
                    mapProvider.select((s) => s.userLocation),
                  );
                  final hasLoc = ref.watch(
                    mapProvider.select((s) => s.hasLocation),
                  );
                  return DebugBBoxWidget(userLocation: hasLoc ? loc : null);
                },
              ),
            ),

          Positioned(
            top: 150,
            left: 0,
            right: 0,
            child: Consumer(
              builder: (context, ref, _) {
                final logLevel = ref.watch(logLevelProvider);
                if (logLevel != Level.debug) return const SizedBox.shrink();
                return const DebugLogBox();
              },
            ),
          ),

          // 6. Version Overlay & Secret Toggle
          MapVersionOverlay(isVisible: _showVersion, onTap: _handleLogoTap),

          // 7. Offline Area Selection UI
          if (isSelectingArea)
            AreaSelectionOverlay(
              bounds: selectionBounds ?? _mapController.camera.visibleBounds,
              onCancel: () =>
                  ref.read(offlineSelectionModeProvider.notifier).disable(),
              onConfirm: (bounds) => ref
                  .read(offlineDownloadControllerProvider.notifier)
                  .startDownload(context: context, bounds: bounds),
            ),
        ],
      ),
    );
  }
}
