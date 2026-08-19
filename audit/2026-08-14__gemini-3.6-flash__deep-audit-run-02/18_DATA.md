# DATA, STATE & MIGRATIONS AUDIT — DATA

- **run_id:** deep-audit-run-02
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `c4492cc`
- **wave:** 1
- **findings_reported:** 1
- **candidates_discarded:** 11
- **examined:** `lib/core/db/`, `lib/features/weather/data/datasources/drift_weather_store.dart`
- **not_examined:** Data restoration benchmarking from multi-gigabyte DB files

---

### DATA-001 — Incremental Schema Migration Missing Indices Creation (v15 to v17)

- **Severity:** S0-Critical
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/core/db/app_database.dart:116-289`
- **Novel:** yes

**Mechanism.** In `AppDatabase.onUpgrade`, incremental migrations (from schema version 5 up to 17) execute `m.createTable()` for new tables (such as `tile_regions`, `tile_cache`, `track_points`), but omit calling `_createIndices(m)`. Users upgrading existing app installs incrementally run SQLite tables without required indexes (`idx_tile_cache_ref_count`, `idx_track_points_track_timestamp`), causing $O(N)$ full table scans on every tile eviction or track query. Only clean installs running `onCreate` receive indices.

**Evidence.**
```dart
// lib/core/db/app_database.dart:116
if (from < 17) {
  await m.createTable(tileRegions);
  await m.createTable(tileCache);
  // Missing: _createIndices(m) for newly created tables!
}
```

**Trigger.** Upgrading the app from an earlier database schema version (< 17) to the current build.

**Impact.** Critical database degradation, 100% CPU lockup during tile eviction, and application freezes for existing users.

**Falsification.** Inspected `onUpgrade` blocks for all schema versions; confirmed `_createIndices` is called ONLY inside `onCreate`.

**Fix.** Add `await _createIndices(m);` inside the final step of `onUpgrade`.

**Related:** PERF-001, ARC-001

---

## Cross-domain sightings
- `lib/core/db/app_database.dart`: WAL (Write-Ahead Logging) mode enabled (`PRAGMA journal_mode=WAL;`).

## Hygiene (low-signal, listed for completeness)
- `lib/core/db/daos/weather_dao.dart`: Duplicate station query in batch store fallback path.

## Open questions
- Does `tile_cache` eviction delete referenced blob bytes across WAL checkpoints?

## This team's blind spot
Data auditing inspects schema definitions and migration blocks, but cannot test physical disk corruption or unexpected flash memory write failures.
