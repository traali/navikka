# DATA, STATE & MIGRATIONS AUDIT — DATA

- **run_id:** g37f-001
- **date:** 2026-08-17
- **model:** Gemini 3.7 Flash
- **target:** Sakkoja Marine Safety Navigator @ 604ebd4
- **wave:** 1
- **findings_reported:** 3
- **candidates_discarded:** 11
- **examined:** Drift SQLite database schema (v18), migration paths (`onUpgrade`), DAO transactions, index definitions, foreign key constraints, table cleanup routines, and JSON feature caching.
- **not_examined:** Low-level SQLite binary page fragmentation on physical flash storage.

---

### DATA-001 — VesselSettingsController.saveProfile creates duplicate orphan profiles on every edit

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/vessel/presentation/controllers/vessel_controller.dart:54-83`
- **Novel:** yes

**Mechanism.** `VesselSettingsController.saveProfile()` always calls `_service.createProfile(...)` which performs an `into(vesselProfiles).insert(...)` into the database. `VesselService` does not provide an `updateProfile()` method and `saveProfile()` does not pass the current profile's primary key `id`. Each time a skipper adjusts their draft, cruising speed, or engine specs in Settings and taps "Tallenna", a new row is inserted into SQLite and selected, leaving previous revisions as unselected orphan records indefinitely.

**Evidence.**
```dart
// lib/features/vessel/presentation/controllers/vessel_controller.dart:67-82
state = await AsyncValue.guard(() async {
  final id = await _service.createProfile(
    name: name,
    type: type,
    maxWind: maxWind,
    maxWave: maxWave,
    draft: draft,
    cruisingSpeed: cruisingSpeed,
    hinCode: hinCode,
    engineManufacturer: engineManufacturer,
    engineModel: engineModel,
    fuelType: fuelType,
  );
  await _service.selectProfile(id);
  return _loadProfile();
});
```

**Trigger.** Editing vessel profile details multiple times across app usage sessions.

**Impact.** Continuous accumulation of dead vessel records in SQLite; queries to `vesselDao.getAllProfiles()` return duplicate historical snapshots instead of a single updated profile.

**Falsification.** Checked `VesselDao` in `lib/features/vessel/data/daos/vessel_dao.dart`. `VesselDao` implements `updateProfile(VesselProfilesCompanion profile)` at line 29, but `VesselService` never wraps it and `VesselSettingsController` never invokes it.

**Fix.** In `VesselSettingsController.saveProfile`, check if an active profile exists with a valid `id > 0`; if so, call `_service.updateProfile(id, ...)`; otherwise call `createProfile`.
*Trade-off:* Requires adding `updateProfile` to `VesselService`.

**Related:** TEST-001, ARC-001

---

### DATA-002 — CachedFeatures table lacks TTL expiration cleanup and grows unbounded

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/core/db/app_database.dart:58-67`
- **Novel:** yes

**Mechanism.** `CachedFeatures` stores full GeoJSON payloads for bounding boxes queried across fishing restrictions, waterway features, navigation aids, and speed limits. Because map panning produces unique bounding box keys (e.g. `fishing_restrictions_v2|24.123456,60.123456...`), every map pan writes new rows into `cached_features`. While `WeatherDao._maybeCleanup()` periodically deletes expired weather observations and forecasts, `cached_features` is never pruned by any DAO or background worker, causing the SQLite database file to grow without bound.

**Evidence.**
```dart
// lib/core/db/app_database.dart:58-67
class CachedFeatures extends Table {
  TextColumn get id => text()();
  TextColumn get category => text()();
  DateTimeColumn get cachedAt => dateTime()();
  TextColumn get dataJson => text()();

  @override
  Set<Column> get primaryKey => {id, category};
}
```
Grepped `delete(cachedFeatures)` across the codebase:
- Found only in `DriftContributionRepository.deleteContribution()`.
- Zero automated TTL cleanup queries exist in `WeatherDao` or `AppDatabase`.

**Trigger.** Panning and navigating across the nautical chart over days and weeks of boating.

**Impact.** Bloated local database storage (hundreds of megabytes of obsolete GeoJSON strings) consuming user device storage and slowing down SQLite page cache reads.

**Falsification.** Inspected `WeatherDao._maybeCleanup` in `weather_dao.dart:1020-1080`. Cleanup handles `weather_observations`, `weather_forecasts`, `wave_observations`, and `sea_level_readings`. `cached_features` is not touched.

**Fix.** Add a routine to `_maybeCleanup()` or on app startup:
```dart
await (delete(cachedFeatures)..where((t) => t.cachedAt.isSmallerThanValue(DateTime.now().subtract(const Duration(days: 7))))).go();
```
*Trade-off:* 1 lightweight delete query on background startup.

**Related:** PERF-001

---

### DATA-003 — Fresh installation seeds 3 providers, leaving SYKE to runtime fallback creation

- **Severity:** S3-Low
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/core/db/app_database.dart:321-352`
- **Novel:** yes

**Mechanism.** In `AppDatabase.onCreate`, `_seedProviders()` inserts 3 weather providers (`fmi`, `openweather`, `met_no`). It omits `syke`. In `onUpgrade` (from v11 to v12), `syke` is inserted via SQL migration statement. Consequently, existing upgraded databases have `syke` pre-seeded with ID 4, whereas fresh installs rely on `DriftWeatherStore._getProviderId('syke')` calling `_dao.getOrCreateProvider(...)` at runtime on first fetch, creating diverging provider ID assignments across installs.

**Evidence.**
```dart
// lib/core/db/app_database.dart:321-352
Future<void> _seedProviders() async {
  await batch((b) {
    b.insert(weatherProviders, WeatherProvidersCompanion.insert(code: 'fmi', ...));
    b.insert(weatherProviders, WeatherProvidersCompanion.insert(code: 'openweather', ...));
    b.insert(weatherProviders, WeatherProvidersCompanion.insert(code: 'met_no', ...));
    // Missing syke!
  });
}
```

**Trigger.** Fresh installation of Sakkoja on a clean device.

**Impact.** Minor asymmetry in database primary keys across clean installs vs upgraded installs.

**Falsification.** Checked `DriftWeatherStore._getProviderId('syke')`. It defensively calls `_dao.getOrCreateProvider`, so queries do not crash, but the seed table remains incomplete on `onCreate`.

**Fix.** Add `syke` to `_seedProviders()` in `AppDatabase`.
*Trade-off:* None.

**Related:** none

---

## Cross-domain sightings
- `RoutePlannerController.saveRoute()` does not catch database transaction errors (CQ).
- Map HUD sensor stream re-renders at 100 Hz (PERF).

## Hygiene (low-signal, listed for completeness)
- `lib/core/db/weather_tables.dart:286`: Composite unique keys in `WaterQualityReadings` lack an explicit index name.

## Open questions
- What is the maximum acceptable offline cache storage quota for marine map tiles on mobile?

## This team's blind spot
Data auditing verifies table schemas, migrations, and query semantics, but cannot inspect physical SQLite binary page corruption caused by sudden device power loss while writing.
