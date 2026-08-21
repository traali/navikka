import 'package:sakkoja/core/utils/logger.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

/// Service to keep device screen awake during active navigation, boating, and voyage recording.
class WakelockService {
  static bool _isEnabled = false;

  /// Whether the screen is currently locked awake.
  static bool get isEnabled => _isEnabled;

  /// Enables screen wakelock (prevents screen from turning off).
  static Future<void> enable() async {
    if (_isEnabled) return;
    try {
      await WakelockPlus.enable();
      _isEnabled = true;
      Log.i('[Wakelock] Screen wake lock enabled for active navigation.');
    } catch (e) {
      Log.w('[Wakelock] Failed to enable wakelock: $e');
    }
  }

  /// Disables screen wakelock (allows device to sleep normally).
  static Future<void> disable() async {
    if (!_isEnabled) return;
    try {
      await WakelockPlus.disable();
      _isEnabled = false;
      Log.i('[Wakelock] Screen wake lock disabled.');
    } catch (e) {
      Log.w('[Wakelock] Failed to disable wakelock: $e');
    }
  }

  /// Updates wakelock state based on [shouldKeepAwake].
  static Future<void> setEnabled(bool shouldKeepAwake) async {
    if (shouldKeepAwake) {
      await enable();
    } else {
      await disable();
    }
  }
}
