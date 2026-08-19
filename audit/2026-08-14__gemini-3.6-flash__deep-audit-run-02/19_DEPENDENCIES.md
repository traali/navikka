# DEPENDENCIES & SUPPLY CHAIN AUDIT — DEP

- **run_id:** deep-audit-run-02
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `c4492cc`
- **wave:** 1
- **findings_reported:** 1
- **candidates_discarded:** 11
- **examined:** `pubspec.yaml`, `pubspec.lock`, `cloudflare-worker/package.json`, `e2e/package.json`
- **not_examined:** Transitive C/C++ libraries in native Flutter engine binaries

---

### DEP-001 — Unused Legacy Dependency in Core Pubspec

- **Severity:** S3-Low
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `pubspec.yaml:45`
- **Novel:** no

**Mechanism.** `pubspec.yaml` includes `cupertino_icons: ^1.0.8` as an explicit direct dependency. Grepping the entire application source tree (`lib/`) reveals 0 imports or references to `CupertinoIcons` (all UI components use Material `Icons` or custom SVG/Painters).

**Evidence.**
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8 # 0 imports in lib/
```

**Trigger.** Building and packaging the application binary bundle.

**Impact.** Unnecessary asset bundle size inflation (~280 KB font file embedded in assets).

**Falsification.** Grepped `lib/` for `cupertino_icons` and `CupertinoIcons`; verified zero usage.

**Fix.** Remove `cupertino_icons` from `pubspec.yaml`.

**Related:** PERF-001

---

## Cross-domain sightings
- `e2e/package.json`: Playwright dependency updated to `@playwright/test ^1.51.0`.

## Hygiene (low-signal, listed for completeness)
- `pubspec.yaml`: Caret constraint ranges used across all dependencies.

## Open questions
- Will upcoming `flutter_map` v9 migration deprecate tile layer stream providers?

## This team's blind spot
Dependency auditing scans manifests and lockfiles, but cannot detect malicious zero-day payloads in transitively compiled npm/pub binaries.
