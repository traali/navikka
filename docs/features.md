# Sakkoja – Complete Feature & Functionality Catalog

> **Version**: 1.25.0+1  
> **Last Verified**: 2026-08-17  
> **Canonical Target**: Web PWA (`sakkoja.pages.dev`), Android, iOS

---

## Table of Contents
1. [Interactive Marine Charts & Map Engine](#1-interactive-marine-charts--map-engine)
2. [Väylävirasto & Traficom Seamarks & Fairways](#2-väylävirasto--traficom-seamarks--fairways)
3. [Speed Limits & No-Wake Restrictive Zones](#3-speed-limits--no-wake-restrictive-zones)
4. [Real-time Weather, Radar & Oceanography](#4-real-time-weather-radar--oceanography)
5. [Modular On-Device Marine AI Suite](#5-modular-on-device-marine-ai-suite)
6. [AIS Vessel Traffic & Collision Avoidance (CPA/TCPA)](#6-ais-vessel-traffic--collision-avoidance-cpatcpa)
7. [Fishing Regulations & Catch Logger](#7-fishing-regulations--catch-logger)
8. [Guest Harbors, Anchorages & Boat Ramps (Lipas)](#8-guest-harbors-anchorages--boat-ramps-lipas)
9. [Route Passage Planner & Active Navigation](#9-route-passage-planner--active-navigation)
10. [Vessel Profiling & Bridge Clearance Safety](#10-vessel-profiling--bridge-clearance-safety)
11. [GPS Track Recording & GPX Export](#11-gps-track-recording--gpx-export)
12. [Emergency Distress System (MRCC SOS)](#12-emergency-distress-system-mrcc-sos)
13. [HUD Layouts & Cockpit Visualization](#13-hud-layouts--cockpit-visualization)
14. [OLED Boating Color Themes ("Ulkoasu")](#14-oled-boating-color-themes-ulkoasu)
15. [Offline Storage, OPFS & Sync Infrastructure](#15-offline-storage-opfs--sync-infrastructure)

---

## 1. Interactive Marine Charts & Map Engine

* **Dual Chart Rendering Pipeline (`flutter_map` 8.x)**:
  * **Standard Mode**: High-contrast OpenStreetMap vector contours optimized for coastal and inland water navigation.
  * **Fishing / Nautical Mode**: Official Traficom raster nautical charts via WMTS servers (depth contours, soundings, rocks, underwater hazards).
* **Smart GPS Cascade**:
  * $500\text{ ms}$ GPS stream throttle to prevent unnecessary re-rendering.
  * $20\text{ m}$ distance filter for stable movement tracking at sea.
  * $300\text{ ms}$ camera movement debounce for butter-smooth panning and zooming.
* **Heading & Course Predictor**:
  * Real-time vessel icon with magnetic/true heading orientation.
  * Extrapolated course-over-ground (COG) projection line.
* **Offline Map Downloader**:
  * Download entire coastal regions (Gulf of Finland, Archipelago Sea, Lake Saimaa, Bothnian Sea) into local SQLite storage for offline navigation.

---

## 2. Väylävirasto & Traficom Seamarks & Fairways

* **Official IALA Seamarks (System A)**:
  * **Cardinal Marks**: North, South, East, West beacons with true topmark arrows and flashing light signatures.
  * **Lateral Marks**: Port (Red) and Starboard (Green) fairway edge buoys and spar buoys.
  * **Safe Water & Isolated Danger Marks**: Mid-channel buoys and isolated rock markers.
  * **Special Marks**: Yellow warning buoys and cable/pipeline indicators.
* **Sector Lights & Lighthouses**:
  * Interactive light sectors displaying colored beams (White/Red/Green) and character intervals (e.g. `Fl(2) WRG 6s`).
* **Official Fairway Geometry**:
  * Vectorized fairway centerlines with authorized depth ratings ($2.4\text{m}$, $3.0\text{m}$, $5.5\text{m}$, $7.3\text{m}$, $9.0\text{m}$, etc.) and fairway width limits.
* **Crowdsourced Hazard Submissions**:
  * Skippers can drop pins on the water to flag unmapped hazards, displaced buoys, or new obstacles.

---

## 3. Speed Limits & No-Wake Restrictive Zones

* **Comprehensive Spatial Speed Zones**:
  * Official Traficom and Väylävirasto statutory speed limits ($10\text{ km/h}$, $15\text{ km/h}$, $20\text{ km/h}$, $30\text{ km/h}$, $40\text{ km/h}$, $60\text{ km/h}$, $80\text{ km/h}$).
* **No-Wake & Restricted Wash Areas**:
  * Visual polygonal overlays marking "Aallokon aiheuttaminen kielletty" (No Wash / No Wake) zones.
* **Dynamic Speed Violation Alerting**:
  * Continuous real-time comparison between vessel Speed Over Ground (SOG) and active water zone limits.
  * Audio chime and visual HUD alerts upon zone entry or speed limit violations.

---

## 4. Real-time Weather, Radar & Oceanography

* **FMI Real-time Observation Stations**:
  * Live wind speed, maximum gust speed, wind direction, air temperature, barometric pressure, and relative humidity.
* **FMI Precipitation Rain Radar (WMS)**:
  * Live composite reflectivity radar with dynamic timestamp frame animation.
* **FMI Real-time Lightning Strike Tracker**:
  * Live cloud-to-ground lightning strike plotting with dynamic proximity danger rings ($<5\text{ km}$, $<15\text{ km}$, $<30\text{ km}$).
* **SYKE Satellite Algae Bloom Heatmap**:
  * Satellite-derived surface cyanobacteria concentration overlays (seasonally active June–September).
* **SYKE Vesla Water Quality & Temperature**:
  * Surface water temperature (°C) and Secchi disk water transparency depth (m).
* **Wave Heights & Sea State**:
  * Significant wave height ($H_s$), wave direction, and wave period (seconds) from MET Norway and Open-Meteo marine models.
* **Sea Level & Baltic Surges**:
  * Real-time water level deviation (cm) relative to N2000 / Mean Sea Level (MW) to prevent grounding during low water anomalies.
* **Multi-Model Divergence Sentinel**:
  * Compares FMI, MET Norway, and OpenWeather; flags divergence when models disagree by $\ge 3.5\text{ m/s}$.

---

## 5. Modular On-Device Marine AI Suite

Every AI capability is modular and can be individually toggled in Settings.

| Subsystem | Underlying Technology | Functionality & Scope | Data Egress |
|---|---|---|---|
| **Voice Copilot ("Hei Kippari")** | Web Speech API / Native STT + Pure Dart Regex Parser | Voice commands for under-keel clearance, depth checks, nearest harbors, waypoint dropping, weather query, SOS call. | **0% (100% On-Device)** |
| **Wave Impact & Slamming IMU** | Hardware Accelerometer & Gyroscope Streams | Vertical $G$-force ($1.0\text{--}5.0\text{g}$), 60s slam frequency, outlier wave spikes, Head/Beam attack angle. | **0% (100% On-Device)** |
| **Marine Weather Reasoner** | Chrome Built-in AI (Gemini Nano) + `LocalMarineReasoner` | Multi-model divergence alerts, approaching front detection, squall factors, harbor approach weather advice. | **0% (100% On-Device)** |
| **Technical Engine Copilot** | Embedded Diagnostic SQLite Knowledge Base | Workshop manuals, oil grades, coolant types, impeller part numbers, symptom fix trees (Volvo Penta, Yamaha, Yanmar, Mercury, Honda, Torqeedo). | **0% (100% Offline)** |
| **Voyage Recap & Logbook** | Local Drift SQLite Persistence | Automatic post-trip summaries: distance (NM), duration, average/max speed, wind exposure, fuel burn estimates. | **0% (100% Offline)** |
| **Hybrid Weather Cloud (Opt-in)** | OpenRouter BYOK (`HybridInsightEngine`) | Optional deep contextual weather explanations. Requires personal API key and explicit `AiConsentDialog` consent. | **Opt-in Only** |

---

## 6. AIS Vessel Traffic & Collision Avoidance (CPA/TCPA)

* **Real-time AIS Target Feed**:
  * Live ship positions from Digitraffic Marine AIS (cargo, tankers, passenger ferries, tugs, pleasure craft).
* **Collision Avoidance Math**:
  * Computes **Closest Point of Approach (CPA)** in nautical miles and **Time to Closest Point of Approach (TCPA)** in minutes.
* **Target Classification & Vectors**:
  * Vessel speed vectors, navigation status (underway using engine, at anchor, moored, restricted manoeuvrability).
  * Color-coded proximity warning levels (Green = Safe, Amber = Approaching, Red = Collision Danger).

---

## 7. Fishing Regulations & Catch Logger

* **Official Fishing Restriction Overlays**:
  * Renders statutory restriction zones from MMM / Ruokavirasto (kalastusrajoitus.fi).
  * Polygons cover conservation areas, nature reserves, fish pass waters, rapids, and seasonal closures.
* **Interactive Regulation Detail Sheets**:
  * Tap any zone to view exact restrictions: gear limits, closed dates, protected species, net mesh regulations.
* **Intelligent Catch Logbook**:
  * Log catches with species, weight (kg), length (cm), lure used, depth, and weather conditions.
  * Automatic capture of GPS coordinates, timestamp, and active sea temperature.
  * **Biological Minimum Size Enforcer**: Visual warning if catch is undersized (e.g. Zander/Kuha $<42\text{ cm}$, Sea Trout $<60\text{ cm}$).

---

## 8. Guest Harbors, Anchorages & Boat Ramps (Lipas)

* **Nationwide Marine Facilities Directory**:
  * Integrated database of official Finnish guest harbors (*vierassatamat*), service havens (*palvelusatamat*), excursion harbors (*retkisatamat*), natural anchorages, and public boat launch ramps (*veneluiskat*).
* **Detailed Port Information**:
  * Moorings type (buoy, boom, anchor, side-tie), depth at quay, phone number, VHF channel.
  * Service filters: Fuel (gasoline/diesel), freshwater, shore power electricity, septic pump-out (*imutyhjennys*), sauna, waste disposal, boat ramp.
* **Direct 1-Tap Navigation**:
  * Plot course directly from current boat position to the selected harbor.

---

## 9. Route Passage Planner & Active Navigation

* **Interactive Waypoint Routing**:
  * Tap chart coordinates to drop waypoints and construct multi-leg passage plans.
  * Computes total distance (NM), true course bearing (°), magnetic heading, and estimated time of arrival (ETA).
* **Active Navigation HUD**:
  * Steer-to-course CDI (Course Deviation Indicator) vector.
  * Cross-Track Error (XTE) measurement in meters/cables.
  * Next waypoint range, bearing, and time-to-go (TTG).
* **GPX Exchange Format**:
  * Import standard `.gpx` routes from other chartplotters (Navionics, Garmin, Orca) and export Sakkoja voyages.

---

## 10. Vessel Profiling & Bridge Clearance Safety

* **Vessel Master Profile (Drift SQLite Schema v18)**:
  * Boat name, registration number, HIN / WIN hull identification code.
  * Length overall (LOA), beam width, safe static draft ($T$), mast air draft ($H_a$).
  * Engine manufacturer, engine model, fuel capacity (L), fuel type (Gasoline, Diesel, Electric).
* **Dynamic Under-Keel Clearance (UKC)**:
  * Real-time calculation: $\text{UKC} = \text{Fairway Depth} + \text{Sea Level Anomaly} - \text{Vessel Draft}$.
  * Warning alert triggered when $\text{UKC} < 0.5\text{ m}$.
* **Overhead Bridge Clearance Warning**:
  * Compares vessel mast air draft against official charted bridge clearances along fairways.

---

## 11. GPS Track Recording & GPX Export

* **Background Voyage Track Recorder**:
  * Continuous logging of position coordinates, speed over ground, heading, and altitude.
* **Auto-Pause & Stationary Detection**:
  * Automatically pauses track recording when moored or anchored to prevent GPS jitter loops.
* **Voyage Telemetry Export**:
  * Export complete recorded voyage as standard GPX or KML files for logbook archival.

---

## 12. Emergency Distress System (MRCC SOS)

* **Dedicated Red Distress Button (`EmergencyDistressDialog`)**:
  * 1-tap access on all HUD layouts.
* **Direct Emergency Dialing**:
  * Pre-configured for the Finnish Maritime Rescue Coordination Centre (**MRCC Turku / Meripelastuskeskus**: `0294 1000`) and National Emergency Number (`112`).
* **Emergency Telemetry Readout**:
  * Displays current position in standard maritime coordinates:
    * **Degrees & Decimal Minutes** (e.g. `60°09.123' N, 024°55.456' E`)
    * **Military Grid Reference System (MGRS)** (e.g. `35V LG 96874 72154`)
  * Displays vessel name, registration, and under-keel depth for instant VHF Mayday readouts.

---

## 13. HUD Layouts & Cockpit Visualization

Five tailored cockpit layouts selectable on the fly to fit different tablet/phone mounts:

1. **Classic HUD**: Traditional card-based bridge layout with speed, depth, wind, and course cards.
2. **Ghost HUD**: Frameless floating translucent overlay maximizing chart visibility.
3. **Omni HUD**: Full-featured tactical dashboard sidebar with concurrent AIS, weather, and sensor gauges.
4. **Vortex UI**: High-tech circular radar HUD with glassmorphic compass ring.
5. **Horizon 3D**: Perspective 3D navigation cockpit with pitch and roll horizon attitude indicators.

---

## 14. OLED Boating Color Themes ("Ulkoasu")

Five curated, high-contrast themes engineered for extreme marine lighting conditions:

| Theme Name | Dominant Colors | Lighting Condition & Purpose |
|---|---|---|
| **Night Captain** | Pitch Black (`#000000`) & Neon Cyan (`#00F0FF`) | Extreme night navigation; zero backlight bleed on OLED screens prevents loss of skipper night vision. |
| **Solar Flare** | Deep Charcoal (`#0F1115`) & Daylight Amber (`#FFB300`) | Direct bright sunlight; high contrast amber elements resist marine sun-glare. |
| **Deep Sea Navy** | Maritime Navy (`#0A192F`) & Electric Aqua (`#64FFDA`) | Daytime / twilight cruising; premium yacht-bridge aesthetic. |
| **Boreal Aurora** | Deep Night (`#05101A`) & Emerald Glow (`#00E676`) | Modern glass-cockpit aesthetic inspired by Finnish Northern Lights. |
| **Red Watch** | Pitch Black (`#0A0000`) & Deep Red (`#FF1744`) | Strict military & commercial bridge night vision compliant with IMO / IEC 62288 standards. |

---

## 15. Offline Storage, OPFS & Sync Infrastructure

* **Drift SQLite with WebAssembly & OPFS**:
  * On Web: Uses `sqlite3.wasm` with Origin Private File System (OPFS) for persistent, high-performance offline SQLite storage.
  * On Mobile: Uses native `sqlite3` in WAL (Write-Ahead Logging) mode.
* **Resilient Network Client**:
  * Unified `Dio` HTTP client with sliding-window domain rate limiters (`RateLimitInterceptor`), exponential retries, and CORS proxy routing (`WebProxyInterceptor`).
  * Cloudflare Worker CORS proxy with origin validation, secret injection for OpenWeather, and strict protocol checks.
