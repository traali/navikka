import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

/// Lightweight wrapper for Timeline performance spans.
/// Instrument hot paths (NavAids, Weather, Map rendering) without overhead in release.
class PerformanceTracker {
  /// Executes [body] wrapped in a named Dart Timeline span.
  /// Spans appear in Chrome Performance Panel and Flutter DevTools.
  static T traceSync<T>(String name, T Function() body) {
    if (kReleaseMode) {
      return body();
    }
    developer.Timeline.startSync(name);
    try {
      return body();
    } finally {
      developer.Timeline.finishSync();
    }
  }

  /// Executes an async [body] wrapped in named Dart Timeline spans.
  static Future<T> traceAsync<T>(String name, Future<T> Function() body) async {
    if (kReleaseMode) {
      return body();
    }
    developer.Timeline.startSync(name);
    try {
      return await body();
    } finally {
      developer.Timeline.finishSync();
    }
  }
}
