# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- **React web-PWA companion (`apps/web-pwa`)**: Leaflet cockpit for Helsinki waters (SOG/COG/UKC HUD, harbors, fairways, speed-limit boxes, fishing rules, MET Norway weather, AIS, MAYDAY/112/MRCC, FI/EN, five bridge themes). Lives next to Flutter, does **not** replace `web/` or `flutter build web`.
- **iPhone 11 / 12 Chrome (CriOS / WebKit) hardening**: `100dvh` + `-webkit-fill-available`, `viewport-fit=cover`, `env(safe-area-inset-*)`, 16px inputs (no iOS focus-zoom), 44px targets, 375px HUD media query, clipboard `execCommand` fallback, SOS Share Sheet, Wake Lock retry on `visibilitychange`, `crypto.randomUUID` polyfill.
- **Tests (65+ `node:test` cases)**: haversine/CPA/UKC, Kauppatori 5 km/h no-wake, kuha 42 cm / taimen 60 cm, COLREG 19/35 fog, MAYDAY text, store demo-vs-device GPS, iPhone 11 vs 12 viewport contracts, **underway fetch policy**, last-good weather on radio loss, no Helsinki fairway at Porkkala. Path-filtered GitHub Action `.github/workflows/web-pwa.yml`.
- **Friday 2026-08-21 field test**: iPhone 11/12 Chrome loaded **navikka.pages.dev (Flutter PWA)**, not `/cockpit/`. Companion Playwright still covers 375×812 @2x and 390×844 @3x with CriOS UA.
- **Underway skipper skill** (`.agent/skills/navikka-underway`): weather/AIS/GPS/map rules so agents do not refetch MET on every GPS tick. Flutter numbers live in `lib/core/constants/underway_fetch.dart`.

### Fixed
- **Web chart blank ("Map data not yet available")**: Flutter PWA `NetworkTileProvider` set `User-Agent` + `Referer` (Chrome forbids those → Traficom CORS 403). Companion night theme used **Esri Ocean** — at Helsinki z13 those tiles *are* the watermark. Flutter: no custom tile headers, OSM underlay, transparent error tiles. Companion `/cockpit/`: Carto dark + Traficom merikartta + OpenSeaMap. Native Drift cache unchanged.
- **Friday field test (Flutter PWA, 2026-08-21) — underway radio + HUD**: iPhone 11/12 Chrome on `navikka.pages.dev`. Weather **HTTP was already TTL-gated** (FMI 10 min / 17.5 km); the Sää title jumping 502→455→517 m was GPS jitter, not a MET refetch (`Päivitetty: 16:00` stayed frozen). Station distance is now bucketed to 100 m. Skipper card + `LinearProgressIndicator` flicker came from `skipperInsightProvider` watching full weather state (`isSyncing`) plus a 2 s delay — now value-selects, `skipLoadingOnReload` on weather screen **and map banner**, no dummy progress. AIS was the real radio hog: `Timer.periodic(15s)` + national Digitraffic `/locations` with no radius; now `UnderwayFetch` (check 15 s, HTTP 60 s follow / 180 s idle, `radius=45` km, bbox ±0.4°). A 2 km pan no longer bypasses that TTL. Failed AIS stamps `_lastFetchAt` so empty-cache cannot 15 s-storm. iOS Chrome Battery Status API reports 0 → Skipper said "AI Disabled - Low Battery" at ~50% iOS battery; 0/null/out-of-range is unknown. Wave HUD `1.0g` was `WaveImpactState.initial()` dummy; chip **and sheet** show "—" until IMU samples. REC "Lopeta & Tallenna" truncated by zoom column → `right: 72`, label "Lopeta". `DioException`/`XMLHttpRequest` no longer lands on the skipper HUD (`sanitizeNetworkError`).
- **Companion AIS error storm**: failed AIS used to leave `aisAt` null so the 15 s poll retried every tick. `decideAisFetch` now requires `lastAttemptAt` and 60 s `AIS_RETRY_MS` backoff; cockpit arms AIS inflight **before** awaiting weather so a `visibilitychange` cannot double-fetch.
- **skipperInsight `.select`**: `ai_providers.dart` now imports `flutter_riverpod` so value-select compiles (CI `select isn't defined`).
- **Companion iPhone Chrome HUD**: `.cockpit` keeps `100dvh` last (CriOS URL bar); menu/catch inputs are 16px so iOS does not zoom on focus.
- **NEXUS v2.1 leftover on companion (main `6ba6270`)**: H1 empty live AIS no longer paints `AIS_SEED` (MEGASTAR ghosts). M1 weather backoff no longer blocks a new snap cell; `lastAttemptAt` is required. M2 skip-gate greps `if: needs.gate.outputs.should_deploy`. M3 README dropped "did not touch web/, lib/".
- **Weather fetched all the time while boating**: MET URLs used `toFixed(4)` (~11 m), so every GPS sample was a new cache-busting request, plus weather+ocean+AIS on one 120 s loop. Now snap to `0.05°` (~5.5 km), weather TTL **10 min**, AIS **60 s** underway / **180 s** idle, pause when the tab is hidden, keep last good weather, show age ("juuri" / "N min sitten") instead of a perpetual spinner. GPS apply-throttle 500 ms / 15 m; map follow pan only after ~12 m, no animation when SOG > 2 kn. 16 s demo watch: **1 weather fetch, 1 AIS fetch**.
- **Radio-loss weather lie**: MET failure used to return a calm 6.4 m/s fallback stamped `updated: now`, so the HUD said "juuri" and overwrote a real gale. Failure now throws; last good snap and its age stay; skipper sees "Säätä ei saatu."
- **MAYDAY / UKC off Helsinki**: `nearestFairwayDepth` always returned a Helsinki channel. Beyond 1 km (Porkkala, open Gulf) UKC is "—" and the VHF readout says *Off-fairway / avomeri* instead of "Sisäväylä 2,4 m".
- **Salmon id `loh` → `lohi`**: catch log now matches the Finnish species key; 45 cm lohi is undersize.
- **Waypoint tap**: selecting a route mark opens a detail sheet (DDM, range/bearing, delete) instead of a blank overlay.
- **CPA Opening**: when TCPA < 0 the sheet shows current range + "Avautuva", not a past closest-approach.
- **MapView unmount**: re-check `cancelled` before window resize listeners; tear the map down if the import finished after unmount.
- **Companion `tsc`**: `@types/node` + `npm run typecheck` in the web-pwa workflow.
- **Gauntlet lock-in (both stacks)**: every PR runs companion `npm test` + `typecheck` inside `ci.yml` (not only the path-filtered `web-pwa.yml`). Flutter `web_companion_contract_test` + `architecture_check` fail if `/cockpit` redirects, `--base=/cockpit/`, AIS radius, segment UKC, or LIVE GPS kinematics are undone. Empty MET `timeseries` now throws. Fishing polygons `.addTo(fish)`. Seed AIS does not CPA-alarm. Lefthook + PR template + AGENTS.md §13 encode the ways of working.
- **Pages deploy no longer fails main CI** when `CLOUDFLARE_API_TOKEN` / `CLOUDFLARE_ACCOUNT_ID` are empty: `deploy.yml` gates on `should_deploy` and skips wrangler. Manual `workflow_dispatch` still errors if secrets are missing.
- **sqlite3 3.5.1 → 3.5.2** (OpenSSL 3.6.3 / SQLCipher 4.18.0). Absorbs leftover dependabot #13.


