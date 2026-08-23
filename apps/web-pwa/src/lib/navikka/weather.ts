import type { LatLng } from "./geo.ts";
import { weatherQuery } from "./fetch-policy.ts";
import type { WeatherSnap } from "./store.ts";

/** Field defaults for a *successful* MET payload with missing keys. Never stamp this as live on fetch failure. */
const FALLBACK: WeatherSnap = {
  tempC: 14.2,
  windMs: 6.4,
  gustMs: 9.1,
  windDir: 232,
  pressureHpa: 1012,
  humidity: 82,
  visM: 14000,
  cloudPct: 48,
  waveM: 0.7,
  waveDir: 240,
  wavePeriod: 4.2,
  waterC: 16.4,
  dewC: 11.1,
  updated: "1970-01-01T00:00:00.000Z",
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
  const d0 = json.properties?.timeseries?.[0]?.data?.instant?.details ?? {};
  let waveM = 0.6;
  let waveDir = d0.wind_from_direction ?? 220;
  let wavePeriod = 4;
  let waterC = 15;
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
      waveM = od.sea_surface_wave_significant_height ?? waveM;
      waveDir = od.sea_surface_wave_from_direction ?? waveDir;
      wavePeriod = od.sea_surface_wave_period ?? wavePeriod;
      waterC = od.sea_water_temperature ?? waterC;
    }
  } catch {
    /* keep estimates from locationforecast */
  }
  return {
    tempC: d0.air_temperature ?? FALLBACK.tempC,
    windMs: d0.wind_speed ?? FALLBACK.windMs,
    gustMs: d0.wind_speed_of_gust ?? (d0.wind_speed ?? 0) * 1.4,
    windDir: d0.wind_from_direction ?? FALLBACK.windDir,
    pressureHpa: d0.air_pressure_at_sea_level ?? FALLBACK.pressureHpa,
    humidity: d0.relative_humidity ?? FALLBACK.humidity,
    visM: (d0.fog_area_fraction ?? 0) > 50 ? 800 : 14000,
    cloudPct: d0.cloud_area_fraction ?? 40,
    waveM,
    waveDir,
    wavePeriod,
    waterC,
    dewC: d0.dew_point_temperature ?? FALLBACK.dewC,
    updated: new Date().toISOString(),
  };
}

export { fogStatus } from "./rules.ts";
