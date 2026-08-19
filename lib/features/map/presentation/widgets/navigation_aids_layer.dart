import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart'; // [NEW] SVG Support
import 'package:sakkoja/core/theme/app_theme.dart';
import 'package:sakkoja/core/utils/lru_cache.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/fishing/domain/entities/waterway_feature.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_data_providers.dart';

class NavigationAidsLayer extends ConsumerWidget {
  const NavigationAidsLayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch waterway features synchronously to eliminate "flash" during panning
    final waterwayFeatures = ref.watch(displayedWaterwayFeaturesProvider);

    if (waterwayFeatures.isEmpty) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        // STATIC: Waterway features (fairway areas)
        // VISIBILITY: Increased opacity for better visibility of navigation channels
        PolygonLayer(
          polygons: waterwayFeatures
              .where(
                (f) =>
                    f.type == WaterwayFeatureType.fairwayArea &&
                    f.rings != null &&
                    f.rings!.isNotEmpty,
              )
              .map(
                (f) => Polygon(
                  points: f.rings!.first,
                  color: AppTheme.kVibrantBlue.withValues(alpha: 0.20),
                  borderColor: AppTheme.kVibrantBlue.withValues(alpha: 0.50),
                  borderStrokeWidth: 2,
                ),
              )
              .toList(),
        ),

        // STATIC: Waterway markers (beacons, buoys)
        // VISIBILITY: Geometric Chart Symbols (IALA A) - 32px
        MarkerLayer(
          markers: waterwayFeatures
              .where((f) => f.position != null)
              .map(
                (f) => Marker(
                  point: f.position!,
                  width: 32,
                  height: 32,
                  child: GestureDetector(
                    onTap: SafeHaptics.selection,
                    child: _buildMarkerIcon(f.type),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildMarkerIcon(WaterwayFeatureType type) {
    if (type == WaterwayFeatureType.beacon) {
      return _cachedSvg('assets/icons/nautical/port_mark.svg');
    } else {
      return _cachedSvg('assets/icons/nautical/starboard_mark.svg');
    }
  }

  static final LruCache<String, SvgPicture> _svgIconCache = LruCache(
    capacity: 50,
  );

  Widget _cachedSvg(String path) {
    final existing = _svgIconCache[path];
    if (existing != null) return existing;

    final svg = SvgPicture.asset(path, width: 24, height: 24);
    _svgIconCache[path] = svg;
    return svg;
  }
}
