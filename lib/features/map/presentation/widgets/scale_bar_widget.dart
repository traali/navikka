import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/theme/app_theme.dart';

/// A simple distance scale bar for the map.
/// Shows approximate ground distance at the current zoom level.
class ScaleBarWidget extends StatelessWidget {
  const ScaleBarWidget({required this.mapController, super.key});
  final MapController mapController;

  @override
  Widget build(BuildContext context) {
    final camera = mapController.camera;
    final zoom = camera.zoom;
    final center = camera.center;

    const barWidth = 80.0;
    final groundDistance = _estimateGroundDistance(center, zoom, barWidth);
    final displayText = _formatDistance(groundDistance);
    final barFraction = groundDistance > 0
        ? barWidth * (groundDistance / _roundDistance(groundDistance))
        : 0.0;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: barFraction.clamp(20, barWidth),
            height: 3,
            color: Colors.white,
          ),
          const SizedBox(height: 2),
          Text(
            displayText,
            style: AppTheme.kCaption.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  double _estimateGroundDistance(LatLng center, double zoom, double pixels) {
    const earthCircumference = 40075016.686;
    final metersPerPixel =
        earthCircumference *
        math.cos(center.latitudeInRad) /
        (1 << (zoom.round() + 8));
    return metersPerPixel * pixels;
  }

  double _roundDistance(double meters) {
    if (meters < 10) return 10;
    if (meters < 50) return 50;
    if (meters < 100) return 100;
    if (meters < 500) return 500;
    if (meters < 1000) return 1000;
    if (meters < 5000) return 5000;
    if (meters < 10000) return 10000;
    if (meters < 50000) return 50000;
    return 100000;
  }

  String _formatDistance(double meters) {
    if (meters >= 1000) {
      return '${(meters / 1000).toStringAsFixed(0)} km';
    }
    return '${meters.toStringAsFixed(0)} m';
  }
}
