# RECONNAISSANCE — SYSTEM MAP & DEFECT PREDICTIONS — 01_RECON

- **run_id:** deep-audit-run-01
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `a8aa5a4`
- **wave:** 0

---

## 1. System Map & Architecture Overview

Sakkoja is a real-time cross-platform marine safety navigator application built for Finnish coastal and inland waterways.

```
[ GPS / Geolocation ]
        │
        ▼
[ MapCameraPosition / SignificantMapCameraPosition ] (Riverpod 3.3.1)
        │
        ├───────────────────────────┬───────────────────────────┐
        ▼                           ▼                           ▼
[ Weather Controllers ]     [ Navigation Aids ]       [ Tracking Service ]
 (FMI/SYKE/MET/OpenWeather)  (Väylävirasto WFS/WMTS)    (50-point SQLite Buffer)
        │                           │                           │
        ▼                           ▼                           ▼
[ Drift SQLite Database ] ◄─── [ Drift Store Layer ] ◄─── [ TrackRepository ]
  (WAL Mode / Schema v17)
        │
        ▼
[ Cloudflare CORS Proxy Worker ] ──► External APIs (wms.fmi.fi, vesla.ymparisto.fi, etc.)
```

---

## 2. Primary Entry Points & Components

1. **Flutter App Entry Point**: `lib/main.dart` — Initializes `ProviderScope`, `dotenv`, global error traps (`PlatformDispatcher.onError`), and `AppDatabase`.
2. **Routing System**: `lib/core/router/router.dart` — `go_router` setup managing bottom navigation bar, map view, settings, vessel profile, and menu.
3. **Database Core**: `lib/core/db/app_database.dart` — Drift SQLite database (schema version 17) with WAL mode enabled.
4. **Cloudflare Proxy Worker**: `cloudflare-worker/src/index.js` — Handles CORS header stripping, proxying external WFS/WMS requests, and rate-limiting.
5. **E2E Test Infrastructure**: `e2e/` — Playwright tests verifying web builds on `https://sakkoja.pages.dev`.

---

## 3. Five Defect Location Predictions

*These 5 predictions will be evaluated in Wave 5 Synthesis against actual audit findings:*

1. **Prediction 1 — Provider Family Key Coordinate Proliferation**: `lib/features/weather/presentation/controllers/point_weather_data_provider.dart`. Unrounded `LatLng` passed to Riverpod family stream providers will cause provider instance churn during continuous panning.
2. **Prediction 2 — Repository Lifecycle & Buffer Flush Short-circuiting**: `lib/features/tracking/data/repositories/track_repository.dart` & `active_track_provider.dart`. Auto-disposed repositories will trigger `ref.onDispose` cleanup on every emission, defeating batching buffers.
3. **Prediction 3 — Resource Cleanup on Async Exception Paths**: `lib/features/map/presentation/controllers/offline_download_controller.dart`. Exception handling during long-running tile downloads will leave orphaned database records stuck in transient states.
4. **Prediction 4 — Secret Storage vs Plaintext Persistence**: `lib/features/ai/data/repositories/skipper_settings_repository_impl.dart`. Sensitive user tokens (e.g. OpenRouter API keys) will be persisted in unencrypted SQLite columns instead of secure keychain/keystore APIs.
5. **Prediction 5 — Proxy CORS Header Duplication & Wildcard Leaks**: `cloudflare-worker/src/index.js`. Header proxying will duplicate `Access-Control-Allow-Origin` headers from upstream servers or leak wildcards on error responses.
