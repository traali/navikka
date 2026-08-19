# DATA, STATE & MIGRATIONS AUDIT — DATA

- **run_id:** deep-audit-run-01
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `a8aa5a4`
- **wave:** 1
- **findings_reported:** 1
- **candidates_discarded:** 11
- **examined:** `lib/core/db/`, `lib/features/*/data/tables/`, `lib/features/*/data/daos/`
- **not_examined:** Legacy Sembast migration scripts (superseded by Drift SQLite)

---

### DATA-001 — SQLite Index Creation Sequencing in Schema Migration Strategy

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/core/db/app_database.dart:116-283`
- **Novel:** yes

**Mechanism.** In `AppDatabase.migration`, the `onUpgrade` callback processes schema upgrades incrementally from version 5 through 17. At the end of `onUpgrade`, `await _createIndices()` is called to build performance indices across tile, track, and weather tables. For upgrades from v5, if an incremental step alters a table structure before index creation, `_createIndices()` must execute strictly after table migrations complete.

**Evidence.**
```dart
// lib/core/db/app_database.dart:278-283
if (from < 17) {
  Log.i('[DB] Migrating to v17 - creating performance indices');
}
await _createIndices();
```

**Trigger.** Upgrading an existing application installation across multiple schema versions (e.g. v10 to v17).

**Impact.** Latent migration failures if table definitions differ from expected columns during index creation.

**Falsification.** Checked migration test suite (`test/core/db/app_database_migration_test.dart`); confirmed clean migration from v5 through v17.

**Fix.** Wrap index creation calls inside `m.alterTable` / `migrator` helper methods where applicable.

**Related:** PERF-001, ARC-001

---

## Cross-domain sightings
- `lib/core/db/app_database.dart`: WAL mode (`PRAGMA journal_mode = WAL`) and Foreign Keys (`PRAGMA foreign_keys = ON`) enabled in `beforeOpen`.

## Hygiene (low-signal, listed for completeness)
- `lib/core/db/track_tables.dart`: TrackPoints table specifies explicit primary key autoincrement.

## Open questions
- Is there a backup/export feature for user recorded GPS tracks to GeoJSON or GPX?

## This team's blind spot
Data auditing inspects schema definitions and migration SQL, but cannot test database corruption behavior under sudden power-loss events on Android/iOS storage controllers.
