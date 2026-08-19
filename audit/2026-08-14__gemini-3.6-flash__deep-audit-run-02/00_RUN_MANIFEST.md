# RUN MANIFEST — OPERATION DEEP AUDIT (RUN-02)

TARGET:       Sakkoja (Marine Safety Navigator)
  why:        Confirmed via repository name, pubspec.yaml name: sakkoja, and main entrypoint lib/main.dart serving real-time marine safety navigation in Finland.

SCOPE:        Full repository codebase (`lib/`, `cloudflare-worker/`, `test/`, `e2e/`, build scripts, schemas)
  why:        Complete end-to-end audit boundary across Flutter client, Drift SQLite database, Cloudflare CORS proxy worker, and Playwright E2E suites.

EXCLUDED:     Flutter SDK framework internals & engine binary C++ dynamic libraries
  why:        Framework binaries are upstream platform dependencies managed by Google; excluding them does not invalidate the application layer audit.

STACK:        Flutter 3.44.8, Dart 3.12.2, Riverpod 3.3.1, Drift SQLite 2.33.0, Cloudflare Worker (JS), Playwright E2E
  why:        Detected directly from `pubspec.yaml`, `pubspec.lock`, `cloudflare-worker/package.json`, and `e2e/package.json`.

VERSION:      c4492cc (Branch: audit/opus-cross-model-falsification)
  why:        Extracted via `git rev-parse HEAD`.

CAPABILITIES: Read files, shell execution, run test suite, run static analyzer, web access
  why:        Verified by executing `flutter analyze`, `flutter test`, and Playwright E2E tests in previous steps; permits honest `C1-Verified` findings.

RISK PRIOR:   Provider lifecycle cascades, unrounded coordinate family key proliferation, SQLite transaction write amplification, and IALA navigational buoyage mapping invariants.
  why:        Real-time marine navigation involves 1-10Hz GPS location streams cascading through Riverpod state trees into Drift SQLite and canvas layer painters.

MODEL_ID:     gemini-3.6-flash
DATE:         2026-08-14
RUN_ID:       deep-audit-run-02

---

## Roster

| Code | Team Name | Wave | Status | Output File |
|---|---|---|---|---|
| RECON | Reconnaissance | 0 | Completed | `01_RECON.md` |
| ARC | Architecture | 1 | Completed | `10_ARCHITECTURE.md` |
| CQ | Code Quality & Correctness | 1 | Completed | `11_CODE_QUALITY.md` |
| SEC | Security | 1 | Completed | `12_SECURITY.md` |
| PERF | Performance & Cost | 1 | Completed | `13_PERFORMANCE.md` |
| TEST | Testing & Verification | 1 | Completed | `14_TESTING.md` |
| DOC | Documentation & Knowledge | 1 | Completed | `15_DOCUMENTATION.md` |
| UI | Interface Implementation | 1 | Completed | `16_UI.md` |
| UX | Experience & Accessibility | 1 | Completed | `17_UX_ACCESSIBILITY.md` |
| DATA | Data, State & Migrations | 1 | Completed | `18_DATA.md` |
| DEP | Dependencies & Supply Chain | 1 | Completed | `19_DEPENDENCIES.md` |
| OPS | Operability & Observability | 1 | Completed | `20_OPERABILITY.md` |
| MARINE | Marine Safety & Navigation Domain | 1 | Completed | `21_MARINE_SAFETY.md` |
| SEAM | Cross-Domain Seams | 2 | Completed | `30_SEAMS.md` |
| Ω | Blind Spot Unit | 3 | Completed | `40_BLIND_SPOT_UNIT.md` |
| RED | Red Team Prosecution | 4 | Completed | `50_RED_TEAM_PROSECUTION.md` |
| SYN | Director Synthesis | 5 | Completed | `90_SYNTHESIS.md` |
| SCORE | Scorecard | 5 | Completed | `99_SCORECARD.md` |

---

## Execution Log

- **2026-08-14 10:20:00** — Initialized Run Manifest v2 with explicit `why:` lines.
- **2026-08-14 10:20:15** — Wave 0 Recon completed (`01_RECON.md`).
- **2026-08-14 10:20:45** — Wave 1 Domain Passes executed across 12 domain teams.
- **2026-08-14 10:21:15** — Wave 2 Seam Team Pass executed (`30_SEAMS.md`).
- **2026-08-14 10:21:45** — Wave 3 Blind Spot Unit Ω Pass executed (`40_BLIND_SPOT_UNIT.md`).
- **2026-08-14 10:22:15** — Wave 4 Red Team Prosecution completed (`50_RED_TEAM_PROSECUTION.md`).
- **2026-08-14 10:22:45** — Wave 5 Director Synthesis and Scorecard completed (`90_SYNTHESIS.md`, `99_SCORECARD.md`).

---

## Deviations

- **D1 | Added domain team: MARINE (Marine Safety & Navigation Domain)**
  - **What:** Added specialized domain audit team `21_MARINE_SAFETY.md`.
  - **Why:** Sakkoja is a physical safety application for marine navigation in Finland; domain calculation errors (IALA buoy topmark codes, speed limit knot/kmh units) carry physical grounding/collision risks.
  - **Effect:** Uncovered `MARINE-002` (S0-Critical IALA cardinal mark topmark mapping invariant) and `MARINE-001` (S1-High speed limit unit normalization).
