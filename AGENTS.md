# AGENTS.md

> **Purpose**: Router and context-injection guide for AI coding assistants and contributors working on the Navikka codebase.
> **Last Verified**: 2026-08-23 @ `fix/friday-field-test-underway`
> **Canonical Docs**: [llms.txt](file:///c:/dev2/gtp/sakkoja/llms.txt) (LLM Context Map) · [docs/architecture.md](file:///c:/dev2/gtp/sakkoja/docs/architecture.md) (Architecture Specification) · [docs/developer_guide.md](file:///c:/dev2/gtp/sakkoja/docs/developer_guide.md) (Developer Guide)

---

## 1. Project Identity & Stack
- **Name**: Navikka (Marine Safety Navigator for Finnish Waters)
- **Primary Stack**: Flutter & Dart (versions pinned in [`pubspec.yaml`](file:///c:/dev2/gtp/sakkoja/pubspec.yaml) and `.fvmrc`), Riverpod 3.x, `flutter_map` 8.x, Drift SQLite (schema v18).
- **Primary Deployment**: Web PWA (Cloudflare Pages + Worker CORS Proxy) and Mobile (Android/iOS).
- **React companion**: `apps/web-pwa`, production URL **`/cockpit/`**. Source-isolated from `lib/`. Ways of working: §13.

---

## 2. Core Architectural Rules
1. **Feature-First Clean Architecture**: Every feature lives in `lib/features/<name>/{data, domain, presentation}`.
2. **DTO Layer Isolation**: DTO models in `data/models/` must NOT import domain entities from `domain/entities/`.
3. **State Management**: Pure `@riverpod` / `@Riverpod(keepAlive: true)` code-generated Notifiers only. No legacy `ChangeNotifier` or `StateProvider`.
4. **Data Persistence**: Drift SQLite (`sqlite3` with WAL mode). Always return `Future<Either<Failure, T>>` using `fpdart`.
5. **GPS & Telemetry Concurrency**: Respect the GPS cascade: 500ms GPS throttle, 300ms camera debounce, and 250ms visual throttle buffer on hardware sensor streams (`WaveImpactAiService`).
6. **Zero N+1 DB Queries**: Always use `_resolveStationsBatch()` / `WeatherDao.getOrCreateStationsBatch()`.

---

## 3. Standard Development Commands
- **Code Generation**: `dart run build_runner build --delete-conflicting-outputs`
- **Run Tests**: `flutter test`
- **Run Static Analysis**: `dart analyze lib/ test/`
- **Run Architecture Checks**: `dart run scripts/architecture_check.dart`
- **Format Code**: `dart format .` (pre-commit auto-formats via `lefthook`)
- **Run E2E Tests**: `cd e2e && npm test`
- **Deploy**: `.\scripts\build_web.ps1` (Windows) or `./scripts/build_web.sh` (macOS/Linux)

---

## 4. Release Protocol
- **Atomic Release Commits**: Bumping `version:` in `pubspec.yaml` MUST also update `CHANGELOG.md`.
- **Commit Type**: `chore: release vX.Y.Z` (must pass `dart analyze lib/ test/` and `flutter test`).

---

## 5. AI Subsystems & Data-Flow Boundaries
- **Core AI is 100% On-Device / Offline**: Voice Copilot, Wave Impact IMU, Marine Weather Reasoner, Engine Copilot, and Voyage Logbook emit zero telemetry to external servers.
- **Opt-in Cloud**: Only `HybridInsightEngine` calls OpenRouter when a user explicitly configures a personal BYOK API key and accepts the consent dialog.
- **Reference**: Full specification table documented in [`README.md`](file:///c:/dev2/gtp/sakkoja/README.md) and [`docs/architecture.md`](file:///c:/dev2/gtp/sakkoja/docs/architecture.md).

---

## 6. Satellite & Earth Observation Standards
- **Explicit Acquisition Metadata**: All satellite screens and badges must explicitly display the capture date, time, and spatial resolution (e.g. `10m/px` for Sentinel-2 optical RGB) to avoid confusion between spatial resolution and temporal recency.
- **Authentic Satellite Basemap**: In meteorological satellite / weather observation views (e.g. EUMETSAT cloud loops), always use high-resolution optical satellite imagery (ESRI World Imagery) as the underlying basemap instead of street/road maps so clouds and rain bands overlay onto genuine Earth textures.
- **Web vs. Native Tile Providers**: On Web/PWA, use `NetworkTileProvider` with proper `User-Agent` and `Referer` headers to leverage the browser's native fetch and CORS caching. On Native, use `DriftTileProvider` for offline SQLite tile caching.

---

## 7. AI Weather & Fog Safety Auditing
- **Deterministic Visibility Thresholds (COLREG Rules 19 & 35)**:
  - $\le 500\text{ m}$: `SafetyStatus.red` (Dense fog — sound fog signals, illuminate navigation lights, reduce speed).
  - $\le 1000\text{ m}$: `SafetyStatus.orange` (Fog warning — post lookouts, monitor Radar/AIS).
  - $\le 2500\text{ m}$: `SafetyStatus.yellow` (Mist/haze).
- **Thermodynamic Sea Fog Condensation Risk**:
  - Flag condensation risk when $|T_{\text{air}} - T_{\text{dew}}| \le 1.2^\circ\text{C}$ and relative humidity $\ge 90\%$.
- **Forecast Low Cloud & Fog Auditing**:
  - Scan next $1\text{--}6\text{ h}$ forecast for incoming cloud cover $\ge 95\%$, high humidity, or fog weather codes to alert the skipper before visibility collapses.

---

## 13. React companion (`apps/web-pwa`) — ways of working

Helsinki skipper cockpit, not a second Navikka. Flutter `lib/` remains the product. Companion is served at **`/cockpit/`** on the same Cloudflare Pages origin.

**Do**

- Put underway numbers only in `apps/web-pwa/src/lib/navikka/fetch-policy.ts` and lock them with `*.test.ts`.
- After a marine-safety change: `cd apps/web-pwa && npm test && npm run typecheck`.
- After a Pages/URL change: `flutter test test/core/web_companion_contract_test.dart` and `dart run scripts/architecture_check.dart`.
- Keep `web/_redirects` `/cockpit` and `/pwa` **above** `/* /index.html 200`. Keep `/cockpit/*` splat 200.
- Build with `--base=/cockpit/`. Never `--base=./`. Never a second copy under `/pwa`.
- Fairway distance is a polyline **segment** (`distToSegmentM` / `distToPolylineM`), cap 1 km.
- First LIVE GPS must not inherit demo SOG (`deviceFixKinematics`).
- AIS query is `aisQuery` (`latitude/longitude/radius`). Seed AIS is not live (`aisSource: "seed"`).
- Weather errors throw. Empty MET `timeseries` throws. Retry uses `lastAttemptAt` + `WEATHER_RETRY_MS` (60 s). **Moved snap cell beats backoff.** `lastAttemptAt` is required.

**CI (every PR, both stacks)**

- Flutter `verify` job runs `architecture_check.dart`, `flutter test` (includes `web_companion_contract_test.dart`), **and** `apps/web-pwa` `npm test` + `typecheck` + `--base=/cockpit/` build.
- Path-filtered `.github/workflows/web-pwa.yml` is extra, not a substitute. Do not remove `npm test` from `ci.yml`.
- Lefthook runs companion tests when `apps/web-pwa/**` is staged.
- Pages deploy (`deploy.yml`) must **skip** (not fail) when `CLOUDFLARE_API_TOKEN` or `CLOUDFLARE_ACCOUNT_ID` is unset. Do not mark those secrets `required: true` on `workflow_call`. Live `/cockpit` still needs both secrets in the GitHub repo.

**Do not**

- Import Flutter `lib/` from the companion, or the reverse.
- Set `User-Agent` on browser `fetch` (MET CORS).
- CPA-alarm MEGASTAR seed traffic.
- Tell the skipper "Avomeri" while they are on a drawn hel-9 segment.
- Make companion tests path-filtered-only (a Dart-only PR must still fail if it unships `/cockpit`).

Skill: `.agent/skills/navikka-underway/SKILL.md`.

