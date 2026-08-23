---
name: navikka-underway
description: >
  Skipper-underway rules for Navikka web: weather/AIS fetch policy, GPS
  throttle, map follow, iPhone Chrome, and HUD freshness. Use whenever
  changing cockpit polling, MET Norway, Digitraffic AIS, geolocation,
  Leaflet follow, or weather UI. Do not refetch marine weather on every
  GPS tick.
metadata:
  short-description: "Underway fetch/GPS/map policy for Navikka"
---

# Navikka underway (skipper, not a demo)

A boat at 6 kn moves ~3 m/s. MET Norway's grid is kilometres. Digitraffic AIS
must be queried with `latitude/longitude/radius` — never the national dump.
iPhone Chrome is WebKit. Treat the phone as a 4-hour watch.

Read `references/fetch-policy.md` before touching poll/GPS/weather/AIS.

The production URL is **`/cockpit/`** on the Flutter Cloudflare Pages origin.
Do not copy a second tree to `/pwa`. Build with `--base=/cockpit/`. Keep
`web/_redirects` `/cockpit` and `/pwa` **above** `/* /index.html 200`.

## Non-negotiables

1. **Never put raw GPS into a weather URL.** Snap to `0.05°` (~5.5 km).
2. **Weather TTL 10 min** (or a new snap cell). On fetch **error**, retry after
   `WEATHER_RETRY_MS` (60 s) via `lastAttemptAt`. Never leave the next poll as
   `"first"` 1 s later (that is an 8 req/min MET storm).
3. **Keep last good weather on error.** Throw on `!res.ok` **and** on empty
   `timeseries`. Never return FALLBACK with `updated: now`. HUD age uses
   `weather.updated`, not the retry clock.
4. **Pause polls when `document.hidden`.**
5. **Decouple weather and AIS.**
6. **GPS apply-throttle: 500 ms or 15 m.** First LIVE fix must **not** inherit
   demo 6.2 kn / 112°. Use `deviceFixKinematics`. CriOS `speed` is often null.
7. **Map follow pan only after ~12 m**, `animate: false` when SOG > 2 kn.
8. **Show age, not a spinner.**
9. **Fairway / UKC / MAYDAY within 1 km of a published polyline SEGMENT**
   (`distToSegmentM` / `distToPolylineM`). Vertices 2 km apart must not punch
   Avomeri holes in hel-9. Porkkala stays null.
10. **AIS:** `aisQuery` with radius 45 km. Seed traffic is DEMO (`aisSource:
    "seed"`). Do not CPA-alarm seed. Errors use `setAisError`, not wipe seed.
11. **Do not set `User-Agent` from browser `fetch`** (CORS preflight on MET).
12. **Fishing polygons** must `.addTo(fish)`.

## When editing

- Thresholds live in `apps/web-pwa/src/lib/navikka/fetch-policy.ts` and are
  locked by `fetch-policy.test.ts`.
- Flutter CI also reads these files (`test/core/web_companion_contract_test.dart`
  + `scripts/architecture_check.dart`). A Dart-only PR that reverts `/cockpit`
  redirects will fail `flutter test`.
- `ci.yml` verify **always** runs `apps/web-pwa` `npm test` + `typecheck`. Do
  not drop that step; `web-pwa.yml` is extra, path-filtered feedback.
- Pages deploy skips (does not fail CI) when `CLOUDFLARE_API_TOKEN` or
  `CLOUDFLARE_ACCOUNT_ID` is unset. Live `/cockpit` still needs both secrets.
- Cockpit only *runs* the policy.

## Done when

- 20 s of demo/GPS motion → **1** weather fetch, **1** AIS fetch (unless
  radio loss, then weather retries at 60 s, not 15 s).
- `npm test` in `apps/web-pwa` and `flutter test test/core/web_companion_contract_test.dart` are green.
