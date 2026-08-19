# Navikka 🚤🇫🇮 – Intelligent Marine Safety Navigator

[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](LICENSE)
[![GitHub Actions CI](https://img.shields.io/github/actions/workflow/status/traali/navikka/ci.yml?branch=main&style=flat-square&label=CI)](https://github.com/traali/navikka/actions)
[![Hosting](https://img.shields.io/badge/Live-navikka.pages.dev-00ffcc?style=flat-square)](https://navikka.pages.dev)
[![Flutter](https://img.shields.io/badge/Flutter-3.44.8-blue?logo=flutter&style=flat-square)](#)
[![Dart](https://img.shields.io/badge/Dart-3.12.2-blue?logo=dart&style=flat-square)](#)

---

## 🧠 The Problem
Boaters navigating Finnish waters and the Baltic archipelago face fragmented, hard-to-read data scattered across multiple legacy systems—FMI sea warnings, SYKE blue-green algae reports, Väylävirasto fairway aids, Traficom speed restrictions, and MET Norway forecasts. Existing navigation apps often lack offline resilience, intelligent multi-model weather divergence analysis, tactile night-vision protection, and live space-borne Earth Observation data.

## 💡 The Solution
**Navikka** is an open-source, offline-first marine safety navigator and situational awareness hub tailored specifically for Finnish waterways. It unifies official open data from Väylävirasto, Traficom, SYKE, FMI, and ESA Copernicus into an interactive, tactile glassmorphic HUD. With 100% on-device AI assistants, real-time wave impact slam analysis, live weather radar, and high-contrast OLED night modes, Navikka ensures absolute safety and precision at sea.

---

## 🏗 Architecture

Built by **Traali** using clean, modern technologies:

| Layer | Technology | Rationale |
|---|---|---|
| **Framework & UI** | Flutter 3.44+ / Dart 3.12+ | High-performance, 60fps reactive UI across Web PWA, Android, and iOS. |
| **Map & Cartography** | `flutter_map` 8.x & Proj4Dart | Low-latency vector and WMTS nautical charts, coordinate reprojection (ETRS-TM35FIN $\leftrightarrow$ WGS84). |
| **State Management** | Riverpod 3.x (`@riverpod`) | Compile-time safe, testable, reactive state notifiers with zero boilerplate. |
| **Local Persistence** | Drift (SQLite v18 in WAL mode) | Fast, 100% offline tile caching, waypoint management, and voyage logs. |
| **Earth Observation** | ESA Copernicus Sentinel-2 & EUMETSAT | Live $10\text{ m}$ optical coastal imagery and 15-minute weather satellite loops. |
| **On-Device AI** | Pure Dart Heuristics & Sensor Fusion | Zero telemetry egress: Voice Copilot ("Hei Kippari"), Wave Slam AI, Engine Diagnostics. |
| **Hosting & Proxy** | Cloudflare Pages & Cloudflare Workers | Global edge CDN delivery and serverless CORS API proxy. |

---

## 📖 Essential Documentation

- 🚤 **[Skipper's User Guide](docs/user_guide.md)** – Step-by-step manual for chart navigation, PWA offline install, AI copilot, voice commands, and safety tools.
- 🛠️ **[Developer & Contributor Guide](docs/developer_guide.md)** – Complete setup guide, architecture rules, testing workflows, and release protocols.
- 🌐 **[Self-Hosting & Deployment Guide](docs/deployment_guide.md)** – Instructions for cloning, hosting your own instance, Cloudflare Pages, Docker, and CORS proxy worker.
- 🧭 **[Complete Feature Catalog](docs/features.md)** – Comprehensive inventory of all 15 functional domains, sensor systems, and safety tools.
- 🏛️ **[Architecture Reference](docs/architecture.md)** – Detailed layer specifications, data flow, and technology standards.
- 📡 **[External API Registry](docs/external_apis.md)** – Official endpoint specifications and query protocols.

---

## ✨ Key Features & Capabilities

### 1. Advanced Navigational Charts & Map Engine
* **Multi-Source Rendering**: Smoothly renders OpenStreetMap basemaps alongside official Traficom and Väylävirasto nautical raster charts.
* **Offline-First DB Cache**: Powered by Drift SQLite to cache tiles locally for uninterrupted navigation offshore.
* **GPS Telemetry Cascade**: 500ms GPS throttle + 20m distance threshold, with 300ms camera debounce for smooth tracking at high speeds.

### 2. 🛰️ Space & Weather Observation Screen (`/satellite`)
* **Copernicus Sentinel-2**: Instant optical True Color ($10\text{ m}$) imagery centered directly on your GPS coordinates to inspect shallow reefs, sandbars, and algae formations.
* **FMI / EUMETSAT Weather Satellite**: Live 15-minute meteorological satellite sweeps with a 24-step interactive timeline and playback controls.
* **Nautical Chart Overlay**: Toggle official Traficom fairways and depth contours with a transparency slider over satellite photography.

### 3. 🤖 100% On-Device Marine AI Suite & Privacy Guarantees
* **Voice Copilot ("Hei Kippari")**: Local intent parser responding to hands-free queries (depth, speed, nearest port). Zero audio leaves the device.
* **Wave Impact AI**: Real-time accelerometer & gyroscope sensor fusion computing hull slam frequencies, $G$-forces, and attack angles.
* **Marine Weather Reasoner**: Local multi-model divergence analysis (FMI vs. MET Norway vs. OpenWeather) flagging sudden barometric drops and gale risks.
* **Technical Engine Copilot**: Embedded offline troubleshooting trees and workshop specifications for marine outboards and inboards.

### 4. 🌙 "Night Captain" OLED & Tactile UI
* **Night Captain**: True pitch-black OLED background with high-contrast neon cyan indicators to preserve skipper night vision.
* **Solar Flare**: Sunlight-readable amber scheme optimized for open daylight.
* **Deep Sea Navy & Boreal Aurora**: Modern aesthetic yacht-bridge cockpits with liquid glassmorphism.
* **Red Watch**: Low-luminance red mode compliant with IMO/IEC 62288 bridge standards.

---

## 🚀 Quick Start

### Prerequisites
- Flutter SDK `>=3.44.8` (Pinned in `.fvmrc`)
- Dart SDK `>=3.12.2`

### Installation & Run

```bash
# Clone the repository
git clone https://github.com/traali/navikka.git
cd navikka

# Install dependencies
flutter pub get

# Generate code & Riverpod notifiers
dart run build_runner build --delete-conflicting-outputs

# Launch the app
flutter run
```

### Running Tests & Verification

```bash
# Run unit & logic tests
flutter test

# Run static analysis
dart analyze lib/ test/

# Verify architecture boundaries
dart run scripts/architecture_check.dart
```

---

## 📄 License
MIT © [Traali](https://github.com/traali)