### Notes
- Flutter PWA (`lib/`) now shares underway numbers with the companion via `lib/core/constants/underway_fetch.dart`.
- Companion stays at `/cockpit/`. Live Pages publish still needs Cloudflare secrets in the GitHub repo.
- Companion does not persist live GPS/weather; only theme, units, vessel, route, and catch log.

## [1.25.0] - 2026-08-17

### Modular On-Device Marine AI Suite & IMU Wave Slamming Estimator
- **Modular AI Settings (`AiSettingsProvider`)**: Independent on/off toggles in Valikko for all individual AI capabilities (Weather AI, Route AI, Acoustic Sentinel, Technical Copilot, Voice Copilot, Logbook AI, Wave Impact AI).
- **Chrome Built-in AI & Local Marine Reasoner**: High-precision zero-latency marine weather situational awareness via Chrome on-device Gemini Nano and deterministic `LocalMarineReasoner`.
- **Intelligent Weather Route Planner AI**: Computes under-keel clearance, wave-sheltered passage segments, and open sea safety indices directly within `RoutePlannerScreen`.
- **Multi-Model Ensemble Divergence Detection**: Identifies cross-model forecast discrepancies between FMI, MET Norway, and OpenWeather ($\ge 3.5\text{ m/s}$) and warns of rapid wind shifts.
- **Vessel Profile DB Extension (Schema v18)**: Drift SQLite migration adding `hin_code`, `engine_manufacturer`, `engine_model`, and `fuel_type` to `VesselProfiles`.
- **Offline Technical Marine Copilot (`/technical-copilot`)**: Workshop specifications, coolant/oil grades, impeller part numbers, and step-by-step fix guides for Volvo Penta, Yanmar, Yamaha, Mercury, Torqeedo, and Honda + custom offline manual notes.
- **Bilingual Hands-Free Voice Marine Copilot ("Hei Kippari" / "Hey Skipper")**: Web Speech / native voice recognition supporting Finnish and English commands for fairway depth, sheltered harbors, waypoint pinning, weather, and distress calls.
- **AI Voyage Recap & Automatic Logbook**: Generates comprehensive post-trip summaries with NM distance, max/average speed, wind exposure, and fuel consumption calculation ($1.1\text{ L/NM}$ gasoline, $0.8\text{ L/NM}$ diesel, $0\text{ L}$ electric).
- **IMU Accelerometer & Gyroscope Wave Roughness AI**: Real-time vertical $G$-force ($1.0\text{--}5.0\text{g}$), 60s sliding window slam frequency (hits/min), outlier bigger wave detection, Head/Beam/Quartering seas angle estimation, and actionable skipper speed/trim advisory.
- **IMO Red Watch Night Theme**: Low-luminance red OLED mode compliant with IMO/IEC 62288 bridge standards alongside Night Captain, Solar Flare, Deep Sea, and Boreal Aurora.
- **Customizable Unit Preferences**: Real-time conversions for speed (kn, km/h, mph), wind (m/s, kn, Bft, km/h), and depth (m, ft).

### Verification
- `flutter analyze`: No issues found (0 warnings/errors)
- `flutter test`: 80/80 AI & DB tests passing, 500+ project tests passing
- CI/CD: Automated deployment verified on Cloudflare Pages (`https://sakkoja.pages.dev`)

### Safety UI/UX Redesign & Web Hotfix Release
- **Global Marine Search Bar**: Floating autocomplete search pill on map supporting harbors, seamarks/buoys, and WGS84 GPS coordinate navigation.
- **Rough Sea / Glove Mode (64px)**: Tactile mode enlarging all GlassIconButton touch targets to 64x64dp with 16dp spacing for vibrating, wet-hand conditions.
- **Dynamic HUD Safe-Zone Engine**: Automatically offsets search bar and HUD controls when emergency banners (Fishing Mode, Lightning Alarms) are active.
- **AIS & Harbors Layers**: Added AIS vessel tracking and Harbors layer toggles to Layers menu and panel.
- **Web Deferred Loading 404 Recovery**: Standardized router imports to eliminate JavaScript chunk 404 errors on static CDN deployments.

### Verification
- flutter analyze: No issues (0 warnings/errors)
- flutter test: All passed (463+ unit/widget tests passing)

## [1.23.0] - 2026-05-20

### Boreal Aurora & DTO Modernization
- **Revontulet (Boreal Aurora) Theme**: Implemented an ultra-premium competitor-inspired dark theme featuring a slate canvas (`#080E17`) and glowing aurora emerald (`#10B981`) accents.
- **Weather DTO Modernization**: Standardized all weather data transfer objects (`AlgaeReportDto`, `AlgaeForecastDto`, `WaterQualityDto`) to use `@freezed` + `@LatLngConverter` JSON serialization for 100% type-safety and consistency.
- **Isolate Type-Safety**: Resolved Dart dynamic map casting warnings in nearest-lightning calculations within background isolate compute processes.
- **PointWeatherController Splitting**: Split the heavy monolithic `PointWeatherController` into three focused sub-controllers for observations, forecasts, and marine details, improving maintainability and performance.

### Verification
- flutter analyze: No issues (0 warnings/errors)
- flutter test: All passed (339+ tests passing)

## [1.22.0] - 2026-05-10

### CommandBar UI Layout
- **New Layout**: Added CommandBar - a unified top bar with speed/weather/course in one row
- **Fishing Mode Support**: CommandBar hides Speed/Weather widgets when fishing mode is enabled (matches Classic layout behavior)
- **Safe Area Compliance**: Uses MediaQuery.paddingOf(context) instead of hardcoded offsets to prevent notch/status bar overlap

### Verification
- flutter analyze: No issues
- flutter test: All passed (228+ tests)
- CI: All checks PASSED

## [1.21.0] - 2026-05-09

### Extensible UI System & Ghost HUD
- **Multi-Style Layouts**: Introduced a system to switch between 'Classic', 'Ghost', and 'Command Bar' UI styles.
- **Ghost HUD**: Ultra-minimalist interface for maximum map real estate, featuring text-shadow legibility and peripheral component placement.
- **Nautical Bottom Bar**: Integrated a slim navigation bar for quick access to Route, Start, and Menu actions.
- **Refined Speed Limits**: Circular "Traffic Sign" style badges for speed limits in Ghost mode.
- **Fishing Mode Integration**: Improved HUD visibility logic to hide clutter during active fishing.

### Fixed
- **PR Review Remediation**: Corrected speed unit labels, restored weather data guards, and resolved shadowed variable lint errors.

## [1.20.0] - 2026-05-09

### Navigation Aids & Data Integrity
- **Marker Visibility**: Promoted lateral markers (Port/Starboard) to "major" status, ensuring they appear at the same zoom level (11+) as cardinal markers.
- **Data Robustness**: Added support for zero-padded IALA codes ('01'-'09') in the safety equipment mapper.
- **Full Data Coverage**: Refreshed all bundled navigation assets (fairways, markers, lines) with a full dataset for Southern Finland, resolving truncation issues in dense areas like Helsinki.

### Fixed
- **Helsinki Data Gaps**: Fixed a 5,000-feature truncation limit in the bundling script that caused missing markers North of Lauttasaari.

## [1.19.0] - 2026-05-08

### SYKE Data Integration & Stabilization
- **CORS Proxy Hardening**: Expanded Cloudflare Worker allowlist and app-side interceptor to support all SYKE and MMM domains.
- **Database Migration Safety**: Added defensive table existence checks (`sqlite_master`) in Drift migrations to prevent crashes for legacy users.
- **Web WMS Proxying**: Implemented manual URL proxying for weather radar and algae layers on Web platform.

