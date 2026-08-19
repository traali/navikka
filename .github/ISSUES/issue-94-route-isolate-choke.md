# Issue: Route Planner Isolate Serialization Choke - UI Freeze on Complex Routes

## Status: ❌ DENIED — Already Fixed in Codebase

## Priority: HIGH (original) → NOT AN ISSUE

## Triage Result (2026-05-11)
Investigated `route_planner_controller.dart:195-218`. Restrictions are already
**pre-filtered by bounding box before** being sent to the `compute()` isolate:

```
lib/features/navigation/presentation/controllers/route_planner_controller.dart:195-218
```

- `pathBBox` is calculated on the main thread (fast)
- `filteredRestrictions = restrictions.where(...boundingBox.intersects(pathBBox))`
- Only the filtered, small set is serialised into `compute()`

The `boundingBox` property exists and is computed on the entity:
```
lib/features/fishing/domain/entities/fishing_restriction.dart:14,58,78
```

## Original Claim
> Passing 5,000+ fishing restriction objects to compute() forces deep-copy serialization

## Actual Code
```
lib/features/navigation/presentation/controllers/route_planner_controller.dart:195-218
```
— BBox pre-filter already in place; isolate receives only the relevant subset.

---
*Created: 2026-05-09*
*Triaged: 2026-05-11 — DENIED, no action required*