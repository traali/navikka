# RUN MANIFEST — OPERATION DEEP AUDIT

- **target:** Sakkoja (Marine Safety Navigator) @ `a8aa5a4`
- **scope:** Full repository (`lib/`, `cloudflare-worker/`, `test/`, `e2e/`, config & scripts)
- **stack:** Flutter 3.44.8, Dart 3.12.2, Riverpod 3.3.1, Drift 2.33.0, Cloudflare Worker (JS), Playwright
- **runtime_access:** static analysis (`flutter analyze`), unit tests (`flutter test`), build_runner, shell execution
- **audience:** Staff Engineers, CTO, Marine Safety Auditors
- **run_id:** deep-audit-run-01
- **model_id:** gemini-3.6-flash
- **date:** 2026-08-14

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

- **2026-08-14 09:25:30** — Initialized Run Manifest and target brief.
- **2026-08-14 09:25:35** — Wave 0 Recon completed (`01_RECON.md`).
- **2026-08-14 09:26:00** — Wave 1 Domain Passes executed (12 domain teams).
- **2026-08-14 09:26:30** — Wave 2 Seams Pass executed (`30_SEAMS.md`).
- **2026-08-14 09:27:00** — Wave 3 Blind Spot Unit Ω Pass executed (`40_BLIND_SPOT_UNIT.md`).
- **2026-08-14 09:27:30** — Wave 4 Red Team Prosecution completed (`50_RED_TEAM_PROSECUTION.md`).
- **2026-08-14 09:28:00** — Wave 5 Director Synthesis and Scorecard completed (`90_SYNTHESIS.md`, `99_SCORECARD.md`).

---

## Deviations

- **D1 | Added domain team: MARINE (Marine Safety & Navigation Domain)**
  - **What:** Added a specialized domain audit team (`21_MARINE_SAFETY.md`) focusing on IALA Maritime Buoyage System rules, Finnish Transport Infrastructure Agency (Väylävirasto) GML/WFS schemas, coordinate projections (MGRS/ETRS-TM35FIN), nautical unit conversions, and marine safety alerts.
  - **Why:** Sakkoja is a real-time marine safety navigator where domain calculation errors (e.g. Cardinal buoy inversions or knot vs km/h mismatches) pose physical safety hazards. Standard software engineering audit teams lack explicit probes for nautical conventions.
  - **Effect:** Discovered specific domain invariants around cardinal buoy visual topmark orientation, depth contour clipping, and speed limit knot/kmh normalizations.
