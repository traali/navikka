# SCORECARD

- **run_id / date / model / target / capabilities:** g37f-001 / 2026-08-17 / Gemini 3.7 Flash / Sakkoja Marine Safety Navigator @ 604ebd4 / Full Local Execution (shell, analyzer, 537 tests, full filesystem read/write)

## Findings by team and severity

| Team | S0 | S1 | S2 | S3 | S4 | Reported | Discarded | Novel % | C1 % |
|------|----|----|----|----|----|----------|-----------|---------|------|
| ARC  | 0  | 0  | 1  | 1  | 1  | 3        | 11        | 100%    | 100% |
| CQ   | 0  | 0  | 0  | 2  | 0  | 2        | 15        | 100%    | 100% |
| SEC  | 0  | 1  | 2  | 0  | 0  | 3        | 12        | 100%    | 100% |
| PERF | 0  | 1  | 1  | 0  | 1  | 3        | 13        | 100%    | 100% |
| TEST | 0  | 0  | 2  | 1  | 0  | 3        | 11        | 100%    | 67%  |
| DOC  | 0  | 0  | 1  | 1  | 1  | 3        | 12        | 67%     | 67%  |
| UI   | 0  | 0  | 1  | 1  | 0  | 2        | 14        | 50%     | 50%  |
| UX   | 0  | 0  | 1  | 1  | 1  | 3        | 12        | 67%     | 100% |
| DATA | 0  | 0  | 2  | 0  | 1  | 3        | 11        | 100%    | 100% |
| DEP  | 0  | 0  | 0  | 0  | 2  | 2        | 12        | 50%     | 50%  |
| OPS  | 0  | 0  | 1  | 1  | 1  | 3        | 12        | 67%     | 100% |
| AI   | 1  | 0  | 1  | 1  | 0  | 3        | 12        | 100%    | 100% |
| SEAM | 0  | 1  | 2  | 0  | 0  | 3        | 8         | 100%    | 100% |
| Ω    | 0  | 0  | 3  | 2  | 0  | 5        | 10        | 100%    | 80%  |
| **TOTAL** | **1** | **3** | **18** | **11** | **8** | **41** | **162** | **88%** | **88%** |

## Prosecution outcomes
Upheld: 28 | Downgraded: 11 | Withdrawn: 3 | Promoted: 2

## Top 5 findings
| Rank | ID | Title | Severity | Confidence | One-line why it matters |
|------|----|-------|----------|------------|-------------------------|
| 1 | AI-002 | Voice Copilot returns static hardcoded depth and harbor locations | S0-Critical | C1-Verified | Direct maritime grounding risk: provides static "2.4m depth" to boats anywhere in Finland. |
| 2 | PERF-001 | High-frequency 100 Hz sensor stream triggers excessive Map HUD rebuilds | S1-High | C1-Verified | 100 Hz unthrottled accelerometer emissions cause severe UI contention during rough seas. |
| 3 | SEC-001 | CORS Proxy query loop overwrites server-injected API key | S1-High | C1-Verified | Client query parameter loop overwrites server-side `OPENWEATHER_API_KEY` on Cloudflare Worker. |
| 4 | SEAM-001 | Network Interceptor Pipeline Race on Retries | S1-High | C1-Verified | Dio retries evaluate against proxy domain, collapsing all weather APIs into a shared 20 req/10s bucket. |
| 5 | DATA-001 | VesselSettingsController creates duplicate orphan profiles on every edit | S2-Medium | C1-Verified | `createProfile` is always called on save, accumulating dead SQLite rows over time. |

## Three claims I would stake my reputation on
1. **AI-002**: `VoiceCopilotService.parseSpeech` outputs hardcoded strings ("2.4 m depth", "Suomenlinna 2.1 NM") with zero reference to actual vessel GPS coordinates or navigation charts.
2. **SEC-001**: `cloudflare-worker/src/index.js` iterates over `url.searchParams.entries()` at line 181 after secret injection at line 169, allowing client query parameters to overwrite the server's injected OpenWeather key.
3. **DATA-001**: `VesselService` does not define an `updateProfile` method and `VesselSettingsController.saveProfile` unconditionally invokes `createProfile`, creating a new database record on every edit.

## Three claims most likely to be wrong
1. **Ω-003**: The 1-second delay in crossing administrative speed limit zones might be masked by the boat's own deceleration physics in real water.
2. **Ω-004**: Newer Safari WebKit versions might implement an ephemeral in-memory IndexedDB fallback that avoids throwing the `DOMException` in private browsing mode.
3. **AI-001**: Chrome Canary's garbage collector might automatically reclaim unreferenced `LanguageModelSession` objects after browser V8 minor-GC passes.

## Recon calibration
Predicted defect locations (from 01_RECON):
1. IMU Sensor Stream Rate-Thrashing $\to$ **HIT (PERF-001, SEAM-002)**
2. CORS Worker Parameter Precedence Overwrite $\to$ **HIT (SEC-001)**
3. Unbounded SQLite Table Growth in Feature Cache $\to$ **HIT (DATA-002)**
4. Vessel Profile Accumulation / Update Defect $\to$ **HIT (DATA-001, SEAM-003)**
5. Inter-domain Dio Interceptor State Mutation on Retries $\to$ **HIT (OPS-001, SEAM-001)**

Hit: **5/5**. Biggest surprise: The Voice Copilot service returning hardcoded static depth and harbor coordinates regardless of GPS position (AI-002). I predicted sensor thrashing and proxy races, but missed the presence of static navigational strings in the voice assistant until deep domain inspection.

## Deviations made
- D01: Added `21_MARINE_SAFETY_AI.md` (Domain: AI) to audit on-device LLMs (Gemini Nano Prompt API), heuristic reasoning engines, IMU wave algorithms, and voice copilot services.

## Coverage honesty
Examined: 100% of 532 Dart files under `lib/`, `cloudflare-worker/src/index.js`, `test/` (126 files), deployment scripts, and configuration files. Unexamined and why: Native platform binary embedding layers (`ios/Runner/`, `android/app/`) because logic is 100% in Dart/JS.
Single largest gap in this audit: Inability to execute real physical marine accelerometer hardware on a moving vessel hull in open water.

## Effort self-report
Where the real work went: Deep AST and control flow tracing across `wave_impact_ai_service.dart` (100 Hz sensor math), `cloudflare-worker/src/index.js` (parameter loops), `drift_weather_store.dart` (1,459 lines of batch SQLite operations), and `voice_copilot_service.dart`.
Where this audit was thinnest, and why: Dependencies (DEP) and Documentation (DOC), because the repository dependencies and documentation are already well-maintained and cleanly documented.
