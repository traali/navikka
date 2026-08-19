# SEAM AUDIT — CROSS-DOMAIN SEAMS — 30_SEAMS

- **run_id:** deep-audit-run-02
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `c4492cc`
- **wave:** 2
- **findings_reported:** 1
- **candidates_discarded:** 5
- **examined:** Inter-domain boundaries between ARC, PERF, DATA, and SEC Wave 1 outputs
- **not_examined:** External third-party OAuth provider boundaries

---

### SEAM-001 — Track Repository Auto-Dispose Disposes In-Flight SQLite Transactions

- **Severity:** S1-High
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/tracking/data/repositories/track_repository.dart` + `lib/core/db/app_database.dart`
- **Novel:** yes

**Mechanism.** ARC-001 identified Riverpod provider auto-dispose behavior and PERF-001 identified 50x transaction amplification in `TrackRepository`. The cross-domain seam occurs between Riverpod's synchronous provider disposal lifecycle and Drift SQLite's asynchronous transaction queue: when `TrackRepository` is disposed via `ref.onDispose` while a batch flush `database.batch(...)` is in-flight, the backing database handle is closed while the transaction is mid-execution, raising an unhandled `StateError: Database is closed`.

**Evidence.**
```dart
// Cross-Domain Seam Analysis:
// ARC-001 (Riverpod sync dispose) ──► SEAM-001 ◄── DATA-001 (Drift Async Batch)
ref.onDispose(() {
  _flushBuffer(); // Async Future fired inside sync onDispose callback!
});
```

**Trigger.** Terminating a GPS tracking session or navigating away from the tracking screen while an active batch flush is writing to disk.

**Impact.** Unhandled `StateError` app crash and partial track point corruption.

**Falsification.** Traced `onDispose` execution in Riverpod; confirmed `onDispose` callbacks do not await `Future` completion before tearing down provider state.

**Fix.** Await `_flushBuffer()` prior to disposing the database connection, or keep `trackRepositoryProvider` alive (`keepAlive: true`).

**Related:** ARC-001, PERF-001, DATA-001

---

## Cross-domain sightings
- SEC-001 (Secret Storage) intersects with DATA-001 (SQLite Schema): Storing sensitive keys in standard tables exposes them during database export operations.

## Hygiene (low-signal, listed for completeness)
- `lib/features/map/presentation/widgets/map_hud_layer.dart`: Duplicate theme resolution across HUD assemblies.

## Open questions
- Does `tile_cache` eviction conflict with active offline download transactions?

## This team's blind spot
Seam auditing analyzes inter-module lifecycle contracts, but cannot predict unknown third-party API breaking changes.
