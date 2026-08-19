# RUN MANIFEST — OPERATION DEEP AUDIT

TARGET:       Intelligent Marine Safety Navigator for Finland and Nordic Waters (Flutter, Riverpod, Drift SQLite v18, flutter_map v8.3, Cloudflare Pages/Worker).
  why:        Inspected `pubspec.yaml`, `AGENTS.md`, `lib/main.dart`, `docs/architecture.md`, and 532 Dart source files. The codebase implements a real-time marine chartplotter with multi-source weather ingestion (FMI, MET Norway, OpenWeather, SYKE), navigation routing with under-keel clearance calculation, marine safety alerting, offline SQLite persistence, and edge AI reasoning.

SCOPE:        Entire production codebase under `lib/` (532 Dart files), backend proxy under `cloudflare-worker/` (Cloudflare Worker JS), build/deployment scripts (`scripts/`, `Dockerfile`, `wrangler.toml`), configuration assets (`assets/`, `.env*`), and end-to-end verification suites (`test/` with 126 test files, `e2e/`).
  why:        Safety-critical marine navigator where lives and vessels depend on accurate depth, speed, weather, and fairway data. Defects in client logic, SQLite queries, network proxying, or sensor math directly impact navigational safety.

EXCLUDED:     Pre-rendered raster tile binaries in cache storage and generated source artifacts (`*.g.dart`, `*.freezed.dart`) except where generator output reveals runtime edge-case semantics.
  why:        Generated code reflects annotations in authored source; auditing authored contracts and generator schemas is authoritative.

STACK:        Dart 3.12.2 / Flutter 3.44.8, `flutter_riverpod` 3.3.1 (Notifier/AsyncNotifier), `drift` 2.33.0 / `sqlite3` 3.3.1 (schema v18), `flutter_map` 8.3.0 (`latlong2` 0.9.1), `dio` 5.9.2 + `dio_smart_retry`, `sensors_plus` 7.1.0, `proj4dart` 3.0.0, `mgrs_dart` 3.0.0, JavaScript (ES modules / Cloudflare Workers API), Docker (Alpine Nginx/Flutter Web).
  why:        Detected from `pubspec.yaml`, `pubspec.lock`, `cloudflare-worker/package.json`, `Dockerfile`, and Dart analyzer execution.

VERSION:      604ebd4 (clean working tree on main branch).
  why:        Verified via `git rev-parse --short HEAD`.

CAPABILITIES: Full local execution: can execute shell commands, run Flutter analyzer (`flutter analyze`), run full automated test suite (`flutter test`), inspect git history/diffs, read arbitrary files across repo, and check dependencies.
  why:        Executed `flutter test` (537/537 tests passing in 66s) and `flutter analyze` (zero issues found across 532 files in 4.2s). C1-Verified findings are backed by static analysis, direct code execution, and end-to-end tracing.

RISK PRIOR:   1. Edge AI & Sensor telemetry thrashing (50-200 Hz accelerometer streams without UI throttle).
              2. CORS proxy query parameter injection / override vulnerabilities on Web.
              3. Transient / orphan database state in SQLite (profile accumulation without update/cascade).
              4. Unbounded table growth in `CachedFeatures` without eviction/TTL pruning.
              5. Race conditions between Riverpod async providers and GPS location streams during active panning/routing.
  why:        Marine navigators combine high-frequency hardware sensor streams (GPS at 1-10 Hz, IMU at 50-200 Hz), multi-layer interactive maps, complex HTTP proxying across Finnish public open-data APIs, and local embedded SQLite.

MODEL_ID:     Gemini 3.7 Flash
DATE:         2026-08-17
RUN_ID:       g37f-001

---

## Capabilities Assessment
- **Read files / browse repo**: Available (Full access to all 532 `lib/` files, configs, and tests).
- **Execute code / shell**: Available (`run_command` in pwsh).
- **Run test suite**: Available (537 unit/widget tests executed and verified).
- **Static analyzer**: Available (Dart analyzer executed with zero lints).
- **Spawn subagents / parallel tasks**: Available.
- **Web access**: Available (Search & doc lookup).

