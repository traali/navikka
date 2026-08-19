import 'package:latlong2/latlong.dart';

enum WaterwayFeatureType {
  fairwayArea,
  waterwayLink,
  beacon,
  buoy,
  unknown;

  static WaterwayFeatureType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'fairwayarea':
        return WaterwayFeatureType.fairwayArea;
      case 'waterwaylink':
        return WaterwayFeatureType.waterwayLink;
      case 'beacon':
        return WaterwayFeatureType.beacon;
      case 'buoy':
        return WaterwayFeatureType.buoy;
      default:
        return WaterwayFeatureType.unknown;
    }
  }
}

class WaterwayFeature {
  // For Beacon/Buoy

  const WaterwayFeature({
    required this.id,
    required this.type,
    this.name,
    this.rings,
    this.points,
    this.position,
  });
  final String id;
  final String? name;
  final WaterwayFeatureType type;
  final List<List<LatLng>>? rings; // For FairwayArea
  final List<LatLng>? points; // For WaterwayLink
  final LatLng? position;
}
