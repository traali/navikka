import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/harbors/presentation/providers/harbors_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';

enum CockpitMode {
  cruising(
    'Matkaveneily',
    'Minimalistinen horisontti ja reittinäkymä',
    Icons.explore_outlined,
  ),
  harbor(
    'Satamatila',
    '10m tarkkuusruudukko, tuuliajoverkko ja laiturit',
    Icons.anchor,
  ),
  fishing(
    'Kalastustila',
    'Syvyyskartat, pintaveden lämpötila ja rajoitukset',
    Icons.phishing,
  ),
  emergency(
    'Hätätila (MRCC)',
    'Pelastuskeskus Turku 0294 1000, MGRS ja VHF 16',
    Icons.warning_amber_rounded,
  );

  const CockpitMode(this.label, this.description, this.icon);
  final String label;
  final String description;
  final IconData icon;
}

class CockpitState {
  const CockpitState({
    required this.mode,
    required this.isAutoTriggered,
    this.nearestHarborName,
    this.nearestHarborDistanceMeters,
  });

  final CockpitMode mode;
  final bool isAutoTriggered;
  final String? nearestHarborName;
  final double? nearestHarborDistanceMeters;

  CockpitState copyWith({
    CockpitMode? mode,
    bool? isAutoTriggered,
    String? nearestHarborName,
    double? nearestHarborDistanceMeters,
  }) {
    return CockpitState(
      mode: mode ?? this.mode,
      isAutoTriggered: isAutoTriggered ?? this.isAutoTriggered,
      nearestHarborName: nearestHarborName ?? this.nearestHarborName,
      nearestHarborDistanceMeters:
          nearestHarborDistanceMeters ?? this.nearestHarborDistanceMeters,
    );
  }
}

class CockpitModeNotifier extends Notifier<CockpitState> {
  bool _manualOverride = false;

  @override
  CockpitState build() {
    _initAutoDetection();
    return const CockpitState(
      mode: CockpitMode.cruising,
      isAutoTriggered: false,
    );
  }

  void _initAutoDetection() {
    ref.listen(mapProvider, (previous, next) {
      if (_manualOverride) return;
      if (!next.hasLocation) return;

      final speedKmh = next.currentSpeedKmh;
      final speedKnots = speedKmh * 0.539957;
      final userLocation = next.userLocation;

      final harbors = ref.read(harborsProvider).value ?? [];
      if (harbors.isEmpty) return;

      double minDistance = double.infinity;
      String? closestHarbor;

      const dist = Distance();
      for (final harbor in harbors) {
        final d = dist.as(LengthUnit.Meter, userLocation, harbor.position);
        if (d < minDistance) {
          minDistance = d;
          closestHarbor = harbor.name;
        }
      }

      // Auto-trigger Harbor mode if speed < 3.0 knots and within 500m of a harbor
      if (speedKnots < 3.0 && minDistance <= 500) {
        if (state.mode != CockpitMode.harbor) {
          state = CockpitState(
            mode: CockpitMode.harbor,
            isAutoTriggered: true,
            nearestHarborName: closestHarbor,
            nearestHarborDistanceMeters: minDistance,
          );
        } else {
          state = state.copyWith(
            nearestHarborName: closestHarbor,
            nearestHarborDistanceMeters: minDistance,
          );
        }
      } else if (speedKnots >= 4.0 && state.isAutoTriggered) {
        // Return to Cruising mode automatically when accelerating away
        state = const CockpitState(
          mode: CockpitMode.cruising,
          isAutoTriggered: false,
        );
      }
    });
  }

  void setMode(CockpitMode mode, {bool manual = true}) {
    _manualOverride = manual;
    state = state.copyWith(
      mode: mode,
      isAutoTriggered: !manual,
    );
  }

  void resetAutoMode() {
    _manualOverride = false;
  }
}

final cockpitModeProvider = NotifierProvider<CockpitModeNotifier, CockpitState>(
  CockpitModeNotifier.new,
);
