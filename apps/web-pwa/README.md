# Navikka web PWA companion

React + Leaflet cockpit for Helsinki waters. This is **not** a replacement for
the Flutter PWA in `web/`. Flutter remains the product for navikka.fi /
Cloudflare Pages. This tree is the working web companion that was field-tested
on iPhone Chrome.

## What this is

A skipper HUD you can open in a phone browser:

- Live (or demo) GPS, SOG, COG, under-keel clearance
- Helsinki harbors, fairways, speed-limit boxes, fishing rules
- MET Norway weather + COLREG 19/35 fog status
- AIS targets (Digitraffic when CORS allows, otherwise seeded Helsinki traffic)
- Route planning, MAYDAY readout, 112 / MRCC Turku
- FI/EN copy, five bridge themes including Red Watch
- Rough-sea 56px targets, 16px inputs (no iOS focus-zoom)

## Why it exists

1. **The Flutter `web/` tree is the production PWA.** Dropping a Vite app there
   would break `flutter build web` and the existing Pages deploy.
2. **iPhone Chrome is WebKit (CriOS), not Chromium.** A Friday field test
   (2026-08-21) on iPhone 11 or 12 + Chrome confirmed the companion at least
   *loads*. This package hardens the things that fail on that stack: `100dvh` /
   `-webkit-fill-available`, `viewport-fit=cover`, `env(safe-area-inset-*)`,
   16px form fields, 44px targets, clipboard `execCommand` fallback, Share
   Sheet for SOS, Wake Lock `visibilitychange` retry, `crypto.randomUUID`
   polyfill.
3. **iPhone 11 ≠ iPhone 12.** 375×812 @2x vs 390×844 @3x. A 4-column HUD that
   fits 390 can clip at 375, so there is a `max-width: 389px` rule plus
   Playwright checks on both viewports.
4. **Safety logic should be unit-tested without a device.** Haversine, CPA,
   UKC, speed-limit polygons, statutory catch sizes, fog thresholds, MAYDAY
   text, and iOS clipboard/share all run under `node:test`.
5. **Weather must not refetch on every GPS tick.** MET URLs are snapped to a
   5.5 km cell with a 10 min TTL. AIS is 60 s underway / 180 s idle. Hidden
   tabs pause. The HUD shows age ("juuri"), never a perpetual "Haetaan…".
   Skill: `.agent/skills/navikka-underway`.

## What we did not do

- Did not rewrite Flutter.
- Did not touch `web/`, `lib/`, or `pubspec.yaml`.
- Did not claim this is an official Traficom chart. The in-app disclaimer stays.
- Did not persist live GPS/weather to `localStorage` (only theme, units, vessel,
  route, catches).

## Field test (Friday 21 Aug 2026)

| Device | Browser | Result |
|---|---|---|
| iPhone 11 or 12 (user) | Chrome (CriOS / WebKit) | App **loaded** |
| iPhone 11 375×812 @2x (Playwright + CriOS UA) | simulated | HUD + map + SOS, no overflow, 16px inputs, 36 tiles |
| iPhone 12 390×844 @3x (Playwright + CriOS UA) | simulated | same |

Chrome on iOS always uses WebKit. Features that exist only in Blink
(Chromium-on-Android/desktop) are not assumed.

## Tests

```bash
cd apps/web-pwa
npm install
npm test
npm run typecheck
```

86+ `node:test` cases covering:

- geo: haversine, CPA, UKC, DDM, route ETA, Finnish-waters parse, **segment distance**
- catalog: harbors, fairways, kuha 42 cm / taimen 60 cm, no-wake box, **hel-9 mid-leg on-channel**
- rules: COLREG fog, overspeed, MAYDAY, `newId` without `randomUUID`,
  clipboard fallback, `navigator.share`
- store: demo GPS tick vs device GPS, catch cap, persist partialization,
  last-good weather, **seed AIS is not live**
- fetch-policy: MET 0.05° snap, 10 min TTL, **60 s weather retry**, AIS radius=45,
  **deviceFixKinematics** (LIVE GPS does not inherit demo 6.2 kn)
- gauntlet file contracts: `/cockpit/` redirects, `--base=/cockpit/`, CI `npm test`,
  Pages skip when Cloudflare secrets are unset
- iPhone: CriOS detection, 11 vs 12 viewports, 16px/44px/dvh/safe-area CSS contracts

Flutter also locks this contract: `test/core/web_companion_contract_test.dart` +
`scripts/architecture_check.dart`. Every PR runs **both** stacks in `ci.yml`.

## Run

```bash
cd apps/web-pwa
npm install
npm run dev
```

Then open the printed local URL on the phone (same Wi-Fi) or use the Grok
preview of this companion.

## Layout

```
apps/web-pwa/
  src/components/navikka/   cockpit, Leaflet map, sheets
  src/lib/navikka/          geo, catalog, rules, store, weather, AIS, i18n
  src/lib/navikka/*.test.ts node:test, no browser required
  scripts/iphone-qa.mjs     Playwright iPhone 11 + 12 CriOS
```
