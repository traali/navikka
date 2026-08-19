import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/weather/data/weather_providers.dart';

part 'point_weather_lightning_provider.g.dart';

/// A bounded-resolution boat position for weather safety calculations.
///
/// Lightning warning thresholds are measured in kilometres. Recomputing the
/// nearest strike for sub-metre GPS jitter adds load without useful accuracy,
/// while a 25 metre grid still updates promptly at boating speeds.
@riverpod
LatLng? safetyBoatPosition(Ref ref) {
  final location = ref.watch(
    mapProvider.select(
      (state) => (
        isFresh: state.isLocationFresh,
        position: state.userLocation,
      ),
    ),
  );
  if (!location.isFresh) return null;

  const gridMeters = 25.0;
  const metersPerLatitudeDegree = 111320.0;
  const latitudeStep = gridMeters / metersPerLatitudeDegree;
  final quantizedLatitude =
      (location.position.latitude / latitudeStep).round() * latitudeStep;
  final longitudeScale = math.max(
    0.1,
    math.cos(quantizedLatitude * math.pi / 180).abs(),
  );
  final longitudeStep = gridMeters / (metersPerLatitudeDegree * longitudeScale);

  return LatLng(
    quantizedLatitude,
    (location.position.longitude / longitudeStep).round() * longitudeStep,
  );
}

@riverpod
Future<double?> lightningProximity(Ref ref) async {
  final boatPosition = ref.watch(safetyBoatPositionProvider);
  final lightningAsync = ref.watch(safetyLightningStreamProvider);

  if (boatPosition == null || !lightningAsync.hasValue) return null;
  final strikes = lightningAsync.value!;

  if (strikes.isEmpty) return null;

  final strikesData = strikes
      .map((s) => {'lat': s.location.latitude, 'lon': s.location.longitude})
      .toList();

  return compute(_calculateNearestLightningInIsolate, {
    'center': {'lat': boatPosition.latitude, 'lon': boatPosition.longitude},
    'strikes': strikesData,
  });
}

double? _calculateNearestLightningInIsolate(Map<String, dynamic> params) {
  final centerData = params['center'] as Map;
  final centerLat = (centerData['lat'] as num).toDouble();
  final centerLon = (centerData['lon'] as num).toDouble();

  final strikesList = params['strikes'] as List;
  if (strikesList.isEmpty) return null;

  final center = LatLng(centerLat, centerLon);
  const distanceCalc = Distance();

  var minDistance = double.infinity;
  for (final rawStrike in strikesList) {
    final strike = rawStrike as Map;
    final lat = (strike['lat'] as num).toDouble();
    final lon = (strike['lon'] as num).toDouble();

    final d = distanceCalc.as(
      LengthUnit.Meter,
      center,
      LatLng(lat, lon),
    );
    if (d < minDistance) minDistance = d;
  }

  return minDistance == double.infinity ? null : minDistance;
}