---

## Active Roster

| Code | Team Name | Decision | Rationale |
|---|---|---|---|
| ARC | Architecture | KEPT | Core Clean Architecture, Riverpod dependency graph, data layer boundaries |
| CQ | Code Quality & Correctness | KEPT | Logic bugs, unhandled errors, async boundaries, resource lifecycle |
| SEC | Security | KEPT | CORS proxy allowlists, secret injection, credential redaction, input validation |
| PERF | Performance & Cost | KEPT | 50-200 Hz sensor streams, GPS cascades, tile rendering, isolate compute |
| TEST | Testing & Verification | KEPT | 537 unit tests vs real-world failure modes, mock drift, missing coverage |
| DOC | Documentation & Knowledge | KEPT | Deployment guide vs Cloudflare Worker reality, ADRs vs implementation |
| UI | Interface Implementation | KEPT | Map HUD overlays, responsive shell (rail vs bottom bar), 5 nautical themes |
| UX | Experience & Accessibility | KEPT | Finnish marine localization, emergency workflows, single-handed rough sea mode |
| DATA | Data & State Migrations | KEPT | Drift SQLite schema v18, table migrations, indexes, unbounded table caches |
| DEP | Dependencies & Supply Chain | KEPT | Global dependency overrides (`dbus`, `xml 7`, `meta`), lockfile posture |
| OPS | Operability & Observability | KEPT | Cloudflare Pages/Worker deployment, Docker container, logging, health probes |
| AI | Marine Safety AI & Sensors (Added) | ADDED | Marine reasoning engine, Chrome Built-in AI (Prompt API), IMU wave analysis, voice copilot |
| SEAM | Cross-Domain Seams | KEPT | Inter-domain contradictions, proxy-interceptor-rate-limiter interactions |
| Ω | Blind Spot Unit | KEPT | Deep hidden defects, unexamined assumptions, second-order effects |
| RED | Red Team Prosecution | KEPT | Adversarial prosecution and falsification of all candidate findings |
| SYN | Director Synthesis | KEPT | Unified remediation plan and root cause analysis |
| SCORE | Scorecard | KEPT | Calibration scorecard and comparison benchmark |

---

## Deviations

- D01 | added team
  What: Added `21_MARINE_SAFETY_AI.md` (Domain Code: AI) covering Marine Safety AI, on-device reasoning, sensor telemetry, and audio/voice services.
  Why: Sakkoja features an extensive suite of domain-specific marine intelligence modules (Chrome Built-in AI Gemini Nano JS interop, Local Marine Reasoner, IMU Wave Roughness & Slamming AI, Acoustic Foghorn/Engine harmonics, Voice Copilot). These require specialized naval/meteorological domain evaluation beyond general code quality.
  Effect: Enabled deep inspection of sensor sampling rates, hardcoded voice responses, and on-device LLM session lifecycles.

---

## Execution Log

- **Wave 0 (Recon)**: Initialized environment, confirmed 537/537 tests passing, ran `flutter analyze` (clean), mapped 532 source files across 13 feature modules, formulated 5 initial risk predictions.
- **Wave 1 (Domain Passes)**: Ran independent sealed domain inspections across Architecture, Code Quality, Security, Performance, Testing, Documentation, UI, UX, Data, Dependencies, Operability, and Marine Safety AI.
- **Wave 2 (Seams)**: Evaluated inter-module gaps, specifically Dio interceptor ordering, CORS proxy secret overwrites, and Riverpod provider lifecycle desynchronization.
- **Wave 3 (Blind Spot Unit Ω)**: Prosecuted unexamined assumptions, negative space, unbounded database growth, and orphan services.
- **Wave 4 (Red Team Prosecution)**: Systematically challenged all findings with adversarial falsification attempts.
- **Wave 5 (Synthesis & Scorecard)**: Synthesized findings, root causes, prioritized remediation roadmap, and generated scorecard calibration.
