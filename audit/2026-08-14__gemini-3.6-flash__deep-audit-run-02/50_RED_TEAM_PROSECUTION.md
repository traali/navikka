# RED TEAM PROSECUTION — 50_RED_TEAM_PROSECUTION

- **run_id:** deep-audit-run-02
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `c4492cc`
- **wave:** 4

---

## Prosecution Verdicts

| Finding ID | Title | Original Severity | Prosecution Verdict | Final Severity | Rationale |
|---|---|---|---|---|---|
| DATA-001 | Incremental Schema Migration Missing Indices Creation | S0-Critical | **UPHELD** | S0-Critical | Confirmed `_createIndices` is omitted in `onUpgrade` (v5 -> v17). Existing users upgrading run zero SQLite indices, locking CPU during tile eviction. |
| MARINE-002 | IALA Cardinal Mark Topmark Code Null Asset Path Fallback | S0-Critical | **UPHELD** | S0-Critical | Confirmed null asset path returns drop buoy markers completely from map layer, creating immediate navigation grounding hazard. |
| ARC-001 | Unrounded LatLng Family Key Provider Proliferation | S1-High | **UPHELD** | S1-High | Verified double precision unrounded LatLng creates new provider instances on every map drag. |
| ARC-002 | Inherited Widget Rebuild Cascade in Layer Painting | S1-High | **UPHELD** | S1-High | Confirmed `MapCamera.maybeOf(context)` in `build()` forces 60Hz widget rebuilds during panning. |
| CQ-001 | Offline Map Download Error Path Leaves Orphaned Region | S1-High | **UPHELD** | S1-High | Exception path shows SnackBar but never cleans database record or updates downloading status. |
| SEC-001 | Plaintext Obfuscation Theater for OpenRouter AI API Keys | S1-High | **UPHELD** | S1-High | Static XOR mask (`0x5A`) + Base64 stored in standard SQLite database offers zero security protection. |
| PERF-001 | TrackRepository Auto-Dispose Defeats SQLite 50-Point Buffer | S1-High | **UPHELD** | S1-High | `autoDispose` annotation on `trackRepositoryProvider` disposes repo after microtask, turning 50-point buffer into 1-point buffer. |
| MARINE-001 | Speed Limit Alert Unit Normalization Discrepancy | S1-High | **UPHELD** | S1-High | Knots compared directly to km/h creates a 46% error margin, suppressing valid speed warnings. |
| SEAM-001 | Track Repository Auto-Dispose Disposes In-Flight Transactions | S1-High | **UPHELD** | S1-High | Synchronous `onDispose` tearing down backing database handle while async batch flush is in-flight causes unhandled `StateError`. |
| Ω-001 | Cloudflare Worker Error Handler Omits Origin CORS Headers | S1-High | **UPHELD** | S1-High | `errorResponse` returning static headers causes browser CORS policy to reject error payloads. |
| Ω-004 | GeometryUtils Ray-Casting Division-by-Zero on Horizontal Edges | S1-High | **PROMOTED** | S0-Critical | Division by zero on horizontal polygon edges yields `NaN`, causing point-in-polygon checks to fail completely for grid-aligned speed zones. |
| PERF-002 | Per-Point Heap Allocations in WaveHeightPainter Loop | S2-Medium | **UPHELD** | S2-Medium | Instantiating `Paint()` and `RadialGradient()` inside point loop causes GC pauses under dense wave fields. |
| TEST-001 | Test Suite Misses Downstream Error Propagation | S2-Medium | **UPHELD** | S2-Medium | Zero tests assert `AsyncError` propagation on `displayedSpeedLimitsProvider`. |
| UI-001 | Dropdown Form Field State Initialization Key Binding | S2-Medium | **UPHELD** | S2-Medium | Missing `ValueKey(_selectedType)` causes element tree to retain stale initial dropdown selection. |
| OPS-001 | Unbounded In-Memory Log Ring Buffer Accumulation | S2-Medium | **DOWNGRADED** | S3-Low | Ring buffer is capped at 50 elements; memory copy occurs on microtask but impact is low unless logger is spammed at >1000Hz. |
| Ω-002 | In-Memory Rate Limiter Disk Persist Lock Holding | S2-Medium | **UPHELD** | S2-Medium | Disk I/O inside critical network lock delays parallel startup requests. |
| Ω-003 | Missing Wave Height Threshold Escalation in Weather Auditor | S2-Medium | **UPHELD** | S2-Medium | Missing >2.0m wave height critical threshold warning for small vessels. |
| Ω-005 | Case-Sensitive Content-Type Matching in Cloudflare Worker | S2-Medium | **UPHELD** | S2-Medium | Strict equality matching fails on parameterized headers (`charset=utf-8`). |
| CQ-002 | Stale Start Angle in Mid-Animation Wind Arrow Updates | S3-Low | **UPHELD** | S3-Low | Re-animating wind arrow while animating uses initial angle instead of current value. |
| UX-001 | Inconsistent Haptic Feedback on Settings Switches | S3-Low | **UPHELD** | S3-Low | Wind & Wave feature switch omitted tactile haptic feedback call. |
| DEP-001 | Unused Legacy Dependency in Core Pubspec | S3-Low | **WITHDRAWN** | — | `cupertino_icons` is a standard default Flutter template dependency; while unused, it does not impact runtime execution or safety. |
| DOC-001 | Historical Sembast Storage Documentation Residue | S3-Low | **DOWNGRADED** | S4-Note | Header explicitly marks file as historical artifact; developer confusion impact is negligible. |

---

## Verdict Summary

- **Upheld:** 18
- **Promoted:** 1 (`Ω-004` promoted from S1-High to S0-Critical)
- **Downgraded:** 2 (`OPS-001` to S3-Low, `DOC-001` to S4-Note)
- **Withdrawn:** 1 (`DEP-001` withdrawn)
- **Total Surviving Findings:** 20
