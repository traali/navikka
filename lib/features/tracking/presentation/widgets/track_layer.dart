import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/tracking/presentation/providers/active_track_provider.dart';

class TrackLayer extends ConsumerWidget {
  const TrackLayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = ref.watch(activeTrackProvider.select((s) => s.points));

    if (points.isEmpty) return const SizedBox.shrink();

    if (points.length < 2) return const SizedBox.shrink();
    final firstPoint = points.first;
    final polylines = <Polyline>[];
    var segmentColor = _getSpeedColor(firstPoint.speedKmh);
    var segmentPoints = <LatLng>[
      LatLng(firstPoint.latitude, firstPoint.longitude),
    ];

    for (var i = 0; i < points.length - 1; i++) {
      final curr = points[i];
      final next = points[i + 1];
      final color = _getSpeedColor(curr.speedKmh);
      if (color != segmentColor && segmentPoints.length > 1) {
        polylines.add(
          Polyline(
            points: segmentPoints,
            strokeWidth: 4,
            color: segmentColor,
          ),
        );
        segmentPoints = <LatLng>[LatLng(curr.latitude, curr.longitude)];
        segmentColor = color;
      }
      segmentPoints.add(LatLng(next.latitude, next.longitude));
    }
    polylines.add(
      Polyline(
        points: segmentPoints,
        strokeWidth: 4,
        color: segmentColor,
      ),
    );

    return PolylineLayer(polylines: polylines);
  }

  Color _getSpeedColor(double speed) {
    if (speed < 5) return Colors.blue;
    if (speed < 15) return Colors.green;
    if (speed < 30) return Colors.yellow;
    return Colors.red;
  }
}
