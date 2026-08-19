# UX & ACCESSIBILITY AUDIT — UX

- **run_id:** g37f-001
- **date:** 2026-08-17
- **model:** Gemini 3.7 Flash
- **target:** Sakkoja Marine Safety Navigator @ 604ebd4
- **wave:** 1
- **findings_reported:** 3
- **candidates_discarded:** 12
- **examined:** Marine navigation workflows, single-handed rough sea ergonomics, touch target sizes, Finnish localization consistency, screen reader semantic labels, and contrast across 5 nautical themes.
- **not_examined:** Physical accessibility testing with marine sailing gloves on wet capacitive touchscreens.

---

### UX-001 — Small FAB size (40x40dp) violates rough sea touch target standard (64dp)

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/ai/presentation/widgets/voice_copilot_mic_button.dart:153-166`
- **Novel:** yes

**Mechanism.** `VoiceCopilotMicButton` is implemented as `FloatingActionButton.small`, which defaults to a 40x40dp touch target size. In marine navigation applications operating in rough sea conditions (where boat slamming and deck vibrations impair fine motor control), touch targets for critical cockpit actions must meet the minimum 64x64dp Rough Sea Mode standard. A 40dp button leads to repeated mis-taps while navigating at speed.

**Evidence.**
```dart
// lib/features/ai/presentation/widgets/voice_copilot_mic_button.dart:153
return FloatingActionButton.small(
  heroTag: 'voice_copilot_fab',
  backgroundColor: colors.surface,
  foregroundColor: colors.primaryAction,
  ...
);
```

**Trigger.** Tapping the Voice Copilot button on a moving boat in choppy seas or wearing sailing gloves.

**Impact.** Skipper distraction and repeated failed tap attempts while operating a vessel.

**Falsification.** Checked if `RoughSeaModeController` or `HudLayoutMetrics` dynamically scales the button. `FloatingActionButton.small` has fixed sizing in Flutter unless explicitly overridden with a custom `FloatingActionButton` or `RoughSeaMode` wrapper.

**Fix.** Wrap `VoiceCopilotMicButton` in a responsive touch target container that scales to 56dp (normal) and 64dp (Rough Sea Mode).
*Trade-off:* Slightly larger visual footprint on the map HUD.

**Related:** UI-001

---

### UX-002 — Voice command chips mix Finnish and English without explicit language picker

- **Severity:** S3-Low
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/ai/presentation/widgets/voice_copilot_mic_button.dart:18-24`
- **Novel:** yes

**Mechanism.** The quick-action commands list in `VoiceCopilotMicButton` contains 4 Finnish phrases and 1 English phrase ("How deep is the fairway?") mixed together in a single list. When the app is set to Finnish, the English chip is displayed without explanation; when set to English, the Finnish chips remain predominant.

**Evidence.**
```dart
// lib/features/ai/presentation/widgets/voice_copilot_mic_button.dart:18-24
final List<String> _quickCommands = [
  'Kuinka paljon vettä on kapeikossa?',
  'Mikä on lähin suojaisa satama?',
  'Merkitse hyvä ankkuripohja',
  'Mikä on tuuliennuste?',
  'How deep is the fairway?',
];
```

**Trigger.** Opening the Voice Copilot modal in either Finnish or English locale.

**Impact.** Cognitive dissonance and cluttered list of irrelevant language chips for non-bilingual users.

**Falsification.** Checked if `_quickCommands` reads `Localizations.localeOf(context)`. The list is a static field on the state class.

**Fix.** Dynamically filter `_quickCommands` based on `Localizations.localeOf(context).languageCode` or provide a segmented language toggle.
*Trade-off:* Requires localized string arrays in l10n.

**Related:** AI-003

---

### UX-003 — Route exit PopScope dialog lacks clear destructive action contrast

- **Severity:** S3-Low
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/navigation/presentation/screens/route_planner_screen.dart:123-145`
- **Novel:** no

**Mechanism.** When exiting the route planner with unsaved waypoints, the `AlertDialog` displays actions for "Peruuta" (Cancel) and "Hylkää" (Discard). Both buttons use the standard `primaryAction` color token rather than styling the destructive "Hylkää" action with `colors.danger`, increasing the risk of accidental route loss.

**Evidence.**
```dart
// lib/features/navigation/presentation/screens/route_planner_screen.dart:130-145
TextButton(
  onPressed: () => Navigator.of(context).pop(true),
  child: Text('Hylkää', style: TextStyle(color: colors.primaryAction)), // Should be danger
)
```

**Trigger.** Accidentally tapping back/exit while editing a multi-point route.

**Impact.** Accidental loss of an unsaved navigation route due to unclear visual hierarchy between Cancel and Discard.

**Falsification.** Inspected `route_planner_screen.dart:130-145`. Confirmed both action buttons use identical text styling without danger styling.

**Fix.** Style the "Hylkää" action button with `colors.danger`.
*Trade-off:* None.

**Related:** CQ-001

---

## Cross-domain sightings
- Floating HUD pills overlap with forecast slider on narrow screens (UI).
- Static voice responses fail to adapt to boat's actual location (AI).

## Hygiene (low-signal, listed for completeness)
- `lib/features/ai/presentation/widgets/voice_copilot_mic_button.dart:163`: Tooltip text is in Finnish only.

## Open questions
- Is there a voice synthesizer (TTS) planned to read aloud the advisory response to the skipper?

## This team's blind spot
UX auditing tests user flows, contrast ratios, and touch affordances, but cannot measure real sailor stress levels navigating a rock-strewn archipelago in fog.