### Fixed
- **Linting & Analysis**: Resolved 20+ critical warnings related to unused catch variables, type inference, and formatting.
- **Production CI**: Stabilized GitHub Actions pipeline by fixing pre-commit hook failures.

## [1.18.0] - 2026-05-03

### Database Hardening & Reliability
- **Centralized Error Handling**: Implemented `DatabaseErrorHandler` to unify error mapping and logging across all database interactions.
- **Reactive Stream Protection**: Hardened all weather data streams against silent failures; UI now correctly receives and handles database outages.
- **Audit Remediation**: Successfully resolved all 12 security and reliability findings, including dead code removal and improved stack trace logging.
- **Cross-Platform Resilience**: Refactored database handlers to be fully web-compatible by removing native-only FFI dependencies.

### Fixed
- **Web Build Regression**: Resolved a critical compilation error on Web caused by native Sqlite dependencies in common code.
- **Transaction Safety**: Refactored data purge (`nuke`) operations to use atomic transactions with proper error recovery.



## [1.17.0] - 2026-04-22

### Operation Code Clash Remediation
- **Modular Map Architecture**: Refactored monolithic `MapScreen` into modular components (`MapVersionOverlay`, `MapControls`).
- **I18n Scaffolding**: Implemented full localization support (Finnish/English) using `AppLocalizations`.
- **Night Captain Theme**: Added premium OLED-optimized dark mode with automatic system-theme detection.
- **Security Hardening**: Tightened Content Security Policy (CSP), added HSTS headers, and blocked sensitive source map exposure.
- **Initialization Resilience**: Improved web loader with error boundaries and timeout recovery.

### Fixed
- **Region Naming Bug**: Fixed non-atomic timestamp bug in area selection naming.
- **Null Safety**: Resolved brittle localization access across all map widgets.
- **Compilation Regressions**: Fixed `OfflineDownloadController` database schema sync issues.

## [1.16.0] - 2026-04-20

### Fishing Mode (Hybrid Skipper)
- **Fishing HUD**: Implemented a glassmorphic HUD for real-time location-aware fishing status (RAJOITUSALUE vs. VAPAA KALASTUSALUE).
- **Advanced Filtering**: Unified fishing restriction filtering with category selection directly in the HUD.
- **Nautical Integration**: Automatically switches to Traficom nautical charts when Fishing Mode is enabled.
- **UX Polish**: Added haptic sonar pings and streamlined UI by hiding navigation clutter in fishing mode.

### Fixed
- **Web Build**: Resolved critical compilation errors in `version_provider.dart` and `drift_worker.dart` for web deployment.

## [1.15.1] - 2026-01-23

### Navigation & UX Redesign
- **Navigation Redesign**: Optimized the boating experience with a streamlined layout, improved tab navigation, and clearer instrumentation.
- **Weather HUD Enhancements**: Refined the Weather HUD V2 with improved state handling, stale data indicators, and polished animations.

### Quality & Infrastructure
- **Gold Standard Build Verification**: Established a hierarchical, multi-phase build pipeline (CodeGen -> Format -> Analyze -> Test -> Build -> Smoke Test) to catch issues at the earliest possible stage.
- **Automated Smoke Testing**: Implemented Android Runtime Verification with a dedicated smoke test suite (`integration_test/app_test.dart`).
- **Logic & Sync Fixes**: Resolved persistent async timer leaks in weather providers and refined synchronization logic for fishing restrictions.

## [1.15.0] - 2026-01-22

### UI Redesign 2026 ("Night Captain")
- **Complete Visual Overhaul**: Fully implemented the "Night Captain" design language with premium glassmorphism, OLED-black backgrounds, and consistent 3px blur effects.
- **Weather HUD V2**: Replaced legacy weather widgets with a unified, animated HUD providing instant access to Wind, Waves, Sea Level, and Temperature.
- **Detail Sheets**: Redesigned `WeatherDetailSheet` and `NavigationAidDetailSheet` with improved typography (Inter/Outfit) and animated headers.

### Reliability
- **Stability**: Fixed critical memory leaks in `debouncedMapCameraPosition` (Timer disposal) and `Log` (microtask leakage).
- **Concurrency**: Resolved async race conditions in `HybridFishingRestrictions` provider using `Listener` pattern.
- **Testing**: Cleaned up flaky widget tests and established strict "skip-with-tracking-ID" (FIX-005) protocol for blocking issues.

## [1.14.0] - 2026-01-22

### Added
- **UI Aesthetics**: Implemented `RoundedSuperellipseBorder` for premium, high-DPI smoothness on cards, dialogs, and bottom sheets.
- **Modern iOS Support**: Successfully migrated to the modern Apple-mandated `UIScene` lifecycle with full iOS 26 compatibility.

### Changed
- **Architecture Modernization**: Upgraded to **Flutter 3.38.7** and **Dart 3.10.7**.
- **Code Logic**: 
    - Refactored weather data parsing with Dart 3.10 **Switch Expressions**.
    - Optimized theme definitions using **Dot Shorthands**.
- **Dependencies**: Upgraded map utilities (`proj4dart`, `mgrs_dart`) and platform plugins (`battery_plus` 7.0.0).

### Fixed
- **Safety**: Resolved a critical async gap in `MapScreen` using `context.mounted`.
- **Infrastructure**: Corrected the SDK constraint in `pubspec.yaml` to align with the latest stable releases.

## [1.13.0] - 2026-01-22

### Added
- **Architecture Documentation**: Added `ARCHITECTURE.md` cataloging the Feature-First structure and contribution module.

### Changed
- **SDK Upgrade**: Updated minimum Flutter SDK constraint to `3.38.0` to support 2026 standards.
- **Adaptive UI**: Migrated Settings screens to use `Switch.adaptive`, `Slider.adaptive`, and `CircularProgressIndicator.adaptive` for native platform feel.
- **Modernization**: Replaced deprecated `Color.withOpacity` with `Color.withValues` for Wide Gamut support.

### Fixed
- **Test Integrity**: Added missing `path_provider_platform_interface` and `plugin_platform_interface` to `dev_dependencies`, resolving `model_download_service_test.dart` runtime errors.

## [1.12.0] - 2026-01-22

### Added
- **Virtual Skipper (Phase 0)**:
    - On-device AI integration using Gemma/MediaPipe (mobile/desktop).
    - Platform-aware AI stubbing for web compliance.
    - AI Safety Dialog and specialized design system tokens (`AppTextStyles`).
    - Expert heuristic engine for marine weather analysis.

### Fixed
- **Keyword Service**: Resolved priority conflict where restricted motor areas were incorrectly flagged as general fishing bans.
- **Navigation Aids**: Refactored repository to a strictly offline-first architecture, resolving dependency injection and test suite mismatches.
- **Vessel Service**: Standardized naming conventions and cleaned up stale controller logic.
- **Analysis**: Resolved 15+ lint warnings and completed project-wide test suite cleanup.
- **Fix**: Corrected WFS coordinate order for Väylävirasto API to fix missing navigation aids.
- **Fix**: Resolved "Fishing Restrictions not working" by switching to `CRS:84` (Lon,Lat) for MMM WFS API and regenerating bundled assets with correct coordinate order.
- **Optimization**: Added explicit rate limiting for Väylävirasto API (100 req/min).

## [1.11.4] - 2026-01-19

### Fixed
- **Race Condition Remediation**:
    - **User Contributions**: Migrated to atomic SQL storage to prevent "Read-Modify-Write" data loss.
    - **Weather Sync**: Implemented `isSyncing` guard in `PointWeatherSyncController` to eliminate redundant parallel API calls.
    - **Rate Limit Persistence**: Added domain-based serialization to `RateLimitInterceptor` to ensure accurate request history tracking under high concurrency.
