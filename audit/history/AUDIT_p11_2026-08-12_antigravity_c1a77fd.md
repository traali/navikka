# AUDIT.md — Relay Audit Document Snapshot (Phase 11 Falsification)

Snapshot File: audit/history/AUDIT_p11_2026-08-12_antigravity_c1a77fd.md
Date: 2026-08-12
Model: Antigravity Agent (Gemini 3.6 Flash)
Commit: c1a77fd7d9e33ab3e46ed9956ca7f16b81b9bd9a (tree DIRTY)

---

# §0 — STATE

```
Repository:         Sakkoja (Marine Safety Navigator)
Root:               c:/dev2/gtp/sakkoja
Stack:              Flutter 3.44.8 · Dart 3.12.2 · Riverpod 3.3.1 · Drift 2.30.1 · flutter_map 8.3
External APIs:      FMI (WFS/OData), SYKE (Water quality/Algae), OpenWeather, MET Norway, Traficom
CORS proxy:         Cloudflare Worker (cloudflare-worker/)
History:            Built incrementally over many months by MULTIPLE different AI models
                    and sessions. No single human ever held the whole design in their head.

Audit started:      2026-08-10
Audit branch/tag:   main (frozen baseline for audit session)
Baseline commit:    a902786a14d00ea72cf4cd7bff962c1fedbbcd13
Current commit:     c1a77fd7d9e33ab3e46ed9956ca7f16b81b9bd9a
Working tree:       DIRTY (.agent/rules/*, AGENTS.md, llms.txt, AUDIT.md)
Line refs valid:    yes

Last session:       2026-08-12 (Phase 11 — Falsification)
Last model:         Antigravity Agent (Gemini 3.6 Flash)
Last snapshot file: audit/history/AUDIT_p11_2026-08-12_antigravity_c1a77fd.md
Phases complete:    12 / 13
Findings so far:    22  (P0: 1 · P1: 7 · P2: 13 · P3: 1)
Open investigations: TI-01 (Weather widget refresh storm) · TI-02 (GPS Cascade & Station Query Storm)
File integrity:     lines: 1290 · findings: 22 (All 22 passed hostile falsification)
Next action:        Execute Phase 12 (Synthesis & Final Executive Report).
```

---

# §11 — FALSIFICATION SUMMARY & SURVIVAL LEDGER

All 22 recorded findings (`F-001` through `F-022`) underwent rigorous static analysis and line-by-line verification against the live codebase.

| Finding | Severity | Category | File & Symbol | Status | Falsification Verification Summary |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **F-001** | P1 | Seam Lifecycle | `model_download_service.dart#L59` | **PASSED** | Verified: `_dio.close()` in `onDispose` closes shared `dioProvider` singleton. |
| **F-002** | P2 | Convergent Evolution | `fishing_restriction.dart#L307` | **PASSED** | Verified: Duplicated ray-casting algorithm vs `GeometryUtils.isPointInPolygon`. |
| **F-003** | P2 | Convergent Sanitization | `web_proxy_interceptor.dart#L18` | **PASSED** | Verified: Hand-rolled `***` scrubbing duplicates `Log._scrubSensitiveData`. |
| **F-004** | P2 | Ghost Dependency | `pubspec.yaml#L14` | **PASSED** | Verified: `cupertino_icons` has zero imports in `lib/`. |
| **F-005** | P2 | Ghost Dependency | `pubspec.yaml#L49` | **PASSED** | Verified: `url_launcher` has zero imports in `lib/` or `test/`. |
| **F-006** | P2 | Ghost Dev-Tooling | `pubspec.yaml#L55` | **PASSED** | Verified: `alchemist`, `husky`, and `lint_staged` unused; superseded by `lefthook`. |
| **F-007** | P2 | Adoption Gap | `weather_repository_impl.dart#L120` | **PASSED** | Verified: Hand-rolled retry loop duplicates `dio_smart_retry` in `dioProvider`. |
| **F-008** | P1 | Proxy CORS Duplication | `cloudflare-worker/src/index.js#L202` | **PASSED** | Verified: Verbatim proxy response header copy causes duplicate CORS headers. |
| **F-009** | P2 | Proxy Origin Leak | `cloudflare-worker/src/index.js#L84` | **PASSED** | Verified: `errorResponse` helper defaults `origin` parameter to `*`. |
| **F-010** | P2 | Documentation Drift | `PROJECT_DOCUMENTATION.md#L36` | **PASSED** | Verified: Document claims Sembast active DB engine (migrated 100% to Drift SQLite). |
| **F-011** | P2 | Documentation Drift | `PROJECT_DOCUMENTATION.md#L20` | **PASSED** | Verified: Document claims Web target undeployed (live on Cloudflare Pages). |
| **F-012** | P3 | Documentation Drift | `ARCHITECTURE.md#L13` | **PASSED** | Verified: Tree states `core/db/` instead of actual path `lib/core/database/`. |
| **F-013** | P1 | Seam Lifecycle | `ais_targets_provider.dart#L22` | **PASSED** | Verified: `ref.listen` in `build()` creates accumulating duplicate listeners. |
| **F-014** | P1 | Seam Error Swallowing | `navigation_aids_providers.dart#L44` | **PASSED** | Verified: `result.fold((f) => [], ...)` wraps database failures in `AsyncValue.data([])`. |
| **F-015** | P2 | Unjustified Machinery | `replay_interceptor.dart#L32` | **PASSED** | Verified: 96 LOC stubbed prototype interceptor registered in production `dioProvider`. |
| **F-016** | P2 | Over-engineered Storage | `rate_limit_interceptor.dart#L16` | **PASSED** | Verified: Serializes transient 10s timestamps into `SharedPreferences` disk storage. |
| **F-017** | P1 | Performance Bottleneck | `navigation_aids_layer_widget.dart#L35` | **PASSED** | Verified: `MapCamera.of(context)` causes 60 Hz rebuilds without `RepaintBoundary`. |
| **F-018** | P2 | Performance Bottleneck | `drift_weather_store.dart#L354` | **PASSED** | Verified: 12 reactive streams bypass `_stationByIdCache` issuing SQL SELECT queries. |
| **F-019** | P1 | Security Defect | `skipper_settings_repository_impl.dart#L52` | **PASSED** | Verified: User `aiApiKey` written as plain text in unencrypted SQLite DB file. |
| **F-020** | P2 | Security / Robustness | `env.dart#L4` | **PASSED** | Verified: `dotenv.get('OPENWEATHER_API_KEY')` throws unhandled `StateError` if unset. |
| **F-021** | P0 | Marine Safety Hazard | `navigation_aid_marker.dart#L245` | **PASSED** | Verified: `_IALAAMapper` swaps East (5) and West (6) Cardinal buoy SVG icons. |
| **F-022** | P1 | Domain Unit Conversion | `speed_limit_dto.dart#L33` | **PASSED** | Verified: Parses `suuruus` raw numeric value without converting knot limits to km/h. |

**Survival Rate**: **100% (22/22 findings verified)**. Zero false positives. Zero relocations needed.
