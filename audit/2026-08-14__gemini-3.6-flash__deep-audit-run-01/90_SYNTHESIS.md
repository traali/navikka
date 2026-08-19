# DIRECTOR SYNTHESIS — 90_SYNTHESIS (Wave 5)

- **run_id:** deep-audit-run-01
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `a8aa5a4`
- **wave:** 5

---

## 1. Master Deduplicated Findings Ledger (Sorted by Severity)

| ID | Title | Severity | Confidence | Location |
|---|---|---|---|---|
| MARINE-002 | IALA Region A Cardinal Mark Visual Topmark Mapping Invariant | S0-Critical | C1-Verified | `lib/features/navigation_aids/presentation/widgets/navigation_aid_marker.dart:246` |
| ARC-001 | Unrounded LatLng Family Key Provider Proliferation | S1-High | C1-Verified | `lib/features/weather/presentation/controllers/point_weather_data_provider.dart:10` |
| ARC-002 | Inherited Widget Rebuild Cascade in Layer Painting | S1-High | C1-Verified | `lib/features/navigation_aids/presentation/widgets/navigation_aids_layer_widget.dart:35` |
| CQ-001 | Offline Map Download Error Path Leaves Orphaned Database Region | S1-High | C1-Verified | `lib/features/map/presentation/controllers/offline_download_controller.dart:78` |
| SEC-001 | Plaintext Obfuscation Theater for OpenRouter AI API Keys | S1-High | C1-Verified | `lib/features/ai/data/repositories/skipper_settings_repository_impl.dart:39` |
| PERF-001 | TrackRepository Auto-Dispose Defeats SQLite 50-Point Batch Buffer | S1-High | C1-Verified | `lib/features/tracking/data/repositories/track_repository.dart:180` |
| MARINE-001 | Knot vs Km/h Unit Normalization on Vessel Speed Limit Zones | S1-High | C1-Verified | `lib/features/speed_limits/data/models/speed_limit_dto.dart:39` |
| SEAM-001 | Unrounded Coordinates Bridge Architecture and Database Performance Cascades | S1-High | C1-Verified | `point_weather_data_provider.dart` ↔ `drift_weather_store.dart` |
| SEAM-002 | Provider Auto-Dispose Defeats Repository In-Memory Batching Invariant | S1-High | C1-Verified | `active_track_provider.dart` ↔ `track_repository.dart` |
| PERF-002 | Per-Point Heap Allocations in WaveHeightPainter Canvas Loop | S2-Medium | C1-Verified | `lib/features/weather/presentation/widgets/wave_height_painter.dart:38` |
| UI-001 | Dropdown Form Field State Initialization Key Binding | S2-Medium | C1-Verified | `lib/features/vessel/presentation/screens/vessel_settings_screen.dart:123` |
| TEST-001 | Test Suite Misses Downstream Error Propagation on Provider Failures | S2-Medium | C1-Verified | `test/features/speed_limits/presentation/providers/` |
| SEAM-003 | Error Propagation Masking Between Data Layer Exception throwing and Presentation UI Fallbacks | S2-Medium | C1-Verified | `speed_limit_provider.dart` ↔ `displayed_speed_limits_provider.dart` |
| Ω-001 | Build Script Silent Success on Missing OPENWEATHER_API_KEY | S2-Medium | C1-Verified | `scripts/build_web.ps1:12` & `scripts/build_web.sh:10` |
| Ω-002 | Constant Speed Assumption in Fairway Route ETA Calculations | S2-Medium | C1-Verified | `lib/features/navigation/domain/services/navigation_service.dart:45` |
| CQ-002 | Stale Start Angle in Mid-Animation Wind Arrow Updates | S3-Low | C1-Verified | `lib/features/weather/presentation/widgets/animated_wind_arrow.dart:45` |
| UX-001 | Inconsistent Haptic Feedback on Settings Switches | S3-Low | C1-Verified | `lib/features/menu/presentation/screens/menu_screen.dart:366` |
| DATA-001 | SQLite Index Creation Sequencing in Schema Migration Strategy | S3-Low | C1-Verified | `lib/core/db/app_database.dart:116` |
| OPS-001 | Network Offline Status Fallback Propagation during Native Startup | S3-Low | C1-Verified | `lib/core/network/network_monitor_provider.dart:25` |
| DOC-001 | Historical Sembast Storage Documentation Residue | S4-Note | C1-Verified | `PROJECT_DOCUMENTATION.md:36` |
| Ω-003 | World Magnetic Model Coefficient Validity Expiration Bound | S4-Note | C1-Verified | `lib/core/services/magnetic_declination_service.dart:18` |

