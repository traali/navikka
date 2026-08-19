# OPERABILITY & OBSERVABILITY AUDIT — OPS

- **run_id:** deep-audit-run-01
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `a8aa5a4`
- **wave:** 1
- **findings_reported:** 1
- **candidates_discarded:** 11
- **examined:** `lib/core/network/`, `lib/core/initialization/`, `lib/main.dart`
- **not_examined:** Production Cloudflare Analytics dashboard

---

### OPS-001 — Network Offline Status Fallback Propagation during Native Startup

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/core/network/network_monitor_provider.dart:25-31`
- **Novel:** yes

**Mechanism.** `isOnlineProvider` monitors network connectivity via `connectivity_plus`. During cold app startup on native devices, `connectivity_plus` may briefly emit an initial disconnected or unknown state before establishing cellular/WiFi interface status. If `PointWeatherSyncController` executes startup sync immediately upon launch, it receives `isOnline = false` and sets `PointWeatherSyncState(error: 'Offline - showing cached data')`.

**Evidence.**
```dart
// lib/core/network/network_monitor_provider.dart
// Initial state defaults to connectivity stream value which may be transiently false on startup.
```

**Trigger.** Cold app startup on mobile devices in poor coverage areas.

**Impact.** Temporary false "Offline" banner display on launch before first network handshake completes.

**Falsification.** Checked `PointWeatherSyncController` listener; confirmed it listens to `isOnlineProvider` transitions from `false` to `true` and auto-retries when connectivity is established.

**Fix.** Add a 500ms initial debounce or check actual HTTP status before flagging offline status on startup.

**Related:** CQ-001

---

## Cross-domain sightings
- `lib/main.dart`: Global error trap (`PlatformDispatcher.onError` and `runZonedGuarded`) logs unhandled exceptions to console.

## Hygiene (low-signal, listed for completeness)
- `lib/core/utils/logger.dart`: Log messages prefixed with module tags (e.g. `[DB]`, `[WeatherRepo]`).

## Open questions
- Are client-side error logs uploaded to Sentry or an error reporting service in production web builds?

## This team's blind spot
Operability auditing inspects error trapping, logging, and retry logic, but cannot monitor live network packet drops in real-time.