- **Data Integrity**: Implemented a robust legacy data migration path for user contributions.

### Added
- **Concurrency Testing**: Introduced a dedicated stress test suite to validate database and network layer stability under extreme parallel load.

## [1.11.3] - 2026-01-19

### Performance
- **Weather Snapping**: Optimized coordinate snapping to 5.5km (0.05°) for all weather data streams, balancing model resolution with API efficiency.
- **Navigation Aids**: Implemented grid-based 3x3 tile fetching for NavAids and Fairway Areas, reducing bandwidth usage.
- **Deduplication**: Enabled universal in-flight request deduplication across Weather, Fishing, and Navigation data sources.

### Changed
- **Geometry Standardization**: Centralized all spatial precision and rounding constants in `GeometryConstants`.

### Fixed
- **NavAids Sync**: Replaced country-wide sync with localized BBox fetching.

## [1.11.2] - 2026-01-19

### Fixed
- **SQLite Integrity**: Resolved systematic `UNIQUE constraint failed` errors by switching `WeatherDao` write paths to `InsertMode.insertOrIgnore`.
- **Lightning Protection**: Enforced strict uniqueness for `LightningStrikes` via composite keys and schema version 5 upgrade.
- **Database Schema**: Bumped Drift schema version to 5 with robust clean-slate migration logic.


## [1.11.1] - 2026-01-19

### Fixed
- **Map Screen Crash**: Fixed critical initialization crash in `MapScreen` and test suite failures by implementing a robust `FakeTileProvider`.
- **Fishing Validation**: Enforced strict data integrity for `FishCatch` entities using `@Assert`, ensuring positive weight/length.
- **Web Stability**: Verified web startup sequence with new `integration_test/web_startup_test.dart`.
- **Test Integrity**: Validated Speed Limit and Weather resilience logic with non-invasive integration tests.

## [1.11.0] - 2026-01-19

### Changed
- **Dependency Injection**: Fully removed GetIt and Injectable from the codebase.
- **Provider Architecture**: Migrated all features (Weather, Fishing, Speed Limits, Navigation Aids, Maps, Contributions) to native Riverpod providers.
- **Project Structure**: Deleted `lib/core/di` and consolidated feature-level DI in `di/` subdirectories.

### Removed
- Removed `get_it`, `injectable`, and `injectable_generator` dependencies.
- Deleted `lib/core/di/injection.dart`, `register_module.dart`, and `drift_module.dart`.

### Fixed
- **Test Integrity**: Updated 200+ tests to use Riverpod `ProviderContainer` and `overrideWith` syntax, ensuring 100% pass rate.

## [1.10.1] - 2026-01-18

### Refactored
- **Fishing Feature DI**: Fully migrated `fishing` feature from GetIt to Riverpod.
  - Removed `@LazySingleton` from Data Sources and Repositories.
  - Removed `@lazySingleton` from 4 Domain Use Cases.
  - Created `fishing_di.dart` with native Riverpod providers.
- **Core Infrastructure**: Added `core_providers.dart` support for `SharedPreferences` and `Dio`.

## [1.10.0] - 2026-01-18

### Refactored
- **Weather DI Migration**: Completed full migration of the entire weather feature from GetIt to Riverpod.
- **Provider Centralization**: Consolidated all weather-related providers (DataSources, Repositories, Services, and Domain Streams) into a single source of truth: `weather_providers.dart`.
- **Architectural Unification**: Resolved the "Split-Brain DI" issue in the weather layer, improving lifecycle management and testability.
- **Legacy Cleanup**: Removed `@injectable` annotations and legacy GetIt service location from the weather feature.

## [1.9.0] - 2026-01-18

### Critical Safety & Modernization (Phase 1 & 2)
### Fixed
- **Offline Safety**: Implemented "Stale Fallback" in `DriftWeatherStore`. Offline users now see cached data (up to 7 days old) with a warning, instead of an empty screen.
- **Rate Limit Persistence**: `RateLimitInterceptor` now persists request history to safe storage (`SharedPreferences`), preventing API quota violations on app restart.
- **Dependency Injection**: Refactored DI graph to support asynchronous `SharedPreferences` initialization.

### Refactored
- **Code Modernization**: Converted `OfficialSignMapper` to use Dart 3.10 Switch Expressions for better readability and conciseness.

## [1.8.1] - 2026-01-17

### Fixed
- **Pre-Merge Integrity**: Resolved all `flutter test` failures prohibiting merge (Weather, Fishing, Speed Limits).
- **Parallel Fetching**: Updated `WeatherRemoteDataSource` to robustly fetch from all providers in parallel, ensuring partial data availability.
- **Race Conditions**: Fixed database closure exceptions in tests by awaiting `DriftWeatherStore` cleanup.
- **Fishing Caching**: Validated behavior of `FishingRepository` when remote sources fail (Offline-First fallback).

### Performance
- **Weather Phase 2**: Completed parallel data fetching and Drift persistence optimization for all weather data types.

## [1.8.0] - 2026-01-17

### Security & CI/CD
- **Hardcoded Secret Removal**: Removed exposed OpenWeather API keys. Access now requires `--dart-define`.
- **Information Disclosure**: Sanitized Cloudflare Worker CORS proxy errors.
- **Secure GPS**: Initiated remediation for unencrypted local storage.
- **Secure Build Pipeline**: Updated GitHub Actions to securely inject secrets.
- **Test Integrity Protocol**: Established strict protocol preventing broken code merges (100% pass rate enforced).

### Added
- **Connectivity Awareness**: Integrated `isOnlineProvider` to prevent redundant API calls.

### Fixed
- **Critical Test Failures**: Remediated 16 critical failing tests across Weather, Fishing, and Core modules.
- **FMI XML Reliability**: Fixed critical column-swap vulnerability in `XmlStreamParser`.
- **Drift Database**: Resolved "Bad state: Can't re-open a database" exceptions.
- **Null Safety**: Fixed `weather_hud_v2.dart` compilation errors.
- **Golden Tests**: Updated Windows golden files.

### Performance
- **Reactive Database**: Eliminated `Stream.periodic` polling in favor of native Drift `watch()`.
- **Battery Optimization**: Reduced GPS accuracy/frequency when appropriate.
- **Query Stabilization**: Implemented coordinate rounding to reduce cache misses.

### Technical
- **SDK Upgrade**: Flutter `3.38.7`, Dart `3.10.7`.
- **Dependencies**: `drift` -> `2.30.1`, `riverpod` -> `3.1.0`.

## [1.6.0] - 2026-01-16

### Architecture (SQL Redesign)
- **Schema Normalization**: Migrated from generic JSON storage to fully typed, relational SQL tables (`WeatherObservations`, `Forecasts`, `Alerts`, etc.) with Drift.
- **Provider Priority System**: Implemented dual-layer protection (Read-Side Deduplication + Write-Side Filtering) to ensure conflicts between FMI, OpenWeather, and MET Norway are resolved by priority.
- **Safety**: Added strict `CHECK` constraints for data validity (`stationType`, `severity`).
- **Performance**: Added 14+ database indices, including composite indices for instant "Latest Forecast" retrieval.

### Added
- **Forecast Versioning**: Added `issuedAt` tracking to correctly distinguish between different model runs.
- **Enhanced Parsing**: FMI parser now extracts **Pressure, Humidity, DewPoint, and CloudCover**.
- **Global Rate Limiting**: Implemented a provider-aware `RateLimitInterceptor` with specific quotas for OpenWeather (60/min), FMI, and MET Norway.
- **Persistence Verification**: Added automated `drift_storage_verification_test.dart` covering 100% of weather types.

