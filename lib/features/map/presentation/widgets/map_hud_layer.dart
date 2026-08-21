import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/settings/presentation/providers/ui_element_preferences_provider.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_mode_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/hud_layout_manager_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/ui_layout_provider.dart';
import 'package:sakkoja/features/map/presentation/widgets/course_hud_widget.dart';
import 'package:sakkoja/features/map/presentation/widgets/horizon3d_hud_assembly.dart';
import 'package:sakkoja/features/map/presentation/widgets/speed_hud_widget.dart';
import 'package:sakkoja/features/map/presentation/widgets/vortex/safety_edge_pulse.dart';
import 'package:sakkoja/features/map/presentation/widgets/vortex/vortex_hud_assembly.dart';
import 'package:sakkoja/features/navigation/presentation/widgets/navigation_guidance_hud.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';
import 'package:sakkoja/features/weather/presentation/widgets/lightning_warning_banner.dart';
import 'package:sakkoja/features/weather/presentation/widgets/weather_alert_badge.dart';
import 'package:sakkoja/features/weather/presentation/widgets/weather_hud_v2.dart';

class MapHudLayer extends ConsumerWidget {
  const MapHudLayer({
    required this.entranceController,
    required this.entranceAnimation,
    super.key,
  });
  final AnimationController entranceController;
  final Animation<double> entranceAnimation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(uiLayoutControllerProvider);
    final hasLocation = ref.watch(mapProvider.select((s) => s.hasLocation));
    final isLocationFresh = ref.watch(
      mapProvider.select((s) => s.isLocationFresh),
    );
    final hasLiveLocation = hasLocation && isLocationFresh;
    final currentSpeed = ref.watch(
      mapProvider.select((s) => s.currentSpeedKmh),
    );
    final currentZone = ref.watch(mapProvider.select((s) => s.currentZone));
    final heading = ref.watch(mapProvider.select((s) => s.heading));
    final isFishingMode =
        ref.watch(fishingModeControllerProvider).value?.isEnabled ?? false;

    void requestGps() {
      ref.read(mapProvider.notifier).requestLocation();
    }

    Widget hudContent;

    if (layout == UiLayout.horizon3D) {
      hudContent = SafetyEdgePulse(
        child: Horizon3dHudAssembly(
          hasLocation: hasLiveLocation,
          currentSpeed: currentSpeed,
          currentZone: currentZone,
          heading: heading,
          isFishingMode: isFishingMode,
          entranceController: entranceController,
          onRequestGps: requestGps,
        ),
      );
    } else if (layout == UiLayout.vortex) {
      hudContent = SafetyEdgePulse(
        child: VortexHudAssembly(
          hasLocation: hasLiveLocation,
          currentSpeed: currentSpeed,
          currentZone: currentZone,
          heading: heading,
          isFishingMode: isFishingMode,
          entranceController: entranceController,
        ),
      );
    } else if (layout == UiLayout.ghost) {
      hudContent = SafetyEdgePulse(
        child: _GhostHudAssembly(
          hasLocation: hasLiveLocation,
          currentSpeed: currentSpeed,
          currentZone: currentZone,
          heading: heading,
          isFishingMode: isFishingMode,
          entranceController: entranceController,
          onRequestGps: requestGps,
        ),
      );
    } else if (layout == UiLayout.commandBar || layout == UiLayout.omni) {
      hudContent = SafetyEdgePulse(
        child: _CommandBarHudAssembly(
          hasLocation: hasLiveLocation,
          currentSpeed: currentSpeed,
          currentZone: currentZone,
          heading: heading,
          isFishingMode: isFishingMode,
          entranceController: entranceController,
          onRequestGps: requestGps,
        ),
      );
    } else {
      hudContent = SafetyEdgePulse(
        child: _ClassicHudAssembly(
          hasLocation: hasLiveLocation,
          currentSpeed: currentSpeed,
          currentZone: currentZone,
          heading: heading,
          isFishingMode: isFishingMode,
          entranceController: entranceController,
          entranceAnimation: entranceAnimation,
          onRequestGps: requestGps,
        ),
      );
    }

    final double topOffset;
    if (layout == UiLayout.ghost) {
      topOffset = MediaQuery.paddingOf(context).top + 64;
    } else if (layout == UiLayout.commandBar || layout == UiLayout.omni) {
      topOffset = MediaQuery.paddingOf(context).top + 68;
    } else {
      topOffset = MediaQuery.paddingOf(context).top + 8;
    }

