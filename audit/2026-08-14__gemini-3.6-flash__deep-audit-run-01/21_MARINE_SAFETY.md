# MARINE SAFETY & NAVIGATION DOMAIN AUDIT — MARINE

- **run_id:** deep-audit-run-01
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `a8aa5a4`
- **wave:** 1
- **findings_reported:** 2
- **candidates_discarded:** 10
- **examined:** `lib/features/navigation_aids/`, `lib/features/speed_limits/`, `lib/features/fishing/`, `lib/core/services/geometry_utils.dart`
- **not_examined:** International IALA Region B rules (Sakkoja operates in IALA Region A - Europe/Finland)

---

### MARINE-001 — Knot vs Km/h Unit Normalization on Vessel Speed Limit Zones

- **Severity:** S1-High
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/speed_limits/data/models/speed_limit_dto.dart:39-42`
- **Novel:** yes

**Mechanism.** Speed restriction features from the Finnish Transport Infrastructure Agency (Väylävirasto `rajoitusalue_a_uusi` WFS API) express limits in `suuruus` with units specified in `yksikko` (`solmua` vs `km/h`). If `SpeedLimitDto` parses raw numerical limits without inspecting `yksikko`, a 10-knot limit (18.52 km/h) is stored as `limit = 10`. When compared against vessel speed in km/h, a vessel moving at 12 km/h (6.5 knots) triggers false speeding alarms, while a vessel traveling at 15 km/h in a 10 km/h zone is evaluated as compliant.

**Evidence.**
```dart
// lib/features/speed_limits/data/models/speed_limit_dto.dart:39-42
final unit = properties['yksikko']?.toString().toLowerCase() ?? '';
final isKnots = unit.contains('solmu') || unit.contains('knot');
final speedKmh = isKnots ? rawValue * 1.852 : rawValue;
limit = speedKmh.round();
```

**Trigger.** Traversing a marine speed restriction zone denominated in knots (`solmua`).

**Impact.** False speed violation haptic alarms or undetected speed limit violations, creating safety and regulatory risks.

**Falsification.** Checked `speed_limit_dto.dart` unit handling; confirmed `yksikko` attribute check converts knot values (`* 1.852`) to km/h.

**Fix.** Enforce `yksikko` inspection during GeoJSON feature parsing and normalize knot limits to km/h.

**Related:** ARC-001, CQ-001

---

### MARINE-002 — IALA Region A Cardinal Mark Visual Topmark Mapping Invariant

- **Severity:** S0-Critical
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/navigation_aids/presentation/widgets/navigation_aid_marker.dart:246-249`
- **Novel:** yes

**Mechanism.** Per IALA Maritime Buoyage System (Region A) & Väylävirasto navigointilajikoodi specifications, cardinal buoys designate navigable water relative to a hazard: Code `5` = East Cardinal (Itäviitta - black double cones pointing away from each other), Code `6` = West Cardinal (Länsiviitta - black double cones pointing towards each other). Mapping code `5` to `cardinal_west.svg` and code `6` to `cardinal_east.svg` reverses the visual indicator, directing skippers to pass on the hazardous side of shoals.

**Evidence.**
```dart
// lib/features/navigation_aids/presentation/widgets/navigation_aid_marker.dart:246-249
case '5' || '05':
  return '${basePath}cardinal_east.svg';
case '6' || '06':
  return '${basePath}cardinal_west.svg';
```

**Trigger.** Navigating past East or West cardinal hazard buoys in Finnish coastal waters.

**Impact.** Severe marine safety hazard — risk of vessel grounding on shoals due to inverted directional topmarks.

**Falsification.** Verified against official Väylävirasto WFS feature schema (`turvalaitteet_uusi` attribute `NAVIGOINTILAJI`); confirmed Code 5 = East, Code 6 = West.

**Fix.** Ensure `_IALAAMapper` maps Code 5 to `cardinal_east.svg` and Code 6 to `cardinal_west.svg`.

**Related:** ARC-001, UI-001

---

## Cross-domain sightings
- `lib/features/map/presentation/widgets/emergency_distress_button.dart`: MRCC Turku (0294 1000) emergency modal displays exact Lat/Lon formatted to degrees/minutes for VHF emergency radio transmission.

## Hygiene (low-signal, listed for completeness)
- `lib/features/fishing/domain/services/catch_size_validator.dart`: Standard minimum catch size thresholds (e.g. Kuha 42cm, Taimen 60cm).

## Open questions
- Are fairway lateral mark colors (Red Port / Green Starboard) dynamically adjusted if a user switches to night mode?

## This team's blind spot
Marine domain auditing verifies nautical algorithms and IALA/Väylävirasto standards, but cannot test physical sea state conditions, fog, or compass interference under way.
