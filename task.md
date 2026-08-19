# Sakkoja Production Hardening & Modernization

## Phase 1: The Iron Foundation (CI/CD & Security)
- [x] Modernize CI/CD Pipeline
    - [x] Remove legacy `deploy.ps1` and `build_web.ps1`
    - [x] Create `.github/workflows/deploy.yml` for automated Cloudflare Pages deployment
    - [x] Secure `OPENWEATHER_API_KEY` via GitHub Secrets + dynamic `.env` generation
- [x] Security Hardening
    - [x] Secure Cloudflare Worker proxy Origin Validation (CF-Access-Client-Id)
    - [x] Implement global error boundaries (`runZonedGuarded`) in `main.dart`
- [x] Git Hygiene
    - [x] Merge unrelated histories and establish clean `main` baseline

## Phase 1.5: Trivial Pass (Performance & Debt)
- [x] Optimize Performance
    - [x] Eliminate `google_fonts` runtime fetching (bundle local fonts)
    - [x] Compress large GeoJSON assets (GZip `nav_lines.geojson`)
- [x] Architectural Modernization
    - [x] Convert `TrafficSign` model from `Equatable` to `Freezed`
    - [x] Convert `NavigationAid` model to `Freezed`
    - [x] Convert `FairwayArea` model to `Freezed`
    - [x] Remove `equatable` dependency from `pubspec.yaml`
    - [x] Fix CI compilation errors (missing imports/vars/generated code)
- [x] **Production Pipeline Hardening**
    - [x] Resolve `inference_failure` and `strict_raw_type` analyzer warnings across the codebase.
    - [x] Stabilize `WeatherAIEdgeService` platform-specific implementations.
    - [x] Verify dependency structure in `pubspec.yaml`.
    - [x] Pass Husky pre-commit hook (Formatting, Analysis, Testing).
    - [x] Successfully push to production `main` branch.

## Phase 2: Navigation & Vessel Personalization
- [x] **Infrastructure & Data**
    - [x] Create centralized `AppInitializer` service for robust startup
    - [x] Extend `VesselProfiles` schema with `cruisingSpeedKmh` (Drift)
    - [x] Fix unit tests for `RouteService` and `RoutePlannerController`
- [x] **Vessel Settings**
    - [x] Implement Night Captain styled Cruising Speed slider
    - [x] Persist vessel speed settings to local database
- [x] **Smart Routing**
    - [x] Enhance `RouteService` with spatial speed-limit aware ETA logic
    - [x] Cross-reference vessel speed with real-world `SpeedLimitZone` polygons
- [x] **UI/UX Refinement**
    - [x] Update `RoutePlannerScreen` with Glassmorphism Time Estimation HUD
    - [x] Convert mobile Menu to `Drawer` for better one-handed usability
- [x] **Phase 2.5: Advanced Visualization**
    - [x] Render dynamic route polylines on map
    - [x] Integrate Route Planner into UI (Menu & Map Controls)
    - [x] Implement color-coded speed zones on route segments

## Phase 3: Verification & Ops
- [x] Run full test suite (`flutter test`) - PASSING
- [x] Verify production stability on `https://sakkoja.pages.dev`
- [/] Run E2E smoke tests (`cd e2e && npm test`)
- [ ] Conduct manual field smoke tests for ETA accuracy

## Phase 4: Weather & Lightning Resilience (Nova Redesign)
- [x] **Lightning Safety**
    - [x] Implement real-time lightning proximity calculation in `PointWeatherController`
    - [x] Define `LightningAlarmLevel` (Warning/Danger) logic
    - [x] Integrate high-visibility Lightning Alarm widget into Weather screen
- [x] **Nova UI Redesign**
    - [x] Update `AppPalette` and `AppTextStyles` with Nova Protocol tokens
    - [x] Implement `NovaGlassCard` reusable component
    - [x] Redesign `WeatherScreen` with Bento grid layout and fluid typography
- [x] **Stability & Cleanup**
    - [x] Verify route storage persistence in Drift
    - [x] Fix pre-existing lint regressions in `RoutePlannerController` and `RouteService`
    - [x] Run `build_runner` for latest state generation

## Phase 4.5: Performance Hardening (Post-Redesign)
- [x] **Compute Isolates Fix**
    - [x] Refactor `RoutePlannerController` math to use raw data isolates (fixes Web worker fallback)
    - [x] Move lightning proximity math to background isolate/provider
- [x] **Renderer Optimization**
    - [x] Enable explicit `--web-renderer skwasm` in deployment CI/CD
    - [x] Configure strict COOP/COEP headers for multi-threaded performance
- [x] **Throttling & Debouncing**
    - [x] Implement `significantMapCameraPositionProvider` to stop map layer hammering
    - [x] Implement 500ms GPS update throttling in `MapNotifier`
    - [x] Memoize Map Layer objects (Polygons/Markers) to eliminate memory churn
    - [x] Verify `RepaintBoundary` usage on all high-complexity layers

## Phase 5: DB Error Handler Migration & Code Quality
- [x] **Centralized Error Handler**
    - [x] Create `lib/core/db/database_error_handler.dart` with Either-based pattern
    - [x] Migrate 13 DB operations to use `_errorHandler.perform()`
    - [x] Migrate 8 stream operations to use `_errorHandler.handleStream()`
    - [x] Add `performTransaction()` for transactional operations
- [x] **Fix handleStream Error Propagation**
    - [x] Update `handleStream` to rethrow after logging (`throw e;`)

## Phase 6: Review Findings - Fix & Optimize
- [x] **HIGH Priority Fixes**
    - [x] Fix N+1 queries in `getLastWaves()` and `getLastSeaLevels()` (batch load stations)
    - [x] Fix hardcoded `providerId: 0` in `DriftWeatherStore.getLastObservations` → use actual DB value
    - [x] Add direct unit tests for `handleStream()` method