---

## 2. Top 5 Findings (Deep Reasoning)

1. **`MARINE-002` (S0-Critical)** — *IALA Cardinal Topmark Inversion Hazard*.
   - *Why this rank:* Inverting East (Code 5) and West (Code 6) cardinal buoy visual topmarks directs skippers to steer into hazardous shoals. Marine navigation safety apps have zero tolerance for navigational marker inversions.
2. **`PERF-001` / `SEAM-002` (S1-High)** — *TrackRepository AutoDispose DB Churn*.
   - *Why this rank:* Disposing `TrackRepository` on every 1Hz GPS coordinate forces an immediate SQLite flush, increasing DB disk transactions by 50x and causing main thread jank during navigation tracking.
3. **`ARC-001` / `SEAM-001` (S1-High)** — *Unrounded LatLng Riverpod Family Key Proliferation*.
   - *Why this rank:* Passing raw double coordinates into family stream providers creates a new provider instance on every micro-pan, cascading into continuous Drift SQL query re-evaluations.
4. **`SEC-001` (S1-High)** — *Plaintext XOR Obfuscation Theater for AI API Keys*.
   - *Why this rank:* OpenRouter API keys stored with static XOR (`0x5A`) in unencrypted SQLite columns leave user paid credentials vulnerable to local extraction.
5. **`CQ-001` (S1-High)** — *Offline Map Download Orphaned Region Leak*.
   - *Why this rank:* Failing to clean up `regionId` in the `catch` block on download exception leaves orphaned database records permanently stuck in "Downloading" state.

---

## 3. Three Root Causes

1. **Provider Lifecycle & Parameter Snapping Invariants**: Riverpod family providers accepting raw spatial parameters (`LatLng`) without coordinate quantization, combined with `autoDispose` annotations on stateful repositories accessed via `ref.read`.
2. **Security & Persistence Layer Abstraction Drift**: Using custom XOR obfuscation instead of OS-native encrypted keychains (`FlutterSecureStorage`).
3. **Async Exception Boundary Cleanup Gaps**: Error handlers focusing on UI feedback (`SnackBar`) without conducting transactional state cleanup in local SQLite storage.

---

## 4. Sequenced Remediation Roadmap

```
Sprint 1 (Immediate Safety & Performance Fixes)
  1. Fix MARINE-002 (Verify Code 5 = East, Code 6 = West cardinal SVG mapping)
  2. Fix ARC-001 / SEAM-001 (Grid-snap LatLng coordinates in point_weather_data_provider.dart)
  3. Fix PERF-001 / SEAM-002 (Add @Riverpod(keepAlive: true) to trackRepositoryProvider)

Sprint 2 (Security & State Integrity)
  4. Fix SEC-001 (Migrate aiApiKey storage to FlutterSecureStorage)
  5. Fix CQ-001 (Add tileDao.deleteRegion(regionId) on download exception)
  6. Fix ARC-002 (Use mapCameraPositionProvider.select for zoom boolean in NavigationAidsLayerWidget)

Sprint 3 (Polish & Validation)
  7. Fix PERF-002 (Pre-allocate Paint object in WaveHeightPainter)
  8. Fix Ω-001 (Add OPENWEATHER_API_KEY check to build_web.ps1 / build_web.sh)
  9. Fix UI-001 & UX-001 (Bind ValueKey on dropdowns and add SafeHaptics.selection)
```

---

## 5. Single-Change Recommendation

If you could change **exactly one thing** about this system:

> **Quantize all spatial parameters (`LatLng`) at the Riverpod provider boundary to a fixed grid (0.01° ~1.1km).**
>
> *Rationale:* This single architectural change immediately resolves provider instance proliferation (`ARC-001`), stops the reactive database query cascade (`SEAM-001`), prevents weather refresh storms during navigation, and preserves memory stability across continuous panning gestures.
