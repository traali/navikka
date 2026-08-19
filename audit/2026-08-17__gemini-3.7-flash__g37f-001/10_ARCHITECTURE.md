# ARCHITECTURE AUDIT — ARC

- **run_id:** g37f-001
- **date:** 2026-08-17
- **model:** Gemini 3.7 Flash
- **target:** Sakkoja Marine Safety Navigator @ 604ebd4
- **wave:** 1
- **findings_reported:** 3
- **candidates_discarded:** 11
- **examined:** Clean Architecture layers (`core`, `features/*`), Riverpod provider graphs, dependency injection scopes, isolate boundaries, and domain/data layer isolation rules.
- **not_examined:** Platform-specific native iOS/Android embedding bridges (`ios/Runner/AppDelegate.swift`, `android/app/src/`).

---

### ARC-001 — Unawaited async prefs in build() causes frame-1 state divergence

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/core/settings/presentation/providers/ai_settings_provider.dart:15-35`
- **Novel:** yes

**Mechanism.** `AiSettingsNotifier.build()` returns `const AiFeatureSettings()` synchronously while initiating an unawaited async `_loadPreferences()` future. Any UI widget or service reading `aiSettingsProvider` during the initial build frame receives default values (`true` for all toggles) regardless of the persisted user preferences in `SharedPreferences`. When `_loadPreferences()` finishes, `state` is mutated asynchronously, triggering an unexpected second build cycle and transiently starting unwanted background services.

**Evidence.**
```dart
// lib/core/settings/presentation/providers/ai_settings_provider.dart:15-18
@override
AiFeatureSettings build() {
  _loadPreferences();
  return const AiFeatureSettings();
}
```

**Trigger.** Starting the application when a user previously disabled any AI feature (e.g., Voice Copilot or Wave Roughness AI).

**Impact.** Unwanted sensors (accelerometer/gyroscope) or network AI modules are temporarily initialized on app launch despite being explicitly turned off by the skipper.

**Falsification.** Checked if `AsyncNotifier` was used instead. It is a synchronous `Notifier<AiFeatureSettings>`. Checked if `_loadPreferences()` is awaited before `runApp()`. In `main.dart`, `sharedPreferencesProvider` is overridden, but `AiSettingsNotifier` is not pre-seeded synchronously from that instance.

**Fix.** Read `ref.watch(sharedPreferencesProvider)` synchronously inside `AiSettingsNotifier.build()` to initialize state immediately from the already-loaded `SharedPreferences` instance without unawaited futures.
*Trade-off:* Couples `AiSettingsNotifier` to `sharedPreferencesProvider` synchronously.

**Related:** PERF-001, AI-002

---

### ARC-002 — Isolate compute serializes untyped maps instead of structured DTOs

- **Severity:** S3-Low
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/navigation/presentation/controllers/route_planner_controller.dart:180-190`
- **Novel:** yes

**Mechanism.** In `RoutePlannerController._updateStateMetrics`, waypoint entities are disassembled into untyped `Map<String, double>` entries before passing them to `compute(_calculateStatsInIsolate, ...)`. This bypasses domain type-safety and incurs redundant list/map allocations on the main thread prior to spawning the isolate worker, contradicting Clean Architecture type encapsulation.

**Evidence.**
```dart
// lib/features/navigation/presentation/controllers/route_planner_controller.dart:182-189
final waypointsData = waypoints
    .map((w) => {'lat': w.lat, 'lon': w.lon})
    .toList();

final stats = await compute(_calculateStatsInIsolate, {
  'waypoints': waypointsData,
  'cruisingSpeed': cruisingSpeed,
});
```

**Trigger.** Any route planning action (adding, removing, or dragging a waypoint).

**Impact.** Runtime type errors if dictionary keys diverge; small memory overhead from map object allocation per waypoint.

**Falsification.** Checked if `WaypointEntity` contains non-sendable isolate state. `WaypointEntity` contains only primitive numeric and string fields (`lat`, `lon`, `orderIndex`, `label`), making it directly sendable across isolates without manual map conversion.

**Fix.** Pass `List<WaypointEntity>` or a dedicated lightweight Sendable struct directly into `compute()`.
*Trade-off:* Minor struct import in the static top-level isolate function.

**Related:** none

---

### ARC-003 — Global provider scope leaks sensor listening across inactive screens

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/ai/presentation/providers/wave_impact_provider.dart:4-9`
- **Novel:** yes

**Mechanism.** `waveImpactAiServiceProvider` is defined as a non-autoDispose root `Provider<WaveImpactAiService>`. When `WaveImpactHudWidget` is mounted on the map, it accesses this provider which invokes `service.start()`. If the user navigates away from the map screen to Settings, Logbook, or Harbors, the service never stops listening to the underlying hardware accelerometer and gyroscope streams because the provider remains alive indefinitely.

**Evidence.**
```dart
// lib/features/ai/presentation/providers/wave_impact_provider.dart:4-9
final waveImpactAiServiceProvider = Provider<WaveImpactAiService>((ref) {
  final service = WaveImpactAiService();
  service.start();
  ref.onDispose(service.dispose);
  return service;
});
```

**Trigger.** Navigating away from the map view to any auxiliary screen (e.g. `/menu`, `/vessel`, `/logbook`).

**Impact.** Continuous background CPU utilization and battery drain on mobile devices while navigation is not active.

**Falsification.** Checked if `ref.onDispose` is triggered on screen exit. Because `waveImpactAiServiceProvider` is not `autoDispose`, `onDispose` only fires when the entire `ProviderScope` is destroyed (at app termination).

**Fix.** Convert `waveImpactAiServiceProvider` and `waveImpactStateProvider` to `autoDispose` providers or bind `service.start()` / `service.stop()` to the lifecycle of the map screen state.
*Trade-off:* Re-allocates sensor subscriptions when navigating back to the map screen (requires ~50ms sensor stabilization).

**Related:** PERF-001

---

## Cross-domain sightings
- `VesselSettingsController.saveProfile()` always creates a new profile without updating existing rows (DATA).
- `WebProxyInterceptor` URL rewrite interacts unpredictably with `RateLimitInterceptor` on retried requests (SEC/OPS).

## Hygiene (low-signal, listed for completeness)
- `lib/features/ai/domain/services/acoustic_marine_ai_service.dart:57`: Unused orphan class with no provider wiring.

## Open questions
- Is there a requirement for sensor recording to persist across background screen navigation during an active voyage recording?

## This team's blind spot
Architecture checks logical layer boundaries, provider scopes, and data flow contracts, but cannot measure runtime GPU composite raster times or verify whether specific mobile platforms throttle background sensor streams automatically.
