import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/core/services/geometry_utils.dart';
import 'package:sakkoja/core/theme/app_theme.dart';
import 'package:sakkoja/features/ais/presentation/widgets/ais_map_layer_widget.dart';
import 'package:sakkoja/features/contribution/domain/entities/user_contribution.dart';
import 'package:sakkoja/features/contribution/presentation/providers/contribution_provider.dart';
import 'package:sakkoja/features/fishing/domain/entities/fishing_restriction.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_data_providers.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_mode_provider.dart';
import 'package:sakkoja/features/harbors/presentation/widgets/harbors_map_layer_widget.dart';
import 'package:sakkoja/features/map/data/services/map_config_service.dart';
import 'package:sakkoja/features/map/domain/entities/map_state.dart';
import 'package:sakkoja/features/map/presentation/providers/layer_filter_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_auto_follow_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_layers_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/map/presentation/widgets/berthing_tactical_grid_layer.dart';
import 'package:sakkoja/features/map/presentation/widgets/boat_marker.dart';
import 'package:sakkoja/features/map/presentation/widgets/drift_tile_provider.dart';
import 'package:sakkoja/features/map/presentation/widgets/fishing_layers.dart';
import 'package:sakkoja/features/map/presentation/widgets/fishing_restriction_detail_sheet.dart';
import 'package:sakkoja/features/map/presentation/widgets/scale_bar_widget.dart';
import 'package:sakkoja/features/navigation/presentation/providers/navigation_providers.dart';
import 'package:sakkoja/features/navigation_aids/presentation/widgets/navigation_aids_layer_widget.dart';
import 'package:sakkoja/features/speed_limits/presentation/providers/speed_alert_notifier.dart';
import 'package:sakkoja/features/tracking/presentation/widgets/track_layer.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';
import 'package:sakkoja/features/weather/presentation/widgets/algae_marker_layer.dart';
import 'package:sakkoja/features/weather/presentation/widgets/algae_wms_layer.dart';
import 'package:sakkoja/features/weather/presentation/widgets/wave_map_layer_widget.dart';
import 'package:sakkoja/features/weather/presentation/widgets/weather_lightning_layer.dart';
import 'package:sakkoja/features/weather/presentation/widgets/weather_radar_layer.dart';
import 'package:sakkoja/features/weather/presentation/widgets/wind_layer_widget.dart';

class MapContent extends ConsumerStatefulWidget {
  const MapContent({required this.mapController, super.key, this.tileProvider});
  final MapController mapController;
  final TileProvider? tileProvider;

  @override
  ConsumerState<MapContent> createState() => _MapContentState();
}

class _MapContentState extends ConsumerState<MapContent> {
  bool _hasCentered = false;
  Timer? _autoReturnTimer;

  @override
  void dispose() {
    _autoReturnTimer?.cancel();
    super.dispose();
  }

  /// Stable TileProvider — created once, reused across rebuilds.
  /// Uses `ref.read` (not `ref.watch`) because [appDatabaseProvider] and
  /// [tileDioProvider] are both `keepAlive` singletons so reactive watching
  /// is unnecessary overhead.
  late final TileProvider _tileProvider =
      widget.tileProvider ??
      DriftTileProvider(
        tileDao: ref.read(appDatabaseProvider).tileDao,
        dio: ref.read(tileDioProvider),
        userAgent: 'com.marinesafety.sakkoja',
      );

