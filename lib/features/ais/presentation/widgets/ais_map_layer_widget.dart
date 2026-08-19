import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/features/ais/presentation/providers/ais_targets_provider.dart';
import 'package:sakkoja/features/ais/presentation/widgets/ais_target_painter.dart';
import 'package:sakkoja/features/map/presentation/providers/layer_filter_provider.dart';

class AisMapLayerWidget extends ConsumerWidget {
  const AisMapLayerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layerFilterState = ref.watch(layerFilterProvider);
    final showAis = layerFilterState.value?.showAisLayer ?? true;

    if (!showAis) return const SizedBox.shrink();

    final camera = MapCamera.of(context);
    final targetsState = ref.watch(aisTargetsProvider);

    return targetsState.when(
      data: (targets) {
        if (targets.isEmpty) return const SizedBox.shrink();
        return Positioned.fill(
          child: RepaintBoundary(
            child: CustomPaint(
              size: camera.size,
              painter: AisTargetPainter(
                targets: targets,
                camera: camera,
                currentZoom: camera.zoom,
              ),
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}