- [x] **MEDIUM Priority Fixes**
    - [x] Hoist `_resolveDbId()` calls outside loops in `cacheObservations()` / `cacheForecast()`
    - [x] Remove `performTransaction()` if truly dead (or wire to `nuke()` properly)
    - [ ] Add logging assertions to tests (verify `Log.e()` called)
    - [ ] Implement `performVoid()` for cache methods to reduce Either allocations
- [x] **LOW Priority & Cleanup**
    - [x] Remove dead `sembast` dependency from `pubspec.yaml` (0 imports in codebase)
    - [ ] Add `handleError` test coverage for stream edge cases
    - [ ] Fix generic catch message to distinguish DB vs code bugs

## Phase 7: SYKE API Integration (Water Quality & Algae)
- [x] **Infrastructure Setup**
    - [x] Add SYKE OData base URL to environment config
    - [x] Create `SykeDataSource` class in `lib/features/weather/data/datasources/`
    - [x] Add water quality methods to `WeatherRemoteDataSource`
- [x] **Water Quality DTO & Storage**
    - [x] Implement `WaterQualityDto` with VESLA API fields
    - [x] Wire into `WeatherRepository` with cache-first strategy
    - [x] Add Drift storage/caching for `WaterQuality`
- [x] **Algae/Cyanobacteria Data**
    - [x] Implement `AlgaeReportDto` and caching layer
- [x] **Satellite WMS Layers**
    - [x] Add WMS source for algae probability map:
        - [x] Base URL: `https://paikkatieto.ymparisto.fi/arcgis/services/Syke/Itameri/MapServer/WMSServer`
        - [x] Layer: `6` (Algae probability)
    - [x] Create `AlgaeWmsLayer` widget for map integration
    - [x] Add seasonal toggle (June-Sept only)
- [x] **UI Integration**
    - [x] Wire SYKE data into `PointWeatherController` and `PointWeatherSyncController`
    - [x] Add Water Quality & Algae indicators to Weather screen (Nova Redesign)
    - [x] Integrate algae WMS layer into map with toggle
- [x] **Testing & Docs**
    - [x] Add unit tests for SYKE API parsing
    - [x] Document API endpoints in `API_AUDIT.md`
    - [x] Add error handling for offline/timeout scenarios

## Phase 8: Fishing Mode & Regulations
- [x] **Infrastructure Baseline**
    - [x] Implement `CatchSize` entity and DTO
    - [x] Implement `getCatchSizes` repository methods with baseline Finnish regulations
    - [x] Create `GetCatchSizes` usecase with Riverpod provider
- [x] **Fishing UI**
    - [x] Add "Fishing Mode" toggle to Skipper Settings
    - [ ] Implement Catch Log with species-specific size validation (Nova UX)
    - [ ] Add fishing restriction markers to map (Regional WFS)

## Phase 9: Project-Wide Validation (v1.0)
- [x] Create tracking issue and linked validation sub-issues in `.github/ISSUES/`
- [x] Define closure evidence requirements per validation area
- [x] Run baseline validation commands and record blockers/results
- [x] Add CI gate to enforce line coverage >= 80%
- [x] Create migration guide artifact for release readiness
- [x] Create load/performance report placeholder for evidence collection
- [ ] Attach security scan findings and sign-off
- [ ] Close all validation sub-issues and finalize release sign-off

## Phase 10: Modular On-Device Marine AI Suite & IMU Wave Roughness (v1.25.0)
- [x] **Modular AI Settings & Toggles**
    - [x] Implement `AiFeatureSettings` with independent on/off toggles
    - [x] Create persistent `AiSettingsProvider` (`SharedPreferences`)
    - [x] Integrate AI switches and navigation into Valikko (Menu Screen)
- [x] **Edge Marine Reasoners**
    - [x] Implement Chrome Built-in AI (Gemini Nano) + deterministic `LocalMarineReasoner`
    - [x] Weather Route Passage AI with under-keel clearance & wave exposure analysis
    - [x] Multi-Model Ensemble Divergence Detection (FMI vs. MET Norway vs. OpenWeather)
- [x] **Vessel Profile & Engine Autoloader (Schema v18)**
    - [x] Drift SQLite v18 migration adding `hin_code`, `engine_manufacturer`, `engine_model`, `fuel_type`
    - [x] Engine specs autoloader for Volvo Penta, Yanmar, Yamaha, Mercury, Torqeedo, Honda
    - [x] Offline Technical Marine Copilot screen (`/technical-copilot`) with diagnostics & manual loader
- [x] **Bilingual Voice Marine Copilot**
    - [x] Web Speech API / native voice parser with `fi-FI` and `en-US` nautical commands
    - [x] Floating pulsating Mic FAB on marine chart
- [x] **Smart Voyage Logbook**
    - [x] Automated post-trip recap with NM, speed, wind, milestones, and fuel consumption calculation
- [x] **IMU Accelerometer & Gyroscope Wave Roughness AI**
    - [x] 3-axis accelerometer dynamic $G$-force measurement ($1.0\text{--}5.0\text{g}$)
    - [x] 60-second sliding window slam frequency ($N/\text{min}$)
    - [x] Outlier bigger wave / rogue wave peak detection
    - [x] Gyroscopic Pitch/Roll angular rate variance resolver (Head Seas, Beam Seas, Quartering Seas)
    - [x] Estimated significant wave height ($H_s^{\text{est}}$)
    - [x] Actionable skipper speed/trim adjustment advisory
    - [x] Live cockpit HUD pill (`WaveImpactHudWidget`)

