import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Safe haptic feedback wrapper.
///
/// On web, HapticFeedback throws or logs "Intervention" if called before user interaction.
/// This wrapper catches those errors and allows skipping background haptics on Web.
class SafeHaptics {
  /// Whether the user has interacted with the app at least once.
  /// This helps avoid "Intervention" warnings on Web for background haptics.
  static bool _hasInteractedOnWeb = false;

  /// Light impact feedback - use for subtle confirmations
  static void light({bool isUserTriggered = true}) {
    _safe(HapticFeedback.lightImpact, isUserTriggered);
  }

  /// Medium impact feedback - use for confirmations
  static void medium({bool isUserTriggered = true}) {
    _safe(HapticFeedback.mediumImpact, isUserTriggered);
  }

  /// Heavy impact feedback - use for warnings
  static void heavy({bool isUserTriggered = true}) {
    _safe(HapticFeedback.heavyImpact, isUserTriggered);
  }

  /// Selection click - use for toggles and selections
  static void selection({bool isUserTriggered = true}) {
    _safe(HapticFeedback.selectionClick, isUserTriggered);
  }

  static void _safe(Future<void> Function() action, bool isUserTriggered) {
    if (kIsWeb) {
      if (isUserTriggered) {
        _hasInteractedOnWeb = true;
      }

      // Skip haptics on Web if it's not a user-triggered event or if we haven't
      // had a confirmed interaction yet (to avoid console "Intervention" logs).
      if (!isUserTriggered && !_hasInteractedOnWeb) {
        return;
      }

      action().catchError((_) {});
    } else {
      action();
    }
  }
}
