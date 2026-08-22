# Fetch policy numbers

| Signal | Fresh | Snap / gate | Hidden tab |
|---|---|---|---|
| Weather (MET locationforecast + ocean) | 10 min | `0.05°` cell (~5.5 km) | skip |
| AIS (Digitraffic) | 60 s follow/nav, 180 s idle | Helsinki bbox around own ship | skip |
| GPS apply | 500 ms **or** 15 m | `enableHighAccuracy` | n/a |
| Map follow pan | 12 m | `animate: false` if SOG > 2 kn | n/a |
| Demo tick | 1 s | skip if `document.hidden` | pause |

MET Norway requires a unique `User-Agent`. Reuse one snapped URL so their CDN
can 304. Ocean forecast rides the same weather refresh — never a second loop.

Digitraffic `/api/ais/v1/locations` is a **national** GeoJSON. Filter to ~0.4°
of own ship before storing. Do not re-download because weather refreshed.

Poll **check** interval may be 15 s. **Fetch** only when the table says so.
