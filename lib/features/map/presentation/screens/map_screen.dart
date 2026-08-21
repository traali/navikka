import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:sakkoja/core/providers/logging_provider.dart';
import 'package:sakkoja/core/services/wakelock_service.dart';
import 'package:sakkoja/core/settings/presentation/providers/ai_settings_provider.dart';
import 'package:sakkoja/core/settings/presentation/providers/ui_element_preferences_provider.dart';
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
import 'package:sakkoja/features/map/presentation/providers/map_auto_follow_provider.dart';
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
import 'package:sakkoja/features/tracking/presentation/providers/active_track_provider.dart';
import 'package:sakkoja/features/tracking/presentation/widgets/voyage_recorder_hud.dart';
import 'package:sakkoja/features/weather/presentation/widgets/weather_legend.dart';
import 'package:sakkoja/features/weather/presentation/widgets/weather_time_slider.dart';
import 'package:sakkoja/l10n/app_localizations.dart';

// DEVIATION: Using ConsumerStatefulWidget to manage AnimationController and MapController lifecycle.
// Clean alternative would require excessive boilerplate with no practical benefit.
class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({
    super.key,
    this.tileProvider,
    this.showDebugOverlay = false,
    this.useMockLocation = false,
  });
  final TileProvider? tileProvider;
  final bool showDebugOverlay;
  final bool useMockLocation;

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen>
    with TickerProviderStateMixin {
  late final MapController _mapController;

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
    _mapController = MapController();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    _entranceAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );

    if (WebHelper.isLocal() || kDebugMode) {
      _showVersion = true;
    }

    BuildInfo.printToConsole();

    // Pre-warm fishing data after first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _syncWakelock();
        try {
          ref.read(hybridFishingRestrictionsProvider);
          Log.d('Pre-warming fishing restrictions data...');
        } catch (e, s) {
          Log.w('Failed to pre-warm fishing data', e, s);
        }
      }
    });
  }

  void _syncWakelock() {
    final keepAwakePref =
        ref.read(uiElementPreferencesProvider).keepScreenAwake;
    final isFollow = ref.read(mapAutoFollowProvider);
    final isRecording = ref.read(activeTrackProvider).isRecording;
    final mode = ref.read(mapNavigationModeProvider);
    final shouldKeepAwake =
        keepAwakePref &&
        (isFollow || isRecording || mode == MapNavigationMode.boatingHeadingUp);
    WakelockService.setEnabled(shouldKeepAwake);
  }

  @override
  void dispose() {
    WakelockService.disable();
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
    // Synchronize Screen Wake Lock on navigation state changes
    ref.listen(
      uiElementPreferencesProvider.select((s) => s.keepScreenAwake),
      (_, _) => _syncWakelock(),
    );
    ref.listen(mapAutoFollowProvider, (_, _) => _syncWakelock());
    ref.listen(
      activeTrackProvider.select((s) => s.isRecording),
      (_, _) => _syncWakelock(),
    );
    ref.listen(mapNavigationModeProvider, (_, _) => _syncWakelock());

    final isSelectingArea = ref.watch(offlineSelectionModeProvider);
    final selectionBounds = ref.watch(selectionBoundsProvider);

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

          // 2c. Active Voyage Track Recording HUD (REC Pill & Live Odometer)
          const VoyageRecorderHud(),

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
              final showTopCapsule = ref.watch(
                uiElementPreferencesProvider.select((s) => s.showTopCapsule),
              );
              if (!showTopCapsule ||
                  layout == UiLayout.ghost ||
                  layout == UiLayout.commandBar) {
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
              final showVoice = ref.watch(
                uiElementPreferencesProvider.select((s) => s.showVoiceButton),
              );
              if (!isVoiceEnabled || !showVoice) return const SizedBox.shrink();
              return const Positioned(
                bottom: 185,
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
              final showWaveImpact = ref.watch(
                uiElementPreferencesProvider.select((s) => s.showWaveImpactHud),
              );
              if (!isWaveImpactEnabled || !showWaveImpact) {
                return const SizedBox.shrink();
              }
              return const Positioned(
                bottom: 185,
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
