# Issue: Critical Parallel API Flooding - 8 Simultaneous Calls Per Camera Move

## Status: ❌ DENIED — Already Fixed in Codebase

## Priority: CRITICAL (original) → NOT AN ISSUE

## Triage Result (2026-05-11)
Investigated `point_weather_sync_controller.dart:139-156`. The current
implementation is **already prioritised and mostly sequential**:

1. Safety calls run first, sequentially: `syncRecentLightning()`, `syncActiveAlerts()`
2. Only two core calls are parallelised: `Future.wait([syncWeatherObservations, syncWeatherForecast])`
3. Supplementary marine/water calls run sequentially after that.

The original "proof" code block showing all 8 calls in one `Future.wait` no
longer matches the actual code — the concern was already addressed before this
triage.

## Original Claim
> Every camera pan/zoom triggers 8 simultaneous HTTP requests

## Actual Code
```
lib/features/weather/presentation/controllers/point_weather_sync_controller.dart:139-156
```
— Safety-first sequential pattern, not a flat 8-way parallel blast.

## Related
- Issue #89 (N+1 station creation) → FIXED in PR #142

---
*Created: 2026-05-09*
*Triaged: 2026-05-11 — DENIED, no action required*