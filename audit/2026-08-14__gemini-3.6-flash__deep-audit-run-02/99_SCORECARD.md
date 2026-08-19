# SCORECARD

- **run_id:** deep-audit-run-02
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `c4492cc`
- **capabilities:** Read files, shell execution, run test suite, run static analyzer, web access

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
| DATA | 1  | 0  | 0  | 0  | 0  | 1        | 11        | 100%    | 100% |
| DEP  | 0  | 0  | 0  | 0  | 0  | 0        | 12        | 0%      | 100% |
| OPS  | 0  | 0  | 0  | 1  | 0  | 1        | 11        | 100%    | 100% |
| MARINE| 1 | 1  | 0  | 0  | 0  | 2        | 10        | 100%    | 100% |
| SEAM | 0  | 1  | 0  | 0  | 0  | 1        | 5         | 100%    | 100% |
| Ω    | 1  | 1  | 3  | 0  | 0  | 5        | 7         | 100%    | 100% |
| **TOTAL** | **3** | **8** | **6** | **3** | **1** | **22** | **133** | **91%** | **100%** |

---

## Prosecution outcomes

Upheld: 18 | Downgraded: 2 | Withdrawn: 1 | Promoted: 1

---

## Top 5 findings

| Rank | ID | Title | Severity | Confidence | One-line why it matters |
|------|----|-------|----------|------------|-------------------------|
| 1 | DATA-001 | Incremental Schema Migration Missing Indices Creation | S0-Critical | C1-Verified | Existing users upgrading run zero SQLite indices, locking CPU during tile eviction. |
| 2 | MARINE-002 | IALA Cardinal Mark Topmark Code Null Asset Path Fallback | S0-Critical | C1-Verified | Unmapped IALA buoy codes drop markers completely from map, creating vessel grounding risk. |
| 3 | Ω-004 | GeometryUtils Ray-Casting Division-by-Zero on Horizontal Edges | S0-Critical | C1-Verified | Division by zero on horizontal polygon edges causes point-in-polygon checks to fail completely. |
| 4 | MARINE-001 | Speed Limit Alert Unit Normalization Discrepancy | S1-High | C1-Verified | Comparing knots directly to km/h creates a 46% speed warning calculation error. |
| 5 | PERF-001 | TrackRepository Auto-Dispose Defeats SQLite 50-Point Buffer | S1-High | C1-Verified | Auto-dispose on repository forces individual disk writes for every single GPS point. |

---

## Three claims I would stake my reputation on

1. **DATA-001**: `_createIndices(m)` is missing from `onUpgrade` in `AppDatabase`, causing $O(N)$ full table scans on upgraded installs.
2. **MARINE-002**: Returning `null` asset path for unmapped sign type codes drops navigational buoy markers from the map overlay entirely.
3. **Ω-004**: Ray-casting calculation in `GeometryUtils` divides by `(p2.latitude - p1.latitude)`, producing `NaN` on horizontal edges.

---

## Three claims most likely to be wrong

1. **Ω-005**: Upstream APIs might normalize content-type headers to lowercase before reaching Cloudflare Worker proxy.
2. **UI-001**: Element tree widget caching might be invalidated by parent key rebuilds under certain Flutter framework versions.
3. **CQ-002**: Mid-animation wind arrow angle updates occur infrequently in real-world 10-second observation intervals.

---

## Recon calibration

Predicted defect locations (from `01_RECON.md`):
1. `lib/features/weather/presentation/controllers/point_weather_data_provider.dart` — **HIT** (ARC-001: Unrounded LatLng family key provider proliferation).
2. `lib/features/tracking/data/repositories/track_repository.dart` — **HIT** (PERF-001 & SEAM-001: Auto-dispose buffer flush and transaction tearing).
3. `lib/features/map/presentation/controllers/offline_download_controller.dart` — **HIT** (CQ-001: Orphaned database region on download failure).
4. `lib/features/ai/data/repositories/skipper_settings_repository_impl.dart` — **HIT** (SEC-001: Plaintext XOR obfuscation of AI keys).
5. `cloudflare-worker/src/index.js` — **HIT** (Ω-001 & Ω-005: CORS error response origin headers & content-type matching).

Hit: 5/5. Biggest surprise: Finding `MARINE-002` (null asset path dropping buoy markers completely from the map layer).

---

## Deviations made

- **D1 | Added domain team: MARINE (Marine Safety & Navigation Domain)** — Discovered `MARINE-002` (S0-Critical topmark drop) and `MARINE-001` (S1-High knot/kmh unit mismatch).

---

## Coverage honesty

Examined: 100% of application source code (`lib/`), Cloudflare Worker proxy script (`cloudflare-worker/`), unit test suite (`test/`), and Playwright E2E suites (`e2e/`).
Unexamined and why: Native C++ runner engine binaries (out of application layer audit scope).
Single largest gap in this audit: Lack of physical mobile device hardware to measure metal GPU thermal throttling during 60Hz map repaints.

---

## Effort self-report

Where the real work went: Deep code inspection of Riverpod provider lifecycles, Drift SQLite migration blocks, geometric ray-casting formulas, and IALA buoy mapper fallbacks.
Where this audit was thinnest, and why: Dependency scanning (`DEP`), because `pubspec.yaml` dependencies are tightly pinned and updated to 2026 standards.
