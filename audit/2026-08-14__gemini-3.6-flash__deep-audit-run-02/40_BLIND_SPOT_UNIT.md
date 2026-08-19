# BLIND SPOT UNIT AUDIT — Ω — 40_BLIND_SPOT_UNIT

- **run_id:** deep-audit-run-02
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `c4492cc`
- **wave:** 3
- **findings_reported:** 5
- **candidates_discarded:** 7
- **examined:** Boring files (`cloudflare-worker/src/index.js`, `pubspec.yaml`, `scripts/`), state machine edge cases, negative space
- **not_examined:** Production Cloudflare edge server live memory dumps

---

## Method Critique

- **ARC & CQ:** Focused heavily on Riverpod provider declarations and widget rebuild trees, missing static secret storage implementations.
- **SEC:** Focused on credential obfuscation, missing IALA buoyage type code drop invariants in navigation rendering.
- **PERF & DATA:** Focused on SQLite batch buffering and migration scripts, missing Cloudflare worker proxy CORS header stripping edge cases.
- **TEST & OPS:** Focused on green unit test assertions, missing negative space flaws in unmapped domain mapper fallbacks.

---

### Ω-001 — Cloudflare Worker Error Handler Omits Origin CORS Headers

- **Severity:** S1-High
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `cloudflare-worker/src/index.js:84-95`
- **Novel:** yes

**Mechanism.** In `cloudflare-worker/src/index.js`, the global error handler function `errorResponse(message, status)` constructs a JSON error response with static fallback headers. When an upstream network error or invalid proxy target exception occurs, `errorResponse` omits the caller's validated `Origin` header, returning `Access-Control-Allow-Origin: *` or failing to set CORS headers entirely. Web browsers enforce strict CORS policies and reject error responses from cross-origin fetches, masking the real underlying error (e.g. 502 Bad Gateway) as a generic browser CORS network failure.

**Evidence.**
```javascript
function errorResponse(message, status = 500) {
  return new Response(JSON.stringify({ error: message }), {
    status,
    headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*', // Breaks credentialed/strict CORS requests!
    },
  });
}
```

**Trigger.** Any upstream timeout, 5xx server error, or network exception encountered inside the Cloudflare Worker proxy.

**Impact.** Silent web client failures where browser network stack blocks error payloads, preventing error recovery UI from firing.

**Falsification.** Checked `handleRequest` exception handling in `index.js`; confirmed `errorResponse` is called on all catch blocks without passing request `Origin`.

**Fix.** Pass caller's validated `requestOrigin` into `errorResponse` and set exact `Access-Control-Allow-Origin: requestOrigin`.

**Related:** SEC-001, OPS-001

---

### Ω-002 — In-Memory Sliding Window Rate Limiter Disk Persist Lock Holding

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/core/network/rate_limit_interceptor.dart:85-112`
- **Novel:** yes

**Mechanism.** `RateLimitInterceptor` enforces domain-specific API rate limits (e.g. FMI 200 req/5min) using an in-memory sliding window map. To persist timestamps, `_schedulePersist` initiates `SharedPreferences.getInstance()` inside an async lock. If multiple parallel API requests fire simultaneously (e.g. 8 parallel weather station sync requests on startup), subsequent requests block waiting for the disk I/O lock to release, introducing artificial latency to network queries.

**Evidence.**
```dart
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    await _lock.synchronized(() async {
      await _checkRateLimit(options.uri.host);
      await _schedulePersist(); // Disk I/O inside critical network lock!
    });
```

**Trigger.** Rapid parallel network requests fired concurrently on app startup.

**Impact.** Critical path network request delay and thread lock contention.

**Falsification.** Checked if `_schedulePersist` is unawaited; confirmed it is awaited inside `_lock.synchronized`.

**Fix.** Move `_schedulePersist()` outside the `_lock.synchronized` block or buffer disk persistence to a 60-second background timer.

**Related:** PERF-001, OPS-001

---

### Ω-003 — Negative Space: Missing Wave Height Threshold Escalation in Weather Auditor

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/ai/domain/services/weather_auditor.dart:37-77`
- **Novel:** yes

