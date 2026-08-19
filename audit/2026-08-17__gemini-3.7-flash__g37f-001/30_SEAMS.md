# CROSS-DOMAIN SEAMS AUDIT — SEAM

- **run_id:** g37f-001
- **date:** 2026-08-17
- **model:** Gemini 3.7 Flash
- **target:** Sakkoja Marine Safety Navigator @ 604ebd4
- **wave:** 2
- **findings_reported:** 3
- **candidates_discarded:** 8
- **examined:** Inter-domain boundaries between Architecture, Security, Performance, Operability, Data persistence, and Marine Safety AI.
- **not_examined:** External Cloudflare edge routing DNS propagation latencies.

---

### SEAM-001 — Network Interceptor Pipeline Race: WebProxy Path Mutation vs Rate Limiter Attribution

- **Severity:** S1-High
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/core/providers/core_providers.dart:49-108` & `lib/core/network/`
- **Novel:** yes

**Mechanism.** In `core_providers.dart`, `RateLimitInterceptor` (index 0) relies on `options.uri.host` to bucket domain quotas, while `WebProxyInterceptor` (index 2) mutates `options.path` to point to the Cloudflare Worker. When `RetryInterceptor` (index 1) retries a failed request, Dio dispatches the mutated `RequestOptions` through the entire interceptor chain again. On retry, `options.uri.host` is now the proxy worker's host (`sakkoja-cors-proxy.sakkoja.workers.dev`), not the original upstream host (`opendata.fmi.fi`). Consequently, the rate limiter misattributes all retried traffic across every weather API to a single global bucket (`defaultConfig: 20 req / 10s`), causing retries of one provider to aggressively throttle live requests to completely different providers.

**Evidence.**
```dart
// lib/core/providers/core_providers.dart:49-108
dio.interceptors.add(RateLimitInterceptor( ... ));
dio.interceptors.add(RetryInterceptor( ... ));
if (kIsWeb) {
  dio.interceptors.add(WebProxyInterceptor());
}
```
In `WebProxyInterceptor.onRequest`:
```dart
// lib/core/network/web_proxy_interceptor.dart:86-94
final newUrl = '$proxyUrl?url=${Uri.encodeComponent(targetUrl)}';
options.extra['original_url'] = targetUrl;
options.baseUrl = '';
options.path = newUrl;
```
In `RateLimitInterceptor.onRequest`:
```dart
// lib/core/network/rate_limit_interceptor.dart:79-82
final domain = options.uri.host;
final config = domainConfigs[domain] ?? defaultConfig;
```

**Trigger.** Any transient 5xx HTTP error or timeout from an upstream provider (e.g. FMI or MET Norway) occurring in a Web browser deployment.

**Impact.** Inter-service cascading denial-of-service on the client: retries against FMI block live OpenWeather and SYKE water quality updates from reaching the skipper's screen.

**Falsification.** Traced the exact Dio request lifecycle on retry:
1. `dio.get('https://opendata.fmi.fi/...')`
2. `RateLimitInterceptor` logs request under `opendata.fmi.fi` (allowed: 200/5m).
3. `WebProxyInterceptor` changes `options.path` to `https://sakkoja-cors-proxy...`.
4. Upstream request fails with 502 Bad Gateway.
5. `RetryInterceptor` executes retry via `dio.fetch(requestOptions)`.
6. Interceptor chain runs again: `RateLimitInterceptor` now reads `options.uri.host` = `sakkoja-cors-proxy.sakkoja.workers.dev`.
7. Host is not in `domainConfigs` $\to$ evaluated against `defaultConfig` (20 req / 10s).
8. After 20 retries, all proxied network calls across the whole app are blocked for 10 seconds.

**Fix.** In `RateLimitInterceptor.onRequest`, inspect `options.extra['original_url']` first:
```dart
final originalUrl = options.extra['original_url'] as String?;
final domain = originalUrl != null ? Uri.tryParse(originalUrl)?.host ?? options.uri.host : options.uri.host;
```
*Trade-off:* 2 lines of defensive logic in `RateLimitInterceptor`.

**Related:** SEC-001, OPS-001

---

### SEAM-002 — Asynchronous Settings Initialization vs Hardware Sensor Lifecycle Desynchronization

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/core/settings/presentation/providers/ai_settings_provider.dart:15-35` & `lib/features/ai/presentation/providers/wave_impact_provider.dart:4-9`
- **Novel:** yes

**Mechanism.** `AiSettingsNotifier.build()` synchronously returns `const AiFeatureSettings()` (all features `true`) while scheduling an unawaited async load. Meanwhile, `waveImpactAiServiceProvider` is a root singleton provider that calls `service.start()` upon creation without checking `aiSettingsProvider`. On app startup, `MapScreen` mounts `WaveImpactHudWidget` (because `waveImpactAiEnabled` is initially evaluated as `true`), which triggers `waveImpactAiServiceProvider` to open unthrottled hardware accelerometer streams (100 Hz). When `_loadPreferences()` finally resolves 200ms later and sets `waveImpactAiEnabled = false`, the HUD widget is removed from the widget tree, but the underlying `waveImpactAiServiceProvider` is never disposed, leaving the 100 Hz hardware sensor listener running in the background for the remainder of the session.

**Evidence.**
```dart
// lib/core/settings/presentation/providers/ai_settings_provider.dart:15-18
@override
AiFeatureSettings build() {
  _loadPreferences(); // Unawaited!
  return const AiFeatureSettings(); // Returns all-true!
}

