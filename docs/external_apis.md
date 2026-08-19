# External API Registry

This document tracks all external API endpoints utilized in the Sakkoja application.

---

## 1. Maritime Data (Väylävirasto / Finnish Transport Infrastructure Agency)

| Service | Type | Endpoint | Description |
| :--- | :--- | :--- | :--- |
| **Speed Limits** | WFS 2.0.0 | `https://avoinapi.vaylapilvi.fi/vaylatiedot/wfs` | Mandatory and recommended speed restriction zones. |
| **Traffic Signs** | WFS 2.0.0 | `https://avoinapi.vaylapilvi.fi/vaylatiedot/wfs` | Maritime signs, buoys, and markers. |
| **Waterway Features** | WFS 2.0.0 | `https://avoinapi.vaylapilvi.fi/inspirepalvelu/tn-w/wfs` | Fairway areas, beacons, and buoys (Inspire TN-W). |

---

## 2. Fishing Data (MMM / Ministry of Agriculture and Forestry)

| Service | Type | Endpoint | Description |
| :--- | :--- | :--- | :--- |
| **Fishing Restrictions** | WFS 2.0.0 | `http://avoinkara.mmm.fi/geoserver/wfs` | Finnish national fishing restriction areas (`avoin:kalastusrajoitus`). |

---

## 3. Weather Data (FMI / Finnish Meteorological Institute)

| Service | Type | Endpoint | Description |
| :--- | :--- | :--- | :--- |
| **Weather Warnings** | CAP Atom | `https://alerts.fmi.fi/cap/feed/atom_fi-FI.xml` | Official meteorological alerts in Atom/CAP format. |
| **Lightning Data** | WFS 2.0.0 | `https://opendata.fmi.fi/wfs` | Real-time lightning strike observations. |
| **Weather Radar** | WMS | `https://openwms.fmi.fi/geoserver/wms?` | Precipitation intensity and reflectivity layers. |
| **Harmonie Point Forecast** | WFS 2.0.0 | `https://opendata.fmi.fi/wfs` | Surface wind, gusts, temperature, sea level. |
| **Wave Model** | WFS 2.0.0 | `https://opendata.fmi.fi/wfs` | Significant wave height ($H_s$) and wave period ($T_p$). |

---

## 4. Water Quality & Algae (SYKE / Finnish Environment Institute)

| Service | Type | Endpoint | Description |
| :--- | :--- | :--- | :--- |
| **Water Quality (VESLA)** | OData v4 | `https://rajapinnat.ymparisto.fi/api/vesla/` | Secchi depth, surface temperature, chlorophyll-a. |
| **Citizen Algae Reports** | OData v4 | `https://rajapinnat.ymparisto.fi/api/jarviwiki/` | Citizen science algae observations. |
| **Algae Satellite Probability** | WMS | `https://paikkatieto.ymparisto.fi/arcgis/services/Syke/Itameri/MapServer/WMSServer` | Satellite-derived surface cyanobacteria blooms (Layer 6). |

---

## 5. Secondary Marine Weather (MET Norway & OpenWeather)

| Service | Type | Endpoint | Description |
| :--- | :--- | :--- | :--- |
| **MET Norway** | Locationforecast | `https://api.met.no/weatherapi/locationforecast/2.0/compact` | Independent Scandinavian ensemble forecast. |
| **OpenWeather** | REST API | `https://api.openweathermap.org/data/2.5/` | Global marine weather cross-validation. |

---

## 6. Map Tiles & Base Layers

| Service | Type | Endpoint | Description |
| :--- | :--- | :--- | :--- |
| **Nautical Charts** | WMTS 1.0.0 | `https://julkinen.traficom.fi/rasteripalvelu/wmts` | Official Traficom nautical chart raster tiles. |
| **OpenStreetMap** | Raster | `https://tile.openstreetmap.org/` | Global standard navigation base map tiles. |
| **Guest Harbors** | REST | `https://lipas.fi/geoserver/lipas/ows` | Official Lipas guest harbor points & services. |
