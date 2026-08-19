import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';
import 'package:sakkoja/features/weather/data/weather_providers.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_data_state.dart';

part 'point_weather_data_provider.g.dart';

LatLng _snapToGrid(LatLng pos) {
  final lat = (pos.latitude * 100).round() / 100.0;
  final lon = (pos.longitude * 100).round() / 100.0;
  return LatLng(lat, lon);
}

@riverpod
PointWeatherDataState pointWeatherData(Ref ref) {
  final rawCenter = ref.watch(debouncedMapCameraPositionProvider).center;
  final center = _snapToGrid(rawCenter);

  return PointWeatherDataState(
    observations:
        ref.watch(weatherObservationsStreamProvider(center)).asData?.value ??
        [],
    forecast:
        ref.watch(weatherForecastStreamProvider(center)).asData?.value ?? [],
    waves:
        ref.watch(waveObservationsStreamProvider(center)).asData?.value ?? [],
    seaLevels: ref.watch(seaLevelStreamProvider(center)).asData?.value ?? [],
    waterQuality:
        ref
            .watch(
              waterQualityStreamProvider(
                lat: center.latitude,
                lon: center.longitude,
              ),
            )
            .asData
            ?.value ??
        [],
    algae:
        ref
            .watch(
              algaeReportsStreamProvider(
                lat: center.latitude,
                lon: center.longitude,
              ),
            )
            .asData
            ?.value ??
        [],
  );
}
