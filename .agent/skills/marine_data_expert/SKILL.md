---
name: Marine Data Expert
description: Expert knowledge on handling marine data APIs (FMI, MET Norway), parsing GML/XML, and coordinate conversions.
---

# Marine Data Expert

This skill embodies the domain expertise required to correctly handle marine weather and oceanographic data in the Sakkoja project.

## 1. Data Interpretation Rules

### 1.1 "Zero" vs "No Reading"
**CRITICAL:** In many marine data sources (specifically FMI buoy data and some legacy mareograph formats), a value of `0.0` often indicates **"no reading" or "sensor malfunction"** rather than a measured value of zero.

-   **Rule:** When parsing wave height, water temperature, or undefined sensor data, treat `0.0` as `null` unless the context guarantees it is a valid measurement (e.g., freezing point temperature).
-   **Context:** Zero wave height is physically unlikely in open sea; zero water temperature is possible but often used as a placeholder.
-   **Implementation:** check for `0.0` *before* assigning to non-nullable types.

### 1.2 Coordinate Systems
-   **Standard:** Use WGS84 (EPSG:4326) for all internal logic and storage.
-   **FMI API:** Requires `lat,lon` order in query parameters but may return `lat lon` or `lon lat` in GML depending on the specific endpoint version. Always verify looking at `gmlcov:positions`.
-   **Conversion:** `LatLng` objects from `latlong2` package are the standard interchange format.

## 2. API Specifics

### 2.1 FMI Open Data (WFS)
-   **Base URL:** `https://opendata.fmi.fi/wfs`
-   **Key Stored Queries:**
    -   **Weather:** `fmi::observations::weather::multipointcoverage`
    -   **Forecast:** `fmi::forecast::harmonie::surface::point::multipointcoverage`
    -   **Waves:** `fmi::observations::wave::timevaluepair`
    -   **Mareograph (Sea Level):** `fmi::observations::mareograph::timevaluepair`
    -   **Alerts:** `fmi::alerts::cap::latest::fi` (or Atom feed)
-   **Parameters:** See `lib/core/constants/fmi_constants.dart` for exact parameter strings (`t2m`, `ws_10min`, `WaveHs`, etc.).

### 2.2 MET Norway
-   Primary source for some specialized forecast models if FMI coverage implies gaps (though FMI is primary).
-   Adheres to similar OGC standards.

## 3. Parsing Logic (GML/XML)

### 3.1 Streaming vs DOM
-   **Standard:** Use `XmlStreamParser` (`lib/core/utils/xml_stream_parser.dart`) for all large datasets (forecasts, observations).
-   **Reason:** XML payloads can be huge (megabytes). Loading full DOM causes frame drops on mobile.

### 3.2 GML Structure
Common FMI GML structure involves:
1.  `gmlcov:positions`: Flattened list of `lat lon epoch`.
2.  `gml:doubleOrNilReasonTupleList`: Flattened list of measurement values corresponding to the positions.

**Parsing Pattern:**
1.  Read `positions` into a generic list.
2.  Read `values` into a generic list.
3.  Map them based on "arity" (number of parameters per point).
    -   *Example:* If there are 5 params (Temp, Wind, Gust, Dir, Precip), then for position `i`, values are `values[i*5]` to `values[i*5 + 4]`.

### 3.3 Handling NaNs
-   FMI often returns `NaN` string for missing values.
-   `XmlStreamParser` handles this by converting "NaN" string to `double.nan`.
-   **DTOs:** Transfer Objects should handle `double.nan` and expose nullable doubles (e.g., `double? temperature`) to the domain layer.

## 4. Common Pitfalls

-   **Axis Order:** FMI positions are usually `lat lon epoch`.
-   **Epoch parsing:** Timestamps are Unix epoch seconds.
-   **Namespace handling:** Rely on local names in `xml_events` (e.g., just `positions`, ignoring `gmlcov` prefix if possible, or strictly matching if using standard parsers). Sakkoja's `XmlStreamParser` checks for `gmlcov:positions` explicitly.
