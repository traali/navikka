# Sakkoja Architecture

> **Last verified**: 2026-08-17 @ `943ec31`

## Overview
Sakkoja follows a **Feature-First Clean Architecture** with Flutter, Riverpod, Drift (SQLite), and `flutter_map`.

---

## Directory Structure

```
lib/
├── core/                    # Shared infrastructure & utilities
│   ├── config/              # Remote config, env vars & build info
│   ├── constants/           # App-wide constants (Palette, strings)
│   ├── db/                  # Drift SQLite database schema (v18) & DAOs
│   ├── network/             # Network clients (Dio), rate-limit interceptors
│   ├── providers/           # Core Riverpod providers (Logger, Database)
│   ├── router/              # Navigation configuration (go_router)
│   ├── settings/            # Modular AI & App feature settings
│   ├── theme/               # Boating design system (5 themes)
│   └── utils/               # Coordinate projections, math & formatting
└── features/                # Feature modules (Domain-driven)
    ├── ai/                  # On-device Marine AI Suite & IMU wave estimator
    ├── ais/                 # Real-time AIS vessel traffic & collision avoidance
    ├── contribution/        # User reporting & community hazard features
    ├── fishing/             # Fishing restrictions & catch logbook
    ├── harbors/             # Guest harbors, service havens & boat ramps
    ├── map/                 # Main Map UI, tile rendering & Vortex HUD
    ├── menu/                # Settings, offline downloads & diagnostics
    ├── navigation/          # Route passage planning, waypoints & guidance HUD
    ├── navigation_aids/     # Väylävirasto IALA buoys, lighthouses & fairways
    ├── speed_limits/        # Speed limit zones, traffic signs & no-wake alerts
    ├── tracking/            # GPS track log recording & GPX export
    ├── vessel/              # Vessel profile (HIN, engine, draft, air draft)
    └── weather/             # FMI, MET Norway, SYKE algae & wave models
```

---

## Architecture Layers

Each feature module contains three strict layers:
1. **Domain**:
   - Entities, Value Objects, Abstract Repositories, and pure Dart Domain Services.
   - Zero framework dependencies (no Flutter, no Dio, no SQLite).
2. **Data**:
   - DTOs (Data Transfer Objects with `@freezed` / `json_serializable`), Data Sources (remote Dio & local Drift DAOs), Repository Implementations.
   - Returns `Future<Either<Failure, T>>` using `fpdart`.
   - DTOs are strictly isolated from domain entities.
3. **Presentation**:
   - Riverpod Providers (`@riverpod` Notifiers / AsyncNotifiers), UI Widgets, and Screens.

---

## Core Technologies
- **Flutter SDK**: `3.44.8` stable (pinned in `.fvmrc`)
- **Dart SDK**: `3.12.2`
- **State Management**: `flutter_riverpod` (^3.3.1)
- **Local Persistence**: `drift` (^2.33.0, SQLite v18) with WebAssembly (`sqlite3.wasm` + OPFS)
- **Map & Spatial**: `flutter_map` (^8.3.0), `proj4dart` (EPSG:3067 $\leftrightarrow$ EPSG:4326), `mgrs_dart`
- **Sensors**: `sensors_plus` (^7.1.0) for IMU wave slamming and hull motion estimation
- **Network**: `dio` with custom sliding-window rate limiters & retry interceptors

---

## AI Subsystems & Data-Flow Privacy Specification

Sakkoja enforces an **offline-first, zero-telemetry-leakage** AI architecture:

| Subsystem | Execution Model | Data Flow & Privacy |
|---|---|---|
| **Voice Copilot ("Hei Kippari")** | Web Speech API / Pure Dart Regex Parser | **100% On-Device**. Speech transcripts are matched locally against telemetry state. Zero audio recordings or transcripts leave the device. |
| **Marine Weather Reasoner** | Chrome Built-in AI (Gemini Nano) + `LocalMarineReasoner` fallback | **100% On-Device**. Weather forecasts are evaluated locally by the embedded heuristic reasoner. Zero coordinates or user context are sent to external LLMs. |
| **Wave Impact IMU AI** | Accelerometer & Gyroscope Streams (`WaveImpactAiService`) | **100% On-Device**. Raw motion ($50\text{--}200\text{ Hz}$) is processed in a 60s sliding window with a 250ms visual buffer. No motion telemetry leaves the device. |
| **Technical Marine Copilot** | Embedded SQLite Reference Manuals (`/technical-copilot`) | **100% Offline**. Workshop specs, part numbers, and failure fixes run locally against offline databases. |
| **Automatic Voyage Recap & Logbook** | Local Drift SQLite Engine | **100% Offline**. Trip distance, route track, and fuel burn estimations are stored exclusively in local SQLite. |

**External Network Egress**: Only standard anonymous HTTP GET requests to official open data endpoints (FMI, MET Norway, SYKE, Open-Meteo, Väylävirasto) and map tile servers occur. No user identifiers, PII, vessel HIN, or private GPS voyage logs are transmitted externally.
