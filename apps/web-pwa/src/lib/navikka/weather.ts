import type { LatLng } from "./geo.ts";
import { weatherQuery } from "./fetch-policy.ts";
import type { WeatherSnap } from "./store.ts";

/** Compact MET has no visibility or dew. Never stamp 14 km / 0.6 m / 11.1 °C as live. */
const FALLBACK = {
  windDir: 232,
  pressureHpa: 1012,
  humidity: 82,
  cloudPct: 48,
};

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
  let waveDir = d0.wind_from_direction ?? FALLBACK.windDir;
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
      waveM = od.sea_surface_wave_significant_height ?? null;
      waveDir = od.sea_surface_wave_from_direction ?? waveDir;
      wavePeriod = od.sea_surface_wave_period ?? null;
      waterC = od.sea_water_temperature ?? null;
    }
  } catch {
    /* keep estimates from locationforecast */
  }
  return {
    tempC,
    windMs,
    gustMs: Number.isFinite(d0.wind_speed_of_gust) ? d0.wind_speed_of_gust : null,
    windDir: d0.wind_from_direction ?? FALLBACK.windDir,
    pressureHpa: d0.air_pressure_at_sea_level ?? FALLBACK.pressureHpa,
    humidity: d0.relative_humidity ?? FALLBACK.humidity,
    visM: Number.isFinite(d0.fog_area_fraction)
      ? d0.fog_area_fraction > 50
        ? 800
        : 14000
      : null,
    cloudPct: d0.cloud_area_fraction ?? FALLBACK.cloudPct,
    waveM,
    waveDir,
    wavePeriod,
    waterC,
    dewC: Number.isFinite(d0.dew_point_temperature) ? d0.dew_point_temperature : null,
    updated: new Date().toISOString(),
  };
}

export { fogStatus } from "./rules.ts";
