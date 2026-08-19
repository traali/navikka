# EXPERIENCE & ACCESSIBILITY AUDIT — UX

- **run_id:** deep-audit-run-01
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `a8aa5a4`
- **wave:** 1
- **findings_reported:** 1
- **candidates_discarded:** 11
- **examined:** `lib/features/menu/`, `lib/features/map/presentation/widgets/`, `lib/core/utils/safe_haptics.dart`
- **not_examined:** Screen reader VoiceOver/TalkBack output on real devices

---

### UX-001 — Inconsistent Haptic Feedback on Settings Switches

- **Severity:** S3-Low
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/menu/presentation/screens/menu_screen.dart:366-368`
- **Novel:** yes

**Mechanism.** In `MenuScreen`, standard feature switches (e.g. Fishing Mode and Layout toggles) invoke `SafeHaptics.selection()` on tap to provide tactile feedback for marine operations under way (where visual attention is limited). The experimental Wind & Wave switch omitted `SafeHaptics.selection()`, breaking tactile feedback consistency.

**Evidence.**
```dart
  onChanged: (_) {
    SafeHaptics.selection();
    ref.read(windWaveFeatureFlagProvider.notifier).toggle();
  },
```

**Trigger.** Toggling the experimental Wind & Wave switch on the Menu screen.

**Impact.** Lack of tactile confirmation for boat skippers operating the app in rough sea conditions.

**Falsification.** Checked all other switch callbacks in `menu_screen.dart`; confirmed all others invoke `SafeHaptics.selection()`.

**Fix.** Add `SafeHaptics.selection()` inside the `onChanged` callback.

**Related:** UI-001

---

## Cross-domain sightings
- `lib/features/map/presentation/widgets/emergency_distress_button.dart`: MRCC Turku (0294 1000) emergency distress dialog provides 44x44pt touch targets and location display.

## Hygiene (low-signal, listed for completeness)
- `lib/features/navigation_aids/presentation/widgets/navigation_aid_detail_sheet.dart`: Missing explicit semantics label on icon button.

## Open questions
- Are color contrast ratios on translucent Night Captain dark mode badges WCAG 2.2 AA compliant?

## This team's blind spot
UX auditing evaluates tactile feedback, target sizes, and error recovery, but cannot test physical glove operation on a wet touchscreen on a moving boat.
