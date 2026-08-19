import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lightning_dismissal_provider.g.dart';

/// Riverpod Notifier to track acknowledged/dismissed lightning strike timestamps.
///
/// Enables the skipper to "sign off" on active weather alerts ("I have seen these,
/// come back when updates"). Alerts will only re-appear if newer
/// lightning strikes are detected.
@riverpod
class LightningDismissal extends _$LightningDismissal {
  @override
  DateTime? build() {
    return null;
  }

  /// Mutes current lightning strikes up to the specified [strikeTime].
  void dismissLightning(DateTime strikeTime) {
    state = strikeTime;
  }

  /// Resets the sign-off state (e.g. for testing or when cache is cleared).
  void reset() {
    state = null;
  }
}
