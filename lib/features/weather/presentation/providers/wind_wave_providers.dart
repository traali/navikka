import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/features/map/presentation/providers/feature_flag_provider.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';

import 'package:sakkoja/features/weather/data/datasources/open_meteo_wind_data_source.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_field.dart';
import 'package:sakkoja/features/weather/domain/entities/wind_field.dart';

part 'wind_wave_providers.g.dart';

/// Forecast time slider offset in hours (0, 3, 6, 9, 12).
@riverpod
class ForecastTimeOffset extends _$ForecastTimeOffset {
  @override
  int build() => 0;

  void setOffset(int hours) {
    state = hours.clamp(0, 12);
  }
}

@riverpod
OpenMeteoWindDataSource openMeteoWindDataSource(Ref ref) {
  return OpenMeteoWindDataSource(ref.watch(dioProvider));
}

/// Wind field provider returning spatial grid points for current camera viewport.
/// Evaluates ONLY when windWaveFeatureFlag is true to conserve battery/network.
@riverpod
Future<WindField> windField(Ref ref) async {
  final isFlagEnabled = ref.watch(windWaveFeatureFlagProvider);
  if (!isFlagEnabled) {
    final camera = ref.read(significantMapCameraPositionProvider);
    return WindField(
      validTime: DateTime.now(),
      southWest: camera.center,
      northEast: camera.center,
      points: const [],
    );
  }

  final camera = ref.watch(significantMapCameraPositionProvider);
  final hourOffset = ref.watch(forecastTimeOffsetProvider);
  final dataSource = ref.watch(openMeteoWindDataSourceProvider);

  final southWest = camera.center; // Bbox approximation
  final northEast = camera.center;

  return dataSource.fetchWindGrid(
    southWest: southWest,
    northEast: northEast,
    forecastHourOffset: hourOffset,
  );
}

/// Wave field provider returning significant wave height grid points.
@riverpod
Future<WaveField> waveField(Ref ref) async {
  final isFlagEnabled = ref.watch(windWaveFeatureFlagProvider);
  if (!isFlagEnabled) {
    final camera = ref.read(significantMapCameraPositionProvider);
    return WaveField(
      validTime: DateTime.now(),
      southWest: camera.center,
      northEast: camera.center,
      points: const [],
    );
  }

  final camera = ref.watch(significantMapCameraPositionProvider);
  final hourOffset = ref.watch(forecastTimeOffsetProvider);
  final dataSource = ref.watch(openMeteoWindDataSourceProvider);

  return dataSource.fetchWaveGrid(
    southWest: camera.center,
    northEast: camera.center,
    forecastHourOffset: hourOffset,
  );
}
