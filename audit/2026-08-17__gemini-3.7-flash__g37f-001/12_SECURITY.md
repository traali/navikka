# SECURITY AUDIT — SEC

- **run_id:** g37f-001
- **date:** 2026-08-17
- **model:** Gemini 3.7 Flash
- **target:** Sakkoja Marine Safety Navigator @ 604ebd4
- **wave:** 1
- **findings_reported:** 3
- **candidates_discarded:** 12
- **examined:** CORS Proxy worker (`cloudflare-worker/src/index.js`), Dio network interceptors (`lib/core/network/`), API key handling, trust boundaries, origin validation, local storage of credentials, and input sanitation.
- **not_examined:** Cloudflare infrastructure DDoS protection layers and upstream third-party API server security.

---

### SEC-001 — CORS Proxy query parameter loop overwrites server-injected API key

- **Severity:** S1-High
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `cloudflare-worker/src/index.js:164-187`
- **Novel:** yes

**Mechanism.** In the Cloudflare CORS proxy worker, secret injection occurs at lines 167-171 where `env.OPENWEATHER_API_KEY` is injected into `targetUri.searchParams.set('appid', env.OPENWEATHER_API_KEY)`. Immediately afterwards at lines 180-186, the worker iterates over all query parameters of the incoming worker request (`url.searchParams.entries()`) and sets each parameter onto `targetUri`. If a client passes `?url=https://api.openweathermap.org/...&appid=attacker_override`, line 183 unconditionally overwrites the server-side injected `appid` with the client parameter.

**Evidence.**
```javascript
// cloudflare-worker/src/index.js:167-171 (Step 1: Injects Secret)
const targetUri = new URL(targetUrl);
if (targetUri.hostname === 'api.openweathermap.org' && env.OPENWEATHER_API_KEY) {
  targetUri.searchParams.set('appid', env.OPENWEATHER_API_KEY);
  targetUrl = targetUri.toString();
}

// cloudflare-worker/src/index.js:180-186 (Step 2: Client Loop Overwrites Target URL)
const targetUri = new URL(targetUrl);
for (const [key, value] of url.searchParams.entries()) {
  if (key !== 'url') {
    targetUri.searchParams.set(key, value); // <--- Overwrites 'appid' if client passed &appid=xxx
  }
}
targetUrl = targetUri.toString();
```

**Trigger.** Any request to the CORS proxy targeting OpenWeather that includes an `&appid=` parameter in the query string.

**Impact.** A malicious or malfunctioning client can bypass or invalidate the server-side API key injection, causing denial of service (401 Unauthorized) for weather requests or forcing usage of an attacker-controlled API key.

**Falsification.** Traced variable mutations sequentially:
1. `targetUrl` contains target with injected `appid`.
2. `targetUri` is re-parsed from `targetUrl`.
3. Loop iterates over `url.searchParams` (the worker request query params).
4. `url.searchParams` contains every query parameter in the incoming URL except `url`.
5. `targetUri.searchParams.set(key, value)` overwrites any pre-existing key on `targetUri`.
6. Verified no check for `key !== 'appid'` exists in the loop.

**Fix.** Perform parameter forwarding BEFORE secret injection, or explicitly exclude sensitive credential keys (`appid`, `apiKey`, `key`) from the client parameter forwarding loop.
*Trade-off:* Prevents clients from supplying custom OpenWeather API keys through the proxy.

**Related:** SEC-002, OPS-001

---

### SEC-002 — Missing validation of target URL protocol allows scheme manipulation in CORS Worker

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `cloudflare-worker/src/index.js:75-81`
- **Novel:** yes

**Mechanism.** `isAllowedTargetHost` validates `new URL(url).hostname` against `ALLOWED_TARGET_HOSTS`. However, it does not validate the URL scheme/protocol (e.g. `http:` vs `https:`). If an unencrypted `http://` URL is supplied for an allowlisted domain that supports HTTPS, the proxy will forward the request in plain text over the public internet, stripping transport-layer encryption between Cloudflare and the upstream provider.

**Evidence.**
```javascript
// cloudflare-worker/src/index.js:75-81
function isAllowedTargetHost(url) {
  try {
    const hostname = new URL(url).hostname;
    return ALLOWED_TARGET_HOSTS.includes(hostname);
  } catch {
    return false;
  }
}
```

**Trigger.** Requesting a proxied URL with `http://` instead of `https://`.

**Impact.** Plaintext transmission of weather/marine API traffic and upstream API keys across intermediary networks.

**Falsification.** Checked if `fetch(targetUrl)` enforces HTTPS. In Node/Fetch/Cloudflare Workers, `fetch('http://...')` will make a plaintext HTTP request to the target origin if the URL scheme is `http:`.

**Fix.** Enforce `targetUri.protocol === 'https:'` or force-rewrite `targetUri.protocol = 'https:'` for all proxied hosts.
*Trade-off:* Any legacy host lacking SSL cannot be proxied (all current allowlisted Finnish hosts support HTTPS).

**Related:** SEC-001

---

### SEC-003 — Proxy authentication secret relies on optional compile-time assertion

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/core/network/web_proxy_interceptor.dart:76-81`
- **Novel:** yes

**Mechanism.** `WebProxyInterceptor` checks the presence of `PROXY_AUTH_SECRET` via a Dart `assert()`. In Flutter web release builds, `assert()` statements are stripped by default by the `dart2js` compiler. If a release build is created without `--dart-define=PROXY_AUTH_SECRET=xxx`, the assertion is bypassed silently and unauthenticated HTTP requests are dispatched with no `X-App-Auth` header, failing with a 401 on an authenticated Cloudflare worker.

**Evidence.**
```dart
// lib/core/network/web_proxy_interceptor.dart:76-81
assert(
  _forceWebForTesting == true || proxyAuthSecret.isNotEmpty,
  'PROXY_AUTH_SECRET is empty. '
  'Pass --dart-define=PROXY_AUTH_SECRET=xxx when building. '
  'Without it, the CORS proxy is unauthenticated and publicly abusable.',
);
```

**Trigger.** Building web artifacts via `flutter build web --release` without providing `PROXY_AUTH_SECRET`.

**Impact.** Web deployments fail silently at runtime on all proxied API endpoints with 401 Unauthorized responses instead of failing fast during build or startup.

**Falsification.** Checked Flutter documentation and Dart compiler flags: `assert()` is never executed in production web builds unless `--enable-asserts` is explicitly passed.

**Fix.** Replace `assert()` with a runtime check in `init()` or throw an explicit configuration exception if deployed in production without the secret.
*Trade-off:* Requires dev builds to supply a dummy secret or explicit bypass flag.

**Related:** OPS-001

---

## Cross-domain sightings
- `WebProxyInterceptor` URL modifications interact with `RateLimitInterceptor` domain grouping during retries (SEAM/OPS).
- Missing error boundary in `RoutePlannerScreen.saveRoute` UI handler (CQ).

## Hygiene (low-signal, listed for completeness)
- `cloudflare-worker/src/index.js:28`: Duplicate entry `'avoinkara.mmm.fi'` in `ALLOWED_TARGET_HOSTS`.

## Open questions
- Is `PROXY_AUTH_SECRET` configured in the Cloudflare Pages environment variables for preview deployments?

## This team's blind spot
Security auditing evaluates network boundaries, credential leaks, and authentication controls, but cannot verify if external third-party API providers (FMI/Traficom/SYKE) alter their token or CORS policies upstream without notice.
