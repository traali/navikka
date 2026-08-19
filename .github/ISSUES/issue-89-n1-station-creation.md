# Issue: N+1 Station Creation Pattern in Weather Data Sync

## Status: ✅ FIXED — PR #142

## Priority: HIGH

## Location
`lib/features/weather/data/datasources/drift_weather_store.dart`
`lib/core/db/daos/weather_dao.dart`

## Original Problem
`_resolveStationsBatch()` looped over unique station keys and awaited
`_dao.getOrCreateStation(...)` per key — one full `transaction(SELECT + INSERT)`
per station, causing N serialised DB round-trips.

Hot paths affected:
- `cacheWaves` `:493`
- `cacheSeaLevels` `:640`
- `cacheWaterQuality` `:1171`
- `cacheAlgaeReports` `:1248`

## Fix Applied (2026-05-11)
Added `WeatherDao.getOrCreateStationsBatch()` which resolves any number of
stations in a **fixed cost** regardless of N:

1. Deduplicate + round coordinates in memory.
2. Per unique station type: one bounding-box `SELECT` covers all requested coords.
3. One Drift `batch()` INSERT for only the missing stations (`insertOrIgnore`).
4. One re-SELECT to retrieve IDs of newly inserted rows.

`_resolveStationsBatch()` now delegates to this single call — all callers unchanged.

**Before → After (N=50 stations):**
```
Before: 50 transactions, 50–100 DB ops
After:  1 transaction, 2–3 DB ops regardless of N
```

## Related
- Issue #88 (parallel API flooding) → DENIED (already sequential)

---
*Created: 2026-05-09*
*Fixed: 2026-05-11 — PR #142*