  /// Calculates camera target based on navigation mode (North-Up vs Boating Heading-Up)
  LatLng _calculateTargetCenter({
    required LatLng userLocation,
    required double heading,
    required double zoom,
    required MapNavigationMode mode,
    required double currentSpeedKmh,
    required double screenHeight,
    bool is3dTilt = false,
  }) {
    if (mode == MapNavigationMode.northUp) {
      return userLocation;
    }

    // In Boating Mode (Heading-Up), offset the camera center forward along heading.
    // In 3D perspective mode, the lookahead offset is enlarged so the vessel sits
    // gracefully in the stern/lower region while maximizing view of the forward horizon.
    final latitudeRad = userLocation.latitude * (math.pi / 180);
    final metersPerPixel =
        (156543.03392 * math.cos(latitudeRad)) / math.pow(2, zoom);
    final h = screenHeight > 0 ? screenHeight : 750.0;
    final speedMultiplier = 1.0 + (currentSpeedKmh / 30.0).clamp(0.0, 1.0);
    final baseOffsetRatio = is3dTilt ? 0.35 : 0.25;
    final pixelOffset = h * baseOffsetRatio * speedMultiplier;
    final forwardOffsetMeters = (pixelOffset * metersPerPixel).clamp(
      15.0,
      2500.0,
    );

    return const Distance().offset(userLocation, forwardOffsetMeters, heading);
  }

  void _onMapChange(MapState? previous, MapState next) {
    if (!next.hasLocation) return;
    final navigationPoseChanged =
        previous == null ||
        previous.userLocation != next.userLocation ||
        previous.heading != next.heading;
    if (!navigationPoseChanged) return;

    final isFirstFix = !_hasCentered;
    if (isFirstFix) {
      setState(() => _hasCentered = true);
      ref.read(mapAutoFollowProvider.notifier).enable();
    }

    if (isFirstFix || ref.read(mapAutoFollowProvider)) {
      final mode = ref.read(mapNavigationModeProvider);
      final is3dTilt = ref.read(map3dTiltProvider);
      final targetRotation = mode == MapNavigationMode.boatingHeadingUp
          ? -next.heading
          : 0.0;
      final speedKmh = next.currentSpeedKmh;
      final dynamicZoom = (15.5 - (speedKmh / 18.0).clamp(0.0, 2.5)).clamp(
        13.0,
        15.5,
      );
      final mediaSize = MediaQuery.maybeOf(context)?.size;
      final targetCenter = _calculateTargetCenter(
        userLocation: next.userLocation,
        heading: next.heading,
        zoom: dynamicZoom,
        mode: mode,
        currentSpeedKmh: speedKmh,
        screenHeight: mediaSize?.height ?? 750.0,
        is3dTilt: is3dTilt,
      );

      widget.mapController.moveAndRotate(
        targetCenter,
        dynamicZoom,
        targetRotation,
      );
    }
  }

  void _onAutoFollowChange(bool? previous, bool next) {
    if (!next || previous == true) return;
    final hasLocation = ref.read(mapProvider.select((s) => s.hasLocation));
    if (!hasLocation) return;
    final mapState = ref.read(mapProvider);
    final mode = ref.read(mapNavigationModeProvider);
    final is3dTilt = ref.read(map3dTiltProvider);
    final targetRotation = mode == MapNavigationMode.boatingHeadingUp
        ? -mapState.heading
        : 0.0;
    final mediaSize = MediaQuery.maybeOf(context)?.size;
    final targetCenter = _calculateTargetCenter(
      userLocation: mapState.userLocation,
      heading: mapState.heading,
      zoom: 14.5,
      mode: mode,
      currentSpeedKmh: mapState.currentSpeedKmh,
      screenHeight: mediaSize?.height ?? 750.0,
      is3dTilt: is3dTilt,
    );
    widget.mapController.moveAndRotate(targetCenter, 14.5, targetRotation);
  }

  void _onNavigationModeChange(
    MapNavigationMode? previous,
    MapNavigationMode next,
  ) {
    if (previous == next) return;
    final hasLocation = ref.read(mapProvider.select((s) => s.hasLocation));
    if (!hasLocation) return;
    final mapState = ref.read(mapProvider);
    final is3dTilt = ref.read(map3dTiltProvider);
    final targetRotation = next == MapNavigationMode.boatingHeadingUp
        ? -mapState.heading
        : 0.0;
    final mediaSize = MediaQuery.maybeOf(context)?.size;
    final targetCenter = _calculateTargetCenter(
      userLocation: mapState.userLocation,
      heading: mapState.heading,
      zoom: 14.5,
      mode: next,
      currentSpeedKmh: mapState.currentSpeedKmh,
      screenHeight: mediaSize?.height ?? 750.0,
      is3dTilt: is3dTilt,
    );
    widget.mapController.moveAndRotate(targetCenter, 14.5, targetRotation);
  }

