import type { LatLng } from "./geo.ts";
import { weatherQuery } from "./fetch-policy.ts";
import type { WeatherSnap } from "./store.ts";

function finiteOrNull(v: unknown): number | null {
  return typeof v === "number" && Number.isFinite(v) ? v : null;
}

/** Compact MET. Missing fields stay null — never mint 1012 hPa / 232° / 14 km vis. */
export async function fetchWeather(pos: LatLng): Promise<WeatherSnap> {
  const q = weatherQuery(pos);
  const headers = { Accept: "application/json" };
  const url = `https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=${q.lat}&lon=${q.lon}`;
  const res = await fetch(url, { headers });
  if (!res.ok) throw new Error(`Weather fetch failed: ${res.status}`);
  const json = (await res.json()) as {
    properties?: {
      timeseries?: Array<{ data?: { instant?: { details?: Record<string, number> } } }>;
    };
  };
  const series0 = json.properties?.timeseries?.[0];
  if (!series0) throw new Error("Weather fetch failed: empty");
  const d0 = series0.data?.instant?.details ?? {};
  const tempC = d0.air_temperature;
  const windMs = d0.wind_speed;
  if (!Number.isFinite(tempC) || !Number.isFinite(windMs)) {
    throw new Error("Weather fetch failed: missing temp/wind");
  }
  let waveM: number | null = null;
  let waveDir: number | null = finiteOrNull(d0.wind_from_direction);
  let wavePeriod: number | null = null;
  let waterC: number | null = null;
  try {
    const ocean = await fetch(
      `https://api.met.no/weatherapi/oceanforecast/2.0/complete?lat=${q.lat}&lon=${q.lon}`,
      { headers },
    );
    if (ocean.ok) {
      const oj = (await ocean.json()) as {
        properties?: {
          timeseries?: Array<{ data?: { instant?: { details?: Record<string, number> } } }>;
        };
      };
      const od = oj.properties?.timeseries?.[0]?.data?.instant?.details ?? {};
      waveM = finiteOrNull(od.sea_surface_wave_significant_height);
      waveDir = finiteOrNull(od.sea_surface_wave_from_direction) ?? waveDir;
      wavePeriod = finiteOrNull(od.sea_surface_wave_period);
      waterC = finiteOrNull(od.sea_water_temperature);
    }
  } catch {
    /* ocean optional — do not invent 0.6 m */
  }
  return {
    tempC,
    windMs,
    gustMs: finiteOrNull(d0.wind_speed_of_gust),
    windDir: finiteOrNull(d0.wind_from_direction),
    pressureHpa: finiteOrNull(d0.air_pressure_at_sea_level),
    humidity: finiteOrNull(d0.relative_humidity),
    visM: null,
    cloudPct: finiteOrNull(d0.cloud_area_fraction),
    waveM,
    waveDir,
    wavePeriod,
    waterC,
    dewC: finiteOrNull(d0.dew_point_temperature),
    updated: new Date().toISOString(),
  };
}

export { fogStatus } from "./rules.ts";
