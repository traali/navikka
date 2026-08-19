# SEAM AUDIT — SEAM (Wave 2)

- **run_id:** deep-audit-run-01
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `a8aa5a4`
- **wave:** 2
- **findings_reported:** 3
- **candidates_discarded:** 5
- **examined:** All Wave 1 domain audit files (`10_` through `21_`)
- **not_examined:** Uncommitted experimental feature branches

---

### SEAM-001 — Unrounded Coordinates Bridge Architecture and Database Performance Cascades

- **Severity:** S1-High
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/weather/presentation/controllers/point_weather_data_provider.dart:10-42` ↔ `lib/features/weather/data/datasources/drift_weather_store.dart:354-380`
- **Novel:** yes

**Mechanism.** ARC-001 identified that `pointWeatherData` passes unrounded `LatLng` coordinates into Riverpod family providers (`weatherObservationsStreamProvider(center)`). DATA-001 and PERF-001 examined database stream behavior. In the seam between them: because Riverpod creates new family provider instances on micro-moves, each new instance subscribes to Drift SQLite `.watch()` streams. This causes Drift to re-run SQL queries and `asyncMap` station resolutions continuously during map panning.

**Evidence.**
```markdown
Quoting ARC-001 (10_ARCHITECTURE.md):
"Riverpod uses identity/equality on family arguments; because LatLng double values change continuously..."

Quoting PERF-001 (13_PERFORMANCE.md):
"12 reactive asyncMap streams fire per GPS update due to unrounded coordinates cascading through provider graph..."
```

**Trigger.** Continuous map panning or vessel motion while weather overlay streams are active.

**Impact.** Dual-domain failure: architecture provider proliferation triggering database query storms.

**Falsification.** Traced call chain from `debouncedMapCameraPositionProvider` -> `pointWeatherData` -> `weatherObservationsStreamProvider` -> `DriftWeatherStore._getStationsByIds`. Confirmed snapping coordinates at the provider layer (`_snapToGrid`) eliminates both provider proliferation and database query cascades.

**Fix.** Grid-snap `center` coordinates in `point_weather_data_provider.dart` before calling family stream providers.

**Related:** ARC-001, PERF-001, DATA-001

---

### SEAM-002 — Provider Auto-Dispose Defeats Repository In-Memory Batching Invariant

- **Severity:** S1-High
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/tracking/presentation/providers/active_track_provider.dart:128` ↔ `lib/features/tracking/data/repositories/track_repository.dart:180`
- **Novel:** yes

**Mechanism.** `TrackRepository` (Data layer) defines an in-memory buffer (`_maxBufferSize = 50`) to batch track point inserts into single SQLite transactions. `ActiveTrackNotifier` (State layer) invokes `ref.read(trackRepositoryProvider).addPoint(...)`. Because `trackRepositoryProvider` is an `autoDispose` provider without `keepAlive: true` and `ref.read` does not retain a subscription, Riverpod disposes `TrackRepository` immediately after the microtask, executing `ref.onDispose` -> `repo.flush()`. The state layer's use of `ref.read` completely destroys the data layer's batching strategy.

**Evidence.**
```markdown
Quoting PERF-001 (13_PERFORMANCE.md):
"ref.read does not maintain a subscription, Riverpod disposes TrackRepository immediately after the microtask..."
```

**Trigger.** Active track recording emission of 1Hz location coordinates.

**Impact.** Seam breakdown between Riverpod provider disposal and SQLite batching invariants, causing 50x DB transaction amplification.

**Falsification.** Checked `track_repository.dart`; adding `@Riverpod(keepAlive: true)` retains the repository instance, preserving the 50-point buffer.

**Fix.** Annotate `trackRepositoryProvider` with `@Riverpod(keepAlive: true)`.

**Related:** PERF-001, DATA-001

---

### SEAM-003 — Error Propagation Masking Between Data Layer Exception throwing and Presentation UI Fallbacks

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/speed_limits/presentation/providers/speed_limit_provider.dart:29` ↔ `lib/features/speed_limits/presentation/providers/displayed_speed_limits_provider.dart:18-21`
- **Novel:** yes

**Mechanism.** `speedLimitsProvider` was refactored in the data/domain boundary to throw an `Exception` on `Either.left` failures instead of returning an empty list (`[]`). However, the presentation layer consumer `displayedSpeedLimits` used `!zonesAsync.hasValue ? [] : zonesAsync.value`. When `speedLimitsProvider` emits `AsyncError`, `.hasValue` is false, causing `displayedSpeedLimits` to silently return `[]`, re-masking the data layer exception from the user interface.

**Evidence.**
```markdown
Quoting CQ-001 (11_CODE_QUALITY.md):
"Downstream consumers contain logic to swallow errors (!zonesAsync.hasValue -> return []), re-masking error propagation..."
```

**Trigger.** Database read failure on speed restriction tables.

**Impact.** Silent masking of data layer exceptions in the presentation UI layer.

**Falsification.** Verified `displayed_speed_limits_provider.dart`; adding `if (zonesAsync.hasError) throw zonesAsync.error!;` propagates the error boundary correctly.

**Fix.** Propagate `zonesAsync.error` in `displayedSpeedLimits` before checking `.hasValue`.

**Related:** CQ-001, TEST-001

---

## Cross-domain sightings
- `lib/features/vessel/presentation/screens/vessel_settings_screen.dart`: `addPostFrameCallback` state initialization vs `DropdownButtonFormField` widget key binding.

## Hygiene (low-signal, listed for completeness)
- None.

## Open questions
- Are there other presentation providers using `!hasValue -> []` fallback patterns?

## This team's blind spot
Seam auditing inspects interactions between domain boundaries, but cannot detect failures that exist entirely within a single isolated function.
