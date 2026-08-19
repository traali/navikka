# OPERABILITY & OBSERVABILITY AUDIT — OPS

- **run_id:** g37f-001
- **date:** 2026-08-17
- **model:** Gemini 3.7 Flash
- **target:** Sakkoja Marine Safety Navigator @ 604ebd4
- **wave:** 1
- **findings_reported:** 3
- **candidates_discarded:** 12
- **examined:** Dio network interceptor pipelines, Cloudflare Worker deployment scripts, Dockerfile configurations, structured logging (`Logger`), error handling, and runtime telemetry.
- **not_examined:** Production Cloudflare CDN edge cache hit ratios and live telemetry dashboards.

---

### OPS-001 — Request retry on Web misattributes rate limits to proxy domain instead of target

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/core/providers/core_providers.dart:49-108`
- **Novel:** yes

**Mechanism.** In `core_providers.dart`, `RateLimitInterceptor` is registered first, `RetryInterceptor` second, and `WebProxyInterceptor` third. On Web, `WebProxyInterceptor.onRequest` mutates `options.baseUrl = ''` and `options.path = '$proxyUrl?url=...'`. If an HTTP request fails and `RetryInterceptor` re-dispatches the request, the retried request passes through `RateLimitInterceptor` with `options.uri.host` set to `'sakkoja-cors-proxy.sakkoja.workers.dev'` rather than the original upstream domain (e.g. `'opendata.fmi.fi'`). Because the proxy domain is not in `domainConfigs`, all retried requests across all weather APIs fall back to the global default bucket (20 req / 10s), causing cross-service rate-limit throttling during network recovery.

**Evidence.**
```dart
// lib/core/providers/core_providers.dart:49-108
dio.interceptors.add(RateLimitInterceptor( ... ));
dio.interceptors.add(RetryInterceptor( ... ));
if (kIsWeb) {
  dio.interceptors.add(WebProxyInterceptor());
}
```
When `WebProxyInterceptor` mutates `options`:
```dart
// lib/core/network/web_proxy_interceptor.dart:93-94
options.baseUrl = '';
options.path = newUrl; // https://sakkoja-cors-proxy.sakkoja.workers.dev?url=...
```

**Trigger.** Upstream API temporary outage (e.g. FMI returning 503) causing `RetryInterceptor` to retry multiple requests on Web.

**Impact.** Retries against FMI throttle unrelated OpenWeather or SYKE requests by exhausting the shared default 20 req/10s rate-limiting bucket of the proxy host.

**Falsification.** Traced Dio interceptor execution on request retry:
1. First attempt: `RateLimitInterceptor` tracks `opendata.fmi.fi` $\to$ `WebProxyInterceptor` mutates path to `proxyUrl`.
2. Request fails with 500 error $\to$ `RetryInterceptor` schedules retry and re-executes request pipeline.
3. Second attempt: `RateLimitInterceptor` reads `options.uri.host` which is now `proxyUrl.host`.
4. Proxy domain is not in `domainConfigs` $\to$ hits `defaultConfig`.

**Fix.** In `RateLimitInterceptor`, extract the original domain from `options.extra['original_url']` if present before falling back to `options.uri.host`.
*Trade-off:* 2 lines of defensive logic in `RateLimitInterceptor`.

**Related:** SEAM-001, SEC-001

---

### OPS-002 — Production Docker container runs Nginx as root user

- **Severity:** S3-Low
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `Dockerfile:1-40`
- **Novel:** no

**Mechanism.** The production Dockerfile builds the Flutter Web bundle and serves it using standard `nginx:alpine` without switching to a non-privileged `USER nginx` directive. While the container is read-only in typical container environments, running web servers as root violates the principle of least privilege.

**Evidence.**
```dockerfile
# Dockerfile
FROM nginx:alpine
COPY --from=builder /app/build/web /usr/share/nginx/html
# No USER directive specified
```

**Trigger.** Deploying the self-hosted Docker container in container environments without rootless security profiles.

**Impact.** Increased blast radius in the event of an Nginx remote code execution vulnerability.

**Falsification.** Checked `Dockerfile` for `USER` directive. None exists.

**Fix.** Add `USER nginx` and configure appropriate permissions on `/var/cache/nginx` and `/var/run`.
*Trade-off:* Requires small chown in Dockerfile build stage.

**Related:** none

---

### OPS-003 — Secret parameter redaction in logs is limited to query string keys

- **Severity:** S3-Low
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/core/network/web_proxy_interceptor.dart:5-28`
- **Novel:** yes

**Mechanism.** `_sanitizeUrl` redacts sensitive query parameter values (`appid`, `api_key`, `token`, `secret`) when logging proxy requests. However, if an API token or basic authentication credential is embedded in the URL path or user-info section (`https://user:pass@host/`), `_sanitizeUrl` leaves the string unredacted, potentially leaking credentials to console logging.

**Evidence.**
```dart
// lib/core/network/web_proxy_interceptor.dart:18-28
String _sanitizeUrl(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null || uri.queryParameters.isEmpty) return url;
  final sanitized = Map<String, String>.from(uri.queryParameters);
  ...
  return uri.replace(queryParameters: sanitized).toString();
}
```

**Trigger.** Constructing a proxied URL containing credentials in the user-info component.

**Impact.** Plaintext credentials printed to debug or release console logs.

**Falsification.** Checked if Sakkoja currently passes credentials in user-info components. All current APIs pass tokens in query params or headers. Risk is latent.

**Fix.** Strip `userInfo` in `_sanitizeUrl`: `uri.replace(userInfo: '', queryParameters: sanitized)`.
*Trade-off:* None.

**Related:** SEC-001

---

## Cross-domain sightings
- `RoutePlannerScreen.saveRoute()` does not log caught database failure events (CQ).
- `AiSettingsNotifier.build()` initiates unawaited async prefs load without log confirmation (ARC).

## Hygiene (low-signal, listed for completeness)
- `lib/core/utils/logger.dart:15`: Console log outputs omit unique request correlation IDs.

## Open questions
- Is there a central Sentry or OpenTelemetry log sink configured for production web builds?

## This team's blind spot
Operability auditing evaluates logging, container security, and retry policies, but cannot monitor live network jitter or 3 a.m. Cloudflare Worker edge compute failovers.
