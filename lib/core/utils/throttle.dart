import 'dart:async';

/// A utility to limit the frequency of function calls.
/// Useful for location updates or UI recalculations during high-frequency events.
class Throttle {
  Throttle(this.duration);
  final Duration duration;
  Timer? _timer;
  void Function()? _pendingAction;

  /// Executes the latest pending action after the throttle duration.
  ///
  /// Calls made during the waiting period replace the pending action. This
  /// makes the utility useful for recalculations where only the newest input
  /// is meaningful.
  void call(void Function() action) {
    _pendingAction = action;
    if (_timer != null) return;

    _timer = Timer(duration, () {
      _timer = null;
      final pendingAction = _pendingAction;
      _pendingAction = null;
      pendingAction?.call();
    });
  }

  /// Cancels any pending throttle timers.
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _pendingAction = null;
  }
}
