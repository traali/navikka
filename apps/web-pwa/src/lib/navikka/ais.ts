import { type LatLng } from "./geo.ts";
import { AIS_BBOX_DEG } from "./fetch-policy.ts";
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

export async function fetchAisAround(pos: LatLng): Promise<LiveAis[]> {
  const url = `https://meri.digitraffic.fi/api/ais/v1/locations?latitude=${pos.lat.toFixed(3)}&longitude=${pos.lng.toFixed(3)}&radius=45`;
  const res = await fetch(url, {
    headers: { Accept: "application/json" },
  });
  if (!res.ok) throw new Error(`AIS fetch failed: ${res.status}`);
  const json = (await res.json()) as { features?: Feature[] };
    const near: LiveAis[] = [];
    for (const f of json.features ?? []) {
      const coords = f.geometry?.coordinates;
      if (!coords) continue;
      const [lng, lat] = coords;
      if (Math.abs(lat - pos.lat) > AIS_BBOX_DEG || Math.abs(lng - pos.lng) > AIS_BBOX_DEG) continue;
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
      const da = (a.pos.lat - pos.lat) ** 2 + (a.pos.lng - pos.lng) ** 2;
      const db = (b.pos.lat - pos.lat) ** 2 + (b.pos.lng - pos.lng) ** 2;
      return da - db;
    });
    return near.slice(0, 48);
}

export async function fetchLiveAis(pos: LatLng): Promise<LiveAis[]> {
  return fetchAisAround(pos);
}
