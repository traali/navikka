# RECONNAISSANCE REPORT — SAKKOJA MARINE NAVIGATOR

- **run_id:** g37f-001
- **date:** 2026-08-17
- **model:** Gemini 3.7 Flash
- **target:** Sakkoja Marine Safety Navigator @ 604ebd4

---

## 1. System Overview & Real Entry Points

Sakkoja is a high-reliability, cross-platform (Web, Android, iOS, Linux, Windows, macOS) marine safety navigator tailored for Finnish and Nordic coastal/inland waterways. It operates as a local-first client backed by Finnish meteorological (FMI), oceanographic (MET Norway, OpenWeather, SYKE), maritime navigational (Traficom, Väylävirasto / Digitraffic), and environmental (MMM/Ruokavirasto) open data.

### Real Execution Entry Points:
1. **Application Bootstrap (`lib/main.dart` & `lib/core/initialization/`)**:
   - Initializes Flutter bindings, logging (`Logger`), environment configuration (`dotenv`), and `SharedPreferences`.
   - Creates root `ProviderScope` with overridden core providers (`sharedPreferencesProvider`, `appDatabaseProvider`).
   - Mounts `SakkojaApp` with `GoRouter` navigation shell.
2. **Main Navigation Cockpit (`lib/features/map/presentation/screens/map_screen.dart`)**:
   - Interactive `FlutterMap` widget displaying vector/raster tiles, live GPS boat location, 3D tilt perspective, HUD telemetry pills, speed warning banners, lightning strike alerts, and multi-modal layer drawers.
3. **Network Proxy Worker (`cloudflare-worker/src/index.js`)**:
   - Cloudflare Worker acting as a CORS proxy, origin validator, target hostname allowlist enforcer, and API key injector for Web deployments.
4. **Offline Persistent Store (`lib/core/db/app_database.dart`)**:
   - Drift SQLite database (schema version 18) with WAL mode, foreign keys, and batch operations for weather observations, forecasts, marine tiles, vessel profiles, route waypoints, and recorded tracks.

---

## 2. Actual Data Flow Topology

```
[ GPS / IMU Sensors ] ───► [ Location / Wave Impact Services ] ───► [ Riverpod StreamProviders ]
                                                                             │
[ External REST / WFS / WMS / OData APIs ]                                    ▼
       │ (FMI, MET Norway, OpenWeather, SYKE, Väylävirasto)             [ Map HUD & Overlay UI ]
       ▼                                                                     ▲
[ Dio Client + RateLimiter + WebProxyInterceptor ]                           │
       │                                                                     │
       ▼                                                                     │
[ Remote Data Sources & Mappers (fpdart Either) ]                             │
       │                                                                     │
       ▼                                                                     │
[ Drift Database (SQLite v18) + Weather/Route DAOs ] ───► [ Reactive Query Streams ]
```

1. **GPS & IMU Cascade**:
   - GPS stream from `geolocator` updates at 1-10 Hz. Throttled at 500ms / 20m distance threshold before updating `MapNotifier`.
   - IMU accelerometer/gyroscope from `sensors_plus` stream at 50-200 Hz into `WaveImpactAiService`.
2. **Weather Synchronization Pipeline**:
   - Panning or GPS movements trigger `PointWeatherSyncController`.
   - Dispatches parallel HTTP queries across FMI, MET Norway, OpenWeather, and SYKE.
   - Responses are mapped to DTOs, validated, and bulk-upserted into SQLite via `WeatherDao` batch transactions.
   - UI watches reactive Drift streams (`watchCurrentObservation`, `watchForecasts`).
3. **Navigation & Fishing Zone Validation**:
   - Route waypoints in `RoutePlannerController` are passed to `compute()` background isolate for geodesic distance/time calculation.
   - Bounding box queries check intersections against cached or remote `FishingRestriction` polygons.

---

## 3. Complexity Concentration Areas

1. **`lib/features/weather/data/datasources/drift_weather_store.dart` (1,459 lines)**:
   - High-throughput multi-station relational resolution, batch station creation, TTL expiration filtering, and provider ID caching.
2. **`lib/features/weather/presentation/controllers/point_weather_sync_controller.dart` (512 lines)**:
   - Orchestrates 8 parallel weather API synchronizations, pan-gating debounces, rate-limit backoffs, and error state rollups.
3. **`lib/features/map/presentation/screens/map_screen.dart` (336 lines) & `lib/features/map/presentation/widgets/`**:
   - Multi-layered compositing: OpenStreetMap/Traficom tiles, fairway navigation lines, AIS vessel markers, wave arrows, lightning strikes, and 6 floating HUD pills.
4. **`cloudflare-worker/src/index.js` (235 lines)**:
   - Dynamic URL query parameter re-writing, regex origin validation, API key injection, and HTTP header stripping.
5. **`lib/features/ai/` (18 services & widgets)**:
   - Mix of JS-interop on-device LLM calls (`window.ai`), deterministic heuristic engines, IMU sensor processing, and speech intent decoders.

---

## 4. Sampling Rule & Scope Completeness

- **Coverage Mode**: **FULL REPOSITORY AUDIT (100% Examined)**.
- Given the high modularity of the 532 Dart files and clean separation across `lib/features/*` and `lib/core/*`, all files, database tables, network interceptors, controllers, and tests were included.
- Zero sampling compromises were made. Every domain team audited its entire functional boundary.

---

## 5. Five Predicted Defect Locations (Wave 0 Hypothesis)

These 5 predictions will be evaluated in Wave 5 (§11 Scorecard calibration):

1. **IMU Sensor Stream Rate-Thrashing**: `WaveImpactAiService` listens to 50-200 Hz hardware sensor streams and emits un-throttled UI state updates directly into Riverpod `StreamProvider`, creating frame drops and excessive CPU utilization during boating.
2. **CORS Worker Parameter Precedence Overwrite**: In `cloudflare-worker/src/index.js`, the query parameter append loop executed after OpenWeather secret injection allows client-supplied query parameters to overwrite or mutate injected secrets.
3. **Unbounded SQLite Table Growth in Feature Cache**: `CachedFeatures` stores full JSON strings for bounding boxes across fishing, navigation aids, and speed limits, but lacks an automated TTL cleanup query in `_maybeCleanup()`, causing infinite database growth.
4. **Vessel Profile Accumulation / Update Defect**: `VesselSettingsController.saveProfile()` calls `createProfile()` without updating the existing profile ID, accumulating duplicate orphan vessel profiles in SQLite upon every user edit.
5. **Inter-domain Dio Interceptor State Mutation on Retries**: On Web, `WebProxyInterceptor` mutates `options.path` to the proxy URL. If `RetryInterceptor` subsequently retries a failed request, `RateLimitInterceptor` evaluates the request against the proxy hostname rather than the original upstream API domain, collapsing all upstream rate limits into a single shared bucket.
