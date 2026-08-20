import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/constants/fmi_constants.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/map/data/services/map_config_service.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/map/presentation/widgets/boat_marker.dart';
import 'package:sakkoja/features/map/presentation/widgets/zoom_controls.dart';
import 'package:sakkoja/features/satellite/domain/entities/satellite_state.dart';
import 'package:sakkoja/features/satellite/presentation/providers/satellite_providers.dart';
import 'package:sakkoja/features/satellite/presentation/widgets/satellite_controls_dock.dart';
import 'package:sakkoja/features/satellite/presentation/widgets/satellite_top_capsule.dart';
import 'package:sakkoja/features/weather/presentation/widgets/safe_tile_provider.dart';

/// Dedicated Space & Earth Observation Satellite Screen for Sakkoja.
/// Renders fresh Copernicus Sentinel-2 optical imagery & live FMI/EUMETSAT weather satellite imagery.
class SatelliteScreen extends ConsumerStatefulWidget {
  const SatelliteScreen({super.key});

  @override
  ConsumerState<SatelliteScreen> createState() => _SatelliteScreenState();
}

class _SatelliteScreenState extends ConsumerState<SatelliteScreen> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final initialLocation = ref.watch(satelliteInitialLocationProvider);
    final satelliteState = ref.watch(satelliteControllerProvider);
    final mapState = ref.watch(mapProvider);

    return Scaffold(
      backgroundColor: colors.canvas,
      body: Stack(
        children: [
          // 1. Full-screen Satellite Map Canvas
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: initialLocation,
              initialZoom: 11.5,
              minZoom: 4,
              maxZoom: 18,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
            ),
            children: [
              // A. Base Optical Satellite Layer
              if (satelliteState.mode == SatelliteMode.sentinel2)
                TileLayer(
                  urlTemplate:
                      'https://tiles.maps.eox.at/wmts/1.0.0/s2cloudless-2023_3857/default/GoogleMapsCompatible/{z}/{x}/{y}.jpg',
                  tileProvider: kIsWeb
                      ? NetworkTileProvider(
                          headers: const {
                            'User-Agent': 'Navikka/1.0 (navikka.pages.dev)',
                            'Referer': 'https://navikka.pages.dev',
                          },
                        )
                      : SafeTileProvider(
                          dio: ref.read(tileDioProvider),
                          userAgent: 'Navikka/1.0',
                        ),
                  maxNativeZoom: 15,
                )
              else if (satelliteState.mode == SatelliteMode.highResBasemap)
                TileLayer(
                  urlTemplate:
                      'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
                  tileProvider: kIsWeb
                      ? NetworkTileProvider(
                          headers: const {
                            'User-Agent': 'Navikka/1.0 (navikka.pages.dev)',
                            'Referer': 'https://navikka.pages.dev',
                          },
                        )
                      : SafeTileProvider(
                          dio: ref.read(tileDioProvider),
                          userAgent: 'Navikka/1.0',
                        ),
                )
              else if (satelliteState.mode == SatelliteMode.eumetsat) ...[
                // High-resolution Earth Observation basemap for authentic space view
                TileLayer(
                  urlTemplate:
                      'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
                  tileProvider: kIsWeb
                      ? NetworkTileProvider(
                          headers: const {
                            'User-Agent': 'Navikka/1.0 (navikka.pages.dev)',
                            'Referer': 'https://navikka.pages.dev',
                          },
                        )
                      : SafeTileProvider(
                          dio: ref.read(tileDioProvider),
                          userAgent: 'Navikka/1.0',
                        ),
                ),
                // FMI Live Weather Satellite / Radar Cloud Layer
                TileLayer(
                  wmsOptions: WMSTileLayerOptions(
                    baseUrl: FmiConstants.wmsBaseUrl,
                    layers: [
                      if (satelliteState.eumetsatPreset ==
                          EumetsatPreset.cloudStructure)
                        FmiConstants.layerRadarRainIntensity
                      else if (satelliteState.eumetsatPreset ==
                          EumetsatPreset.fogDetection)
                        'Radar:suomi_rr1h_eureffin'
                      else
                        FmiConstants.layerRadarReflectivity,
                    ],
                    version: '1.3.0',
                    otherParameters: {
                      if (satelliteState.currentTimestamp != null)
                        'time':
                            "${satelliteState.currentTimestamp!.toUtc().toIso8601String().split('.')[0]}Z",
                    },
                  ),
                  tileProvider: SafeTileProvider(
                    dio: ref.read(tileDioProvider),
                    userAgent: kIsWeb ? null : 'Navikka/1.0',
                  ),
                  minZoom: 4,
                  maxZoom: 19,
                ),
              ],

              // B. Optional Nautical Overlay (Traficom Fairways & Depths)
              if (satelliteState.showNauticalOverlay)
                Opacity(
                  opacity: satelliteState.nauticalOverlayOpacity,
                  child: TileLayer(
                    urlTemplate: MapUrls.traficomWmts,
                    tileProvider: kIsWeb
                        ? NetworkTileProvider(
                            headers: const {
                              'User-Agent': 'Navikka/1.0 (navikka.pages.dev)',
                              'Referer': 'https://navikka.pages.dev',
                            },
                          )
                        : SafeTileProvider(
                            dio: ref.read(tileDioProvider),
                            userAgent: 'Navikka/1.0',
                          ),
                    maxNativeZoom: 16,
                  ),
                ),

              // C. Live Boat / GPS Location Marker
              if (mapState.hasLocation)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: mapState.userLocation,
                      width: 52,
                      height: 52,
                      child: Transform.rotate(
                        angle: mapState.heading * (math.pi / 180),
                        child: const BoatMarker(size: 28),
                      ),
                    ),
                  ],
                ),
            ],
          ),

          // 2. Top Floating Satellite Capsule
          Positioned(
            top: MediaQuery.paddingOf(context).top + 10,
            left: 12,
            right: 12,
            child: const SatelliteTopCapsule(),
          ),

          // 3. Bottom Controls & Presets Dock
          Positioned(
            bottom: MediaQuery.paddingOf(context).bottom + 16,
            left: 12,
            right: 12,
            child: const SatelliteControlsDock(),
          ),

          // 4. Right-side FABs: GPS Recenter & Zoom Controls
          Positioned(
            right: 12,
            bottom: MediaQuery.paddingOf(context).bottom + 180,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Recenter GPS Button
                Container(
                  decoration: BoxDecoration(
                    color: colors.glassBackground,
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.glassBorder),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.my_location_rounded,
                      color: mapState.hasLocation
                          ? colors.primaryAction
                          : colors.textSecondary,
                      size: 22,
                    ),
                    tooltip: 'Keskitä sijaintiin',
                    onPressed: () {
                      SafeHaptics.medium();
                      final loc = mapState.hasLocation
                          ? mapState.userLocation
                          : initialLocation;
                      _mapController.move(loc, 12);
                    },
                  ),
                ),

                const SizedBox(height: 10),

                // Zoom Controls
                ZoomControls(
                  onZoomIn: () {
                    SafeHaptics.light();
                    _mapController.move(
                      _mapController.camera.center,
                      _mapController.camera.zoom + 1,
                    );
                  },
                  onZoomOut: () {
                    SafeHaptics.light();
                    _mapController.move(
                      _mapController.camera.center,
                      _mapController.camera.zoom - 1,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
