# BLIND SPOT UNIT AUDIT — TEAM Ω (Wave 3)

- **run_id:** deep-audit-run-01
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `a8aa5a4`
- **wave:** 3
- **findings_reported:** 3
- **candidates_discarded:** 7
- **examined:** `scripts/`, `lib/core/services/magnetic_declination_service.dart`, `lib/features/navigation/domain/services/navigation_service.dart`, `pubspec.yaml`, `AGENTS.md`
- **not_examined:** Hardware sensor drift on physical marine GPS receivers

---

## Method Critique

- **ARC Method Critique:** ARC focused on Riverpod provider graphs, missing environment script contract gaps in `scripts/build_web.ps1`.
- **CQ Method Critique:** CQ evaluated in-function error handling, missing domain-level ETA algorithm assumptions in navigation services.
- **SEC Method Critique:** SEC inspected API key storage, missing build-time environment variable injection fallbacks.
- **PERF Method Critique:** PERF analyzed loop allocations, missing multi-year coefficient validity windows in magnetic declination calculations.
- **DATA Method Critique:** DATA audited SQLite tables, missing non-persisted physical magnetic variation model drift.

---

### Ω-001 — Build Script Silent Success on Missing OPENWEATHER_API_KEY

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `scripts/build_web.ps1:12-25` & `scripts/build_web.sh:10-22`
- **Novel:** yes

**Mechanism.** The local web build scripts (`build_web.ps1` and `build_web.sh`) inject `OPENWEATHER_API_KEY` into `lib/core/config/env.dart` during release compilation. If the environment variable `OPENWEATHER_API_KEY` is not set in the host terminal, the script proceeds with `OPENWEATHER_API_KEY=""` and completes with exit code 0. The resulting production release build compiles cleanly but fails at runtime when OpenWeather API calls return 401 Unauthorized.

**Evidence.**
```powershell
# scripts/build_web.ps1
$envKey = $env:OPENWEATHER_API_KEY
# Script executes flutter build web --release without asserting $envKey is non-empty!
```

**Trigger.** Executing `build_web.ps1` or `build_web.sh` in a fresh terminal session where `OPENWEATHER_API_KEY` is not exported.

**Impact.** Deployment of silent production web builds lacking OpenWeather forecast capabilities.

**Falsification.** Inspected `build_web.ps1` lines 12-25; confirmed no validation assertion stops the build if `$envKey` is empty.

**Fix.** Add explicit check `if ([string]::IsNullOrWhiteSpace($envKey)) { throw "OPENWEATHER_API_KEY environment variable is required" }` at script start.

**Related:** OPS-001, DEP-001

---

### Ω-002 — Constant Speed Assumption in Fairway Route ETA Calculations

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/navigation/domain/services/navigation_service.dart:45-52`
- **Novel:** yes

**Mechanism.** `NavigationService.calculateEta` calculates route duration by dividing total route distance by vessel cruising speed (`vessel.cruisingSpeedKmh`). It does not intersect route waypoints with active speed limit zones along the fairway. If a vessel's cruising speed is 30 km/h, but 10 km of a 20 km route traverses a 10 km/h restricted channel, the calculated ETA is 40 minutes instead of the actual required 70 minutes.

**Evidence.**
```dart
// lib/features/navigation/domain/services/navigation_service.dart:45-52
final totalHours = totalDistanceKmh / cruisingSpeedKmh;
return DateTime.now().add(Duration(minutes: (totalHours * 60).round()));
```

**Trigger.** Planing a navigation route that passes through speed-restricted harbors or narrow channels.

**Impact.** Overly optimistic ETA estimates, potentially leading to unrealistic passage planning and fuel management errors under way.

**Falsification.** Checked `navigation_service.dart`; confirmed route ETA calculation does not query `SpeedLimitRepository` or spatial speed zones.

**Fix.** Segment route vectors by speed restriction bounding boxes and sum segment transit times using `min(cruisingSpeed, zoneLimit)`.

**Related:** MARINE-001

---

### Ω-003 — World Magnetic Model Coefficient Validity Expiration Bound

- **Severity:** S3-Low
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/core/services/magnetic_declination_service.dart:18-45`
- **Novel:** yes

**Mechanism.** `MagneticDeclinationService` computes magnetic variation (declination) using WMM (World Magnetic Model) spherical harmonic coefficients. WMM coefficient matrices are valid for 5-year epoch windows (e.g. WMM2025 valid 2025.0–2030.0). The service performs Taylor series expansion without checking if the system date exceeds the model epoch bound, leading to gradual magnetic declination error accumulation as time progresses past the 5-year horizon.

**Evidence.**
```dart
// lib/core/services/magnetic_declination_service.dart:18-45
// Calculates declination based on WMM coefficients without checking if DateTime.now().year > epochMaxYear.
```

**Trigger.** Operating the application past the WMM coefficient epoch window (e.g. year 2030+).

**Impact.** Slight magnetic compass heading overlay inaccuracy (0.1° to 0.5° error) over multi-year operational horizons.

**Falsification.** Checked coefficient constants; confirmed WMM2025 coefficients are current for 2025-2030, but no warning is logged when evaluating dates past 2030.

**Fix.** Add a log warning when evaluating declination past the model epoch validity window (`2030.0`).

**Related:** MARINE-001

---

## Cross-domain sightings
- `lib/core/initialization/`: App initialization sequence traps `PlatformDispatcher.onError` and logs startup timing.

## Hygiene (low-signal, listed for completeness)
- `scripts/build_web.sh`: Missing `set -e` at script header.

## Open questions
- Are magnetic declination values cached per 10km grid square to avoid repeated spherical harmonic calculations?

## This team's blind spot
The Blind Spot Unit hunts structural assumptions and non-obvious operational gaps, but cannot predict future third-party API schema deprecations by external government providers.

---

## What this entire audit still cannot see

1. **Physical GPS Hardware Sensor Noise**: Mobile device GPS chipsets exhibit multipath reflection errors near high coastal cliffs and metal vessel structures. No static code audit can simulate sensor noise or satellite fix loss under real sea conditions.
2. **WebGL GPU Canvas Rendering Variations**: Web builds render maps via WebGL / HTML Canvas across Chrome, Safari, and Firefox. GPU driver bug workarounds and shader rendering differences across diverse mobile browsers require physical device matrix testing.
3. **Live Cellular Data Coverage Handover in Open Water**: Transitioning between LTE coastal towers and satellite/offline modes while under way involves OS network stack timeouts that cannot be fully verified without field sea trials.
