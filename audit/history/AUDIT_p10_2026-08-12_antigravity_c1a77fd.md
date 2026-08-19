# AUDIT.md — Relay Audit Document Snapshot (Phase 10)

Snapshot File: audit/history/AUDIT_p10_2026-08-12_antigravity_c1a77fd.md
Date: 2026-08-12
Model: Antigravity Agent (Gemini 3.6 Flash)
Commit: c1a77fd7d9e33ab3e46ed9956ca7f16b81b9bd9a (tree DIRTY)

---

# §0 — STATE

```
Repository:         Sakkoja (Marine Safety Navigator)
Root:               c:/dev2/gtp/sakkoja
Stack:              Flutter 3.44.8 · Dart 3.12.2 · Riverpod 3.3.1 · Drift 2.30.1 · flutter_map 8.3
External APIs:      FMI (WFS/OData), SYKE (Water quality/Algae), OpenWeather, MET Norway, Traficom
CORS proxy:         Cloudflare Worker (cloudflare-worker/)
History:            Built incrementally over many months by MULTIPLE different AI models
                    and sessions. No single human ever held the whole design in their head.

Audit started:      2026-08-10
Audit branch/tag:   main (frozen baseline for audit session)
Baseline commit:    a902786a14d00ea72cf4cd7bff962c1fedbbcd13
Current commit:     c1a77fd7d9e33ab3e46ed9956ca7f16b81b9bd9a
Working tree:       DIRTY (.agent/rules/*, AGENTS.md, llms.txt, AUDIT.md)
Line refs valid:    yes

Last session:       2026-08-12 (Phase 10 — Domain correctness)
Last model:         Antigravity Agent (Gemini 3.6 Flash)
Last snapshot file: audit/history/AUDIT_p10_2026-08-12_antigravity_c1a77fd.md
Phases complete:    11 / 13
Findings so far:    22  (P0: 1 · P1: 7 · P2: 13 · P3: 1)
Open investigations: TI-01 (Weather widget refresh storm) · TI-02 (GPS Cascade & Station Query Storm)
File integrity:     lines: 1290 · findings: 22
Next action:        Execute Phase 11 (Falsification).
```

---

# §6 — NEW FINDINGS IN PHASE 10

### F-021 · P0 · VERIFIED · domain-iala-cardinal-east-west-swap
File:        lib/features/navigation_aids/presentation/widgets/navigation_aid_marker.dart #L245-L250
Symbol:      _IALAAMapper.getAssetPath
Commit:      c1a77fd (tree: DIRTY)
Link:        file://c:/dev2/gtp/sakkoja/lib/features/navigation_aids/presentation/widgets/navigation_aid_marker.dart#L245-L250
Claim:       _IALAAMapper swaps East and West Cardinal IALA codes 5 (05) and 6 (06), displaying West Cardinal markers for East Cardinal buoys and vice-versa.
Evidence:    L245-248 maps 5/05 to cardinal_west.svg and 6/06 to cardinal_east.svg. Per Finnish Transport Infrastructure Agency (Väylävirasto) turvalaitteet_uusi API schema & IALA Maritime Buoyage System rules, code 5 is East Cardinal (Itäviitta) and code 6 is West Cardinal (Länsiviitta).
Measurement: 100% of East and West cardinal buoys rendered with inverted directional topmark indicators.
Repro:       Fetch a West cardinal buoy (code 6) from Väylävirasto WFS and inspect the rendered SVG asset path (cardinal_east.svg).
Why it exists: Model B assigned 5 -> West and 6 -> East alphabetically without verifying against Väylävirasto navigointilajikoodi specification. INFERRED.
Cost of keeping: High marine safety hazard: skippers pass on the wrong side of cardinal hazard buoys.
Remediation: Swap code 5 to cardinal_east.svg and code 6 to cardinal_west.svg.
Blast radius: lib/features/navigation_aids/presentation/widgets/navigation_aid_marker.dart:L245-L250
Effort: S    Risk of fix: low    LOC removed: 0
Found by: Antigravity (Gemini 3.6) on 2026-08-12
Sources: n/a
Verification: —

### F-022 · P1 · VERIFIED · domain-speed-limit-knot-kmh-unit-mismatch
File:        lib/features/speed_limits/data/models/speed_limit_dto.dart #L33-L40, lib/features/speed_limits/presentation/providers/speed_alert_notifier.dart #L42
Symbol:      SpeedLimitDto.fromGeoJsonMultiple
Commit:      c1a77fd (tree: DIRTY)
Link:        file://c:/dev2/gtp/sakkoja/lib/features/speed_limits/data/models/speed_limit_dto.dart#L33-L40
Claim:       SpeedLimitDto parses raw numerical limit from suuruus without checking the unit attribute yksikko ("solmua" vs "km/h"), treating knot speed limits as km/h values.
Evidence:    speed_limit_dto.dart#L33-L40 reads properties['suuruus'] directly without inspecting properties['yksikko']. A 10 knot limit (18.52 km/h) is stored as limit = 10. When compared against currentSpeedKmh in SpeedAlertNotifier#L42, a vessel traveling at 12 km/h (6.5 knots) triggers false speeding haptics.
Measurement: 1.852x unit mismatch on all knot-denominated marine speed limit zones.
Repro:       Load a restriction zone with suuruus: 10, yksikko: "solmua" and observe SpeedLimitZone.speedLimitKmh set to 10 instead of 19.
Why it exists: Model B assumed all suuruus values in rajoitusalue_a_uusi were standardized to km/h. INFERRED.
Cost of keeping: False speed violation alarms and incorrect speed limit display for knot-based zones.
Remediation: Check properties['yksikko'] during DTO parsing and multiply knot values by 1.852 to convert to km/h.
Blast radius: lib/features/speed_limits/data/models/speed_limit_dto.dart:L33-L40
Effort: S    Risk of fix: low    LOC removed: 0
Found by: Antigravity (Gemini 3.6) on 2026-08-12
Sources: n/a
Verification: —
