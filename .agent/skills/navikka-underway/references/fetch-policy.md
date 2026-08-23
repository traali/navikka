# Fetch policy numbers

| Signal | Fresh | Snap / gate | Hidden tab |
|---|---|---|---|
| Weather (MET locationforecast + ocean) | 10 min | `0.05°` cell (~5.5 km) | skip |
| AIS (Digitraffic) | 60 s follow/nav, 180 s idle | `latitude/longitude/radius=45` km, then 0.4° client filter | skip |
| GPS apply | 500 ms **or** 15 m | `enableHighAccuracy`; first LIVE fix does **not** inherit demo SOG | n/a |
| Map follow pan | 12 m | `animate: false` if SOG > 2 kn | n/a |
| Demo tick | 1 s | skip if `document.hidden` | pause |

MET Norway wants a unique User-Agent. **Do not set it from browser `fetch`**
(forbidden header → CORS preflight; MET only allows `Origin`). Identify via
the page Origin. Reuse one snapped URL so their CDN can 304. Ocean forecast
rides the same weather refresh — never a second loop.

Digitraffic `GET /api/ais/v1/locations?latitude=&longitude=&radius=` (km,
haversine). Never the unfiltered national dump. Keep the 0.4° client filter.

Poll **check** interval may be 15 s. **Fetch** only when the table says so.

On MET/HTTP failure **or empty timeseries**: **throw**. Never return a
synthetic snap with `updated: now`. The store keeps the last good
`WeatherSnap`. Cockpit stamps `lastAttemptAt` so the next tick is not
`"first"` (`WEATHER_RETRY_MS` = 60 s).

Fairway lookup: distance to polyline **segments**, within **1 km**.
Otherwise UKC/MAYDAY are open water — do not name a Helsinki channel at
Porkkala, and do not punch Avomeri holes mid hel-9.
