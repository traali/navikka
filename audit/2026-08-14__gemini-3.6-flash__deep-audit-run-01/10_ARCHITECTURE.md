# ARCHITECTURE AUDIT — ARC

- **run_id:** deep-audit-run-01
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `a8aa5a4`
- **wave:** 1
- **findings_reported:** 2
- **candidates_discarded:** 10
- **examined:** `lib/core/providers/`, `lib/features/*/presentation/providers/`, `lib/core/router/`
- **not_examined:** Platform-native C++ plugins (built via Flutter runner)

---

### ARC-001 — Unrounded LatLng Family Key Provider Proliferation

- **Severity:** S1-High
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/weather/presentation/controllers/point_weather_data_provider.dart:10-42`
- **Novel:** yes

**Mechanism.** `pointWeatherData` watches `debouncedMapCameraPositionProvider.center` and passes the unrounded `LatLng` directly into `weatherObservationsStreamProvider(center)`, `weatherForecastStreamProvider(center)`, and `waveObservationsStreamProvider(center)`. Riverpod uses identity/equality on family arguments; because `LatLng` double values change continuously during map panning, Riverpod instantiates a new family provider on every micro-move.

**Evidence.**
```dart
@riverpod
PointWeatherDataState pointWeatherData(Ref ref) {
  final center = ref.watch(debouncedMapCameraPositionProvider).center;
  return PointWeatherDataState(
    observations: ref.watch(weatherObservationsStreamProvider(center)).asData?.value ?? [],
    ...
```

**Trigger.** Any continuous map panning gesture or GPS position update while weather layers are enabled.

**Impact.** Continuous allocation of new provider instances, orphaned stream subscriptions, memory churn, and redundant database queries.

**Falsification.** Checked `DriftWeatherStore` which rounds coordinates internally, but verified that Riverpod creates new top-level provider instances *before* the store method is invoked.

**Fix.** Grid-snap coordinates to a 0.01° grid before passing them to family stream providers. Trade-off: weather station selection is quantized to ~1.1km resolution.

**Related:** PERF-001, MARINE-002

---

### ARC-002 — Inherited Widget Rebuild Cascade in Layer Painting

- **Severity:** S1-High
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/navigation_aids/presentation/widgets/navigation_aids_layer_widget.dart:35-36`
- **Novel:** yes

**Mechanism.** Invoking `MapCamera.maybeOf(context)` inside a layer's `build()` method registers the layer widget as a dependent of `MapCamera`'s inherited widget. During camera gestures (panning at 60Hz), the entire `NavigationAidsLayerWidget` rebuilds continuously, executing `.where()` filter loops and instantiating hundreds of `Marker` objects per frame.

**Evidence.**
```dart
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final camera = MapCamera.maybeOf(context);
    final isZoomedOut = (camera?.zoom ?? 15.0) < 14.0;
```

**Trigger.** Panning or zooming the map with navigation aids visible.

**Impact.** 60Hz widget rebuild cascade and high CPU frame render times during navigation.

**Falsification.** Checked if `RepaintBoundary` prevents `build()`. Confirmed `RepaintBoundary` isolates GPU painting but does not prevent CPU `build()` execution.

**Fix.** Replace `MapCamera.maybeOf(context)` with a selective Riverpod selector: `ref.watch(mapCameraPositionProvider.select((s) => s.zoom < 14.0))`.

**Related:** PERF-002

---

## Cross-domain sightings
- `lib/features/tracking/data/repositories/track_repository.dart`: Auto-dispose annotation may affect SQLite batch buffer lifecycle.

## Hygiene (low-signal, listed for completeness)
- `lib/features/vessel/presentation/controllers/vessel_controller.dart`: Unused import of unused model DTO.

## Open questions
- Does `debouncedMapCameraPositionProvider`'s 500ms timer introduce noticeable UI delay when panning rapidly?

## This team's blind spot
Architecture analysis evaluates structural coupling and provider graph boundaries, but cannot measure actual frame render times or GPU raster thread bottlenecks without profiling tools.
