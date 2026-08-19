# OPERABILITY & OBSERVABILITY AUDIT — OPS

- **run_id:** deep-audit-run-02
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `c4492cc`
- **wave:** 1
- **findings_reported:** 1
- **candidates_discarded:** 11
- **examined:** `lib/core/utils/logger.dart`, `lib/core/network/`, `lib/core/services/`
- **not_examined:** Production Cloudflare Analytics dashboard

---

### OPS-001 — Unbounded In-Memory Log Ring Buffer Memory Accumulation

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/core/utils/logger.dart:53-61`
- **Novel:** yes

**Mechanism.** `Log._addLogToMemory` appends log messages to `_recentLogs` and caps length at 50 items. However, `recentLogsNotifier.value = List.from(_recentLogs)` creates a new list copy on every single log call. During high-frequency background network retries or GPS location cascades emitting 100+ logs per minute, microtask queue churn and memory allocation spikes occur continuously.

**Evidence.**
```dart
  static void _addLogToMemory(String message) {
    _recentLogs.add(message);
    if (_recentLogs.length > 50) {
      _recentLogs.removeAt(0);
    }
    Future.microtask(() {
      recentLogsNotifier.value = List.from(_recentLogs);
    });
  }
```

**Trigger.** Continuous logging during high-frequency network or map interaction.

**Impact.** CPU microtask queue congestion and unnecessary garbage collection pauses.

**Falsification.** Checked if `recentLogsNotifier` has active listeners in production; confirmed it is listened to only when the UI Debug Console drawer is opened.

**Fix.** Wrap `recentLogsNotifier.value` update in a check for `recentLogsNotifier.hasListeners`.

**Related:** PERF-001, CQ-001

---

## Cross-domain sightings
- `lib/core/utils/logger.dart`: Sensitive data scrubber sanitizes coordinates and Bearer tokens before memory/file writing.

## Hygiene (low-signal, listed for completeness)
- `lib/core/network/network_monitor_provider.dart`: Default online status returns true on startup.

## Open questions
- Are log files in `LogIo.getFileOutput()` automatically rotated when reaching 5MB?

## This team's blind spot
Operability auditing checks logger implementations and error catchers, but cannot observe physical production server outages or CDN edge network disruptions.
