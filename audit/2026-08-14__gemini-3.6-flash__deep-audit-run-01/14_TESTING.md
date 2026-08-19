# TESTING & VERIFICATION AUDIT — TEST

- **run_id:** deep-audit-run-01
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `a8aa5a4`
- **wave:** 1
- **findings_reported:** 1
- **candidates_discarded:** 11
- **examined:** `test/`, `e2e/`, `pubspec.yaml`
- **not_examined:** Platform integration tests requiring physical hardware

---

### TEST-001 — Test Suite Misses Downstream Error Propagation on Provider Failures

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `test/features/speed_limits/presentation/providers/`
- **Novel:** yes

**Mechanism.** Unit test coverage for speed limits tests the happy path and empty list returns, but does not verify behavior when `speedLimitsProvider` emits `AsyncValue.error`. Downstream consumers (e.g. `displayedSpeedLimits`) contain logic to swallow errors (`.value ?? []`), and the test suite passes even when error contracts change.

**Evidence.**
```dart
// test/features/speed_limits/presentation/providers/speed_alert_notifier_test.dart
// All test cases mock successful Right(zones) returns; 0 test cases verify Left(Failure) behavior.
```

**Trigger.** Any database or network error in speed limit data loading.

**Impact.** Silent regression of error boundary propagation without test suite detection.

**Falsification.** Checked full test suite output (`478 passed`); confirmed zero tests assert `AsyncError` handling on `displayedSpeedLimitsProvider`.

**Fix.** Add unit test cases verifying that `displayedSpeedLimitsProvider` throws or propagates `AsyncError` when repository fails.

**Related:** CQ-001

---

## Cross-domain sightings
- `e2e/`: Playwright tests run against live site `https://sakkoja.pages.dev`.

## Hygiene (low-signal, listed for completeness)
- `test/core/db/app_database_migration_test.dart`: Missing test case for incremental migration from v15 to v17.

## Open questions
- Are E2E tests executing in headless Chrome CI with mocked GPS positions?

## This team's blind spot
Testing analysis evaluates test assertions and mock fidelity, but cannot prove that green unit tests guarantee zero runtime crashes on all real device variants.
