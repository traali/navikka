import type { LatLng } from "./geo.ts";
import type { WeatherSnap } from "./store.ts";

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
  updated: new Date().toISOString(),
};

type Details = Record<string, number>;

function snapFromMet(d0: Details, ocean: Details): WeatherSnap {
  return {
    tempC: d0.air_temperature ?? FALLBACK.tempC,
    windMs: d0.wind_speed ?? FALLBACK.windMs,
    gustMs: d0.wind_speed_of_gust ?? (d0.wind_speed ?? 0) * 1.4,
    windDir: d0.wind_from_direction ?? FALLBACK.windDir,
    pressureHpa: d0.air_pressure_at_sea_level ?? FALLBACK.pressureHpa,
    humidity: d0.relative_humidity ?? FALLBACK.humidity,
    visM: (d0.fog_area_fraction ?? 0) > 50 ? 800 : 14000,
    cloudPct: d0.cloud_area_fraction ?? 40,
    waveM: ocean.sea_surface_wave_significant_height ?? 0.6,
    waveDir: ocean.sea_surface_wave_from_direction ?? d0.wind_from_direction ?? 220,
    wavePeriod: ocean.sea_surface_wave_period ?? 4,
    waterC: ocean.sea_water_temperature ?? 15,
    dewC: d0.dew_point_temperature ?? FALLBACK.dewC,
    updated: new Date().toISOString(),
  };
}

async function metJson(url: string): Promise<{ details: Details }> {
  const res = await fetch(url, { headers: { Accept: "application/json" } });
  if (!res.ok) throw new Error(String(res.status));
  const json = (await res.json()) as {
    properties?: { timeseries?: Array<{ data?: { instant?: { details?: Details } } }> };
  };
  return { details: json.properties?.timeseries?.[0]?.data?.instant?.details ?? {} };
}

/** MET Norway first; CORS or network failure falls back so the HUD never blanks. */
export async function fetchWeather(pos: LatLng): Promise<WeatherSnap> {
  try {
    const q = `lat=${pos.lat.toFixed(4)}&lon=${pos.lng.toFixed(4)}`;
    const air = await metJson(`https://api.met.no/weatherapi/locationforecast/2.0/compact?${q}`);
    let ocean: Details = {};
    try {
      ocean = (await metJson(`https://api.met.no/weatherapi/oceanforecast/2.0/complete?${q}`)).details;
    } catch {
      /* keep air-only */
    }
    return snapFromMet(air.details, ocean);
  } catch {
    return { ...FALLBACK, updated: new Date().toISOString() };
  }
}

export { fogStatus } from "./rules.ts";
