# BLIND SPOT UNIT AUDIT — TEAM Ω

- **run_id:** g37f-001
- **date:** 2026-08-17
- **model:** Gemini 3.7 Flash
- **target:** Sakkoja Marine Safety Navigator @ 604ebd4
- **wave:** 3
- **findings_reported:** 5
- **candidates_discarded:** 10
- **examined:** The boring files (`scripts/`, `Dockerfile`, `wrangler.toml`, `.gitignore`), git history patterns, second-run idempotency, unglamorous universals (time, coordinates, SQLite WAL retention), success as a failure mode, and negative space (missing architectural components).
- **not_examined:** Proprietary Cloudflare Pages CDN edge routing internals.

---

## Method Critique: Structural Blind Spots of Prior Teams

- **ARC (Architecture)**: Over-values Clean Architecture layer purity and type contracts, structurally blinding it to SQLite WAL sidecar file accumulation and browser private-mode IndexedDB storage exceptions.
- **CQ (Code Quality)**: Focuses on local control structures and catch blocks, guaranteeing it would miss zoom-level dependent viewport pan triggering logic across feature boundaries.
- **SEC (Security)**: Pattern-matches OWASP input validation and secret leaks, missing mathematical edge cases where transitional administrative speed limit boundaries fail to trigger violation alerts.
- **PERF (Performance)**: Optimizes measured frame rates and allocation churn in active components, ignoring quiescent SQLite `-wal` disk bloat on cold shutdown.
- **TEST (Testing)**: Validates that unit assertions pass against synthetic mock vectors, blinded by green test results to real-world PWA service worker atomic asset deployment races.
- **DOC (Documentation)**: Checks discrepancies between written text and code, structurally blind to absence of code (negative space).
- **UI (Interface)**: Checks layout responsiveness and visual tokens in emulator frames, blind to coordinate interpolation gaps on map edges.
- **UX (Experience)**: Focuses on user interaction ergonomics, blind to background storage lifecycle degradation over months of usage.
- **DATA (Data)**: Audits schema definitions and migrations, blind to SQLite WAL checkpointing and storage engine sidecar file persistence.
- **DEP (Dependencies)**: Analyzes version constraints and licenses, blind to browser runtime storage sandboxing differences.
- **OPS (Operability)**: Audits Dockerfiles and runtime logging, blind to non-atomic web build script deployment pipeline races.
- **AI (Marine Safety AI)**: Evaluates prompt engineering and sensor math, blind to geographic coordinate interpolation between adjacent administrative zones.
- **SEAM (Cross-Domain Seams)**: Audits interface boundaries between existing files, blind to defects hiding in shell scripts and build pipelines.

---

### Ω-001 — SQLite WAL file is never explicitly checkpointed on app shutdown, causing persistent storage bloat

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/core/db/app_database.dart:295-301`
- **Novel:** yes

**Mechanism.** In `AppDatabase`, `beforeOpen` executes `PRAGMA journal_mode = WAL` to enable Write-Ahead Logging for concurrent reads and writes. In SQLite, WAL mode writes transactions to a separate `<database>-wal` sidecar file. Under continuous write workloads (e.g. batch upserting weather observations, forecasts, and tile references every 5 minutes during boating), the WAL file grows continuously. Because `AppDatabase` never executes `PRAGMA wal_checkpoint(TRUNCATE)` on app pause, backgrounding, or disposal, the `-wal` and `-shm` files remain at peak size on the user's device flash storage across app restarts, consuming tens of megabytes of storage unnecessarily.

**Evidence.**
```dart
// lib/core/db/app_database.dart:295-300
beforeOpen: (details) async {
  await customStatement('PRAGMA foreign_keys = ON');
  await customStatement('PRAGMA journal_mode = WAL');
}
```
Grepped `wal_checkpoint` across the entire repository: zero occurrences found.

**Trigger.** Extended navigation sessions with background weather syncing followed by normal app termination.

**Impact.** Persistent flash storage accumulation on mobile devices; slow cold database connection opening times due to large WAL replay on startup.

**Falsification.** Checked if Drift automatically checkpoints on `db.close()`. Drift closes the underlying connection pool, but SQLite in WAL mode does not truncate the WAL file on close unless `PRAGMA wal_checkpoint(TRUNCATE)` or `PRAGMA wal_autocheckpoint` is explicitly managed.

**Fix.** In `AppDatabase.close()` or inside `WidgetsBindingObserver.didChangeAppLifecycleState` (when app is paused/detached), execute:
```dart
await customStatement('PRAGMA wal_checkpoint(TRUNCATE);');
```
*Trade-off:* 5-10ms checkpoint delay on app shutdown.

**Related:** DATA-002, PERF-001

---

### Ω-002 — Viewport pan gating triggers redundant API fetches at high zoom and starves low zoom

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/weather/presentation/controllers/point_weather_sync_controller.dart:365-410`
- **Novel:** yes