  void _on3dTiltChange(bool? previous, bool next) {
    if (previous == next) return;
    final hasLocation = ref.read(mapProvider.select((s) => s.hasLocation));
    if (!hasLocation) return;
    final mapState = ref.read(mapProvider);
    final mode = ref.read(mapNavigationModeProvider);
    final targetRotation = mode == MapNavigationMode.boatingHeadingUp
        ? -mapState.heading
        : 0.0;
    final mediaSize = MediaQuery.maybeOf(context)?.size;
    final speedKmh = mapState.currentSpeedKmh;
    final dynamicZoom = (15.5 - (speedKmh / 18.0).clamp(0.0, 2.5)).clamp(
      13.0,
      15.5,
    );
    final targetCenter = _calculateTargetCenter(
      userLocation: mapState.userLocation,
      heading: mapState.heading,
      zoom: dynamicZoom,
      mode: mode,
      currentSpeedKmh: speedKmh,
      screenHeight: mediaSize?.height ?? 750.0,
      is3dTilt: next,
    );
    widget.mapController.moveAndRotate(
      targetCenter,
      dynamicZoom,
      targetRotation,
    );
  }

  void _resetAutoReturnTimer() {
    _autoReturnTimer?.cancel();
    _autoReturnTimer = Timer(const Duration(seconds: 10), () {
      if (!mounted) return;
      final speedKmh = ref.read(mapProvider.select((s) => s.currentSpeedKmh));
      if (!ref.read(mapAutoFollowProvider) && speedKmh > 2.0) {
        ref.read(mapAutoFollowProvider.notifier).enable();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. Watch minimal state for map configuration
    final initialLocation = ref.read(mapProvider).userLocation;

    // 2. Watch Layers
    // PERFORMANCE: Use memoized providers to avoid re-creating widgets/models on every frame
    final speedLimitPolygons = ref.watch(memoizedSpeedLimitPolygonsProvider);
    // Watch map settings and camera state
    // PERFORMANCE: Use select() to only rebuild when specific values change
    // Note: contributions are watched inside _ContributionMarkerLayer, not here.
    final lightningStrikes = ref.watch(
      pointWeatherControllerProvider.select((state) => state.lightningStrikes),
    );
    final isFishingMode = ref.watch(
      fishingModeControllerProvider.select((s) => s.value?.isEnabled ?? false),
    );
    final layerFilterAsync = ref.watch(layerFilterProvider);
    final layerFilter = layerFilterAsync.value ?? LayerFilterState.initial();

    // Watch Route Planner State
    final plannerWaypoints = ref.watch(
      routePlannerControllerProvider.select((s) => s.waypoints),
    );
    final routePolylines = ref.watch(memoizedRoutePolylinesProvider);
    ref.watch(speedAlertProvider);

    final navMode = ref.watch(mapNavigationModeProvider);
    ref.watch(map3dTiltProvider);

    ref.listen(mapProvider, _onMapChange);
    ref.listen(mapAutoFollowProvider, _onAutoFollowChange);
    ref.listen(mapNavigationModeProvider, _onNavigationModeChange);
    ref.listen(map3dTiltProvider, _on3dTiltChange);

    final mapWidget = FlutterMap(
      mapController: widget.mapController,
      options: MapOptions(
        initialCenter: initialLocation,
        initialZoom: 14,
        minZoom: 5,
        maxZoom: 18,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
        onPositionChanged: (camera, hasGesture) {
          // Publish the current camera immediately. API consumers use the
          // bounded throttle-latest provider and therefore cannot be starved
          // by continuous GPS auto-follow or map gestures.
          ref
              .read(mapCameraPositionProvider.notifier)
              .update(camera.center, camera.zoom);

          // Disable auto-follow immediately on manual pan/zoom.
          if (hasGesture) {
            if (ref.read(mapAutoFollowProvider)) {
              ref.read(mapAutoFollowProvider.notifier).disable();
            }
            _resetAutoReturnTimer();
          }
        },
        onTap: (tapPosition, point) {
          if (ref.read(fishingModeControllerProvider).value?.isEnabled ??
              false) {
            // Hit test for fishing restrictions
            // OPTIMIZATION: Hit test ONLY visible restrictions (viewport-culled)
            final restrictions = ref.read(displayedFishingRestrictionsProvider);
            final hits = <FishingRestriction>[];

            for (final restriction in restrictions) {
              if (restriction.boundingBox != null &&
                  !restriction.boundingBox!.contains(
                    lat: point.latitude,
                    lon: point.longitude,
                  )) {
                continue;
              }
              for (final ring in restriction.rings) {
                if (GeometryUtils.isPointInPolygon(point, ring)) {
                  hits.add(restriction);
                  break; // Found hit for this restriction, move to next restriction
                }
              }
            }

            if (hits.isNotEmpty) {
              showModalBottomSheet<void>(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (context) =>
                    FishingRestrictionDetailSheet(restrictions: hits),
              );
            }
          }
        },
      ),
      children: [
        // 1. Optimized Base Map Tile Layer (Marine Focus Filter in Boating Mode)
        if (navMode == MapNavigationMode.boatingHeadingUp)
          ColorFiltered(
            colorFilter: const ColorFilter.matrix(<double>[
              0.75,
              0,
              0,
              0,
              0,
              0,
              0.8,
              0,
              0,
              0,
              0,
              0,
              1.1,
              0,
              0,
              0,
              0,
              0,
              0.88,
              0,
            ]),
            child: TileLayer(
              urlTemplate: layerFilter.showOsmBasemap
                  ? MapUrls.openStreetMap
                  : MapUrls.traficomWmts,
              tileProvider: _tileProvider,
              evictErrorTileStrategy: EvictErrorTileStrategy.dispose,
              minZoom: 5,
              maxZoom: 19,
              maxNativeZoom: layerFilter.showOsmBasemap ? 19 : 15,
            ),
          )
        else
          TileLayer(
            urlTemplate: layerFilter.showOsmBasemap
                ? MapUrls.openStreetMap
                : MapUrls.traficomWmts,
            tileProvider: _tileProvider,
            evictErrorTileStrategy: EvictErrorTileStrategy.dispose,
            minZoom: 5,
            maxZoom: 19,
            maxNativeZoom: layerFilter.showOsmBasemap ? 19 : 15,
          ),

        // 2. Track Recording Breadcrumb Trail
        const RepaintBoundary(child: TrackLayer()),

        // Weather Radar Layer — visible when layer toggle is on
        if (layerFilter.showWeatherRadar)
          const RepaintBoundary(child: WeatherRadarLayer(visible: true)),

        // Dynamic Wind Arrow Layer
        const WindLayerWidget(),

        // Algae WMS Layer (SYKE satellite imagery) + Interactive Marker Layer
        if (layerFilter.showAlgaeLayer) ...[
          const RepaintBoundary(child: AlgaeWmsLayer(visible: true)),
          const RepaintBoundary(child: AlgaeMarkerLayer(visible: true)),
        ],

        // Draw Filtered Speed Limit Zones
        // Wrapped in RepaintBoundary for performance
        if (layerFilter.showSpeedLimits && !isFishingMode)
          RepaintBoundary(child: PolygonLayer(polygons: speedLimitPolygons)),

        // Navigation Aids (Fairways, Beacons, Buoys, Traffic Signs, Lighthouses)
        // Uses new Väylävirasto API integration with viewport filtering
        // RepaintBoundary ensures they don't repaint when other layers change
        if (layerFilter.showNavigationAids || layerFilter.showBoatingLines)
          const RepaintBoundary(child: NavigationAidsLayerWidget()),

        // Small Harbors & Excursion Docks Layer
        if (layerFilter.showHarborsLayer)
          const RepaintBoundary(child: HarborsMapLayerWidget()),

        // AIS Vessel Tracking & Collision Guard Layer
        if (layerFilter.showAisLayer)
          const RepaintBoundary(child: AisMapLayerWidget()),

        // Wave Visualization & FMI Buoys Layer
        const RepaintBoundary(child: WaveMapLayerWidget()),

        // User Contributions Layer — own ConsumerWidget so it only rebuilds
        // when contributions change, not on every MapContent rebuild.
        // HIDDEN in fishing mode (contributions are navigation-related).
        if (!isFishingMode && layerFilter.showNavigationAids)
          const RepaintBoundary(child: _ContributionMarkerLayer()),

        // Active Route Planner Visualization
        if (plannerWaypoints.length > 1)
          RepaintBoundary(child: PolylineLayer(polylines: routePolylines)),

        // Active Route Navigation (when not in planner)
        if (plannerWaypoints.isEmpty)
          RepaintBoundary(
            child: PolylineLayer(
              polylines: ref.watch(memoizedActiveRoutePolylinesProvider),
            ),
          ),

        if (plannerWaypoints.isNotEmpty)
          RepaintBoundary(
            child: MarkerLayer(
              markers: plannerWaypoints.map((w) {
                return Marker(
                  point: LatLng(w.lat, w.lon),
                  width: 16,
                  height: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.kNeonCyan,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.kSurfaceColor,
                        width: 2,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

        // Harbor & Berthing Tactical 10m Maneuvering Grid Layer
        const RepaintBoundary(child: BerthingTacticalGridLayer()),

        const RepaintBoundary(child: _BoatLocationLayer()),

        // Lightning Layer (using select()-optimized value)
        if (layerFilter.showWeatherRadar)
          RepaintBoundary(
            child: WeatherLightningLayer(strikes: lightningStrikes),
          ),

        // Fishing Layers (Restrictions & Waterways)
        // PERFORMANCE: RepaintBoundary isolates fishing layer repaints
        // Fishing restrictions are ONLY shown in Fishing Mode
        if (isFishingMode) const RepaintBoundary(child: FishingLayers()),

        // Scale bar overlay
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ScaleBarWidget(mapController: widget.mapController),
          ),
        ),
      ],
    );

    return mapWidget;
  }
}

/// Keeps high-frequency GPS marker updates out of the full map layer tree.
class _BoatLocationLayer extends ConsumerWidget {
  const _BoatLocationLayer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(
      mapProvider.select(
        (state) => (
          location: state.userLocation,
          hasLocation: state.hasLocation,
          isFresh: state.isLocationFresh,
          heading: state.heading,
        ),
      ),
    );
    if (!position.hasLocation) return const SizedBox.shrink();

    return MarkerLayer(
      markers: [
        Marker(
          point: position.location,
          width: 24,
          height: 38,
          child: Transform.rotate(
            angle: position.heading * (math.pi / 180),
            child: BoatMarker(
              accentColor: position.isFresh
                  ? const Color(0xFF14B8A6)
                  : Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}

/// Dedicated ConsumerWidget for user contribution markers.
///
/// Extracted from MapContent so that contribution list changes only trigger
/// a rebuild of this widget — not the entire map layer stack.
class _ContributionMarkerLayer extends ConsumerWidget {
  const _ContributionMarkerLayer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contributions = ref.watch(
      contributionProvider.select((s) => s.value ?? []),
    );

    if (contributions.isEmpty) return const SizedBox.shrink();

    final tertiary = Theme.of(context).colorScheme.tertiary;
    final shadowColor = Theme.of(context).shadowColor.withValues(alpha: 0.26);

    return MarkerLayer(
      markers: contributions.map((c) {
        return Marker(
          point: c.location,
          width: 40,
          height: 40,
          child: Icon(
            c.type == ContributionType.speedLimit
                ? Icons.speed
                : Icons.signpost,
            color: tertiary,
            size: 32,
            shadows: [Shadow(blurRadius: 2, color: shadowColor)],
          ),
        );
      }).toList(),
    );
  }
}
