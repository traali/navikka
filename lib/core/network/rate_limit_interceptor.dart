import 'dart:async';
import 'package:dio/dio.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Configuration for rate limiting
class RateLimitConfig {
  const RateLimitConfig(this.maxRequests, this.window);
  final int maxRequests;
  final Duration window;
}

/// Dio interceptor that implements rate limiting to prevent self-DoS.
///
/// Persists request history to SharedPreferences to enforce limits across app restarts.
class RateLimitInterceptor extends Interceptor {
  RateLimitInterceptor({
    required this.prefs,
    this.defaultConfig = const RateLimitConfig(10, Duration(seconds: 10)),
    this.domainConfigs = const {},
  }) {
    _loadHistory();
  }
  final RateLimitConfig defaultConfig;
  final Map<String, RateLimitConfig> domainConfigs;
  final SharedPreferences prefs;

  static const String _storageKeyPrefix = 'ratelimit_history_';

  // Tracks request timestamps per domain
  final Map<String, List<DateTime>> _requestHistory = {};
  Timer? _persistTimer;
  static const _persistInterval = Duration(seconds: 60);

  /// Serialization queue to prevent RMW races on SharedPreferences per domain
  final Map<String, Future<void>> _saveLockMap = {};

  void _loadHistory() {
    final keys = prefs.getKeys().where((k) => k.startsWith(_storageKeyPrefix));
    for (final key in keys) {
      try {
        final domain = key.substring(_storageKeyPrefix.length);
        final list = prefs.getStringList(key) ?? [];
        _requestHistory[domain] = list
            .map(DateTime.tryParse)
            .whereType<DateTime>()
            .toList();
      } catch (e, s) {
        Log.w('RateLimit: Failed to load history for key $key', e, s);
      }
    }
  }

  void _schedulePersist() {
    _persistTimer ??= Timer(_persistInterval, () async {
      _persistTimer = null;
      final domains = _requestHistory.keys.toList();
      for (final domain in domains) {
        final history = _requestHistory[domain];
        try {
          if (history == null || history.isEmpty) {
            await prefs.remove('$_storageKeyPrefix$domain');
          } else {
            final list = history.map((e) => e.toIso8601String()).toList();
            await prefs.setStringList('$_storageKeyPrefix$domain', list);
          }
        } catch (e, s) {
          Log.w('RateLimit: Failed to persist history for $domain', e, s);
        }
      }
    });
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final originalUrlStr = options.extra['original_url'] as String?;
    final originalHost = originalUrlStr != null
        ? Uri.tryParse(originalUrlStr)?.host
        : null;
    final domain = (originalHost != null && originalHost.isNotEmpty)
        ? originalHost
        : options.uri.host;

    // Find config for this domain or use default
    final config = domainConfigs[domain] ?? defaultConfig;

    // Use a lock to ensure atomic history check-and-add per domain
    final lastLock = _saveLockMap[domain] ?? Future.value();
    final completer = Completer<void>();
    _saveLockMap[domain] = completer.future;

    try {
      await lastLock; // Wait for previous operations on this domain to finish
      // A queued request must use the time at which it owns the lock. Using
      // its arrival time adds a second, stale delay after another request
      // has already waited for this domain's window.
      final now = DateTime.now();

      // Clean up old entries based on the specific window for this domain
      _cleanupOldRequests(domain, now, config.window);

      final history = _requestHistory[domain] ?? [];

      if (history.length >= config.maxRequests) {
        // Calculate how long to wait
        final oldestRequest = history.first;
        final windowEnd = oldestRequest.add(config.window);
        final waitDuration = windowEnd.difference(now);

        if (waitDuration.isNegative || waitDuration == Duration.zero) {
          // Window has passed, proceed
          await _addRequest(domain, now);
          handler.next(options);
        } else {
          // Rate limited - wait for window to reset
          Log.w(
            'RateLimit: Throttling request to $domain for ${waitDuration.inMilliseconds}ms',
          );
          await Future<void>.delayed(waitDuration);

          if (options.cancelToken?.isCancelled == true) {
            Log.d('RateLimit: Discarded cancelled request to $domain');
            handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.cancel,
                error: 'Request cancelled during rate-limit delay',
              ),
            );
            return;
          }

          // Clean up and add new request
          final nextNow = DateTime.now();
          _cleanupOldRequests(domain, nextNow, config.window);
          await _addRequest(domain, nextNow);
          handler.next(options);
        }
      } else {
        // Under limit, proceed immediately
        await _addRequest(domain, now);
        handler.next(options);
      }
    } finally {
      completer.complete();
    }
  }

  Future<void> _addRequest(String domain, DateTime timestamp) async {
    _requestHistory[domain] ??= [];
    _requestHistory[domain]!.add(timestamp);
    _schedulePersist();
  }

  void _cleanupOldRequests(String domain, DateTime now, Duration window) {
    final history = _requestHistory[domain];
    if (history == null) return;

    final cutoff = now.subtract(window);
    history.removeWhere((timestamp) => timestamp.isBefore(cutoff));
  }

  /// Resets rate limit tracking
  Future<void> reset() async {
    _requestHistory.clear();
    final keys = prefs.getKeys().where((k) => k.startsWith(_storageKeyPrefix));
    for (final key in keys) {
      await prefs.remove(key);
    }
  }
}
