# Issue: Tile Download Writes Individual SQLite Rows - O(n) Disk I/O Disaster

## Status: ❌ DENIED — Already Fixed in Codebase

## Priority: HIGH (original) → NOT AN ISSUE

## Triage Result (2026-05-11)
Investigated `tile_download_manager.dart` and `tile_dao.dart`. Batch insert
is **already implemented and in use**:

- `tile_download_manager.dart:92-150` — download manager buffers tiles and
  calls `dao.batchSaveTiles(...)` for chunked batch writes
- `tile_dao.dart:178-234` — `batchSaveTiles()` implemented with a single
  transaction + batch insert + ref_count update

There are **no individual per-tile INSERT calls** in the current code.

## Original Claim
> Each tile download triggers an individual SQLite insert (50,000 = 50,000 disk writes)

## Actual Code
```
lib/features/map/data/services/tile_download_manager.dart:92-150
lib/core/db/daos/tile_dao.dart:178-234
```
— Buffer + batch flush pattern already in place.

---
*Created: 2026-05-09*
*Triaged: 2026-05-11 — DENIED, no action required*