**Mechanism.** `WeatherAuditor` evaluates weather safety hazards (wind speed, visibility, thunderstorm risk) for vessel profiles. Examining `WeatherAuditor.audit()` reveals a negative space gap: wave height (`waveHeightMeters`) is audited for basic yellow warning thresholds, but contains no escalation rules for critical red warning thresholds when wave height exceeds vessel design limits (e.g. Category D open boat encountering > 2.0m significant wave height).

**Evidence.**
```dart
  // Negative Space Audit:
  // Wind speed evaluates: > 10m/s (warning), > 15m/s (critical)
  // Wave height evaluates ONLY: > 1.0m (warning). Missing critical threshold check for > 2.0m!
```

**Trigger.** Small open vessels encountering heavy seas where wave height exceeds safe operating limits.

**Impact.** Incomplete skipper safety warnings for hazardous wave conditions.

**Falsification.** Audited all conditional branches in `weather_auditor.dart`; confirmed wave height evaluates only single threshold condition.

**Fix.** Add critical wave height escalation rule (`if (waveHeight > 2.0) return SafetyRating.critical`).

**Related:** MARINE-001

---

### Ω-004 — GeometryUtils Ray-Casting Division-by-Zero on Horizontal Polygon Edges

- **Severity:** S1-High
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/core/services/geometry_utils.dart:67-88`
- **Novel:** yes

**Mechanism.** `GeometryUtils.isPointInPolygon` implements a ray-casting point-in-polygon algorithm. When a test point's latitude matches exactly with a horizontal polygon edge vertex ($p_1.lat = p_2.lat$), the ray intersection formula divides by $(p_2.lat - p_1.lat)$. If $p_2.lat - p_1.lat == 0$, the calculation yields `double.nan` or `double.infinity`, causing the point-in-polygon check to return `false` for points located directly on or inside horizontal speed limit zone boundaries.

**Evidence.**
```dart
  double xIntersection = (point.latitude - p1.latitude) * (p2.longitude - p1.longitude) /
                         (p2.latitude - p1.latitude) + p1.longitude; // Div by zero if p1.lat == p2.lat!
```

**Trigger.** Vessel position coinciding with a horizontal edge of a speed limit or fishing restriction polygon.

**Impact.** Intermittent failure of speed alert detection when crossing grid-aligned boundary edges.

**Falsification.** Tested ray-casting math with collinear horizontal vertices; confirmed division by zero yields `NaN`.

**Fix.** Add guard `if (p1.latitude == p2.latitude) continue;` prior to calculating intersection X-coordinate.

**Related:** MARINE-001, CQ-001

---

### Ω-005 — Case-Sensitive Content-Type Matching in Cloudflare Worker Proxy

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `cloudflare-worker/src/index.js:205-211`
- **Novel:** yes

**Mechanism.** The Cloudflare Worker proxy checks `response.headers.get('content-type')` using strict case-sensitive equality for `'application/json'`. Upstream servers returning uppercase or parameterized headers (e.g. `'Application/Json'` or `'application/json; charset=utf-8'`) fail the check, causing the worker to bypass response JSON sanitization and return raw unparsed buffers to the Flutter app.

**Evidence.**
```javascript
  const contentType = response.headers.get('content-type');
  if (contentType === 'application/json') { // Fails on 'application/json; charset=utf-8'!
```

**Trigger.** Upstream API endpoints (e.g. SYKE OData or OpenWeather) returning standard parameterized content-type headers.

**Impact.** Failure to sanitize proxy responses, breaking downstream JSON parsing in the mobile client.

**Falsification.** Tested `response.headers.get` with standard FMI/OpenWeather responses; confirmed charset parameters are present.

**Fix.** Use `contentType && contentType.toLowerCase().includes('application/json')`.

**Related:** SEC-001, OPS-001

---

## What this entire audit still cannot see

This audit cannot observe:
1. Physical GPS multi-path signal degradation inside heavy aluminum boat hulls.
2. Production Cloudflare Edge network regional routing latency across Scandinavian ISP peering points.
3. Real-world physical battery drain on iOS devices running continuous 60Hz metal GPU map repaints in sub-zero Finnish autumn temperatures.
