import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/features/harbors/presentation/providers/harbors_provider.dart';
import 'package:sakkoja/features/harbors/presentation/widgets/harbor_marker.dart';
import 'package:sakkoja/features/map/presentation/providers/layer_filter_provider.dart';

class HarborsMapLayerWidget extends ConsumerWidget {
  const HarborsMapLayerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layerFilterAsync = ref.watch(layerFilterProvider);
    final layerFilter = layerFilterAsync.value ?? LayerFilterState.initial();

    if (!layerFilter.showHarborsLayer) {
      return const SizedBox.shrink();
    }

    final harborsAsync = ref.watch(harborsProvider);

    return harborsAsync.when(
      data: (harbors) {
        if (harbors.isEmpty) return const SizedBox.shrink();

        final markers = harbors
            .map((harbor) {
              return Marker(
                point: harbor.position,
                width: 38,
                height: 38,
                child: HarborMarker(harbor: harbor),
              );
            })
            .toList(growable: false);

        return RepaintBoundary(
          child: MarkerLayer(markers: markers),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}
