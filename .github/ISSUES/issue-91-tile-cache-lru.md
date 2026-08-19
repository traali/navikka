# Issue: Tile Cache Has No LRU Size Limits

## Status: ❌ DENIED — Already Implemented in Codebase

## Priority: MEDIUM (original) → NOT AN ISSUE

## Triage Result (2026-05-11)
Investigated `tile_dao.dart`. LRU eviction is **already fully implemented**:

- `maxTileCacheSize = 10000` (`:14`)
- `_evictIfNeeded()` with `ORDER BY last_accessed ASC` LRU eviction (`:251-272`)

The "TODO: For LRU caching if we ever implement soft-cache limits" comment in
`tile_tables.dart` is stale and does not reflect the current DAO implementation.

## Original Claim
> No limit on how many tiles can be cached; storage grows unbounded

## Actual Code
```
lib/core/db/daos/tile_dao.dart:14-18, 251-272
```
— Hard cap + LRU eviction already in place.

---
*Created: 2026-05-09*
*Triaged: 2026-05-11 — DENIED, no action required*