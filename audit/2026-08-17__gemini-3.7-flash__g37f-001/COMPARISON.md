# COMPARATIVE AUDIT EVALUATION: GEMINI 3.7 FLASH (RUN A) vs. GROK 4.5 (RUN B)

- **Target:** Sakkoja Marine Safety Navigator @ main `604ebd4`
- **RUN A:** `2026-08-17__gemini-3.7-flash__g37f-001` (Full Multi-Agent Graph, Live Shell/Test Execution)
- **RUN B:** `grok001` (Grok 4.5, Sequential Architecture & Performance Focus under Sandbox I/O Limits)

---

## 1. Findings Matrix

| Finding / Defect Theme | Location in Codebase | Run A Finding | Run B Finding | Match Category |
|---|---|---|---|---|
| **Voice Copilot Static 2.4m Depth / Location Grounding Risk** | `lib/features/ai/domain/services/voice_copilot_service.dart:94-160` | **AI-002** ($S_0$ / $C_1$) | *Omitted (Skipped Wave 1 AI)* | **Only Run A** |
| **CORS Worker Parameter Loop Overwrites API Key** | `cloudflare-worker/src/index.js:164-187` | **SEC-001** ($S_1$ / $C_1$) | *Omitted (Skipped Wave 1 SEC)* | **Only Run A** |
| **100 Hz Accelerometer Sensor HUD Rebuild Thrashing** | `lib/features/ai/domain/services/wave_impact_ai_service.dart:129-144` | **PERF-001** ($S_1$ / $C_1$) | *Omitted (Skipped Wave 1 AI)* | **Only Run A** |
| **Dio Retry Path Mutation Rate-Limit Collapse** | `lib/core/providers/core_providers.dart:49-108` & `core/network/` | **SEAM-001** ($S_1$ / $C_1$) | **PERF-002** ($S_2$ / $C_2$) *(Related)* | **Shared Theme** |
| **Dual Source of Truth (Riverpod keepAlive vs Drift SQLite)** | `lib/features/weather/` & `core/settings/` | **ARC-001** ($S_3$ / $C_1$) & **SEAM-002** ($S_2$ / $C_1$) | **ARC-001** ($S_2$ / $C_2$) | **Found by Both** |
| **Vessel Profile Accumulation on Every Save** | `lib/features/vessel/presentation/controllers/vessel_controller.dart:67-82` | **DATA-001** ($S_2$ / $C_1$) | *Omitted (Skipped Wave 1 DATA)* | **Only Run A** |
| **Unbounded `CachedFeatures` SQLite Growth** | `lib/core/db/app_database.dart:58-67` | **DATA-002** ($S_2$ / $C_1$) | *Omitted (Skipped Wave 1 DATA)* | **Only Run A** |
| **Chrome Built-in AI `LanguageModelSession` Leak** | `lib/features/ai/domain/services/weather_ai_edge_service_web.dart:129-132` | **AI-001** ($S_2$ / $C_1$) | *Omitted (Skipped Wave 1 AI)* | **Only Run A** |
| **SQLite WAL File Never Truncated on Shutdown** | `lib/core/db/app_database.dart:295-300` | **Ω-001** ($S_2$ / $C_1$) | *Omitted (Skipped Wave 3 Ω)* | **Only Run A** |
| **Safari Private Browsing IndexedDB Web Crash** | `lib/core/db/app_database.dart:420-455` | **Ω-004** ($S_2$ / $C_1$) | *Omitted (Skipped Wave 3 Ω)* | **Only Run A** |
| **N+1 `getOrCreateStation` in Weather Cache Loops** | `lib/core/db/daos/weather_dao.dart:172` | *Discarded / Verified Resolved* | **PERF-001** ($S_1$ / $C_2$) | **Only Run B** |
| **Shared Core DB Tables Without Module Ownership** | `lib/core/db/` & `features/*/data/daos/` | *Omitted (Captured in DATA-001)* | **ARC-002** ($S_3$ / $C_2$) | **Only Run B** |
| **Lack of Unified SpatialService Abstraction Layer** | `lib/features/navigation_aids/`, `fishing/`, `speed_limits/` | *Omitted (Captured in DEP-003)* | **ARC-003** ($S_3$ / $C_3$) | **Only Run B** |
| **Concurrent Tile Download vs Live Map LRU Cache** | `TileDownloadManager` & Drift tile tables | *Discarded (Guarded by tileDio)* | **PERF-004** ($S_2$ / $C_3$) | **Only Run B** |

