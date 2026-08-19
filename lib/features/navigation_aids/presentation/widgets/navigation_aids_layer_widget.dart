import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/utils/safe_haptics.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_mode_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/layer_filter_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/navigation_aid.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/navigation_aid_type.dart';
import 'package:sakkoja/features/navigation_aids/presentation/mappers/official_sign_mapper.dart';
import 'package:sakkoja/features/navigation_aids/presentation/providers/navigation_aids_providers.dart';
import 'package:sakkoja/features/navigation_aids/presentation/widgets/navigation_aid_detail_sheet.dart';
import 'package:sakkoja/features/navigation_aids/presentation/widgets/navigation_aid_marker.dart';

/// Premium map layer for navigation aids with glassmorphism and animations.
///
/// Per `.agent/rules/design.md`:
/// - Glassmorphism for info panels
/// - Micro-animations for marker entrances
/// - 44x44pt touch targets
/// - Haptic feedback on tap
class NavigationAidsLayerWidget extends ConsumerWidget {
  const NavigationAidsLayerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layerFilterAsync = ref.watch(layerFilterProvider);
    final layerFilter = layerFilterAsync.value ?? LayerFilterState.initial();

    final fishingModeState = ref.watch(fishingModeControllerProvider).value;
    final isFishingMode = fishingModeState?.isEnabled ?? false;

    final fairwayAreaPolygons = isFishingMode
        ? const <Polygon>[]
        : ref.watch(fairwayAreaPolygonsProvider);
    final isZoomedOut = ref.watch(
      mapCameraPositionProvider.select((s) => s.zoom < 14.0),
    );

    final aids = layerFilter.showNavigationAids
        ? (isFishingMode
                  ? ref.watch(displayedSafetyEquipmentProvider)
                  : ref.watch(displayedNavigationAidsProvider))
              .where(_hasVisibleMarker)
              .toList(growable: false)
        : const <NavigationAid>[];

    final navAidMarkers = aids
        .map((aid) {
          return Marker(
            point: aid.position,
            width: 32,
            height: 32,
            rotate: false,
            child: GestureDetector(
              onTap: () => _showNavigationAidDetail(context, aid),
              child: NavigationAidMarker(aid: aid),
            ),
          );
        })
        .toList(growable: false);

    final navLinePolylines = layerFilter.showBoatingLines
        ? ref.watch(navigationLinePolylinesProvider)
        : const <Polyline>[];
    final navLineDepthLabels = (layerFilter.showBoatingLines && !isZoomedOut)
        ? ref.watch(navigationLineDepthLabelsProvider)
        : const <Marker>[];

    return RepaintBoundary(
      child: Stack(
        children: [
          if (fairwayAreaPolygons.isNotEmpty)
            RepaintBoundary(
              child: PolygonLayer(polygons: fairwayAreaPolygons),
            ),

          if (navAidMarkers.isNotEmpty)
            RepaintBoundary(child: MarkerLayer(markers: navAidMarkers)),

          if (navLinePolylines.isNotEmpty)
            RepaintBoundary(child: PolylineLayer(polylines: navLinePolylines)),
          if (navLineDepthLabels.isNotEmpty)
            RepaintBoundary(child: MarkerLayer(markers: navLineDepthLabels)),
        ],
      ),
    );
  }

  void _showNavigationAidDetail(BuildContext context, NavigationAid aid) {
    SafeHaptics.selection();
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => NavigationAidDetailSheet(aid: aid),
    );
  }
}

bool _hasVisibleMarker(NavigationAid aid) {
  if (aid.type == NavigationAidType.trafficSign) {
    return OfficialSignMapper.getAssetPath(aid.signTypeCode) != null;
  }
  return true;
}
