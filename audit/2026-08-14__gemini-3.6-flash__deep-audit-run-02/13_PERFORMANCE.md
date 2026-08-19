# PERFORMANCE & COST AUDIT — PERF

- **run_id:** deep-audit-run-02
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `c4492cc`
- **wave:** 1
- **findings_reported:** 2
- **candidates_discarded:** 10
- **examined:** `lib/features/tracking/`, `lib/features/weather/presentation/widgets/`, `lib/core/db/daos/`
- **not_examined:** GPU shader compilation timings on real physical iOS/Android devices

---

### PERF-001 — TrackRepository Auto-Dispose Defeats SQLite 50-Point Batch Buffer

- **Severity:** S1-High
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/tracking/data/repositories/track_repository.dart:180-185`
- **Novel:** yes

**Mechanism.** `TrackRepository` maintains a 50-point in-memory buffer (`_maxBufferSize = 50`) to batch SQLite point insertions. However, `trackRepositoryProvider` is declared as an `autoDispose` provider without `keepAlive: true`. In `ActiveTrackNotifier`, points are recorded via `ref.read(trackRepositoryProvider).addPoint(...)`. Because `ref.read` does not maintain a subscription, Riverpod disposes `TrackRepository` immediately after the microtask, triggering `ref.onDispose(repo.dispose)` → `repo.flush()`. This flushes every single GPS coordinate individually, increasing DB write operations by 50x.

**Evidence.**
```dart
// lib/features/tracking/data/repositories/track_repository.dart:180
@riverpod
TrackRepository trackRepository(Ref ref) {
  final repo = TrackRepository(ref.watch(appDatabaseProvider));
  ref.onDispose(repo.dispose);
  return repo;
}
```

**Trigger.** Recording a GPS track during navigation (1Hz location updates).

**Impact.** 50x increase in SQLite disk write transactions, CPU thread jank, and excessive battery drain on mobile devices.

**Falsification.** Checked `ActiveTrackNotifier` to see if `ref.watch(trackRepositoryProvider)` is held; confirmed only `ref.read` is used.

**Fix.** Add `@Riverpod(keepAlive: true)` to `trackRepositoryProvider` so the repository instance lives throughout the recording session.

**Related:** ARC-001, DATA-001

---

### PERF-002 — Per-Point Heap Allocations in WaveHeightPainter Canvas Loop

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/weather/presentation/widgets/wave_height_painter.dart:38-42`
- **Novel:** yes

**Mechanism.** Inside `WaveHeightPainter.paint()`, a new `Paint()` object and a new `RadialGradient().createShader(rect)` shader instance are instantiated for *every single visible wave point* in a `for` loop. When rendering a dense wave field (e.g. 500+ points), this generates thousands of transient allocations per repaint frame, triggering GC pauses.

**Evidence.**
```dart
    for (final point in field.points) {
      ...
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..shader = RadialGradient(
          colors: [color, color.withValues(alpha: 0)],
        ).createShader(rect);

      canvas.drawCircle(center, radius, paint);
    }
```

**Trigger.** Displaying wave height contours over a large map region.

**Impact.** Garbage collection churn and frame rate stutter on low-end devices during map panning.

**Falsification.** Checked if `Paint` is reused across loop iterations; confirmed a new `Paint()` is created on every point.

**Fix.** Pre-allocate a single `Paint` instance outside the loop (`final paint = Paint()..style = PaintingStyle.fill;`) and update only its `shader` property per point.

**Related:** CQ-002, UI-001

---

## Cross-domain sightings
- `lib/features/navigation_aids/presentation/widgets/navigation_aids_layer_widget.dart`: Marker list rebuilt on every camera frame.

## Hygiene (low-signal, listed for completeness)
- `lib/core/db/daos/tile_dao.dart`: SQLite query uses select * without explicit column pruning.

## Open questions
- What is the peak memory consumption of tile caching when zooming rapidly through levels 10 to 15?

## This team's blind spot
Performance analysis measures algorithmic complexity and allocation sites, but cannot measure actual hardware thermal throttling without device profilers.
