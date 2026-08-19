import 'package:flutter_test/flutter_test.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_sync_controller.dart';

void main() {
  group('PointWeatherSyncState equality', () {
    test('identical instances are equal', () {
      const state = PointWeatherSyncState();
      expect(state == state, true);
    });

    test('same values are equal', () {
      const a = PointWeatherSyncState(
        isSyncing: false,
        error: null,
        lastSuccessfulSync: null,
      );
      const b = PointWeatherSyncState();
      expect(a == b, true);
    });

    test('different isSyncing are not equal', () {
      const a = PointWeatherSyncState(isSyncing: false);
      const b = PointWeatherSyncState(isSyncing: true);
      expect(a == b, false);
    });

    test('different error are not equal', () {
      const a = PointWeatherSyncState(error: null);
      const b = PointWeatherSyncState(error: 'Network error');
      expect(a == b, false);
    });

    test('different lastSuccessfulSync are not equal', () {
      final now = DateTime.now();
      final earlier = now.subtract(const Duration(minutes: 5));
      const a = PointWeatherSyncState();
      final b = PointWeatherSyncState(lastSuccessfulSync: now);
      final c = PointWeatherSyncState(lastSuccessfulSync: earlier);
      expect(a == b, false);
      expect(b == c, false);
    });

    test('hashCode is consistent with ==', () {
      const a = PointWeatherSyncState(isSyncing: true, error: 'err');
      const b = PointWeatherSyncState(isSyncing: true, error: 'err');
      expect(a == b, true);
      expect(a.hashCode, b.hashCode);
    });

    test('copyWith preserves equality', () {
      const original = PointWeatherSyncState(isSyncing: false, error: null);
      final copied = original.copyWith();
      expect(original == copied, true);
    });
  });
}