### Fixed
- **Sea Level Data**: Fixed schema to allow `NULL` values instead of defaulting to physically incorrect `0.0`.
- **Unit Consistency**: Normalized OpenWeather precipitation probability to percentage (0-100) to match internal standards.

## [1.5.2] - 2026-01-163

### Added
- **Weather Radar Animation**: Full playback controls (play/pause, timestamp selection) integrated into the map HUD.
- **Lightning Strikes Reactive Layer**: Real-time display of recent lightning strike data (1h window) on the map.
- **Cache-First Architecture (Weather)**: Standardized "Offline-Fallback" strategy for all weather data types (Observations, Forecasts, Waves, Sea Level, Lightning, Alerts) to ensure instant UI responsiveness.

### Optimized
- **Lightning XML Parsing**: Implemented high-performance streaming parser using `xml_events`, reducing memory overhead and CPU usage during lightning data ingestion.

### Refactored
- **Unified Weather Controllers**: Merged `WeatherController` into `PointWeatherController`, eliminating logic duplication and simplifying the provider graph.
- **Removed Legacy Code**: Deleted legacy weather controller and state files to reduce technical debt.

## [1.4.0] - 2026-01-12

### Added
- **Navigation Aids**: Implemented `NavigationAidDetailSheet` to show detailed spatial and technical data for maritime markers.
- **Enhanced Logging**:
  - Detailed semantic logs for FMI API requests/responses (station names, result counts).
  - Explicit Cache HIT/MISS logging with data age in `DriftWeatherStore`.
  - Fetch-reason logging in `PointWeatherController` (TTL expiry vs Distance threshold).

### Changed
- **Battery & Network Efficiency**: Increased weather sync distance threshold from 5km to 15km to reduce redundant background activity.
- **Performance**: Optimized `displayedSpeedLimitsProvider` to use hybrid fetching and Riverpod `.select()` for efficient rebuilds.

### Fixed
- **UI Performance**: Eliminated `WeatherHudV2` flickering during data refreshes using `skipLoadingOnRefresh` and `RepaintBoundary`.
- **Data Completeness**: Restored missing `visibility` field to `WeatherDetailSheet`.
- **Testing**: Fixed regressions in `speed_limit_provider_test.dart` caused by new MapProvider dependencies.

## [1.3.0] - 2026-01-12

### Added
- **Aesthetics**: Integrated temperature display into the main `WeatherHudV2` summary row.
- **Detailed Weather Stats**: Added stats for Air Pressure, Precipitation (1h), and Cloud Cover to the `WeatherDetailSheet`.
- **Semantic Logging**: Enhanced FMI API debug logs with clickable request URLs and value-rich summaries (e.g., "Station Name | Temp | Wind").

### Changed
- **Weather Fetching Strategy**: Switched from unreliable point queries (`latlon`) to small BBox queries (±0.05°) for better FMI data availability (e.g., Helsinki observations).
- **Network Optimization**: Implemented spatial debouncing (5km move threshold) and temporal debouncing (1h TTL) to prevent redundant API calls.

### Fixed
- **Stability**: Fixed `Cannot use the Ref... after it has been disposed` crash in `PointWeatherController` by refining dependency injection and adding lifecycle guards.
- **Testing**: Updated `WeatherRepository` tests to match the new `requestId` parameter and resolved usecase initialization errors.


### Security & Privacy
- **Secure Proxy**: Implemented `WebProxyInterceptor` with `kIsWeb` check to ensure strict CORS handling on Web without exposing internal endpoints on mobile.
- **Privacy Hardening**:
  - **PII Masking**: Logs now mask high-precision coordinates (`60.1***, 25.0***`) to prevent leakage in debug output.
  - **Privacy Audit**: Recorded findings in `DOCS/PRIVACY_AUDIT.md`.
- **Infrastructure**: Secured `register_module.dart` to prevent proxy usage on native platforms.

### Reliability
- **CRITICAL / Infinite Loop Fix**: Added hard page limit (20 pages / 10k items) to `SpeedLimitRemoteDataSource` to prevent runaway recursion during WFS pagination.
- **Crash Prevention**:
  - **NaN Sanitization**: Implemented strict `safeDouble` parsing for FMI `WeatherForecastDto`, `WeatherObservationDto`, and `WaveObservationDto` to prevent crashes when API returns "NaN" strings.
  - **Safety Checks**: Added explicit null handling for `0.0` vs `null` ambiguity in weather data.

### Observability
- **Request Tracing**: Added `requestId` to `WeatherRemoteDataSource` and logs to trace individual API calls from Repository to Network layer.

## [1.1.3] - 2026-01-11

### Fixed
- **PointWeatherController**: Resolved `LateInitializationError` crash occurring during provider rebuilds by removing `final` modifier from `late` dependency fields, allowing safe re-initialization.

## [1.1.2] - 2026-01-11

### Fixed
-   **Critical**: Resolved `SÄÄ-VIRHE` (Weather Error) widget crash on Web caused by unhandled exceptions during Forecast fetching. Added robust `try-catch` blocks and instrumentation to `PointWeatherController` to ensure partial data (Observations, Waves) is shown even if Forecast fails.
-   **Architecture**: Fixed dependency injection order in `PointWeatherController` to prevent initialization race conditions.

### Added
-   **Storage**: Implemented reactive `watchList` methods in `BasePersistentStore` (Sembast) to support real-time UI updates from local database changes.
-   **Testing**: Added `weather_controller_forecast_robustness_test.dart` to verify controller stability under failure conditions.

## [0.14.1] - 2026-01-11

### Fixed
- **Weather HUD Resilience**: Resolved the "disappearing widget" issue on emulators by decoupoling visibility from individual data source failures.
  - **Graceful Degradation**: The HUD now remains visible if at least one data source (Sea Level, Wind, or Waves) succeeds.
  - **Transparency**: Added explicit Loading... and "SAA-VIRHE" (Weather Error) states to eliminate UI "ghosting" during failures.
  - **Observability**: Upgraded `PointWeatherController` to use semantic `.message` logging for API failures, improving diagnostic speed.
- **FMI API Hardening**:
  - **Timestamp Safety**: Implemented robust ISO8601 formatting to prevent "400 Bad Request" on systems lacking millisecond precision.
  - **Locale Independence**: Enforced strict dot-decimal formatting for geolocation parameters to prevent locale-specific failures.
  - **Wave Data**: Added missing bounding box constraint required by the FMI Wave API.
- **Maintenance**: Retired legacy `WeatherHudWidget` and fully migrated to `WeatherHudV2` with 100% updated widget test coverage.

## [0.14.0] - 2026-01-11

### Added
- **Weather HUD Testing**: Comprehensive widget tests for `WeatherHudWidget` covering loading, data rendering, and error states.

### Changed
- **Navigation Aids Performance**: Implemented `displayedWaterwayFeaturesProvider` (synchronous) to eliminate flickering/blank frames during map panning.

### Fixed
- **Weather HUD Robustness**: Improved error resilience in `PointWeatherController`, ensuring secondary service failures (like Sea Level) do not block primary weather data display.

## [0.13.2] - 2026-01-11

### Fixed
- **Weather Analysis**: Removed unused imports in `weather_persistence_test.dart` to resolve CI failures.
- **Observability**: 
  - Added explicit debug logging for Sembast cache misses in `WeatherLocalDataSource`.
  - Added warning logging for "Complete Failure" scenarios (API fail + no cache) in `WeatherRepository`.

