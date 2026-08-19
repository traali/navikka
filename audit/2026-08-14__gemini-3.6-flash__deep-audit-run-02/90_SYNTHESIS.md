# DIRECTOR SYNTHESIS — MASTER CANDIDATE LIST & REMEDIATION PLAN — 90_SYNTHESIS

- **run_id:** deep-audit-run-02
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `c4492cc`
- **wave:** 5

---

## Master List of Surviving Findings by Severity

### S0-Critical (3 Findings)

1. **DATA-001** — Incremental Schema Migration Missing Indices Creation (`lib/core/db/app_database.dart:116-289`)
2. **MARINE-002** — IALA Cardinal Mark Topmark Code Null Asset Path Fallback (`lib/features/navigation_aids/presentation/mappers/official_sign_mapper.dart:28-42`)
3. **Ω-004** — GeometryUtils Ray-Casting Division-by-Zero on Horizontal Edges (`lib/core/services/geometry_utils.dart:67-88`)

---

### S1-High (8 Findings)

4. **ARC-001** — Unrounded LatLng Family Key Provider Proliferation (`lib/features/weather/presentation/controllers/point_weather_data_provider.dart:10-42`)
5. **ARC-002** — Inherited Widget Rebuild Cascade in Layer Painting (`lib/features/navigation_aids/presentation/widgets/navigation_aids_layer_widget.dart:35-36`)
6. **CQ-001** — Offline Map Download Error Path Leaves Orphaned Region (`lib/features/map/presentation/controllers/offline_download_controller.dart:78-84`)
7. **SEC-001** — Plaintext Obfuscation Theater for OpenRouter AI API Keys (`lib/features/ai/data/repositories/skipper_settings_repository_impl.dart:39-41`)
8. **PERF-001** — TrackRepository Auto-Dispose Defeats SQLite 50-Point Buffer (`lib/features/tracking/data/repositories/track_repository.dart:180-185`)
9. **MARINE-001** — Speed Limit Alert Unit Normalization Discrepancy (`lib/features/speed_limits/presentation/providers/speed_alert_notifier.dart:34-45`)
10. **SEAM-001** — Track Repository Auto-Dispose Disposes In-Flight Transactions (`lib/features/tracking/data/repositories/track_repository.dart`)
11. **Ω-001** — Cloudflare Worker Error Handler Omits Origin CORS Headers (`cloudflare-worker/src/index.js:84-95`)

---

### S2-Medium (6 Findings)

12. **PERF-002** — Per-Point Heap Allocations in WaveHeightPainter Loop (`lib/features/weather/presentation/widgets/wave_height_painter.dart:38-42`)
13. **TEST-001** — Test Suite Misses Downstream Error Propagation (`test/features/speed_limits/presentation/providers/`)
14. **UI-001** — Dropdown Form Field State Initialization Key Binding (`lib/features/vessel/presentation/screens/vessel_settings_screen.dart:123-125`)
15. **Ω-002** — In-Memory Rate Limiter Disk Persist Lock Holding (`lib/core/network/rate_limit_interceptor.dart:85-112`)
16. **Ω-003** — Missing Wave Height Threshold Escalation in Weather Auditor (`lib/features/ai/domain/services/weather_auditor.dart:37-77`)
17. **Ω-005** — Case-Sensitive Content-Type Matching in Cloudflare Worker (`cloudflare-worker/src/index.js:205-211`)

---

### S3-Low & S4-Note (3 Findings)

18. **CQ-002** — Stale Start Angle in Mid-Animation Wind Arrow Updates (`lib/features/weather/presentation/widgets/animated_wind_arrow.dart:45-66`)
19. **UX-001** — Inconsistent Haptic Feedback on Settings Switches (`lib/features/menu/presentation/screens/menu_screen.dart:366-368`)
20. **OPS-001** — Unbounded In-Memory Log Ring Buffer Accumulation (`lib/core/utils/logger.dart:53-61`)

---

## Top 5 Critical Findings Reasoning

1. **DATA-001 (S0-Critical)**: Upgrading users run zero database indices on core tile and tracking tables, degrading app responsiveness to a crawl.
2. **MARINE-002 (S0-Critical)**: Unmapped IALA buoy codes cause navigational aids to vanish from the map overlay, presenting an immediate maritime vessel grounding risk.
3. **Ω-004 (S0-Critical)**: Division by zero on horizontal polygon edges causes point-in-polygon checks to evaluate to `false` for grid-aligned speed zones.
4. **MARINE-001 (S1-High)**: Direct comparison of knots to km/h creates a 46% speed calculation error, suppressing speed limit violation alerts.
5. **PERF-001 (S1-High)**: `autoDispose` on `trackRepositoryProvider` forces individual disk writes for every single GPS point, causing 50x SQLite transaction write amplification.

---

## Three Root Causes

1. **Unchecked Provider Lifecycle Auto-Dispose Defaults**: Defaulting Riverpod providers to `autoDispose` without checking backing state persistence lifecycles (PERF-001, SEAM-001, ARC-001).
2. **Null/Unmapped Fallback Drop Invariants**: Dropping missing or unmapped domain enum values (`null` return) instead of rendering high-visibility generic hazard symbols (MARINE-002, UI-001).
3. **Domain Unit & Precision Normalization Deficits**: Performing direct arithmetic comparisons without explicitly converting between nautical units (knots vs km/h) or handling horizontal collinear polygon edges (MARINE-001, Ω-004).

---

## Sequenced Remediation Order

1. **Phase 1 (Immediate Safety Fixes)**: Fix `MARINE-002` (fallback hazard icon), `Ω-004` (horizontal edge check in `GeometryUtils`), and `MARINE-001` (speed unit conversion).
2. **Phase 2 (Database & Data Integrity)**: Fix `DATA-001` (add `_createIndices` to `onUpgrade`) and `PERF-001` (add `keepAlive: true` to `trackRepositoryProvider`).
3. **Phase 3 (Network & Proxy Security)**: Fix `Ω-001` (CORS error origin headers) and `SEC-001` (migrate AI keys to `FlutterSecureStorage`).

---

## One Single Change Rationale

If I could change exactly one thing about Sakkoja, I would implement **strict unit-typed value wrappers for all spatial and marine measurements** (`Knots(double)`, `Kmh(double)`, `Meters(double)`). Enforcing type-safe domain units at compile time eliminates entire classes of nautical calculation bugs (such as comparing knots directly to km/h) before code ever reaches production.
