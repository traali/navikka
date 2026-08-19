import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';
import 'package:sakkoja/features/weather/data/weather_providers.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_alert_state.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_lightning_provider.dart';

part 'point_weather_alert_provider.g.dart';

bool _isPointNearAlertPolygon(
  LatLng point,
  List<LatLng> polygon,
  String areaDescription, {
  double maxDistanceKm = 15.0,
}) {
  // 1. If areaDescription is present, strictly verify point falls within named region
  if (areaDescription.isNotEmpty) {
    if (!_isPointInAreaDescription(point, areaDescription)) {
      return false;
    }
  }

  // 2. If polygon is present, check point-in-polygon or tight 15km proximity
  if (polygon.isNotEmpty) {
    if (_isPointInPolygon(point, polygon)) return true;
    const dist = Distance();
    for (final vertex in polygon) {
      if (dist.as(LengthUnit.Kilometer, point, vertex) <= maxDistanceKm) {
        return true;
      }
    }
    return false;
  }

  return true;
}

bool _isPointInAreaDescription(LatLng point, String areaDesc) {
  final desc = areaDesc.toLowerCase();
  final lat = point.latitude;
  final lon = point.longitude;

  // 1. Maritime sea areas
  if (desc.contains('suomenlahti')) {
    return lat >= 59.3 && lat <= 60.7 && lon >= 22.0 && lon <= 28.0;
  }
  if (desc.contains('ahvenanmaa') ||
      desc.contains('saaristomeri') ||
      desc.contains('ahvenanmeri')) {
    return lat >= 59.3 && lat <= 60.8 && lon >= 19.0 && lon <= 22.5;
  }
  if (desc.contains('selkämer') || desc.contains('selkamer')) {
    return lat >= 60.8 && lat <= 63.2 && lon >= 19.0 && lon <= 22.5;
  }
  if (desc.contains('merenkurkku')) {
    return lat >= 63.0 && lat <= 64.0 && lon >= 19.5 && lon <= 23.0;
  }
  if (desc.contains('perämer') || desc.contains('peramer')) {
    return lat >= 63.8 && lat <= 66.2 && lon >= 21.0 && lon <= 25.5;
  }
  if (desc.contains('pohjois-itämeri') || desc.contains('itämeri')) {
    return lat >= 58.5 && lat <= 60.2 && lon >= 19.0 && lon <= 24.0;
  }

  // 2. Lakes & Inland Waters
  if (desc.contains('saimaa') || desc.contains('saimaan')) {
    return lat >= 61.0 && lat <= 63.2 && lon >= 27.0 && lon <= 30.5;
  }
  if (desc.contains('päijänne') || desc.contains('paijanne')) {
    return lat >= 61.0 && lat <= 62.5 && lon >= 25.0 && lon <= 26.2;
  }
  if (desc.contains('näsijärvi') || desc.contains('nasijarvi')) {
    return lat >= 61.5 && lat <= 62.0 && lon >= 23.5 && lon <= 24.2;
  }
  if (desc.contains('inari')) {
    return lat >= 68.5 && lat <= 69.8 && lon >= 26.5 && lon <= 29.5;
  }

  // 3. Land regions / Provinces & Municipalities
  if (desc.contains('uusimaa') ||
      desc.contains('helsinki') ||
      desc.contains('espoo') ||
      desc.contains('vantaa') ||
      desc.contains('porvoo')) {
    return lat >= 59.7 && lat <= 60.8 && lon >= 22.8 && lon <= 26.5;
  }
  if (desc.contains('kymenlaakso') ||
      desc.contains('kotka') ||
      desc.contains('hamina')) {
    return lat >= 60.3 && lat <= 61.4 && lon >= 26.3 && lon <= 27.9;
  }
  if (desc.contains('varsinais-suomi') ||
      desc.contains('turku') ||
      desc.contains('parainen')) {
    return lat >= 59.7 && lat <= 61.1 && lon >= 21.0 && lon <= 24.1;
  }
  if (desc.contains('satakunta') ||
      desc.contains('pori') ||
      desc.contains('rauma')) {
    return lat >= 60.9 && lat <= 62.3 && lon >= 21.0 && lon <= 23.2;
  }
  if (desc.contains('pohjanmaa') ||
      desc.contains('alavieska') ||
      desc.contains('ylivieska') ||
      desc.contains('raahe') ||
      desc.contains('oulu') ||
      desc.contains('kalajoki')) {
    return lat >= 62.0 && lat <= 66.0 && lon >= 20.5 && lon <= 27.5;
  }
  if (desc.contains('pirkanmaa') || desc.contains('tampere')) {
    return lat >= 61.0 && lat <= 62.4 && lon >= 22.5 && lon <= 25.2;
  }
  if (desc.contains('häme') ||
      desc.contains('lanti') ||
      desc.contains('hämeenlinna')) {
    return lat >= 60.5 && lat <= 61.6 && lon >= 23.5 && lon <= 26.2;
  }
  if (desc.contains('karjala') ||
      desc.contains('imatra') ||
      desc.contains('lappeenranta')) {
    return lat >= 60.8 && lat <= 63.5 && lon >= 27.0 && lon <= 31.8;
  }
  if (desc.contains('savo') ||
      desc.contains('kuopio') ||
      desc.contains('mikkeli')) {
    return lat >= 61.3 && lat <= 63.9 && lon >= 26.0 && lon <= 30.2;
  }
  if (desc.contains('kainuu') || desc.contains('kajaani')) {
    return lat >= 63.7 && lat <= 65.5 && lon >= 27.0 && lon <= 30.5;
  }
  if (desc.contains('lappi') ||
      desc.contains('rovaniemi') ||
      desc.contains('enontekiö')) {
    return lat >= 65.2 && lat <= 70.1 && lon >= 20.5 && lon <= 29.5;
  }

  // Default: if areaDescription was provided but does not match the active area,
  // do not pollute the current location with distant regional warnings.
  return false;
}

bool _isPointInPolygon(LatLng point, List<LatLng> polygon) {
  var inside = false;
  var j = polygon.length - 1;
  for (var i = 0; i < polygon.length; i++) {
    if ((polygon[i].longitude > point.longitude) !=
            (polygon[j].longitude > point.longitude) &&
        (point.latitude <
            (polygon[j].latitude - polygon[i].latitude) *
                    (point.longitude - polygon[i].longitude) /
                    (polygon[j].longitude - polygon[i].longitude) +
                polygon[i].latitude)) {
      inside = !inside;
    }
    j = i;
  }
  return inside;
}

@riverpod
PointWeatherAlertState pointWeatherAlert(Ref ref) {
  final activeAlerts =
      ref.watch(activeAlertsStreamProvider).asData?.value ?? [];
  final lightning =
      ref.watch(recentLightningStreamProvider).asData?.value ?? [];
  final nearestLightning = ref.watch(lightningProximityProvider).asData?.value;

  final center = ref.watch(debouncedMapCameraPositionProvider).center;

  // Filter active alerts so only warnings relevant to the active location
  // (boat position or panned map center) are surfaced.
  final filteredAlerts = activeAlerts.where((alert) {
    return _isPointNearAlertPolygon(
      center,
      alert.polygon,
      alert.areaDescription,
    );
  }).toList();

  return PointWeatherAlertState(
    activeAlerts: filteredAlerts,
    lightningStrikes: lightning,
    nearestLightning: nearestLightning,
  );
}
