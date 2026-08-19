import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/constants/fmi_constants.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';
import 'package:sakkoja/features/weather/presentation/widgets/safe_tile_provider.dart';

class WeatherRadarLayer extends ConsumerWidget {
  const WeatherRadarLayer({
    required this.visible,
    super.key,
    this.opacity = 0.8,
  });
  final bool visible;
  final double opacity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!visible) return const SizedBox.shrink();

    // PERFORMANCE: Use select() to only rebuild on radar-specific changes
    final radarTimestamps = ref.watch(
      pointWeatherControllerProvider.select((state) => state.radarTimestamps),
    );
    final currentIndex = ref.watch(
      pointWeatherControllerProvider.select(
        (state) => state.currentTimestampIndex,
      ),
    );

    if (radarTimestamps.isEmpty) return const SizedBox.shrink();

    final currentTimestamp = radarTimestamps[currentIndex];
    final timeString = "${currentTimestamp.toIso8601String().split('.')[0]}Z";

    final layer = TileLayer(
      wmsOptions: WMSTileLayerOptions(
        baseUrl: FmiConstants.wmsBaseUrl,
        layers: const [FmiConstants.layerRadarReflectivity],
        version: '1.3.0',
        otherParameters: {'time': timeString},
      ),
      tileProvider: SafeTileProvider(
        dio: ref.read(tileDioProvider),
        userAgent: kIsWeb ? null : 'SakkojaApp/1.0',
      ),
      minZoom: 5,
      maxZoom: 19,
    );

    if (opacity >= 0.999) {
      return layer;
    }

    // dart format off
    return ColorFiltered(
      colorFilter: ColorFilter.matrix(<double>[
        1, 0, 0, 0, 0,
        0, 1, 0, 0, 0,
        0, 0, 1, 0, 0,
        0, 0, 0, opacity, 0,
      ]),
      // dart format on
      child: RepaintBoundary(
        child: layer,
      ),
    );
  }
}
