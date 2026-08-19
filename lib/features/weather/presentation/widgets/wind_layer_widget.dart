import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/features/map/presentation/providers/feature_flag_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/layer_filter_provider.dart';
import 'package:sakkoja/features/weather/presentation/providers/wind_wave_providers.dart';
import 'package:sakkoja/features/weather/presentation/widgets/wind_arrow_painter.dart';
import 'package:sakkoja/features/weather/presentation/widgets/wind_particle_painter.dart';

/// Layer widget rendering dynamic wind barbs AND animated particle flow stream lines on the map canvas.
/// Evaluated ONLY when both windWaveFeatureFlag AND layerFilter.showWindLayer are true.
class WindLayerWidget extends ConsumerStatefulWidget {
  const WindLayerWidget({super.key});

  @override
  ConsumerState<WindLayerWidget> createState() => _WindLayerWidgetState();
}

class _WindLayerWidgetState extends ConsumerState<WindLayerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFlagEnabled = ref.watch(windWaveFeatureFlagProvider);
    final layerFilterState = ref.watch(layerFilterProvider);
    final showWind = layerFilterState.value?.showWindLayer ?? false;

    if (!isFlagEnabled || !showWind) return const SizedBox.shrink();

    final camera = MapCamera.of(context);
    final windFieldAsync = ref.watch(windFieldProvider);

    return windFieldAsync.when(
      data: (field) {
        if (field.points.isEmpty) return const SizedBox.shrink();
        return AnimatedBuilder(
          animation: _animController,
          builder: (context, child) {
            return RepaintBoundary(
              child: Stack(
                children: [
                  CustomPaint(
                    size: camera.size,
                    painter: WindParticlePainter(
                      field: field,
                      camera: camera,
                      progress: _animController.value,
                    ),
                  ),
                  CustomPaint(
                    size: camera.size,
                    painter: WindArrowPainter(
                      field: field,
                      camera: camera,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}