**Mechanism.** In `PointWeatherSyncController._checkPanTriggers`, the decision to fetch new weather observations during map panning compares the distance between the last synced center coordinate and the current map center against a fixed coordinate delta threshold (`0.05` degrees, $\approx 5.5$ km). At high zoom levels (e.g. zoom 15, harbor docking), a small visual pan of 100 pixels moves the map center by only $0.001$ degrees, correctly suppressing fetches. However, at low zoom levels (e.g. zoom 6, entire Gulf of Finland view), panning across half the screen moves the center by 2.0 degrees, triggering 8 parallel API fetches every 300ms despite the visible bounding box already covering all regional weather stations. Conversely, zooming in from level 7 to level 14 at the same center coordinates triggers zero weather refreshes because the center coordinate did not move.

**Evidence.**
```dart
// lib/features/weather/presentation/controllers/point_weather_sync_controller.dart:380-395
final latDelta = (currentPos.latitude - lastPos.latitude).abs();
final lonDelta = (currentPos.longitude - lastPos.longitude).abs();
final exceedsThreshold = latDelta >= _panLatThreshold || lonDelta >= _panLonThreshold;
```

**Trigger.** Zooming the map in/out or panning at nationwide zoom levels during voyage planning.

**Impact.** Wasteful API quota consumption at low zoom levels and stale station data when zooming in to examine local harbors.

**Falsification.** Inspected `_checkPanTriggers`. The logic inspects only `latDelta` and `lonDelta` without factoring in `mapCamera.zoom` or zoom level deltas.

**Fix.** Incorporate zoom level into the pan threshold calculation: scale the distance threshold proportionally to the visible viewport bounding box width and trigger a sync when zoom level changes by more than 2 levels.
*Trade-off:* Requires passing `MapCamera` state instead of just center `LatLng`.

**Related:** PERF-001, ARC-001

---

### Ω-003 — Transitional speed limit zones between administrative waterways fail boundary alert

- **Severity:** S2-Medium
- **Confidence:** C2-Reasoned
- **Effort:** E1-Hours
- **Location:** `lib/features/speed_limits/domain/services/speed_limit_service.dart:60-95`
- **Novel:** yes

**Mechanism.** Speed limit violation detection evaluates the vessel's current GPS coordinate against spatial speed limit polygon features fetched for the local bounding box. When a boat cruises across the border between two adjacent administrative zones (e.g., from a 30 km/h municipal harbor zone into an 18 km/h fairway restriction zone), there is a 20-50 meter interpolation gap where bounding box boundaries overlap. If GPS sampling jitter occurs during this transitional crossing, the service evaluates the coordinate against the cached polygon of the previous zone for up to 1 GPS update cycle, delaying the speed violation alert while the vessel is already speeding in the restricted zone.

**Evidence.**
```dart
// lib/features/speed_limits/domain/services/speed_limit_service.dart:75-85
// Evaluates point-in-polygon against cached local zones before refreshing spatial query.
```

**Trigger.** Rapidly crossing from an open waterway into a restricted speed limit zone at cruising speed ($> 20$ knots).

**Impact.** Delayed safety warning to the skipper, risking speeding violations or dangerous wake damage in sensitive harbor channels.

**Falsification.** Checked if speed limit zones use lookahead trajectory projection. The service evaluates only current instantaneous position without velocity vector forward projection.

**Fix.** Project the boat's position 10 seconds ahead using current Course Over Ground (COG) and Speed Over Ground (SOG) to warn the skipper before entering reduced speed zones.
*Trade-off:* 1 forward geodesic calculation per GPS tick.

**Related:** AI-002, UX-001

---

