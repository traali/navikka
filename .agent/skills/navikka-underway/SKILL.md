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

A boat at 6 kn moves ~3 m/s. MET Norway's grid is kilometres. Digitraffix AIS
is a national dump. iPhone Chrome is WebKit. Treat the phone as a 4-hour
watch: battery, radio quota, and a skipper who glances — they do not stare.

Read `references/fetch-policy.md` before touching poll/GPS/weather/AIS.

## Non-negotiables

1. **Never put raw GPS into a weather URL.** Snap to `0.05°` (~5.5 km).
   `toFixed(4)` (~11 m) busts HTTP cache every poll — that is the "weather
   fetched all the time while boating" bug.
2. **Weather TTL 10 min** (or a new snap cell). MET locationforecast does not
   update faster in a way a skipper can use.
3. **Keep last good weather on error.** Never blank the HUD with "Haetaan…"
   after a successful fetch. **Never return FALLBACK with `updated: now`.**
   Throw. Cockpit calls `setWeather(null, err)` which keeps the last snap
   and `weatherAt` — age chip stays honest ("4 min sitten"), not "juuri".
4. **Pause polls when `document.hidden`.** Background tabs do not need AIS.
5. **Decouple weather and AIS.** Different TTL, different inflight guards.
6. **GPS apply-throttle: 500 ms or 15 m.** Flutter cascade: 500 ms GPS, 20 m
   move, 300 ms camera. Match the spirit.
7. **Map follow pan only after ~12 m**, `animate: false` when SOG > 2 kn.
   Do not `import("leaflet")` on every store tick.
8. **Show age, not a spinner.** "4 min sitten" / "vanha sää" (>15 min).
9. **Fairway / UKC / MAYDAY only within 1 km of a published polyline.**
   Beyond that: Avomeri. Never inject a Helsinki channel into a Porkkala
   distress readout.

## When editing

- Put new thresholds in `src/lib/navikka/fetch-policy.ts` and lock them with
  `fetch-policy.test.ts`.
- Cockpit only *runs* the policy. It does not invent intervals.
- iPhone Chrome: Wake Lock is flaky, Clipboard needs `execCommand` + Share.

## Done when

- 20 s of demo/GPS motion → **1** weather fetch, **1** AIS fetch.
- Weather chip shows age, not perpetual "Haetaan merisäätä…".
- Unit tests cover snap/TTL/hidden/GPS/pan.
