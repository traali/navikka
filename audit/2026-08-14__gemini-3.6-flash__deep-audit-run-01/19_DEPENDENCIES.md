# DEPENDENCIES & SUPPLY CHAIN AUDIT — DEP

- **run_id:** deep-audit-run-01
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `a8aa5a4`
- **wave:** 1
- **findings_reported:** 1
- **candidates_discarded:** 11
- **examined:** `pubspec.yaml`, `pubspec.lock`, `cloudflare-worker/package.json`
- **not_examined:** Transitive C/C++ native dynamic libraries bundled inside Flutter engine plugins

---

### DEP-001 — Verified Dependency Utility for Emergency Calling Hardware Bindings

- **Severity:** S4-Note
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `pubspec.yaml:49`
- **Novel:** yes

**Mechanism.** Prior automated dependency audits flagged `url_launcher` as an unused "ghost dependency". Forensic examination revealed that `url_launcher` is load-bearing: it is directly imported by `lib/features/map/presentation/widgets/emergency_distress_button.dart` to launch native telephone dialing (`tel:02941000` / `tel:112`) for MRCC Turku emergency distress calls. Removing `url_launcher` causes a compilation error and breaks emergency calling.

**Evidence.**
```dart
// lib/features/map/presentation/widgets/emergency_distress_button.dart:4
import 'package:url_launcher/url_launcher.dart';
...
final launched = await launchUrl(uri);
```

**Trigger.** Executing automated dependency pruning without checking cross-feature widget hardware launch bindings.

**Impact.** Prevention of false-positive dependency deletion that would break critical safety features.

**Falsification.** Ran `flutter test test/features/map/presentation/widgets/emergency_distress_button_test.dart`; test fails if `url_launcher` is missing, passes when present.

**Fix.** Retain `url_launcher` in `pubspec.yaml` under active dependencies.

**Related:** MARINE-001

---

## Cross-domain sightings
- `pubspec.yaml`: All core dependencies (`flutter_map: ^8.3.0`, `flutter_riverpod: ^3.3.1`, `drift: ^2.33.0`) updated to current stable releases.

## Hygiene (low-signal, listed for completeness)
- `pubspec.yaml`: Dependencies sorted in strict alphabetical order (A to Z).

## Open questions
- Are Cloudflare Worker Wrangler dependencies pinned in CI pipeline config?

## This team's blind spot
Dependency auditing inspects `pubspec.lock` declarations and import usages, but cannot scan compiled binary native code for zero-day vulnerabilities in underlying operating system libraries.
