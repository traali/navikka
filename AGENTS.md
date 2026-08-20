# AGENTS.md

> **Purpose**: Router and context-injection guide for AI coding assistants and contributors working on the Navikka codebase.
> **Last Verified**: 2026-08-19 @ `fad64ef`
> **Canonical Docs**: [llms.txt](file:///c:/dev2/gtp/sakkoja/llms.txt) (LLM Context Map) · [docs/architecture.md](file:///c:/dev2/gtp/sakkoja/docs/architecture.md) (Architecture Specification) · [docs/developer_guide.md](file:///c:/dev2/gtp/sakkoja/docs/developer_guide.md) (Developer Guide)

---

## 1. Project Identity & Stack
- **Name**: Navikka (Marine Safety Navigator for Finnish Waters)
- **Primary Stack**: Flutter & Dart (versions pinned in [`pubspec.yaml`](file:///c:/dev2/gtp/sakkoja/pubspec.yaml) and `.fvmrc`), Riverpod 3.x, `flutter_map` 8.x, Drift SQLite (schema v18).
- **Primary Deployment**: Web PWA (Cloudflare Pages + Worker CORS Proxy) and Mobile (Android/iOS).

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