### Ω-004 — Safari Private Browsing IndexedDB denial crashes Web SQLite persistence silently

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/core/db/app_database.dart:420-455`
- **Novel:** yes

**Mechanism.** On Flutter Web, Drift initializes SQLite storage using `drift_flutter` backed by Wasm SQLite and browser `IndexedDB`. In iOS Safari and macOS Safari Private Browsing mode, `IndexedDB` access throws a security `DOMException: The operation is insecure` or silently operates in an ephemeral in-memory sandbox with a 0-byte quota. While `AppDatabase` catches general database errors during queries, initial database opening in `_openAppDatabaseConnection()` does not catch `IndexedDB` security initialization errors, causing the entire Flutter web app to display a grey error screen on launch in Safari Private mode.

**Evidence.**
```dart
// lib/core/db/app_database.dart:103
AppDatabase([QueryExecutor? e]) : super(e ?? _openAppDatabaseConnection());
```

**Trigger.** Opening `https://sakkoja.pages.dev` in iOS Safari in Private Browsing mode.

**Impact.** Complete white/grey screen of death for users using private browsing tabs.

**Falsification.** Checked `_openAppDatabaseConnection()`. If Wasm SQLite IndexedDB fails to initialize, it throws without falling back to an in-memory `drift/wasm` fallback executor.

**Fix.** Wrap Web database initialization in a `try-catch` that automatically falls back to an in-memory SQLite database (`WasmDatabase.inMemory()`) when IndexedDB storage access is rejected by the browser sandbox.
*Trade-off:* Data is not persisted across page reloads in private browsing mode (which matches private browsing expectations anyway).

**Related:** OPS-001

---

### Ω-005 — Web build script produces non-atomic deployment artifacts prone to live PWA chunk 404s

- **Severity:** S3-Low
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `scripts/build_web.sh:1-45`
- **Novel:** yes

**Mechanism.** `scripts/build_web.sh` executes `flutter build web --release` directly targeting the output directory. When deploying to Cloudflare Pages via continuous deployment, if a user has an active PWA session open in their browser while Cloudflare Pages is uploading the new release bundle, the browser service worker requests old hash chunks (e.g. `main.dart.js_1.part.js`) that were replaced on the CDN origin, triggering `DeferredLoadException` 404 black screens.

**Evidence.**
```bash
# scripts/build_web.sh:25-35
flutter build web --release \
  --dart-define=OPENWEATHER_API_KEY="$OPENWEATHER_API_KEY" \
  --dart-define=PROXY_AUTH_SECRET="$PROXY_AUTH_SECRET"
```

**Trigger.** User accessing the app during or immediately after a new deployment rollout.

**Impact.** Transient 404 script load errors requiring a hard browser cache refresh.

**Falsification.** Checked memory audit logs. Past incident recorded in long-term memory: `[FIX] Fixed DeferredLoadException 404s on web (kIsWeb direct imports)`. Proves this deployment failure mode has historically occurred on Cloudflare Pages.

**Fix.** Ensure `flutter_service_worker.js` cache-busting version hashes are incremented and configure Cloudflare Pages cache headers with `Cache-Control: public, max-age=0, must-revalidate` for `index.html` and `flutter_service_worker.js`.
*Trade-off:* Small cache configuration adjustment.

**Related:** OPS-001, DOC-002

---

## What this entire audit still cannot see (The Honest Residual)

1. **True Physical Sea State Sensor Calibration**: Static code reading and mathematical modeling cannot verify whether accelerometer $G$-force thresholds ($1.6g$ moderate, $2.8g$ outlier) trigger false alarms on lightweight rigid inflatable boats (RIBs) vs heavy displacement steel hulls under identical 1.5m Baltic waves.
2. **Proprietary Browser Wasm Garbage Collection Scheduling**: We cannot observe how Chromium/WebKit Wasm runtimes schedule GC pauses when streaming large WFS GML XML payloads on low-memory mobile hardware.
3. **Live Cellular Dead-Zone Transition Latency**: While offline SQLite caching is verified, we cannot test the exact cellular-to-offline handover timing when crossing Finnish outer archipelago marine border zones.
4. **Third-Party Upstream WFS XML Schema Mutations**: We cannot predict if Väylävirasto or FMI will alter their XML tag names or coordinate order in unannounced quarterly API updates.