    return Stack(
      children: [
        hudContent,
        Positioned(
          top: topOffset,
          left: 0,
          right: 0,
          child: const LightningWarningBanner(),
        ),
        Positioned(
          top: MediaQuery.paddingOf(context).top + 112,
          left: 12,
          right: 12,
          child: const Align(
            alignment: Alignment.topCenter,
            child: NavigationGuidanceHud(),
          ),
        ),
      ],
    );
  }
}

class _GhostHudAssembly extends StatelessWidget {
  const _GhostHudAssembly({
    required this.hasLocation,
    required this.currentSpeed,
    required this.currentZone,
    required this.heading,
    required this.isFishingMode,
    required this.entranceController,
    this.onRequestGps,
  });

  final bool hasLocation;
  final double currentSpeed;
  final SpeedLimitZone? currentZone;
  final double heading;
  final bool isFishingMode;
  final AnimationController entranceController;
  final VoidCallback? onRequestGps;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final uiPrefs = ref.watch(uiElementPreferencesProvider);
        return Stack(
          children: [
            Positioned(
              top: MediaQuery.paddingOf(context).top + 8,
              left: 0,
              right: 0,
              child: Center(
                child: FadeTransition(
                  opacity: entranceController,
                  child: const WeatherHudV2(),
                ),
              ),
            ),
            if (uiPrefs.showSpeedHud)
              Positioned(
                bottom: 116,
                left: 12,
                child: FadeTransition(
                  opacity: entranceController,
                  child: SpeedHudWidget(
                    hasLocation: hasLocation,
                    currentSpeedKmh: currentSpeed,
                    speedLimitKmh: currentZone?.speedLimitKmh ?? 0,
                    onRequestGps: onRequestGps,
                  ),
                ),
              ),
            if (hasLocation && uiPrefs.showCompassHud)
              Positioned(
                bottom: 116,
                right: 12,
                child: FadeTransition(
                  opacity: entranceController,
                  child: CourseHudWidget(heading: heading),
                ),
              ),
            Consumer(
              builder: (context, ref, _) {
                final hudMetrics = ref.watch(hudLayoutMetricsProvider);
                return Positioned(
                  top: hudMetrics.badgeTopPadding,
                  left: 12,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.sizeOf(context).width - 96,
                    ),
                    child: const WeatherAlertBadge(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _CommandBarHudAssembly extends StatelessWidget {
  const _CommandBarHudAssembly({
    required this.hasLocation,
    required this.currentSpeed,
    required this.currentZone,
    required this.heading,
    required this.isFishingMode,
    required this.entranceController,
    this.onRequestGps,
  });

  final bool hasLocation;
  final double currentSpeed;
  final SpeedLimitZone? currentZone;
  final double heading;
  final bool isFishingMode;
  final AnimationController entranceController;
  final VoidCallback? onRequestGps;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: FadeTransition(
            opacity: entranceController,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                16,
                MediaQuery.paddingOf(context).top + 12,
                16,
                12,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.7),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!isFishingMode)
                    SpeedHudWidget(
                      hasLocation: hasLocation,
                      currentSpeedKmh: currentSpeed,
                      speedLimitKmh: currentZone?.speedLimitKmh ?? 0,
                      onRequestGps: onRequestGps,
                    )
                  else
                    const SizedBox(width: 120),
                  if (!isFishingMode)
                    const WeatherHudV2()
                  else
                    const SizedBox(width: 200),
                  if (hasLocation) CourseHudWidget(heading: heading),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.paddingOf(context).top + 70,
          left: 16,
          child: const WeatherAlertBadge(),
        ),
      ],
    );
  }
}

class _ClassicHudAssembly extends StatelessWidget {
  const _ClassicHudAssembly({
    required this.hasLocation,
    required this.currentSpeed,
    required this.currentZone,
    required this.heading,
    required this.isFishingMode,
    required this.entranceController,
    required this.entranceAnimation,
    this.onRequestGps,
  });

  final bool hasLocation;
  final double currentSpeed;
  final SpeedLimitZone? currentZone;
  final double heading;
  final bool isFishingMode;
  final AnimationController entranceController;
  final Animation<double> entranceAnimation;
  final VoidCallback? onRequestGps;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.paddingOf(context).top + 64,
          left: 16,
          child: const WeatherAlertBadge(),
        ),
      ],
    );
  }
}