// lib/features/ai/presentation/providers/wave_impact_provider.dart:4-9
final waveImpactAiServiceProvider = Provider<WaveImpactAiService>((ref) {
  final service = WaveImpactAiService();
  service.start(); // Starts sensor stream immediately!
  ref.onDispose(service.dispose);
  return service;
});
```

**Trigger.** Launching the app when the skipper has toggled "Wave Roughness AI" OFF in Settings.

**Impact.** The app continues to read device motion sensors at 100 Hz, consuming battery and CPU cycles despite the skipper explicitly turning off the feature.

**Falsification.** Traced provider lifecycles from `main.dart` through `map_screen.dart`. Because `waveImpactAiServiceProvider` is not `autoDispose` and `service.stop()` is not called when the setting turns false, the hardware stream remains open indefinitely.

**Fix.** Refactor `waveImpactAiServiceProvider` to watch `aiSettingsProvider.select((s) => s.waveImpactAiEnabled)` and dynamically start or stop the service:
```dart
final waveImpactAiServiceProvider = Provider<WaveImpactAiService>((ref) {
  final isEnabled = ref.watch(aiSettingsProvider.select((s) => s.waveImpactAiEnabled));
  final service = WaveImpactAiService();
  if (isEnabled) service.start();
  ref.onDispose(service.dispose);
  return service;
});
```
*Trade-off:* 3 lines of reactive binding.

**Related:** ARC-001, ARC-003, PERF-001

---

### SEAM-003 — Domain Entity Immutability vs Data Access Object Update Contract Mismatch

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/vessel/domain/services/vessel_service.dart:21-51` & `lib/features/vessel/presentation/controllers/vessel_controller.dart:67-82`
- **Novel:** yes

**Mechanism.** The Architecture team designed `VesselEntity` as an immutable domain entity with clean mapping between DTOs and domain models. However, the Data layer implemented `VesselDao.updateProfile` expecting a Drift `VesselProfilesCompanion`, while `VesselService` exposed only `createProfile()`. The presentation layer (`VesselSettingsController`), finding no update method on `VesselService`, called `createProfile()` on every save operation. The architectural isolation between presentation and data layer prevented the controller from accessing `VesselDao.updateProfile` directly, silently converting every user profile edit into a row insertion.

**Evidence.**
```dart
// lib/features/vessel/presentation/controllers/vessel_controller.dart:68-80
final id = await _service.createProfile( ... );
await _service.selectProfile(id);
```
`VesselService` has:
- `getAllProfiles()`
- `getSelectedProfile()`
- `createProfile()`
- `selectProfile()`
- (Missing `updateProfile()`)

**Trigger.** Any profile edit in the Settings/Vessel screen.

**Impact.** Unbounded growth of orphan vessel profile records in SQLite; UI displays duplicate historical profiles if `getAllProfiles()` is queried.

**Falsification.** Inspected `VesselDao` in `lib/features/vessel/data/daos/vessel_dao.dart:29`. `updateProfile` exists in `VesselDao` but was never bridged into `VesselService`.

**Fix.** Add `updateProfile(int id, ...)` to `VesselService` and call it from `VesselSettingsController.saveProfile()` when an existing profile is being edited.
*Trade-off:* Completes the CRUD contract across domain and presentation layers.

**Related:** DATA-001, TEST-001

---

## Cross-Domain Contradictions & Adjudication

### Contradiction 1: Cloudflare CORS Proxy Security vs Client Query Parameters
- **SEC Team Claim (SEC-001)**: The client query parameter loop overwrites server-injected API keys.
- **OPS Team Claim (OPS-001)**: Interceptor re-writing alters domain attribution during retries.
- **Adjudication**: Both teams identified facets of the same architectural seam: `cloudflare-worker/src/index.js` and `WebProxyInterceptor` perform two-way query string transformations without preserving clean parameter namespaces. Fixing parameter precedence in the Cloudflare Worker and preserving `original_url` in Dio resolves both issues simultaneously.

---

## Hygiene (low-signal, listed for completeness)
- `lib/features/navigation/presentation/controllers/route_planner_controller.dart:186`: Isolate `compute()` maps parameters across isolate memory boundaries without typed envelopes.

## Open questions
- Should Dio request retries be disabled entirely for real-time marine chart tile requests to avoid stale tile flashes?

## This team's blind spot
The Seam team specializes in interface contracts between modules, but cannot predict failure modes when external cloud providers (Cloudflare / FMI) change their API behaviors simultaneously.
