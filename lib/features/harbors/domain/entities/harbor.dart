import 'package:latlong2/latlong.dart';

/// Category type for small harbors and boating sites.
enum HarborType {
  guestHarbor, // Vierasvenesatama
  excursionDock, // Retkisatama / Saarisatama
  smallBoatHarbor, // Pienvenesatama
  boatRamp, // Veneenlaskupaikka
}

/// Domain entity representing a small boat harbor, guest harbor, or excursion dock.
class Harbor {
  const Harbor({
    required this.id,
    required this.name,
    required this.type,
    required this.position,
    this.municipality,
    this.hasSauna = false,
    this.hasCampfire = false,
    this.hasWater = false,
    this.hasElectricity = false,
    this.hasSepticPumpout = false,
    this.berthCount,
    this.depthMeters,
  });

  final String id;
  final String name;
  final HarborType type;
  final LatLng position;
  final String? municipality;
  final bool hasSauna;
  final bool hasCampfire;
  final bool hasWater;
  final bool hasElectricity;
  final bool hasSepticPumpout;
  final int? berthCount;
  final double? depthMeters;

  String get typeLabel {
    switch (type) {
      case HarborType.guestHarbor:
        return 'Vierasvenesatama';
      case HarborType.excursionDock:
        return 'Retkisatama';
      case HarborType.smallBoatHarbor:
        return 'Pienvenesatama';
      case HarborType.boatRamp:
        return 'Veneenlaskupaikka';
    }
  }
}
