# Navikka Engineering Audit — Twenty-Agent Council Review

> **Audit date**: 2026-08-24
> **Audited revision**: `1bde577` (`fix: own-ship HUD/MAYDAY wait for LIVE GPS; never invent dew/gust/waves (#20)`), branch `main`, working tree clean, synced with `origin/main`.
> **Methodology**: Static analysis + parallel sub-agent sweeps. Full runtime suites (`flutter test`, companion `npm test`, Playwright e2e) were **not executed** during this pass; every finding below cites static, verifiable evidence.
> **Status**: Complete. Remediation tracking lives in [§7 Roadmap](#7-remediation-roadmap).

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Verified Baseline](#2-verified-baseline)
3. [Methodology](#3-methodology)
4. [Findings Catalog](#4-findings-catalog)
5. [Panel Reviews (20 Perspectives)](#5-panel-reviews)
6. [Cross-Examination Record](#6-cross-examination-record)
7. [Remediation Roadmap](#7-remediation-roadmap)
8. [Appendix A — Evidence Inventory](#appendix-a--evidence-inventory)
9. [Appendix B — Limitations](#appendix-b--limitations)

---

## 1. Executive Summary

Navikka's engineering spine is strong: deterministic on-device safety reasoning, honesty-locked test culture, mechanized contract enforcement, and correct secret hygiene. Twelve consolidated findings were identified and voted on by a twenty-perspective review council. The three trust gaps that block "best end state":

| # | Trust Gap | Finding |
|---|---|---|
| 1 | An **unenforced privacy promise** — the cloud-AI consent dialog is dead code and the engine never checks the consent flag | F-01 |
| 2 | A **safety-critical copy-paste twin** — ~200 lines of marine-safety thresholds duplicated across platform variants | F-02 |
| 3 | A **test apparatus that partly performs protection** — untested datasource parsers, broken/orphaned e2e, vestigial golden gates | F-06 / F-07 / F-08 |

Clearing these (roadmap items P0-1 … P2-3) brings the repository to its best end result.

---

## 2. Verified Baseline

| Metric | Value (at `1bde577`) |
|---|---|
| Architecture check | ✅ Pass (395 Dart files scanned) |
| `dart analyze lib/ test/` | 0 errors, 12 info-level notes |
| Flutter test files / `test()` blocks / widget tests | 127 / 547 / 46 |
| Companion TS source / test files | 4,488 LOC total / 11 `*.test.ts` |
| `print(` / `debugPrint(` / TODO / FIXME / committed `.env` | 0 / 0 / 0 / 0 / none |
| Forbidden imports (hive/provider/getx) | 0 |
| App version | `1.25.0+1` (`pubspec.yaml:5`); CHANGELOG top section `[Unreleased]` |
| SDK pins | Flutter `3.44.8` (`.fvmrc` = `.flutter-version` = CI matrix) |

---

## 3. Methodology

The audit emulated twenty independent reviewer disciplines (defensive programming, zero-defect delivery, scalability, risk mitigation, minimalism, refactoring agility, coverage rigor, security, DX/a11y, automation, formal patterns, operational transparency, rendering latency, runtime adaptation, governance, empathy/i18n, visual design, error logging, algorithmic efficiency, resource/concurrency efficiency). Each perspective:

1. Produced an independent review grounded strictly in workspace evidence.
2. Participated in a cross-examination round where contested claims were upheld, debunked, or adjusted against exact file/line references.
3. Cast exactly five weighted votes (100 votes total) on the consolidated findings catalog.

Evidence was gathered via four parallel sweeps: (a) Flutter core services under `lib/features/{weather,ai,map}`, (b) React companion under `apps/web-pwa/src`, (c) tests/CI/contracts (`test/`, `.github/workflows/`, `scripts/architecture_check.dart`, `web/_redirects`), and (d) documentation/hygiene scans.

---

## 4. Findings Catalog

Each finding is fact-checked with exact locations. Vote counts are from §6.2.

### F-01 — Cloud-AI consent gate is cosmetic · 13 votes · 🔴 P0

* **Evidence**: `HybridInsightEngine` gates cloud calls only on `settings.isAIEnabled` and non-empty key — `lib/features/ai/domain/services/hybrid_insight_engine.dart:72,89–91`. `hasAcknowledgedAISafety` is never checked there. `AiConsentDialog` (`lib/features/ai/presentation/widgets/ai_consent_dialog.dart:5–6`) has zero call sites in `lib/`. Consent is enforced only as a UI-side dialog when toggling AI on (`skipper_settings_screen.dart:106–116`).
* **Impact**: AGENTS.md §5 promises cloud inference only after explicit consent acceptance; code does not enforce it. A user who enabled AI once keeps sending localized weather/GPS context to OpenRouter indefinitely.
* **Not affected**: Key storage itself is correct — FlutterSecureStorage key `sakkoja_ai_api_key` (`skipper_settings_repository_impl.dart:15–16`), Drift row nulled (`:71`).

### F-02 — Duplicated marine-safety reasoning engine (native/web) · 10 votes · 🟠 P1

* **Evidence**: Native `getAdvice` body (`weather_ai_edge_service_native.dart:74–232`) is byte-equivalent to web `LocalMarineReasoner.synthesize` (`weather_ai_edge_service_web.dart:174–332`); `analyzeRoute` likewise identical (`:31–64` vs `:343–376`). ≈200 lines of COLREG/fog/gust thresholds must be edited twice.
* **Impact**: A threshold fix applied to one variant ships inconsistent safety advice to mobile vs web.

### F-03 — Repository contract violates fpdart Either convention · 7 votes · 🟠 P1

* **Evidence**: Entire public surface of `lib/features/navigation/data/repositories/navigation_repository_impl.dart:14–83` returns raw `Future<T>` (`getAllRoutes`, `createRoute`, `deleteRoute`, …); DAO exceptions escape uncaught. Also `fishing_repository_impl.dart:183` (`Future<bool> getFishingMode()`). Weather/harbors/AI boundaries comply (`weather_repository_impl.dart:154–189`; `open_router_service_impl.dart:88–105`).
* **Impact**: Breaches AGENTS.md §2 rule 4 ("Always return `Future<Either<Failure, T>>`") and breaks uniform error composition.

### F-04 — IMU sensor-loss has no recovery path · 10 votes · 🟠 P1

* **Evidence**: Accelerometer/gyro `onError` handlers log only (`wave_impact_ai_service.dart:122–124,129–131`); no resubscribe/backoff; no user-visible health state beyond stale `hasSensorSamples`. Default `boatSpeedKnots = 15.0` parameter at `:186` risks stale-speed classification if callers fail to thread real SOG.
* **Impact**: Mid-session sensor death (web permission revocation, iOS stream failure) silently disables slam detection.

### F-05 — `ForecastIntelligenceProvider` fragility cluster · 9 votes · 🟠 P1

* **Evidence**: Synchronous notifier mutating instance state inside `build()` — `_snapshotStore[gridKey] = newSnapshot` (`forecast_intelligence_provider.dart:113`); `isAutoDispose: true` wipes alert history when listeners drop (`forecast_intelligence_provider.g.dart:24–27,37`); no `==`/`hashCode` → rebuild storms; `copyWith` cannot clear fired events (`:32–33`); no error surface at all.
* **Impact**: Stale/un-dismissible alerts, wasted rebuilds, silent failure of the forecast-intelligence feature.

### F-06 — Weather datasource parsers untested · 11 votes · 🟠 P1

* **Evidence**: Of ~9 datasources in `lib/features/weather/data/datasources/`, only SYKE dedup (`syke_dedup_test.dart`) and `provider_result_test.dart` have coverage. Zero dedicated tests for `fmi_weather_data_source.dart`, `met_norway_data_source.dart`, `met_norway_ocean_source.dart`, `open_meteo_marine_data_source.dart`, `open_meteo_wind_data_source.dart`, `openweather_data_source.dart`, nor `weather_repository_impl.dart` parsing paths.
* **Impact**: Malformed upstream responses (XML/JSON drift) ship directly to production.

### F-07 — e2e suite broken and orphaned from CI · 10 votes · 🔴 P0

* **Evidence**: `e2e/ulkoasu_layouts.spec.ts:3` hardcodes personal Windows artifact dir `C:/Users/aoinonen/.gemini/antigravity/brain/…` (throws off-machine) and hardcodes production URL `https://sakkoja.pages.dev`, ignoring `baseURL`. `live_audit.spec.ts` performs zero assertions. No workflow under `.github/workflows/` runs `cd e2e && npm test`, despite AGENTS.md §3 advertising it. `e2e/` root carries ~25 ad-hoc `capture_*.mjs` scripts and committed PNG artifacts (~20 MB).
* **Impact**: Playwright suite verifies nothing reproducibly and hits production by default.

### F-08 — Golden-test infrastructure vestigial · 4 votes · 🟡 P2

* **Evidence**: Two orphan PNGs in `test/features/weather/presentation/widgets/goldens/`; zero `matchesGoldenFile` usages repo-wide; `ci.yml:98–100` runs `flutter test --tags=golden` with `continue-on-error: true` selecting zero tests.
* **Impact**: A vacuous CI step that fakes a quality gate.

### F-09 — Silent empty catch blocks around persistence · 9 votes · 🔴 P0

* **Evidence**: Seven `catch (_) {}` occurrences in five files: `unit_preferences_provider.dart:165,173,181`; `ui_element_preferences_provider.dart:97`; `ai_settings_provider.dart:69` (`_persistBool`); `skipper_settings_repository_impl.dart:88` (secure-storage read of BYOK key); `offline_download_controller.dart:83`.
* **Impact**: A failed secure-storage read makes the user's API key silently vanish from settings; preference writes drop without trace.

### F-10 — Documentation truth-drift · 7 votes · 🟡 P2

* **Evidence**: `AGENTS.md:5,11,47` reference Windows absolute links (`file:///c:/dev2/gtp/sakkoja/…`) — broken on macOS/Linux. `README.md` documents the on-device suite (`README.md:60–64`) but never mentions HybridInsightEngine/BYOK opt-in cloud path. Naming drift: package `sakkoja` (`pubspec.yaml:1`), keys `sakkoja_*`, docs titled "Sakkoja", product "Navikka". `docs/architecture.md` last verified @ `943ec31` (stale); `developer_guide.md` omits Riverpod 3.x / flutter_map 8.x pins.

### F-11 — Spec/code timing-constant drift · 6 votes · 🟡 P2

* **Evidence**: Documented "300 ms camera debounce" (AGENTS.md §2.5) exists nowhere in code; all `milliseconds: 300` hits are animation durations. Real mechanisms: 500 ms throttle (`map_camera_provider.dart:46`, `navigation_controller.dart:16`) and distance/zoom pan gating (`map_camera_provider.dart:107`). The 250 ms visual buffer lives only inside the IMU service (`wave_impact_ai_service.dart:268`). `scripts/architecture_check.dart` does not enforce timing constants.
* **Impact**: Contract drift between spec, Dart, and TS (`apps/web-pwa/src/lib/navikka/fetch-policy.ts`).

### F-12 — Non-hermetic / inconsistent CI edges · 4 votes · 🟡 P2

* **Evidence**: `web-pwa.yml:45` uses `npm install` instead of `npm ci`. `deploy.yml:30–33` hard-fails manual `workflow_dispatch` without secrets while gracefully skipping `workflow_call`/push (`deploy.yml:26–34`). Coverage floor is 25% (`ci.yml:82–96`).
* **Impact**: Non-reproducible installs; surprising operator experience.

---

## 5. Panel Reviews

Condensed per-reviewer records. Each entry lists the reviewer lens, principal observations (with evidence), and top findings contributed to the catalog.

| # | Lens | Principal observations (evidence) | Findings raised |
|---|---|---|---|
| 1 | Defensive programming & typing | Strong `Either` at weather/AI boundary; navigation repo raw-throw surface; broken canonical doc links | F-03, F-09, F-10, F-02, F-11 |
| 2 | Zero-defect delivery & flake prevention | Verbatim-duplicated safety engine; dead golden infra masked by `continue-on-error`; excellent honesty tests (`local_marine_ai_test.dart:54–77,122–154`) | F-02, F-08, F-11, F-04, F-06, F-09 |
| 3 | Velocity, scalability, telemetry | Value-less provider state (`forecast_intelligence_provider.dart:9–37`); side-effect-in-build (:113); e2e defaults to production; `pollStats` never surfaced | F-05, F-07, F-01, F-04, F-06 |
| 4 | Pragmatic risk mitigation | Load-bearing contract tests (`web_companion_contract_test.dart`, 18 assertions); uneven coverage (harbors 1/8, satellite 1/5); deploy secrets correctly optional (`deploy.yml:6–11`) | F-07, F-08, F-06, F-10, F-01 |
| 5 | Utilitarian minimalism | Zero debug-print/TODO/.env debt; battery-gate input validation (`underway_fetch.dart:55–59`); only 7 `Semantics(` uses in 395 files; Navikka/Sakkoja split | F-01, F-09, F-10, F-04, F-05 |
| 6 | Refactoring agility | Healthy honest-refactor cadence (#18–#20); `AiConsentDialog` dead code; e2e debris (~25 ad-hoc scripts, 20 MB) | F-02, F-07, F-01, F-03, F-11 |
| 7 | Coverage rigor & scale | Well-enumerated fetch decision machines (`fetch-policy.ts:96–149`); five+ untested datasource parsers; `npm install` in path-filtered CI; 25% coverage floor | F-06, F-03, F-12, F-08, F-02 |
| 8 | Security & longevity | Correct secret encapsulation (secure storage + Drift null-out); consent enforcement cosmetic; dispatch-mode hard-fail inconsistency | F-01, F-09, F-03, F-12, F-02 |
| 9 | Ergonomics, DX & a11y | Clean feature-first boundaries; hardcoded Finnish aria-label (`cockpit.tsx:357`); rebuild storms from missing equality; lefthook companion gating works (`lefthook.yml:12–14`) | F-10, F-05, F-01, F-04, F-07 |
| 10 | Automation & lean delivery | Typed AIS query objects mirrored Dart↔TS; freshness/format/linter-budget gates (`ci.yml:35,38,55–77`); no CI job runs e2e; machine-locked layout spec | F-07, F-12, F-08, F-06, F-10 |
| 11 | Formal patterns & mathematical correctness | Honest gust-factor and divergence mathematics (`local_marine_ai_test.dart:122–154,319–366`); Either-algebra inconsistency confined to two repos | F-03, F-11, F-02, F-05, F-06 |
| 12 | Operational transparency | Anti-fabrication locks verified (`web_companion_contract_test.dart:182–193,215–237`); assertion-free `live_audit.spec.ts`; docs advertise unenforced processes | F-07, F-01, F-10, F-09, F-04 |
| 13 | Rendering latency & throughput | Sound throttle stack (500 ms GPS, 4 Hz IMU budget, distance/zoom gating); rebuild churn hazard; phantom 300 ms debounce | F-05, F-11, F-02, F-04, F-06 |
| 14 | Runtime adaptation & UX edge cases | Layered degradation (SW offline shell `navikka-sw.js:68–84`; ocean-forecast fallback `weather.ts:36–55`); CriOS speed-null derivation tested (`fetch-policy.ts:58–90`); FIFO-not-LRU tile eviction | F-04, F-07, F-01, F-09, F-06 |
| 15 | Governance & pipeline security | Sanitized HUD error strings (`underway_fetch.dart:87–109`); `.env` stripped pre-deploy (`deploy.yml:97–98`); README silent on the one cloud pathway | F-01, F-12, F-07, F-09, F-06 |
| 16 | Empathy, WCAG & i18n | fi/en dictionaries present; sparse Flutter semantics (7 instances); dynamic alert states lack live regions; language leak in a11y layer | F-01, F-04, F-10, F-07, F-05 |
| 17 | Frontend aesthetics & naming | Coherent OLED identity; 5-layout system ambitious but unverifiable as shipped (`ulkoasu_layouts.spec.ts:3`); analyzer polish debt (12 infos incl. `map_content.dart:352`) | F-10, F-04, F-01, F-05, F-02 |
| 18 | Error logging & recoverability | `Log.*` discipline enforced (`architecture_check.dart:109–124`); gale/shelter advice tested (`local_marine_ai_test.dart:190–222`); silent sensor-death UX | F-09, F-07, F-04, F-06, F-01 |
| 19 | Algorithmic & memory efficiency | Bounded ring buffers (50 gyro samples, 30 peak-G, `wave_impact_ai_service.dart:155–199`); mutation-during-build antipattern; non-clearing `copyWith` | F-03, F-11, F-02, F-05, F-06 |
| 20 | Resource & concurrency efficiency | SW cache caps bound storage (`sw.js:4–5`); `_inFlightSyncs` race guard + coalescing (`point_weather_sync_controller.dart:64,290–298`); autoDispose wiping snapshot store | F-11, F-02, F-05, F-09, F-03 |

---

## 6. Cross-Examination Record

### 6.1 Debate Outcomes

| Challenger challenges Claimant | Claim | Verdict |
|---|---|---|
| Minimalism vs Velocity | "`pollStats` telemetry counters are useless" | **Adjusted** — exported and test-resettable (`fetch-policy.ts:20–32`) but zero UI/log surfacing in `cockpit.tsx`/`panels.tsx`; gap real, severity lowered. |
| Security vs Governance | Implied API-key exposure risk | **Debunked** — secure storage + Drift null-out verified (`skipper_settings_repository_impl.dart:15–16,71`). True issue is silent read failure at `:88`. |
| Coverage vs Risk | "Maintainability acceptable given contract tests" | **Upheld (against Risk)** — contract tests lock policy strings, not parsers; six datasource files lack any dedicated tests. |
| Zero-defect vs Adaptation | "Runtime adaptation covers sensor loss" | **Upheld (against Adaptation)** — SW/fallbacks cover network loss only; IMU `onError` log-and-abandon (`wave_impact_ai_service.dart:122–131`). |
| Transparency vs Aesthetics | "Visual hierarchy well-tested by layout spec" | **Upheld (against Aesthetics)** — spec machine-locked (`ulkoasu_layouts.spec.ts:3`) and production-hitting; verifies nothing reproducibly. |
| Typing vs Formalism | "Either algebra broken broadly" | **Adjusted** — violation confined to `navigation_repository_impl.dart:14–83` and `fishing_repository_impl.dart:183`; other boundaries comply. |
| Automation vs Velocity | "Golden tests harmless leftovers" | **Debunked (Velocity stands)** — `ci.yml:98–100` spends CI minutes selecting zero tests under `continue-on-error`. |
| i18n vs Ergonomics | "a11y adequately started" | **Adjusted** — FAB labeling real (`cockpit.tsx:299–338`) but untranslated label at `:357` and 7 Flutter `Semantics(` instances. |

### 6.2 Voting Record

Twenty reviewers × five votes = **100 votes** over twelve findings.

| Rank | Finding | Description | Votes |
|---|---|---|---|
| 1 | F-01 | Consent gate cosmetic / dead dialog | **13** |
| 2 | F-06 | Untested weather datasource parsers | **11** |
| 3 | F-02 | Duplicated native/web safety engine | **10** |
| 3 | F-04 | IMU sensor loss unrecoverable | **10** |
| 3 | F-07 | e2e broken & orphaned from CI | **10** |
| 6 | F-05 | Provider fragility cluster | **9** |
| 6 | F-09 | Silent persistence catch blocks | **9** |
| 8 | F-03 | Raw-throw repositories | **7** |
| 8 | F-10 | Documentation truth-drift | **7** |
| 10 | F-11 | Timing-spec drift | **6** |
| 11 | F-08 | Vestigial golden machinery | **4** |
| 11 | F-12 | Non-hermetic CI edges | **4** |

Full voter attribution per finding is retained in the audit session transcript; tallies above are the authoritative totals.

---

## 7. Remediation Roadmap

### P0 — Immediate blockers (1–7 days)

#### P0-1 · Enforce the cloud-AI consent invariant *(F-01, 13 votes)*
* **Root cause**: `hybrid_insight_engine.dart:72,89–91` ignores `hasAcknowledgedAISafety`; `ai_consent_dialog.dart` unwired.
* **Action**: Require consent flag in the cloud-call branch; wire `AiConsentDialog` into the settings enable-flow; add mocktail test asserting cloud refusal without consent (pattern: `hybrid_insight_engine_test.dart:262–301`).

#### P0-2 · Rescue the e2e suite *(F-07, 10 votes)*
* **Root cause**: Machine-locked artifact path + hardcoded prod URL (`ulkoasu_layouts.spec.ts:3`); assertion-free `live_audit.spec.ts`; no CI invocation.
* **Action**: `ARTIFACT_DIR ?? './artifacts'`; honor `baseURL`; add ≥1 assertion to `live_audit.spec.ts`; add optional artifact-uploading e2e job to `ci.yml` (non-blocking initially).

#### P0-3 · Stop silently dropping keys/preferences *(F-09, 9 votes)*
* **Root cause**: Seven empty catches incl. `skipper_settings_repository_impl.dart:88`.
* **Action**: Replace with `Log.w` + surfaced error state; secure-storage read failure must emit a settings-load warning, not return defaults.

### P1 — High priority (1–30 days)

#### P1-1 · Deduplicate the platform safety engine *(F-02)*
Extract shared reasoning core into one pure-Dart module consumed by both `weather_ai_edge_service_native.dart` and `..._web.dart`; run existing 11 `local_marine_ai_test.dart` cases against the shared core.

#### P1-2 · Test the weather parsers *(F-06)*
Fixture-driven tests (malformed XML/JSON, empty series, partial fields) for FMI, MET Norway (+ocean), Open-Meteo marine/wind, and OpenWeather sources, matching companion rigor in `weather.test.ts`.

#### P1-3 · IMU recovery + visibility *(F-04)*
Resubscribe-with-backoff in `wave_impact_ai_service.dart` `onError`; expose `sensorHealth` for HUD display; thread real SOG instead of default `boatSpeedKnots = 15.0` (:186).

#### P1-4 · Refactor `ForecastIntelligenceProvider` *(F-05)*
Move snapshot write out of `build()` (:113); keepAlive or persisted store; value equality; clearable events via `copyWith`; propagate errors.

#### P1-5 · Restore Either discipline *(F-03)*
Wrap `navigation_repository_impl.dart` and `fishing_repository_impl.dart:183` surfaces in `try/catch → Left(Failure)`; update consumers to `.fold`.

### P2 — Medium priority (30–60 days)

#### P2-1 · Documentation truth-pass *(F-10)*
Relative links at `AGENTS.md:5,11,47`; document HybridInsightEngine/BYOK in `README.md`; reconcile Navikka/Sakkoja naming; refresh `docs/architecture.md` past `943ec31`.

#### P2-2 · Align timing constants with spec *(F-11)*
Implement or de-document the 300 ms camera debounce; hoist the 250 ms buffer beside the 500 ms constant; extend `architecture_check.dart` to assert presence.

#### P2-3 · Fix or delete golden machinery; hermetic CI *(F-08/F-12)*
Delete orphan goldens and the vacuous `ci.yml:98–100` step (or author ≥1 real golden test); switch `web-pwa.yml:45` to `npm ci`; align `deploy.yml:30–33` dispatch behavior with the skip path.

### P3 — Polish (60–90 days)

#### P3-1 · Accessibility & i18n depth
Translate `cockpit.tsx:357` label via `i18n.ts`; live-region semantics for alert/MAYDAY states; grow the Flutter `Semantics` surface; consider a third locale (sv).

#### P3-2 · Cache eviction & observability
LRU-order eviction in `navikka-sw.js:33–39`; surface `fetch-policy.ts:20–25` poll statistics in a diagnostics panel.

#### P3-3 · Repository hygiene
Purge ad-hoc scripts/artifacts from `e2e/`; resolve the 12 `dart analyze` info notes (incl. `map_content.dart:352`, `forecast_intelligence_provider.dart:139–141`).

---

## Appendix A — Evidence Inventory

Commands and scans backing this audit (all executed at `1bde577`):

```
git fetch origin && git status -sb          # main == origin/main, clean
dart run scripts/architecture_check.dart    # PASS, 395 files
dart analyze lib/ test/                     # 0 errors, 12 infos
rg -c '\btest\(' -g '*_test.dart' test/     # 547 blocks across 127 files
rg -n 'catch \([e_]\)\s*\{\s*\}' lib/ ...   # 7 occurrences, 5 files
rg -n 'print\(|debugPrint\(' lib/ ...       # 0 matches
rg -n 'TODO|FIXME' lib/ apps/web-pwa/src    # 0 matches
git ls-files | grep -E '\.env'              # none tracked
rg -n 'matchesGoldenFile' test/             # 0 matches
rg --files .github/workflows/ | xargs grep -l 'e2e'   # no e2e job
```

Key single-source-of-truth files inspected line-by-line: `scripts/architecture_check.dart` (469 lines), `test/core/web_companion_contract_test.dart` (238 lines, 18 assertions), `apps/web-pwa/src/lib/navikka/fetch-policy.ts` (191 lines), `apps/web-pwa/public/navikka-sw.js` (85 lines), `lib/core/constants/underway_fetch.dart`.

## Appendix B — Limitations

1. **Static-only**: `flutter test`, companion `npm test`, and Playwright suites were not executed in this session; runtime failures may exist beyond these findings. Re-run the full gauntlet before release.
2. **Derived counts**: Playwright effective test counts (×browser projects) are arithmetic, not observed runs.
3. **Secrets**: GitHub Actions secret configuration (`OPENWEATHER_API_KEY`, Cloudflare tokens) not inspectable locally.
4. **Naming**: "Engine Copilot" (AGENTS.md §5) maps to `marine_technical_copilot_service.dart`; no 1:1 file exists — flagged for the P2-1 documentation pass.
