import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/config/env.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/features/weather/presentation/widgets/safe_tile_provider.dart';

class AlgaeWmsLayer extends ConsumerWidget {
  const AlgaeWmsLayer({
    required this.visible,
    super.key,
    this.opacity = 0.6,
  });
  final bool visible;
  final double opacity;

  String _getEffectiveUrl() {
    // First try the env var, fall back to the original hardcoded URL
    final url = Env.sykeWmsUrl.isNotEmpty
        ? Env.sykeWmsUrl
        : 'https://paikkatieto.ymparisto.fi/arcgis/services/Syke/Itameri/MapServer/WMSServer';
    return url.contains('?') ? url : '$url?';
  }

  static bool isSeasonalActive({int startMonth = 6, int endMonth = 9}) {
    final now = DateTime.now();
    final month = now.month;
    return month >= startMonth && month <= endMonth;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!visible || !isSeasonalActive()) return const SizedBox.shrink();

    final layer = TileLayer(
      wmsOptions: WMSTileLayerOptions(
        baseUrl: _getEffectiveUrl(),
        layers: const ['6'],
        version: '1.3.0',
        otherParameters: const {
          'format': 'image/png',
          'transparent': 'true',
        },
      ),
      tileProvider: SafeTileProvider(
        dio: ref.read(tileDioProvider),
        userAgent: kIsWeb ? null : 'SakkojaApp/1.0',
      ),
      minZoom: 5,
      maxZoom: 19,
    );

    if (opacity >= 0.999) {
      return RepaintBoundary(child: layer);
    }

    return RepaintBoundary(
      child: ColorFiltered(
        // dart format off
        colorFilter: ColorFilter.matrix(<double>[
          1, 0, 0, 0, 0,
          0, 1, 0, 0, 0,
          0, 0, 1, 0, 0,
          0, 0, 0, opacity, 0,
        ]),
        // dart format on
        child: layer,
      ),
    );
  }
}