---

## 2. Agreement Rate & Severity Calibration

### Shared Findings ($n = 2$)
1. **Dual State Ownership (Riverpod vs. Drift SQLite)**
   - *Run A Verdict:* $S_3$-Low / $C_1$ (ARC-001). Initial asynchronous preferences load causes a 1-frame state divergence on startup ($<50$ms), but reactive Drift streams converge quickly.
   - *Run B Verdict:* $S_2$-Medium / $C_2$ (ARC-001). Identifies that keepAlive notifiers and Drift tables can desynchronize on app resume or web multi-tab OPFS usage without explicit reconciliation.
   - *Adjudication:* **Both are correct.** Run A analyzed the exact startup frame transition; Run B captured the broader architectural debt of managing state in two concurrent layers.
2. **Parallel Weather Sync / Rate Limiting Strain**
   - *Run A Verdict:* $S_1$-High / $C_1$ (SEAM-001). Traced the exact bug where `WebProxyInterceptor` URL rewriting causes retried Dio requests to misattribute domain quotas to the proxy worker.
   - *Run B Verdict:* $S_2$-Medium / $C_2$ (PERF-002). Identified that concurrent provider triggers across FMI, MET Norway, and OpenWeather can flood external API quotas during cold start and map pans.
   - *Adjudication:* **Both are valid.** Run B diagnosed the architectural concurrency trigger; Run A isolated the exact interceptor retry mechanism that amplifies it into a rate-limit lockout.

### Disagreed Finding: N+1 Weather Station Cache Loops
- *Run B Claim (PERF-001 / $S_1$):* Station caching performs individual `getOrCreateStation()` queries inside per-DTO loops, causing hundreds of DB round-trips per sync.
- *Code Evidence at `604ebd4`:* 
  - `git grep -n "getOrCreateStation(" lib/` reveals that single-station creation is called **0 times** across `lib/`.
  - All 6 ingestion methods in `drift_weather_store.dart` (lines 239, 433, 598, 739, 1325, 1395) use `_resolveStationsBatch()` and `WeatherDao.getOrCreateStationsBatch()`, which were implemented in commit `8a03b24`.
- *Adjudication:* **Run B's finding is historically accurate but factually obsolete in the current codebase.** Run B relied on historical signals in `PERFORMANCE_AUDIT.md` and repository issue logs without live code execution to verify the current commit state.

---

## 3. Unique-Find Analysis

### Findings Unique to Run A (Gemini 3.7 Flash)
1. **`AI-002` ($S_0$-Critical — Static Voice Copilot Navigational Hazard):**
   - *Why Run B missed it:* Run B did not audit the Marine AI domain team (`features/ai`). Run A inspected `VoiceCopilotService.parseSpeech` and discovered that voice queries return hardcoded strings (*"2.4 m depth"*, *"Suomenlinna 2.1 NM"*) regardless of the vessel's actual GPS coordinates.
2. **`SEC-001` ($S_1$-High — CORS Proxy Secret Parameter Overwrite):**
   - *Why Run B missed it:* Run B did not perform a dedicated Security pass. Run A traced the JavaScript execution order in `cloudflare-worker/src/index.js:180-186` where client query parameters overwrite server-injected API keys.
3. **`DATA-001` ($S_2$-Medium — Vessel Profile Accumulation):**
   - *Why Run B missed it:* Run B skipped the Data domain team. Run A traced `VesselSettingsController.saveProfile` and found that `createProfile` is invoked unconditionally on every edit because `VesselService` lacks an `updateProfile` method.
4. **`Ω-001` & `Ω-004` ($S_2$-Medium — SQLite WAL Retention & Safari Private Mode Crash):**
   - *Why Run B missed it:* Run B skipped the Blind Spot Unit (Ω). Run A analyzed SQLite storage lifecycle defaults and Web Wasm IndexedDB initialization exceptions.

### Findings Unique to Run B (Grok 4.5)
1. **`ARC-002` ($S_3$-Low — Core DB Shared Schema Ownership Debt):**
   - *Is it real?* **Yes.** Having multiple feature modules (`weather`, `fishing`, `vessel`, `ai`) extend and query shared core tables without modular sub-schemas or clear domain ownership creates long-term migration coupling.
