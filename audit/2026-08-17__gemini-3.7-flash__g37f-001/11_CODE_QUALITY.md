# CODE QUALITY & CORRECTNESS AUDIT — CQ

- **run_id:** g37f-001
- **date:** 2026-08-17
- **model:** Gemini 3.7 Flash
- **target:** Sakkoja Marine Safety Navigator @ 604ebd4
- **wave:** 1
- **findings_reported:** 3
- **candidates_discarded:** 14
- **examined:** Logic flows, error handling boundaries, resource disposal, animation controllers, nullability assertions, and exception propagation across `lib/features/*`.
- **not_examined:** Low-level C/C++ FFI bindings inside `sqlite3` and `sensors_plus` native binaries.

---

### CQ-001 — Uncaught exception in RoutePlannerScreen.saveRoute crashes modal workflow

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/navigation/presentation/screens/route_planner_screen.dart:106-114`
- **Novel:** yes

**Mechanism.** In `RoutePlannerScreen._showSaveDialog`, `ref.read(routePlannerControllerProvider.notifier).saveRoute(name)` is called without a `try-catch` wrapper. In `RoutePlannerController.saveRoute()`, the `try/finally` block does not catch exceptions thrown by `RouteService.createRoute()`. If an SQLite constraint error, database lock, or disk I/O failure occurs, the unhandled error escapes the Flutter gesture handler, preventing the UI from notifying the skipper and leaving the modal dialog in an ambiguous hanging state.

**Evidence.**
```dart
// lib/features/navigation/presentation/screens/route_planner_screen.dart:106-114
if (name != null && mounted) {
  await ref.read(routePlannerControllerProvider.notifier).saveRoute(name);
  if (mounted) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Reitti tallennettu')));
    context.pop();
  }
}
```

**Trigger.** Saving a route when the underlying SQLite transaction fails (e.g. storage full, locked DB, or illegal character constraint).

**Impact.** The route is not saved, the user receives no feedback about why the operation failed, and the route editor remains open without error notification.

**Falsification.** Inspected `RoutePlannerController.saveRoute`:
```dart
// lib/features/navigation/presentation/controllers/route_planner_controller.dart:306-314
state = state.copyWith(isSaving: true);
try {
  await _service.createRoute(name, state.waypoints);
  ++_metricsToken;
  state = RoutePlannerState.initial();
} finally {
  state = state.copyWith(isSaving: false);
}
```
Confirmed `saveRoute` contains only `try/finally` with no `catch` block or error state emission in `RoutePlannerState`.

**Fix.** Wrap `_service.createRoute` in `RoutePlannerController` with structured error handling, update `RoutePlannerState` with an error message, and show an error SnackBar in `RoutePlannerScreen`.
*Trade-off:* Adds error field to `RoutePlannerState`.

**Related:** none

---

### CQ-002 — Indefinitely repeating AnimationController in VoiceCopilotMicButton drives no visual tree

- **Severity:** S3-Low
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/ai/presentation/widgets/voice_copilot_mic_button.dart:27-33`
- **Novel:** yes

**Mechanism.** `_VoiceCopilotMicButtonState` initializes an `AnimationController` with `..repeat(reverse: true)` in `initState()`. However, in the `build()` method, `FloatingActionButton.small` renders a static `Icon(Icons.mic)` and static `CircleBorder` without using `AnimatedBuilder`, `FadeTransition`, or `_animController.value`. The ticker fires at the device refresh rate (60-120 Hz) continuously on the main map cockpit without altering any rendered pixel.

**Evidence.**
```dart
// lib/features/ai/presentation/widgets/voice_copilot_mic_button.dart:29-32
_animController = AnimationController(
  vsync: this,
  duration: const Duration(milliseconds: 1200),
)..repeat(reverse: true);

// lib/features/ai/presentation/widgets/voice_copilot_mic_button.dart:151-167
@override
Widget build(BuildContext context) {
  final colors = context.colors;
  return FloatingActionButton.small(
    heroTag: 'voice_copilot_fab',
    backgroundColor: colors.surface,
    foregroundColor: colors.primaryAction,
    shape: CircleBorder(
      side: BorderSide(
        color: colors.primaryAction.withValues(alpha: 0.5),
        width: 1.5,
      ),
    ),
    tooltip: 'Hei Kippari (Puheohjaus)',
    onPressed: () => _showVoiceModal(context),
    child: const Icon(Icons.mic, size: 20),
  );
}
```

**Trigger.** Displaying the map screen with Voice Copilot enabled.

**Impact.** Continuous background frame ticker execution consuming CPU and battery power without producing visual output.

**Falsification.** Grepped `_animController` usage across `voice_copilot_mic_button.dart`. It is referenced only in `initState`, `dispose`, and its declaration.

**Fix.** Either attach `_animController` to an `AnimatedBuilder` to create a pulsing halo animation around the mic icon or remove `_animController` and `SingleTickerProviderStateMixin` entirely.
*Trade-off:* Removing simplifies code; attaching adds mild GPU raster cost.

**Related:** PERF-001

---

### CQ-003 — In-flight request map key collision between distinct provider parameters

- **Severity:** S3-Low
- **Confidence:** C2-Reasoned
- **Effort:** E1-Hours
- **Location:** `lib/features/weather/data/datasources/openweather_data_source.dart:44-58`
- **Novel:** yes

**Mechanism.** In `OpenWeatherDataSourceImpl`, in-flight deduplication keys are generated using `current_${lat.toStringAsFixed(4)},${lon.toStringAsFixed(4)}`. If the application triggers a fetch for current weather with differing query parameters (such as units or language), the key collapses them into the identical future. While current endpoints use constant units/lang, future multi-parameter callers would silently receive mismatched in-flight data.

**Evidence.**
```dart
// lib/features/weather/data/datasources/openweather_data_source.dart:44
final key = 'current_${lat.toStringAsFixed(4)},${lon.toStringAsFixed(4)}';
```

**Trigger.** Requesting current weather for identical coordinates with different query configurations within an overlapping HTTP round-trip window.

**Impact.** In-flight request deduplication could return cached results from a request with different options.

**Falsification.** Checked if language or units are currently dynamic in `OpenWeatherDataSourceImpl`. They are hardcoded to `OpenWeatherConstants.units` and `OpenWeatherConstants.lang`. Risk is currently latent.

**Fix.** Include query parameters in the deduplication key string.
*Trade-off:* Slightly longer key string allocation.

**Related:** none

---

## Cross-domain sightings
- `waveImpactAiServiceProvider` stream emissions trigger complete HUD widget rebuilds without debounce (PERF).
- Missing `updateProfile` method in `VesselService` causes profile record bloat (DATA).

## Hygiene (low-signal, listed for completeness)
- `lib/features/ai/domain/services/acoustic_marine_ai_service.dart:163`: `dispose()` method in orphan service uncalled in application code.

## Open questions
- Was the pulsing mic animation intended to visually signal active listening mode on the map HUD?

## This team's blind spot
Code Quality analyzes syntax, exception paths, and control structures, but cannot determine whether third-party native platform plugins behave correctly under OS-level permission revocations.
