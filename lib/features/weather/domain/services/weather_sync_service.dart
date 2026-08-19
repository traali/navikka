import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/weather/di/weather_di.dart';
import 'package:sakkoja/features/weather/domain/repositories/weather_repository.dart';

part 'weather_sync_service.g.dart';

@Riverpod(keepAlive: true)
WeatherSyncService weatherSyncService(Ref ref) {
  return WeatherSyncService(ref.watch(weatherRepositoryProvider));
}

class WeatherSyncService {
  WeatherSyncService(this._repository);
  final WeatherRepository _repository;

  // Track last sync time to implement "Stale Check"
  final Map<String, DateTime> _lastSyncTimes = {};

  // Default stale threshold (e.g., 10 minutes)
  // FMI updates are typically every 10 mins or 1 hour depending on model.
  static const Duration defaultStaleThreshold = Duration(minutes: 10);

  bool _isStale(String key, [Duration threshold = defaultStaleThreshold]) {
    final lastSync = _lastSyncTimes[key];
    if (lastSync == null) return true;
    return DateTime.now().difference(lastSync) > threshold;
  }

  void _markSynced(String key) {
    _lastSyncTimes[key] = DateTime.now();
  }

  /// Syncs weather observations if stale.
  /// Returns locally cached data immediately if available is handled by Stream,
  /// this method only triggers the network fetch.
  Future<void> syncObservations(double lat, double lon) async {
    final key = 'obs_${lat.toStringAsFixed(3)}_${lon.toStringAsFixed(3)}';

    if (_isStale(key)) {
      Log.d('WeatherSync: Observations stale for $lat, $lon. Syncing...');
      try {
        await _repository.syncWeatherObservations(lat, lon);
        _markSynced(key);
      } catch (e, s) {
        Log.w('WeatherSync: Failed to sync observations for $lat, $lon', e, s);
        // Do not verify sync time, so it retries next time
      }
    } else {
      Log.d('WeatherSync: Observations fresh for $lat, $lon. Skipping.');
    }
  }

  Future<void> syncForecast(double lat, double lon) async {
    final key = 'forecast_${lat.toStringAsFixed(3)}_${lon.toStringAsFixed(3)}';

    if (_isStale(key)) {
      Log.d('WeatherSync: Forecast stale. Syncing...');
      try {
        await _repository.syncWeatherForecast(lat, lon);
        _markSynced(key);
      } catch (e, s) {
        Log.w('WeatherSync: Failed to sync forecast', e, s);
      }
    }
  }

  Future<void> syncWaves() async {
    const key = 'waves';
    if (_isStale(key)) {
      Log.d('WeatherSync: Waves stale. Syncing...');
      try {
        await _repository.syncWaveObservations();
        _markSynced(key);
      } catch (e, s) {
        Log.w('WeatherSync: Failed to sync waves', e, s);
      }
    }
  }

  Future<void> syncSeaLevel() async {
    const key = 'sea_level';
    if (_isStale(key)) {
      Log.d('WeatherSync: Sea Level stale. Syncing...');
      try {
        await _repository.syncSeaLevel();
        _markSynced(key);
      } catch (e, s) {
        Log.w('WeatherSync: Failed to sync sea level', e, s);
      }
    }
  }

  Future<void> syncAlerts() async {
    const key = 'alerts';
    if (_isStale(key)) {
      Log.d('WeatherSync: Alerts stale. Syncing...');
      try {
        await _repository.syncActiveAlerts();
        _markSynced(key);
      } catch (e, s) {
        Log.w('WeatherSync: Failed to sync alerts', e, s);
      }
    }
  }

  /// Force clear sync history
  void clearHistory() {
    _lastSyncTimes.clear();
  }
}
