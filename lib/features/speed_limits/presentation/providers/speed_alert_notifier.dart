import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';

part 'speed_alert_notifier.g.dart';

/// Notifier that monitors speed vs limits and triggers haptic alerts.
/// Use strictly for "Background/Headless" logic. UI should just listen.
@Riverpod(keepAlive: true)
class SpeedAlertNotifier extends _$SpeedAlertNotifier {
  bool _isCurrentlyViolating = false;

  @override
  void build() {
    ref.listen(mapProvider, (previous, next) {
      final (currentSpeed, limit) = (
        next.currentSpeedKmh,
        next.currentZone?.speedLimitKmh ?? 0,
      );
      _checkSpeed(currentSpeed, limit);
    });

    final mapState = ref.read(mapProvider);
    _checkSpeed(
      mapState.currentSpeedKmh,
      mapState.currentZone?.speedLimitKmh ?? 0,
    );
  }

  void _checkSpeed(double currentSpeed, int limit) {
    if (limit <= 0) {
      if (_isCurrentlyViolating) {
        _isCurrentlyViolating = false; // Reset if entering no-limit zone
      }
      return;
    }

    final isViolating = currentSpeed > limit;

    // Rising Edge Logic: Safe -> Speeding
    if (isViolating && !_isCurrentlyViolating) {
      Log.i(
        'SpeedAlert: VIOLATION TRIGGERED (Speed: ${currentSpeed.toStringAsFixed(1)} / Limit: $limit)',
      );
      _triggerAlert();
      _isCurrentlyViolating = true;
    }
    // Falling Edge Logic: Speeding -> Safe
    else if (!isViolating && _isCurrentlyViolating) {
      Log.d('SpeedAlert: Violation cleared');
      _isCurrentlyViolating = false;
    }
  }

  Future<void> _triggerAlert() async {
    try {
      // 3-pulse sequence for heavy impact
      await HapticFeedback.heavyImpact();
      await Future<void>.delayed(const Duration(milliseconds: 150));
      await HapticFeedback.heavyImpact();
      await Future<void>.delayed(const Duration(milliseconds: 150));
      await HapticFeedback.heavyImpact();
    } catch (e, s) {
      Log.w('SpeedAlert: Haptics failed', e, s);
    }
  }
}
