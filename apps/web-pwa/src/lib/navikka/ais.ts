import { HELSINKI_SEA, type LatLng } from "./geo.ts";
import { kindFromName } from "./rules.ts";

export type LiveAis = {
  mmsi: string;
  name: string;
  sogKn: number;
  cog: number;
  pos: LatLng;
  kind: "ferry" | "cargo" | "tanker" | "pilot" | "pleasure";
};

export { kindFromName };

type Feature = {
  mmsi?: number;
  properties?: { mmsi?: number; sog?: number; cog?: number; heading?: number; name?: string };
  geometry?: { coordinates?: [number, number] };
};

/** Digitraffic AIS; CORS failure leaves the seeded Helsinki traffic in the store. */
export async function fetchLiveAis(): Promise<LiveAis[]> {
  try {
    const res = await fetch("https://meri.digitraffic.fi/api/ais/v1/locations");
    if (!res.ok) return [];
    const json = (await res.json()) as { features?: Feature[] };
    const near: LiveAis[] = [];
    for (const f of json.features ?? []) {
      const coords = f.geometry?.coordinates;
      if (!coords) continue;
      const [lng, lat] = coords;
      if (lat < 59.7 || lat > 60.6 || lng < 23.8 || lng > 26.2) continue;
      const mmsi = String(f.properties?.mmsi ?? f.mmsi ?? "");
      if (!mmsi) continue;
      near.push({
        mmsi,
        name: f.properties?.name || mmsi,
        sogKn: f.properties?.sog ?? 0,
        cog: f.properties?.cog ?? f.properties?.heading ?? 0,
        pos: { lat, lng },
        kind: kindFromName(f.properties?.name || ""),
      });
    }
    near.sort((a, b) => {
      const da = (a.pos.lat - HELSINKI_SEA.lat) ** 2 + (a.pos.lng - HELSINKI_SEA.lng) ** 2;
      const db = (b.pos.lat - HELSINKI_SEA.lat) ** 2 + (b.pos.lng - HELSINKI_SEA.lng) ** 2;
      return da - db;
    });
    return near.slice(0, 48);
  } catch {
    return [];
  }
}
