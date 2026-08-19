import 'dart:async';

import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/map/presentation/providers/map_camera_provider.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_alert_provider.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_alert_state.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_data_provider.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_data_state.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_state.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_sync_controller.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_ui_controller.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_ui_state.dart';

export 'package:sakkoja/features/weather/presentation/controllers/point_weather_state.dart';

part 'point_weather_controller.g.dart';

bool _listEq<T>(List<T> a, List<T> b) =>
    identical(a, b) || ListEquality<T>().equals(a, b);

@riverpod
class PointWeatherController extends _$PointWeatherController {
  bool _isDisposed = false;
  bool _hasBuiltOnce = false;

  @override
  PointWeatherState build() {
    ref.onDispose(() => _isDisposed = true);

    final dataState = ref.watch(pointWeatherDataProvider);
    final alertState = ref.watch(pointWeatherAlertProvider);
    final uiState = ref.watch(pointWeatherUiControllerProvider);
    final syncState = ref.watch(pointWeatherSyncControllerProvider);

    return _calculateState(
      dataState: dataState,
      alertState: alertState,
      uiState: uiState,
      syncState: syncState,
    );
  }

  PointWeatherState _calculateState({
    required PointWeatherDataState dataState,
    required PointWeatherAlertState alertState,
    required PointWeatherUiState uiState,
    required PointWeatherSyncState syncState,
  }) {
    final nearestWave = dataState.waves.isNotEmpty
        ? dataState.waves.first
        : null;
    final nearestSeaLevel = dataState.seaLevels.isNotEmpty
        ? dataState.seaLevels.first
        : null;
    final newWeather = dataState.observations.isNotEmpty
        ? dataState.observations.last
        : null;
    final newWaterQuality = dataState.waterQuality.isNotEmpty
        ? dataState.waterQuality.first
        : null;
    final newAlgae = dataState.algae.isNotEmpty ? dataState.algae.first : null;

    final dataTimestamp = dataState.observations.isNotEmpty
        ? dataState.observations.last.timestamp
        : syncState.lastSuccessfulSync ??
              DateTime.fromMillisecondsSinceEpoch(0);

    if (_hasBuiltOnce) {
      final prev = state;
      final forecastSame = _listEq(prev.forecast, dataState.forecast);
      final alertsSame = _listEq(prev.activeAlerts, alertState.activeAlerts);
      final lightningSame = _listEq(
        prev.lightningStrikes,
        alertState.lightningStrikes,
      );
      final radarTimestampsSame = _listEq(
        prev.radarTimestamps,
        uiState.radarTimestamps,
      );

      if (prev.weather == newWeather &&
          prev.wave == nearestWave &&
          prev.seaLevel == nearestSeaLevel &&
          prev.nearestLightningDistanceMeters == alertState.nearestLightning &&
          prev.waterQuality == newWaterQuality &&
          prev.algae == newAlgae &&
          prev.lastUpdated == dataTimestamp &&
          prev.syncError == syncState.error &&
          prev.isSyncing == syncState.isSyncing &&
          prev.lastSuccessfulSync == syncState.lastSuccessfulSync &&
          prev.isRadarVisible == uiState.isRadarVisible &&
          prev.isAnimating == uiState.isAnimating &&
          prev.currentTimestampIndex == uiState.currentTimestampIndex &&
          forecastSame &&
          alertsSame &&
          lightningSame &&
          radarTimestampsSame) {
        return prev;
      }
    }
    _hasBuiltOnce = true;

    return PointWeatherState(
      weather: newWeather,
      wave: nearestWave,
      seaLevel: nearestSeaLevel,
      forecast: dataState.forecast,
      activeAlerts: alertState.activeAlerts,
      lightningStrikes: alertState.lightningStrikes,
      nearestLightningDistanceMeters: alertState.nearestLightning,
      waterQuality: newWaterQuality,
      algae: newAlgae,
      lastUpdated: dataTimestamp,

      syncError: syncState.error,
      lastSuccessfulSync: syncState.lastSuccessfulSync,
      isSyncing: syncState.isSyncing,

      isRadarVisible: uiState.isRadarVisible,
      isAnimating: uiState.isAnimating,
      radarTimestamps: uiState.radarTimestamps,
      currentTimestampIndex: uiState.currentTimestampIndex,
    );
  }

  // --- Actions ---

  void toggleRadar() {
    ref.read(pointWeatherUiControllerProvider.notifier).toggleRadar();
  }

  void toggleAnimation() {
    ref.read(pointWeatherUiControllerProvider.notifier).toggleAnimation();
  }

  void setTimestampIndex(int index) {
    ref
        .read(pointWeatherUiControllerProvider.notifier)
        .setTimestampIndex(index);
  }

  Future<void> clearCache() async {
    if (_isDisposed) return;
    try {
      await ref.read(pointWeatherSyncControllerProvider.notifier).clearCache();
    } catch (e, s) {
      final errStr = e.toString().toLowerCase();
      if (errStr.contains('disposed') || errStr.contains('deactivated')) {
        return;
      }
      Log.w('[Weather] clearCache failed', e, s);
      rethrow;
    }
  }

  Future<void> syncAll() async {
    if (_isDisposed) return;
    final camera = ref.read(debouncedMapCameraPositionProvider);
    await ref
        .read(pointWeatherSyncControllerProvider.notifier)
        .attemptSync(camera.center);
  }
}