## [0.13.1] - 2026-01-11

### Maintenance
- **Test Infrastructure**:
  - Replaced discontinued `golden_toolkit` with `alchemist` for golden tests.
  - Verified golden generation with `test/goldens/verification_golden_test.dart`.

## [0.13.0] - 2026-01-11

### Added
- **Weather Persistence Strategy (Offline-First)**:
  - **Local Caching**: Weather data (observations, forecasts, warnings, waves, sea levels) is now cached locally using **Sembast**.
  - **Offline Fallback**: Automatically retrieves cached data when network is unavailable.
  - **Smart Expiry**: Stale data handling integrated into repository logic.
- **DTO Serialization**: All weather DTOs upgraded to support JSON serialization for database storage.
- **Debug Experience**: Added explicit debug logs for persistence operations (Cache/Retrieve).

### Technical
- **Testing**: Added comprehensive persistence verification suites (`weather_persistence_test.dart`, `stress_test_weather.dart`).
- **Architecture**: `WeatherRepositoryImpl` refactored to use `WeatherLocalDataSource` for cleaner data management.

## [0.12.0] - 2026-01-10

### Maintenance
- **Annual Dependency Update (Q1 2026)**:
  - Upgraded `mgrs_dart` to v3.0.0 (uses maintained `unicode` 1.1.8).
  - Upgraded `proj4dart` to v3.0.0.
  - Removed `flutter_map_cancellable_tile_provider` (functionality now native in `flutter_map` v8).
- **Refactor (Global/Architectural)**:
  - **DTO Migration**: Converted **ALL 13** legacy DTOs to immutable `@freezed` classes (Weather, Speed Limits, Navigation Aids, Fishing, Map).
  - **Import Hygiene**: Enforced absolute imports (`package:sakkoja/...`) across the entire codebase (130+ files updated).
  - **Type Safety**: Fixed implicit casting and type mismatch issues in Repositories.
  - **Upgrades**: Checked `proj4dart` and `package_info_plus`. Upgraded SDK constraint to `>=3.8.0`.

### Added
- **Debug Experience**:
  - **Filter**: Toggle Info/Warn/Error levels in on-screen debug box.
  - **Copy**: Added "Copy to Clipboard" button.
  - **Timestamps**: Explicit HH:mm:ss timestamps in log output.

## [0.11.0] - 2026-01-10

### Added
- **Sea Level (Mareograph) Support**: 
  - Real-time water level data from the nearest FMI mareograph station.
  - Automatic station discovery based on map center position.
  - New "Sea Level" stat card in `WeatherDetailSheet`.
  - Seamless integration into the main `WeatherHudWidget`.
  - Robust XML parsing with `NaN` filtering and automatic unit conversion (mm to cm).

## [0.10.3] - 2026-01-09

### Fixed
- **Wave Data API**: Fixed "400 Bad Request" and missing wave data by updating API parameters to the correct FMI codes (`WTP` for period, `ModalWDi` for direction).
- **Data Robustness**: Restored explicit parameter requesting for Wave API to ensure optimal response size and correctness.

## [0.10.2] - 2026-01-09

### Fixed
- **FMI API Hardening**: Extended explicit parameter ordering to Lightning and Wave observation queries to prevent data misinterpretation issues similar to the forecast bug.
- **Documentation**: Updated FMI API guides with "Explicit Parameters" best practices.

## [0.10.1] - 2026-01-09

### Fixed
- **FMI Forecast Temperature**: Resolved a critical issue where atmospheric pressure (e.g., 1016 hPa) was being displayed as temperature (1016°C). The app now explicitly requests parameters to ensure correct data ordering.

## [0.10.0] - 2026-01-09

### Added
- **Improved Debugging**: Added an on-screen **Debug Log Box** accessible by **long-pressing the COURSE HUD** (the glass heading card).
- **Architectural Logging**: Enhanced all core repositories with `Log` statements and `Stopwatch` metrics for execution time.
- **Web Compatibility**:
    - Replaced `dart:io` ZLib with `package:archive` to support GZip decompression on Web.
    - Wrapped logging notifications in microtasks to prevent `setState() during build` errors.
- **Production Fixes**: 
    - Resolved Web **Haptic Intervention** errors by skipping automated haptics until user interaction.
    - Fixed missing **Lighthouse** icon causing 404 errors.


### Fixed
- **Wave Data Aggregation**: Resolved a critical issue where wave parameters (height, period, temp) were split across multiple records. They are now correctly aggregated into a single `WaveData` entity per station.

### Performance
- **Fishing Mode Optimization**:
  - **Instant Toggle**: Optimistic state updates <16ms.
  - **Entity Caching**: O(1) rendering lookups.
  - **Hit-Testing**: Viewport culling (50 items vs 2000).
  - **Pre-warming**: Background data fetch.

### Fixed
- **Visual Regression**: Visual regression where redundant traffic sign markers (red/white circles) were cluttering the map. They are now hidden, prioritizing the Speed Limit Zones (polygons).
- **Tests**: `map_provider_test.dart` failure due to missing mock fallback values.

### Changed
- **Fishing Mode**: Removed navigation clutter (fairways, beacons, buoys, traffic signs, and user contributions) from fishing mode to focus on fishing restrictions and nautical charts.
- **Performance**: Removed a redundant `FishingLayers` instance from `MapContent` to optimize rendering.


### Added
- **Navigation Aids LOD**: Zoom-based Level of Detail reduces visual clutter at low zoom levels.
  - Lighthouses: visible at zoom ≥ 9
  - Traffic signs: visible at zoom ≥ 11
  - Major buoys (cardinals, danger, safe water): visible at zoom ≥ 13
  - All equipment: visible at zoom ≥ 15
  - **Fairway areas**: visible at zoom ≥ 11
- **Fishing Restrictions Visibility**: Fixed issue where restrictions were missing outside Helsinki (e.g., Joensuu).
  - Implemented WFS pagination in bundle script to fetch 5000 features.
  - Enhanced repository to trigger blocking network fetches for uncached regions.
  - Implemented regional cache merging to prevent data loss during background refreshes.

### Technical
- Added tiered zoom thresholds to `NavigationAidsConstants`.
- Implemented `_shouldShowAtZoom()` filtering in `displayedNavigationAidsProvider`.
- Added 19 unit tests for LOD logic.

## [0.8.0] - 2026-01-08

### Added
- **Navigation Aids API Integration**: Full integration of 4 Väylävirasto WFS layers (Fairway Areas, Water Traffic Signs, Maritime Safety Equipment, Lighthouses/Beacons).
- **Offline-First Strategy**: Implemented asset-first loading with Sembast local caching and background network refresh.
- **Performance**: 
  - Offloaded JSON parsing and coordinate transformation to background isolates.
  - Implemented synchronous viewport-based filtering (flicker-free) with 30km buffer.
- **UI/UX**:
  - Premium `NavigationAidsLayerWidget` with glassmorphism markers and entrance micro-animations.
  - Interactive markers with 44x44pt touch targets and haptic sonar-ping feedback.
  - High-visibility fairway polygons with depth information.

### Changed
- **Map Integration**: Updated `MapContent` to use the new navigation aids system, replacing legacy placeholder layers.

### Technical
- Clean Architecture implementation in `lib/features/navigation_aids/`.
- Consolidated DTO system for all maritime navigation aids.
- Automated API data audit pipeline with saved fixtures.

## [0.7.0] - 2026-01-07

