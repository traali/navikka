# RED TEAM PROSECUTION — 50_RED_TEAM_PROSECUTION (Wave 4)

- **run_id:** deep-audit-run-01
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `a8aa5a4`
- **wave:** 4

---

## Verdict Summary

- **UPHELD:** 17
- **DOWNGRADED:** 4
- **WITHDRAWN:** 1
- **PROMOTED:** 0
- **Total Candidate Findings Prosecuted:** 22

---

## Prosecution Detailed Ledger

| ID | Title | Original | Verdict | New | Prosecution Rationale |
|---|---|---|---|---|---|
| ARC-001 | Unrounded LatLng Family Key Proliferation | S1-High / C1 | **UPHELD** | S1 / C1 | Confirmed in `point_weather_data_provider.dart`. Raw coordinates create new provider instances on micro-pans. |
| ARC-002 | MapCamera Rebuild Cascade | S1-High / C1 | **UPHELD** | S1 / C1 | Confirmed in `navigation_aids_layer_widget.dart`. `MapCamera.maybeOf` registers context as inherited dependent. |
| CQ-001 | Offline Download Region Leak | S1-High / C1 | **UPHELD** | S1 / C1 | Confirmed in `offline_download_controller.dart`. Catch block omits `tileDao.deleteRegion(regionId)`. |
| CQ-002 | Stale Wind Arrow Start Angle | S3-Low / C1 | **UPHELD** | S3 / C1 | Confirmed in `animated_wind_arrow.dart`. `_currentAngle` not updated during mid-animation updates. |
| SEC-001 | Plaintext Obfuscation Theater | S1-High / C1 | **UPHELD** | S1 / C1 | Confirmed in `skipper_settings_repository_impl.dart`. XOR `0x5A` obfuscation stores keys in unencrypted SQLite. |
| PERF-001 | TrackRepository AutoDispose DB Churn | S1-High / C1 | **UPHELD** | S1 / C1 | Confirmed in `track_repository.dart`. `autoDispose` provider combined with `ref.read` flushes every point. |
| PERF-002 | WaveHeightPainter Loop Allocations | S2-Medium / C1 | **UPHELD** | S2 / C1 | Confirmed in `wave_height_painter.dart`. `Paint()` instantiated inside loop per wave point. |
| TEST-001 | Missing AsyncError Assertions | S2-Medium / C1 | **UPHELD** | S2 / C1 | Confirmed in `speed_alert_notifier_test.dart`. Tests mock `Right(zones)` but omit error boundary assertions. |
| DOC-001 | Sembast Doc Residue | S3-Low / C1 | **DOWNGRADED** | S4 / C1 | Document has an explicit deprecation warning header at line 3. Low risk. |
| UI-001 | Vessel Settings Dropdown Key | S2-Medium / C1 | **UPHELD** | S2 / C1 | Confirmed in `vessel_settings_screen.dart`. Initial value captured once on mount without `ValueKey`. |
| UX-001 | Experimental Switch Haptics | S3-Low / C1 | **UPHELD** | S3 / C1 | Confirmed in `menu_screen.dart`. Omitted `SafeHaptics.selection()`. |
| DATA-001 | SQLite Index Creation Sequencing | S2-Medium / C1 | **DOWNGRADED** | S3 / C1 | Incremental migration test suite passes cleanly from v5 through v17. Latent risk only. |
| DEP-001 | url_launcher Dependency Utility | S4-Note / C1 | **WITHDRAWN** | N/A | Falsification proved `url_launcher` is required for MRCC Turku emergency calls in `emergency_distress_button.dart`. |
| OPS-001 | Startup Network Offline Fallback | S2-Medium / C1 | **DOWNGRADED** | S3 / C1 | Transient offline state auto-recovers when connectivity listener fires. Minimal operational impact. |
| MARINE-001 | Knot vs Km/h Speed Normalization | S1-High / C1 | **UPHELD** | S1 / C1 | Confirmed in `speed_limit_dto.dart`. `yksikko` unit attribute check verified essential. |
| MARINE-002 | IALA Cardinal Mark Topmark Mapping | S0-Critical / C1 | **UPHELD** | S0 / C1 | Confirmed in `navigation_aid_marker.dart`. Code 5 = East, Code 6 = West. |
| SEAM-001 | Unrounded Coordinates to DB Cascade | S1-High / C1 | **UPHELD** | S1 / C1 | Cross-domain seam between Riverpod family keys and Drift stream re-evaluations. |
| SEAM-002 | AutoDispose Defeats SQLite Batching | S1-High / C1 | **UPHELD** | S1 / C1 | Seam between Riverpod disposal and Drift batching. |
| SEAM-003 | Error Propagation Masking | S2-Medium / C1 | **UPHELD** | S2 / C1 | Seam between Data exception throwing and Presentation UI fallback. |
| Ω-001 | Build Script Missing API Key Check | S2-Medium / C1 | **UPHELD** | S2 / C1 | Confirmed in `build_web.ps1`. Script does not validate `$envKey` is non-empty before compiling release. |
| Ω-002 | Constant Speed Assumption in Route ETA | S2-Medium / C1 | **UPHELD** | S2 / C1 | Confirmed in `navigation_service.dart`. `calculateEta` ignores spatial speed restriction caps. |
| Ω-003 | WMM Epoch Expiration Bound | S3-Low / C1 | **DOWNGRADED** | S4 / C1 | WMM2025 coefficients are current through 2030. No immediate risk. |
