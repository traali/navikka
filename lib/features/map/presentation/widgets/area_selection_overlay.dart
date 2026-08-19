import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/l10n/app_localizations.dart';

/// Helper to estimate tile counts and sizes for a given area
class OfflineAreaLogic {
  static int estimateTileCount(LatLngBounds bounds, int minZoom, int maxZoom) {
    var total = 0;
    for (var z = minZoom; z <= maxZoom; z++) {
      final p1 = _latLonToTile(bounds.southWest, z);
      final p2 = _latLonToTile(bounds.northEast, z);

      final width = (p1.x - p2.x).abs().toInt() + 1;
      final height = (p1.y - p2.y).abs().toInt() + 1;
      total += width * height;
    }
    return total;
  }

  static Point<double> _latLonToTile(LatLng loc, int zoom) {
    final x = (loc.longitude + 180) / 360 * pow(2, zoom);
    final y =
        (1 -
            log(
                  tan(loc.latitude * pi / 180) +
                      1 / cos(loc.latitude * pi / 180),
                ) /
                pi) /
        2 *
        pow(2, zoom);
    return Point(x, y);
  }

  static String formatSize(int tileCount) {
    // Average tile size estimated at 25KB
    final bytes = tileCount * 25 * 1024;
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

class AreaSelectionOverlay extends StatelessWidget {
  const AreaSelectionOverlay({
    required this.onCancel,
    required this.onConfirm,
    super.key,
    this.bounds,
  });
  final LatLngBounds? bounds;
  final VoidCallback onCancel;
  final void Function(LatLngBounds) onConfirm;

  @override
  Widget build(BuildContext context) {
    if (bounds == null) return const SizedBox.shrink();

    final tileCount = OfflineAreaLogic.estimateTileCount(bounds!, 10, 15);
    final sizeStr = OfflineAreaLogic.formatSize(tileCount);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.selectedArea,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(
                  label: AppLocalizations.of(context)!.tiles,
                  value: '$tileCount',
                ),
                _StatItem(
                  label: AppLocalizations.of(context)!.estSize,
                  value: sizeStr,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onCancel,
                    child: Text(AppLocalizations.of(context)!.cancel),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => onConfirm(bounds!),
                    child: Text(AppLocalizations.of(context)!.download),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
