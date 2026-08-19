# TESTING & VERIFICATION AUDIT — TEST

- **run_id:** g37f-001
- **date:** 2026-08-17
- **model:** Gemini 3.7 Flash
- **target:** Sakkoja Marine Safety Navigator @ 604ebd4
- **wave:** 1
- **findings_reported:** 3
- **candidates_discarded:** 11
- **examined:** 126 test files across `test/`, mocktail definitions, unit tests, widget contracts, fake_async timing assertions, and Playwright e2e test scripts.
- **not_examined:** Hardware sensor integration tests on physical GPS/IMU silicon.

---

### TEST-001 — Test suite asserts initial save but fails to assert consecutive profile updates

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `test/features/vessel/presentation/controllers/vessel_controller_test.dart` (or vessel unit tests)
- **Novel:** yes

**Mechanism.** Existing vessel controller unit tests verify that calling `saveProfile` inserts a profile and marks it as selected. However, no test performs consecutive `saveProfile()` calls with modified attributes to assert that the database row count remains 1 and that `updateProfile` is called. Consequently, 537/537 tests pass with green checkmarks while the production code accumulates duplicate orphan rows upon every profile modification.

**Evidence.**
```bash
$ flutter test
01:06 +537: All tests passed!
```
Inspected `VesselSettingsController.saveProfile`:
```dart
// lib/features/vessel/presentation/controllers/vessel_controller.dart:68-80
final id = await _service.createProfile( ... );
await _service.selectProfile(id);
```
No test asserts that `await service.getAllProfiles()` returns exactly 1 profile after an edit.

**Trigger.** Running `flutter test` — suite gives false confidence that vessel editing is fully tested.

**Impact.** Critical database bloat defects ship to production despite 100% passing automated test runs.

**Falsification.** Checked all test files in `test/features/vessel/`. Tests check initial creation and selection, but never check row count idempotency across multiple edits.

**Fix.** Add a state transition test: create profile $\to$ modify draft $\to$ save profile $\to$ assert `getAllProfiles().length == 1` and `selectedProfile.id` remains stable.
*Trade-off:* 1 additional unit test.

**Related:** DATA-001, ARC-001

---

### TEST-002 — Acoustic AI tests assert pure static math while pipeline has zero live input

- **Severity:** S3-Low
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `test/features/ai/domain/services/acoustic_marine_ai_test.dart:1-90`
- **Novel:** yes

**Mechanism.** `acoustic_marine_ai_test.dart` contains 10 thorough unit tests verifying `AcousticMarineAIService.decodeSignal` and `diagnoseEngineSound` against exact millisecond and Hz threshold arrays. These tests give the impression of a verified sound analysis feature, but the underlying service has no microphone listener, no audio buffer processor, and is unreferenced by the rest of the application.

**Evidence.**
```dart
// test/features/ai/domain/services/acoustic_marine_ai_test.dart:9-14
final signal = AcousticMarineAIService.decodeSignal(
  pulseDurationsSeconds: [4.5],
  gapDurationsSeconds: [],
);
expect(signal, equals(FoghornSignalType.underwayPower));
```

**Trigger.** Reviewing test reports and coverage metrics for Marine AI features.

**Impact.** High coverage metrics mask the fact that acoustic listening is completely disconnected from real hardware audio input.

**Falsification.** Grepped `AcousticMarineAIService` across `lib/` and `test/`. The service is tested only via hardcoded synthetic lists and never integrated into any UI or platform audio stream.

**Fix.** Document `AcousticMarineAIService` as an experimental domain model or wire it into a real microphone audio stream.
*Trade-off:* Clarifies test coverage boundaries.

**Related:** CQ-002, AI-003

---

### TEST-003 — Weather sync controller test suite lacks test for CORS proxy retry domain mutation

- **Severity:** S2-Medium
- **Confidence:** C2-Reasoned
- **Effort:** E1-Hours
- **Location:** `test/core/network/web_proxy_interceptor_test.dart`
- **Novel:** yes

**Mechanism.** Unit tests for `WebProxyInterceptor` test the interceptor in isolation using a standalone `Dio` instance. They verify that `options.path` is rewritten to `proxyUrl?url=...`. However, no integration test combines `RateLimitInterceptor`, `RetryInterceptor`, and `WebProxyInterceptor` in a single pipeline to verify that a retried request retains its original domain rate-limiting bucket.

**Evidence.**
```dart
// test/core/network/web_proxy_interceptor_test.dart
// Tests WebProxyInterceptor in isolation without RateLimitInterceptor chained before it.
```

**Trigger.** Simulating network retry failures on web builds.

**Impact.** Inter-interceptor mutation bugs cannot be caught by unit tests.

**Falsification.** Checked `test/core/network/` test files. Each interceptor is tested in isolation with mock handlers.

**Fix.** Add a composite interceptor chain test verifying that `RateLimitInterceptor` preserves upstream domain counters during Dio request retries on Web.
*Trade-off:* 1 composite integration test.

**Related:** SEC-003, SEAM-001

---

## Cross-domain sightings
- `WaveImpactAiService` emits 100 Hz events to UI without throttle (PERF).
- `CachedFeatures` lacks TTL deletion in database (DATA).

## Hygiene (low-signal, listed for completeness)
- `test/core/config/env_test.dart`: Tests default environment fallback string values.

## Open questions
- Are there plans to add Playwright E2E tests for the offline PWA cache fallback?

## This team's blind spot
Testing auditing examines test structures, assertions, and mock drift, but cannot verify whether physical sensors on moving vessels produce noisy data that fails heuristic thresholds.
