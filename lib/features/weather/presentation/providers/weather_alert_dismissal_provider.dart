import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider tracking acknowledged weather alert identifiers (event + description key).
final weatherAlertDismissalProvider =
    NotifierProvider<WeatherAlertDismissalNotifier, Set<String>>(
      WeatherAlertDismissalNotifier.new,
    );

class WeatherAlertDismissalNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => {};

  /// Acknowledges a specific weather alert by key.
  void dismissAlert(String alertKey) {
    state = {...state, alertKey};
  }

  /// Acknowledges multiple weather alerts at once.
  void dismissAllAlerts(Iterable<String> alertKeys) {
    state = {...state, ...alertKeys};
  }

  /// Resets all dismissed alerts.
  void reset() {
    state = {};
  }
}