### Added
- **UX/Audio**: "Night Captain" design phase 2 implementation
  - **Visuals**: Integrated Finnish/IALA-A Chart Symbols (Geometric Shapes) for Navigation Aids (Port/Starboard).
  - **Audio**: Added `AudioService` with Riverpod integration for centralized sound management.
  - **Feedback**: Implemented audio cues for Speeding, GPS Lock, and Map Interactions (Sonar Ping).
  - **Assets**: Added optimized SVG assets for Speed HUD, GPS Reticle, and Weather Badges.
  - **Refactor**: Updated `GlassIconButton` to support SVG widgets for better performance and visual fidelity.

## [0.6.0] - 2026-01-07

### Added
- **Design System Implementation**: Formalized "Night Captain" design system with `AppPalette` single source of truth.
- **Typography Upgrade**: Integrated `google_fonts` with **Inter** for UI and **JetBrains Mono** for data displays.
- **OLED Optimization**: Canvas color updated to True Black (`#000000`) for maximum contrast and battery saving.

### Changed
- **Component Styling**: Refactored `SpeedHudWidget`, `FishingRestrictionDetailSheet`, and `GlassIconButton` to use new design tokens.
- **Theme Injection**: `main.dart` now uses `AppTheme.light()` directly.

### Documentation
- Updated `DESIGN_PATTERNS.md` with Flutter implementation mapping tables and Day Mode specifications.

### Systematization & Polish
- **Component System**: Introduced `GlassContainer` and `AnimatedBorderContainer` for consistent UI rendering.
- **Interactions**: Standardized motion curves (`AppInteraction`) and button states.
- **Visual Depth**: Enabled "Micro-Blur" (3px) on glass surfaces and enhanced "Active Navigation" state with rotating gradient borders.

## [0.5.9] - 2026-01-07

### Added
- **External API Registry**: Documentation cataloging all third-party endpoints (`docs/external_apis.md`).
- **Architectural Verification**: Comprehensive standard enforcement for Clean Architecture.

### Fixed
- **ZoneSpatialService Violation**: Relocated `ZoneSpatialService` from `domain` to `data` to strictly enforce "No Flutter in Domain" rule.
- **MapNotifier Reliability**: Resolved intermittent async race conditions in `MapNotifier` initialization and fixed test flakiness.

### Technical
- **Test Coverage**: Achieved 100% test coverage for targeted repositories and providers (30+ new tests).
- **Code Generation**: Synchronized all DI and Provider configurations via `build_runner`.

## [0.5.8] - 2026-01-07

### Added
- **Viewport Speed Limits**: Speed limit zones are now rendered based on the visible map area (viewport) rather than just the user's GPS location. This allows users to pan the map to any location (e.g., Turku, Oulu) and see local speed limits.

### Technical
- Implemented `displayedSpeedLimitsProvider` with BBox spatial filtering (30km buffer).
- Removed legacy GPS-based `filteredZonesProvider`.
- Cleaned up unused imports and test files.


### Changed
- **Maritime Speed Signs**: Signs with `rajoitusarvo` (speed limit value) now correctly identified as "Nopeusrajoitus" and rendered with speed limit marker styling.

### Technical
- Extracted sign type constants to `SignConstants` class.
- Added analysis scripts for WFS data exploration (`scripts/analysis/`).

## [0.5.6] - 2026-01-07

### Added
- **Navigation Aids in all modes**: Fairway areas, beacons, and buoys are now visible in both Navigation and Fishing modes via new `NavigationAidsLayer`.

### Changed
- **Improved Visibility**: Fairway areas now render at 20% fill / 50% border opacity (was 8%/20%). Beacon and buoy markers increased to 32px (was 24px).
- **Higher Data Limit**: Waterway feature fetch limit increased from 100 to 500 to show more navigation aids in dense areas.

### Technical
- Extracted waterway rendering from `FishingLayers` into reusable `NavigationAidsLayer` widget.

## [0.5.5] - 2026-01-06

### Performance
- **Sync Fishing Display**: Replaced async `visibleFishingRestrictionsProvider` with sync `displayedFishingRestrictionsProvider` to eliminate UI flicker during map panning.
- **Larger Buffer (30km)**: Increased viewport buffer from 15km to 30km, preventing "pop-in" effect at screen edges.
- **Instant Updates**: Fishing restrictions now update immediately without async delays.

### Technical
- Old async provider commented out with detailed reasoning for future reference.

## [0.5.4] - 2026-01-06

### Performance
- **Instant Fishing Restrictions**: Implemented Asset-First loading strategy. Bundled data loads in ~100ms, with background network refresh for updates.
- **Memory Cache**: Added in-memory cache for instant subsequent data access (no disk I/O after first load).

### Technical
- Refactored `FishingRepositoryImpl` data flow: Memory → Asset → Sembast → Network.
- Added `@visibleForTesting` cache reset method for test isolation.

## [0.5.3] - 2026-01-06

### Performance
- **Fishing Mode Optimization**: Implemented strict Viewport Culling. Fishing polygons outside the visible map area (with 15km buffer) are now filtered out before rendering, significantly reducing GPU load properties.
- **Unified Geometry**: Consolidated `BBox` usage across the app, removing duplicate logic in `GeometryUtils`.

## [0.5.2] - 2026-01-05

### Maintenance
- **Log Enforcement**: Configured `analysis_options.yaml` to treat `avoid_print` as a build error.
- **Lint Fixes**: Resolved unnecessary import warnings in database services.

## [0.5.1] - 2026-01-05

### Added
- **Debug Logging Architecture**: Implemented a comprehensive logging system using the `logger` package (`Log.d`, `Log.i`, `Log.e`).
- **Runtime Debug Toggle**: Added long-press gesture to the Radar button to toggle debug logs and visual SnackBar feedback.
- **Log Migration**: Replaced all legacy `debugPrint` and `print` calls with structured logging across the entire codebase.

## [0.5.0] - 2026-01-05

### Added
- **Offline Fishing Restrictions**: Bundled 2000+ fishing restrictions as `fishing_restrictions.json.gz` (5.8MB) for immediate data availability on first launch and offline usage.

### Fixed
- **Invisible Restrictions**: Solved critical bug where map panning caused restriction data to disappear due to provider state reset (fixed with `ref.keepAlive()` and static caching).

## [0.4.8] - 2026-01-05

### Fixed
- **Fishing Restrictions**: Fixed "missing restrictions" issue by correcting WFS request to use standard `urn:ogc:def:crs:EPSG::4326` and `Lat,Lon` axis order.
- **Fishing Restrictions**: Resolved rendering issue where `MultiPolygon` disjoint areas were invisible by splitting them into separate entities.


## [0.4.7] - 2026-01-05

### Fixed
- **Web Proxy**: Fixed double-encoding issue in `WebProxyInterceptor` that caused 400 Bad Request errors for external APIs (FMI, MMM).

## [0.4.6] - 2026-01-05

### Refactor
- **Code Cleanup**: Removed hardcoded `_showDebugOverlay` flag in `MapScreen`.
- **Debug Experience**: Debug overlay now automatically enabled in Debug mode (`kDebugMode`), or can be manually controlled via constructor parameter for testing.

## [0.4.5] - 2026-01-05

### Performance
- **Web**: Implemented "Chunked Spatial Calculation" for Web target. Replaces synchronous blocking execution with time-sliced processing, eliminating UI freezes during map updates.
- **Native**: Retained Isolate-based parallelism for optimal performance on iOS/Android.

## [0.4.4] - 2026-01-05

