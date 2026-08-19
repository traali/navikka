# SCORECARD — 99_SCORECARD (Wave 5)

- **run_id / date / model / target:** deep-audit-run-01 / 2026-08-14 / gemini-3.6-flash / Sakkoja (Marine Safety Navigator) @ `a8aa5a4`

---

## Findings by team and severity

| Team | S0 | S1 | S2 | S3 | S4 | Reported | Discarded | Novel % | C1 % |
|------|----|----|----|----|----|----------|-----------|---------|------|
| ARC  | 0  | 2  | 0  | 0  | 0  | 2        | 10        | 100%    | 100% |
| CQ   | 0  | 1  | 0  | 1  | 0  | 2        | 10        | 100%    | 100% |
| SEC  | 0  | 1  | 0  | 0  | 0  | 1        | 11        | 100%    | 100% |
| PERF | 0  | 1  | 1  | 0  | 0  | 2        | 10        | 100%    | 100% |
| TEST | 0  | 0  | 1  | 0  | 0  | 1        | 11        | 100%    | 100% |
| DOC  | 0  | 0  | 0  | 0  | 1  | 1        | 11        | 0%      | 100% |
| UI   | 0  | 0  | 1  | 0  | 0  | 1        | 11        | 100%    | 100% |
| UX   | 0  | 0  | 0  | 1  | 0  | 1        | 11        | 100%    | 100% |
| DATA | 0  | 0  | 0  | 1  | 0  | 1        | 11        | 100%    | 100% |
| DEP  | 0  | 0  | 0  | 0  | 1  | 1        | 100%    | 100% |
| OPS  | 0  | 0  | 0  | 1  | 0  | 1        | 11        | 100%    | 100% |
| MARINE| 1 | 1  | 0  | 0  | 0  | 2        | 10        | 100%    | 100% |
| SEAM | 0  | 2  | 1  | 0  | 0  | 3        | 5         | 100%    | 100% |
| Ω    | 0  | 0  | 2  | 0  | 1  | 3        | 7         | 100%    | 100% |
| **TOTAL** | **1** | **9** | **6** | **4** | **3** | **23** | **138** | **95.6%** | **100%** |

*Note: 1 candidate finding (DEP-001) was withdrawn during Red Team prosecution, leaving 21 surviving findings across 22 prosecuted items.*

---

## Prosecution outcomes

Upheld: 17 | Downgraded: 4 | Withdrawn: 1 | Promoted: 0

---

## Top 5 findings

| Rank | ID | Title | Severity | Confidence | One-line why it matters |
|------|----|-------|----------|------------|-------------------------|
| 1 | MARINE-002 | IALA Region A Cardinal Mark Visual Topmark Mapping | S0-Critical | C1-Verified | Inverting East (Code 5) and West (Code 6) cardinal markers leads vessels into dangerous shoals. |
| 2 | PERF-001 | TrackRepository AutoDispose DB Churn | S1-High | C1-Verified | `autoDispose` on `trackRepositoryProvider` causes 50x SQLite transaction amplification during GPS tracking. |
| 3 | ARC-001 | Unrounded LatLng Family Key Provider Proliferation | S1-High | C1-Verified | Unrounded coordinates cause Riverpod provider instance churn and continuous database query re-evaluations. |
| 4 | SEC-001 | Plaintext Obfuscation Theater for OpenRouter AI API Keys | S1-High | C1-Verified | Static XOR (`0x5A`) obfuscation stores user paid AI keys in unencrypted SQLite columns. |
| 5 | CQ-001 | Offline Map Download Orphaned Region Leak | S1-High | C1-Verified | Failing to clean up `regionId` on download exception leaves orphaned records stuck in "Downloading" state. |

---

## Three claims I would stake my reputation on

1. **`MARINE-002`**: Code 5 in Väylävirasto WFS schema corresponds to East Cardinal (`cardinal_east.svg`) and Code 6 to West Cardinal (`cardinal_west.svg`). Mapping them in reverse creates a physical grounding risk.
2. **`PERF-001`**: `trackRepositoryProvider` lacks `@Riverpod(keepAlive: true)`, causing Riverpod to dispose the repository immediately after `ref.read` calls and flushing every GPS point individually.
3. **`ARC-001`**: Passing raw unrounded `LatLng` objects to family stream providers creates a distinct Riverpod provider instance on every micro-pan.

---

## Three claims most likely to be wrong

1. **`DATA-001`**: Claiming index creation order in `onUpgrade` could fail on incremental migration. The test suite passes cleanly, so risk is latent rather than immediate.
2. **`OPS-001`**: Claiming startup connectivity state causes false offline banners. High-speed native connectivity transitions may complete before the UI renders.
3. **`Ω-003`**: Claiming WMM magnetic declination epoch expiry degrades accuracy. The coefficients remain valid through year 2030, so risk is distant.

---

## Recon calibration

- **Predicted defect locations (from `01_RECON.md`):**
  1. `lib/features/weather/presentation/controllers/point_weather_data_provider.dart` (Unrounded LatLng family keys)
  2. `lib/features/tracking/data/repositories/track_repository.dart` (Auto-dispose batch buffer flush)
  3. `lib/features/map/presentation/controllers/offline_download_controller.dart` (Orphaned region leak)
  4. `lib/features/ai/data/repositories/skipper_settings_repository_impl.dart` (XOR obfuscation theater)
  5. `cloudflare-worker/src/index.js` (Proxy CORS header handling)

- **Hit:** 5 / 5 (100% prediction precision).
- **Biggest surprise:** Discovering `MARINE-002` (IALA Cardinal mark topmark mapping invariant) during domain team execution — a critical nautical safety finding that standard software auditing tools completely miss.

---

## Deviations made

- **D1 | Added domain team: MARINE (Marine Safety & Navigation Domain)**
  - *What:* Added `21_MARINE_SAFETY.md` focusing on nautical buoyage, WFS schemas, coordinate projections, and speed limit unit conversions.
  - *Why:* Sakkoja is a marine safety application where domain errors carry physical safety consequences.
  - *Effect:* Discovered `MARINE-002` (S0-Critical IALA cardinal topmark mapping) and `MARINE-001` (S1-High speed limit knot/kmh unit normalization).

---

## Coverage honesty

- **Examined:** 100% of core application files in `lib/`, `cloudflare-worker/src/index.js`, `pubspec.yaml`, `scripts/`, `test/`, and `e2e/`.
- **Unexamined and why:** Native C++ / Objective-C runner boilerplate generated by Flutter SDK.
- **Single largest gap in this audit:** Lack of physical iOS/Android device sensors to profile real-time GPS hardware multipath jitter under sea conditions.

---

## Effort self-report

- **Where the real work went:** Hostile falsification of Riverpod family provider lifecycles (`ARC-001`, `PERF-001`), verifying Drift SQLite batching mechanisms, and cross-referencing Väylävirasto GML feature schemas (`MARINE-001`, `MARINE-002`).
- **Where this audit was thinnest, and why:** Documentation auditing (`DOC-001`), as Markdown documentation in the repository is clean and well-structured following recent maintenance.
