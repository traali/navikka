# CODE QUALITY & CORRECTNESS AUDIT — CQ

- **run_id:** deep-audit-run-01
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `a8aa5a4`
- **wave:** 1
- **findings_reported:** 2
- **candidates_discarded:** 10
- **examined:** `lib/features/*/data/datasources/`, `lib/features/*/presentation/controllers/`, `lib/core/network/`
- **not_examined:** Generated `.g.dart` and `.freezed.dart` boilerplate

---

### CQ-001 — Offline Map Download Error Path Leaves Orphaned Database Region

- **Severity:** S1-High
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/map/presentation/controllers/offline_download_controller.dart:78-84`
- **Novel:** yes

**Mechanism.** `startDownload` inserts an `OfflineRegion` with `downloadStatus: 1` (Downloading) and awaits `TileDownloadManager.downloadRegion`. If `downloadRegion` throws an exception (e.g. network failure), the `catch` block shows a `SnackBar` but does not invoke `tileDao.deleteRegion(regionId)` or update `downloadStatus`. The region remains permanently stuck in the database as "Downloading".

**Evidence.**
```dart
      await ref.read(tileDownloadManagerProvider.notifier).downloadRegion(...);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.areaSaveFailed)));
      }
    }
```

**Trigger.** Any network error, timeout, or user cancellation during an offline region download.

**Impact.** Database bloat and permanent UI state corruption showing perpetual downloading indicators.

**Falsification.** Checked `tileDao` methods to see if background worker cleans up stale downloads on app launch; no cleanup process exists.

**Fix.** Add `tileDao.deleteRegion(regionId)` inside the `catch` block on failure.

**Related:** DATA-001, OPS-001

---

### CQ-002 — Stale Start Angle in Mid-Animation Wind Arrow Updates

- **Severity:** S3-Low
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/weather/presentation/widgets/animated_wind_arrow.dart:45-66`
- **Novel:** yes

**Mechanism.** `AnimatedWindArrow.didUpdateWidget` creates a rotation tween from `_currentAngle` to `target`. `_currentAngle` is updated only inside `_controller.forward().then(...)` upon animation completion. If a new wind direction update arrives while `_controller.isAnimating` is true, the new tween begins from the stale initial angle instead of the current animated value, causing a visual snap-back jump.

**Evidence.**
```dart
  @override
  void didUpdateWidget(AnimatedWindArrow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.directionDegrees != widget.directionDegrees) {
      final start = _currentAngle; // Stale if animating!
```

**Trigger.** Frequent wind direction updates arriving faster than the 600ms animation duration.

**Impact.** Visual jitter/snap-back on wind direction indicators in gusty marine conditions.

**Falsification.** Checked if `_animation.value` is read; confirmed `_currentAngle` is used directly instead of `_animation.value`.

**Fix.** Update `_currentAngle = _animation.value` if `_controller.isAnimating` before constructing the new `Tween`.

**Related:** UI-001

---

## Cross-domain sightings
- `lib/features/speed_limits/presentation/providers/displayed_speed_limits_provider.dart`: Error handling converts AsyncError to empty list.

## Hygiene (low-signal, listed for completeness)
- `lib/features/fishing/domain/services/catch_size_validator.dart`: Unused local variable in catch validation loop.

## Open questions
- Are tile download retries handled at Dio network layer or batch download level?

## This team's blind spot
Code quality inspection reads static control flows and error handling logic, but cannot simulate real hardware interrupts or OS-level process kills mid-transaction.