2. **`ARC-003` ($S_3$-Low — Lack of Unified SpatialService Layer):**
   - *Is it real?* **Yes.** While individual layers work, coordinate transformations (EPSG:3067 $\leftrightarrow$ 4326) and spatial bounding-box checks are implemented ad-hoc across feature modules rather than behind a unified spatial engine.
3. **`PERF-004` ($S_2$-Medium — Tile LRU vs Live Map Write Concurrency):**
   - *Is it real?* **Plausible hypothesis.** While live map tiles use a dedicated `tileDio` client, concurrent write contention on SQLite tile metadata tables during active navigation downloads remains a valid stress-case risk.

---

## 4. Evidence Quality & Confidence Calibration

- **Run B’s Calibration Honesty:** Run B self-reported that due to sandbox I/O limitations and lack of Flutter SDK execution, its findings were constrained to $C_2$-Reasoned and $C_3$-Hypothesis. This is **exemplary adherence to Law 4 (Label certainty, never hide it)**. Run B did not claim false verification for things it could not execute.
- **Run A’s Verification Depth:** Run A operated with full local execution (running `flutter test` [537/537 passed] and `flutter analyze` [clean]), enabling it to earn $C_1$-Verified status by tracing live execution paths, confirming dependency presence (`sensors_plus: ^7.1.0`), and verifying line-level AST structures.

---

## 5. Blind Spot Unit Comparison

* **Run B:** Did not complete a separate Wave 3 Blind Spot Unit due to response length and environment constraints (logged as a deliberate deviation).
* **Run A:** Produced 5 unique $\Omega$ findings that prior domain teams structurally overlooked:
  * `Ω-001`: Omission of `PRAGMA wal_checkpoint(TRUNCATE)` on app shutdown.
  * `Ω-002`: Zoom-independent coordinate delta pan gating causing excessive low-zoom API queries.
  * `Ω-003`: Administrative boundary speed-limit warning interpolation delays.
  * `Ω-004`: Safari Private Browsing IndexedDB initialization white-screen crash on Web.
  * `Ω-005`: PWA service worker chunk 404 deployment race conditions.

---

## 6. Deviations & Methodological Evaluation

* **Run B Deviations:**
  * *D1 (Sampling / Sequential pass):* Prioritized ARC and PERF due to I/O extract limits.
  * *D2 (Prior audit awareness):* Treated historical performance notes as secondary signals.
  * *Evaluation:* Reasonable adaptation to environment constraints, but relying on historical issue signals led to reporting the already-fixed N+1 issue.
* **Run A Deviations:**
  * *D01 (Added Domain Team: AI / Marine Safety):* Added specialized review for on-device Gemini Nano, heuristic engines, IMU wave algorithms, and voice copilot services.
  * *Evaluation:* Highly productive — directly uncovered `AI-002` (the sole $S_0$-Critical finding in the codebase).

---

## 7. Unified Verdict & Synthesis

When the findings of both runs are merged without partisan framing, they tell a clear and consistent story:

### 1. What Both Runs Succeeded At:
* **Architectural Diagnosis:** Both runs correctly diagnosed the tension between Riverpod keepAlive state and Drift SQLite persistence, as well as the risk of concurrent multi-provider weather syncs overwhelming network rate limits.

### 2. What the Union of Both Runs Teaches:
* **From Run A (Immediate Safety & Code Hotfixes):**
  1. Fix `AI-002` ($S_0$): Eliminate static 2.4m depth / Suomenlinna strings from `VoiceCopilotService`.
  2. Fix `SEC-001` ($S_1$): Re-order parameter loop in `cloudflare-worker/src/index.js` to protect `OPENWEATHER_API_KEY`.
  3. Fix `PERF-001` ($S_1$): Throttle `WaveImpactAiService` sensor stream emissions to 250ms.
  4. Fix `DATA-001` ($S_2$): Add `updateProfile` to `VesselService` to prevent SQLite row accumulation.
* **From Run B (Long-Term Structural Hygiene):**
  1. Adopt `ARC-002` ($S_3$): Establish clear module ownership boundaries and contract tests for shared SQLite tables.
  2. Adopt `ARC-003` ($S_3$): Consolidate ad-hoc coordinate transformations (EPSG:3067/4326) into a unified `SpatialService`.
  3. Reconcile State (`ARC-001`): Formalize Drift SQLite as the single source of truth, converting Riverpod providers into pure stream projections.