### Fixed
- **Error Resilience**: Added error logging to `FishingRepository` to prevent silent failures during cache operations.
- **Code Quality**: Added missing `flutter/foundation.dart` import.

## [0.4.3] - 2026-01-05

### Fixed
- **Web App Stability**: Replaced `Isolate.run` with `compute` for background parsing, resolving crashes in `WeatherRepository` and `MapNotifier` on Flutter Web.
- **CORS Centralization**: Implemented `WebProxyInterceptor` to automatically handle proxying for all external APIs (FMI, Traficom, Vaylapilvi) without manual datasource changes.

### Infrastructure
- **Proxy Allowlist**: Expanded Cloudflare Worker allowlist to support radar data, nautical charts, and weather alerts.

---

## [0.4.2] - 2026-01-05

### Added
- **Secure CORS Proxy**: Self-hosted Cloudflare Worker (`sakkoja-cors-proxy.sakkoja.workers.dev`) replaces public `corsproxy.io` dependency.

### Security
- Worker includes allowlist (only proxies to `avoinkara.mmm.fi`), origin validation (only responds to `sakkoja.pages.dev`), and method restriction (GET only).

### Infrastructure
- New `cloudflare-worker/` directory with Wrangler configuration for easy deployment.

---

## [0.4.1] - 2026-01-05

### Fixed
- **Fishing Restriction Visibility**: Resolved issue where fishing restrictions disappeared at high zoom levels by removing manual viewport culling in favor of map engine optimization.
- **Map Panning Gaps**: Expanded data fetching to a 3x3 tile grid (neighbors), ensuring fishing restrictions and waterway features remain visible during rapid panning and zooming.

### Technical
- Cleaned up unused imports in presentation layer.
- Verified with 90+ automated tests and full static analysis.

---

## [0.4.0] - 2026-01-03

### Added
- **Catch Tracking**: Record and view fish catches with metadata (species, weight, location).
- **Riverpod 3.x Migration**: Full codebase migration to Riverpod 3.x and Freezed 3.x for modern reactivity.
- **Architectural Bridge**: Unified dependency injection using Riverpod providers, eliminating the "DI Gap".
- **Dynamic Theming**: Support for `ColorScheme` tokens across the entire UI, including 20+ specialized widgets.
- **High-Contrast "OnGlass"**: New `AppTheme.kOnGlass` token ensuring HUD visibility in both light and dark system modes.

### Changed
- **Service Injection**: `LocationService` is now fully injectable via Riverpod, improving testability.
- **Standardized HUD Styling**: `GlassIconButton`, `SpeedHudWidget`, and others now use consistent theme-aware styling.
- **Performance Polish**: Eliminated unnecessary rebuilds in map overlays.

### Fixed
- **UI Visibility**: Fixed "invisible buttons" in Light Mode by enforcing high-contrast styling on glass surfaces.
- **DI Race Conditions**: Resolved initialization issues by leveraging Riverpod's dependency graph.

---


## [0.3.0] - 2026-01-03

### Added
- **Performance Benchmarks**: Automated tests for zone filtering (1000+ zones), point-in-polygon checks, and distance calculations
- **Viewport Culling**: Fishing restrictions now only render when visible in map viewport
- `BBox.overlaps()` method for efficient spatial intersection checks
- Viewport culling test suite (4 tests)

### Changed
- **Optimized UI Rebuilds**: Applied `select()` to all heavy provider watches in:
  - `MapContent` (contributions, weather radar, fishing mode)
  - `MapControls` (weather state)
  - `WeatherRadarLayer` (radar timestamps)
  - `WeatherAlertBadge` (alerts only)
  - `FishingLayers` (restrictions and waterway features)
- Simplified `AsyncValue.when` patterns to direct data access where safe

### Performance
- Eliminated unnecessary widget rebuilds during radar animation playback
- Reduced draw calls by ~60% during map panning (viewport culling)
- All spatial operations complete in <100ms for 1000+ entities

---

## [0.2.0] - 2025-12-31

### Added
- Weather radar integration with FMI WMS layers
- Lightning strike visualization
- Weather alert badge with warning count
- Parallel API fetching for weather data
- Isolate-based JSON parsing for large datasets

### Changed
- Debounced map camera updates (300ms) to reduce API calls
- Smart grid-based data fetching (only fetch new tiles)

### Fixed
- Race conditions in fishing data providers
- Excessive API calls during rapid map panning

---

## [0.1.0] - 2025-12-23

### Added
- Initial marine navigation app with offline-first architecture
- Speed limit zones from Väylävirasto API
- Traffic sign markers (speed limits, warnings, no-wake)
- Fishing restrictions layer with category filtering
- Waterway features (beacons, fairway areas)
- Premium glass-style HUD (speed, course, limits)
- Boat marker with heading indicator
- Layer filter controls

### Technical
- Feature-first Clean Architecture
- Riverpod state management with code generation
- Sembast local storage (cross-platform)
- flutter_map v8.x integration
- Golden test suite for visual regression

---

[Unreleased]: https://github.com/traali/sakkoja/compare/v0.11.0...HEAD
[0.11.0]: https://github.com/traali/sakkoja/compare/v0.10.3...v0.11.0
[0.10.3]: https://github.com/traali/sakkoja/compare/v0.10.2...v0.10.3
[0.10.0]: https://github.com/traali/sakkoja/compare/v0.9.0...v0.10.0
[0.9.0]: https://github.com/traali/sakkoja/compare/v0.8.0...v0.9.0
[0.8.0]: https://github.com/traali/sakkoja/compare/v0.7.0...v0.8.0
[0.7.0]: https://github.com/traali/sakkoja/compare/v0.6.0...v0.7.0
[0.6.0]: https://github.com/traali/sakkoja/compare/v0.5.9...v0.6.0
[0.5.9]: https://github.com/traali/sakkoja/compare/v0.5.8...v0.5.9
[0.5.8]: https://github.com/traali/sakkoja/compare/v0.5.7...v0.5.8
[0.5.6]: https://github.com/traali/sakkoja/compare/v0.5.5...v0.5.6
[0.5.5]: https://github.com/traali/sakkoja/compare/v0.5.4...v0.5.5
[0.5.4]: https://github.com/traali/sakkoja/compare/v0.5.3...v0.5.4
[0.5.3]: https://github.com/traali/sakkoja/compare/v0.5.2...v0.5.3
[0.5.2]: https://github.com/traali/sakkoja/compare/v0.5.1...v0.5.2
[0.5.1]: https://github.com/traali/sakkoja/compare/v0.5.0...v0.5.1
[0.5.0]: https://github.com/traali/sakkoja/compare/v0.4.8...v0.5.0
[0.4.8]: https://github.com/traali/sakkoja/compare/v0.4.7...v0.4.8
[0.4.7]: https://github.com/traali/sakkoja/compare/v0.4.6...v0.4.7
[0.4.6]: https://github.com/traali/sakkoja/compare/v0.4.5...v0.4.6
[0.4.5]: https://github.com/traali/sakkoja/compare/v0.4.4...v0.4.5
[0.4.4]: https://github.com/traali/sakkoja/compare/v0.4.3...v0.4.4
[0.4.3]: https://github.com/traali/sakkoja/compare/v0.4.2...v0.4.3
[0.4.2]: https://github.com/traali/sakkoja/compare/v0.4.1...v0.4.2
[0.4.1]: https://github.com/traali/sakkoja/compare/v0.4.0...v0.4.1
[0.4.0]: https://github.com/traali/sakkoja/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/traali/sakkoja/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/traali/sakkoja/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/traali/sakkoja/releases/tag/v0.1.0
