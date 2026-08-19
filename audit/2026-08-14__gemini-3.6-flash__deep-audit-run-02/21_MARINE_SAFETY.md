# MARINE SAFETY AUDIT — MARINE

- **run_id:** deep-audit-run-02
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `c4492cc`
- **wave:** 1
- **findings_reported:** 2
- **candidates_discarded:** 10
- **examined:** `lib/features/speed_limits/`, `lib/features/navigation_aids/`, `lib/core/services/geometry_utils.dart`
- **not_examined:** Real-world AIS transponder signals

---

### MARINE-001 — Speed Limit Alert Unit Normalization Discrepancy (Knots vs Km/h)

- **Severity:** S1-High
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/speed_limits/presentation/providers/speed_alert_notifier.dart:34-45`
- **Novel:** yes

**Mechanism.** `SpeedAlertNotifier._checkSpeed` evaluates current Vessel Speed Over Ground (`sogKnots`) against spatial speed restriction zones (`SpeedLimitZone.limitKmh`). `sogKnots` (in knots, nautical miles per hour) is compared directly against `limitKmh` (in kilometers per hour) without applying the $1 \text{ knot} = 1.852 \text{ km/h}$ conversion factor. A vessel traveling at 10 knots (18.52 km/h) in a 15 km/h speed zone evaluates $10 < 15$, failing to trigger a speed violation alert.

**Evidence.**
```dart
  void _checkSpeed(double sogKnots, List<SpeedLimitZone> zones) {
    for (final zone in zones) {
      if (sogKnots > zone.limitKmh) { // Comparing knots directly to km/h!
        state = SpeedAlertState.exceeded(zone);
        return;
      }
    }
  }
```

**Trigger.** Navigating in speed-restricted fairways or harbor channels where speed limits are specified in km/h.

**Impact.** False negative speed alerts, exposing skippers to maritime speeding fines and dangerous wake damage in restricted channels.

**Falsification.** Checked `SpeedLimitZone` entity definition; `limitKmh` is explicitly stored in km/h ($10 \text{ km/h} \approx 5.4 \text{ knots}$). Direct comparison without `sogKnots * 1.852` creates a 46% error margin.

**Fix.** Convert `sogKnots` to km/h (`final sogKmh = sogKnots * 1.852;`) before comparing against `zone.limitKmh`.

**Related:** CQ-001

---

### MARINE-002 — IALA Cardinal Mark Topmark Code Null Asset Path Fallback

- **Severity:** S0-Critical
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/navigation_aids/presentation/mappers/official_sign_mapper.dart:28-42`
- **Novel:** yes

**Mechanism.** `OfficialSignMapper.getAssetPath` maps Finnish Maritime Administration (Väylävirasto) sign type codes to SVG asset paths. For unmapped sign codes or missing topmark enum variants, `getAssetPath` returns `null`. `NavigationAidsLayerWidget` filters out null asset paths (`if (assetPath == null) return null;`), rendering *no marker at all* on the map for unmapped cardinal/lateral navigation signs instead of rendering a high-visibility fallback hazard symbol.

**Evidence.**
```dart
  static String? getAssetPath(int typeCode) {
    switch (typeCode) {
      case 1: return 'assets/icons/cardinal_north.svg';
      ...
      default: return null; // Hides marker completely!
    }
  }
```

**Trigger.** Encountering a newly classified or rare IALA-A fairway sign type code from Väylävirasto WFS feed.

**Impact.** Critical marine safety hazard: navigational buoys and cardinal marks invisible on plotter, risking vessel grounding.

**Falsification.** Checked map rendering pipeline; confirmed markers returning `null` asset paths are dropped from the map overlay completely.

**Fix.** Return a default fallback hazard marker asset (`assets/icons/nav_aid_generic.svg`) when `typeCode` is unmapped.

**Related:** ARC-002, UI-001

---

## Cross-domain sightings
- `lib/core/services/geometry_utils.dart`: Polygon ray-casting algorithm includes boundary point precision handling.

## Hygiene (low-signal, listed for completeness)
- `lib/features/fishing/domain/services/catch_size_validator.dart`: Pikeperch minimum size threshold set to 42cm.

## Open questions
- Are MRCC Turku emergency coordinates verified against WGS84 ellipsoid projections?

## This team's blind spot
Marine safety auditing evaluates nautical unit conversions and IALA buoyage rules, but cannot test physical vessel GPS signal loss under heavy sea spray or storm conditions.
