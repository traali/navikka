export type LatLng = { lat: number; lng: number };

export const HELSINKI_SEA: LatLng = { lat: 60.155, lng: 24.89 };

const EARTH_M = 6371000;

export function toRad(d: number) {
  return (d * Math.PI) / 180;
}

export function toDeg(r: number) {
  return (r * 180) / Math.PI;
}

export function haversineM(a: LatLng, b: LatLng) {
  const dLat = toRad(b.lat - a.lat);
  const dLng = toRad(b.lng - a.lng);
  const s =
    Math.sin(dLat / 2) ** 2 +
    Math.cos(toRad(a.lat)) * Math.cos(toRad(b.lat)) * Math.sin(dLng / 2) ** 2;
  return 2 * EARTH_M * Math.asin(Math.min(1, Math.sqrt(s)));
}

export function nmBetween(a: LatLng, b: LatLng) {
  return haversineM(a, b) / 1852;
}

export function bearingDeg(a: LatLng, b: LatLng) {
  const y = Math.sin(toRad(b.lng - a.lng)) * Math.cos(toRad(b.lat));
  const x =
    Math.cos(toRad(a.lat)) * Math.sin(toRad(b.lat)) -
    Math.sin(toRad(a.lat)) * Math.cos(toRad(b.lat)) * Math.cos(toRad(b.lng - a.lng));
  return (toDeg(Math.atan2(y, x)) + 360) % 360;
}

export function offsetMeters(origin: LatLng, eastM: number, northM: number): LatLng {
  return {
    lat: origin.lat + northM / 111320,
    lng: origin.lng + eastM / (111320 * Math.cos(toRad(origin.lat))),
  };
}

export function destination(origin: LatLng, bearing: number, meters: number): LatLng {
  const br = toRad(bearing);
  return offsetMeters(origin, Math.sin(br) * meters, Math.cos(br) * meters);
}

export function formatDdm(pos: LatLng) {
  const fmt = (v: number, posH: string, negH: string) => {
    const hemi = v >= 0 ? posH : negH;
    const abs = Math.abs(v);
    const deg = Math.floor(abs);
    const min = (abs - deg) * 60;
    return `${deg}°${min.toFixed(3).padStart(6, "0")}' ${hemi}`;
  };
  return `${fmt(pos.lat, "N", "S")}  ${fmt(pos.lng, "E", "W")}`;
}

export function padCourse(deg: number) {
  const n = ((Math.round(deg) % 360) + 360) % 360;
  return `${n.toString().padStart(3, "0")}°`;
}

export function knToMs(kn: number) {
  return kn * 0.514444;
}

export function msToKn(ms: number) {
  return ms / 0.514444;
}

export function kmhToKn(kmh: number) {
  return kmh / 1.852;
}

export type CpaResult = {
  cpaNm: number;
  tcpaMin: number;
  colliding: boolean;
};

/** Great-circle-ish CPA using local ENU approximation. */
export function computeCpa(
  own: LatLng,
  ownCog: number,
  ownSogKn: number,
  tgt: LatLng,
  tgtCog: number,
  tgtSogKn: number,
): CpaResult {
  const dx = haversineM(own, { lat: own.lat, lng: tgt.lng }) * Math.sign(tgt.lng - own.lng);
  const dy = haversineM(own, { lat: tgt.lat, lng: own.lng }) * Math.sign(tgt.lat - own.lat);
  const ovx = knToMs(ownSogKn) * Math.sin(toRad(ownCog));
  const ovy = knToMs(ownSogKn) * Math.cos(toRad(ownCog));
  const tvx = knToMs(tgtSogKn) * Math.sin(toRad(tgtCog));
  const tvy = knToMs(tgtSogKn) * Math.cos(toRad(tgtCog));
  const rvx = tvx - ovx;
  const rvy = tvy - ovy;
  const rr = rvx * rvx + rvy * rvy;
  if (rr < 1e-6) {
    return { cpaNm: Math.hypot(dx, dy) / 1852, tcpaMin: Infinity, colliding: false };
  }
  const tcpaSec = -((dx * rvx + dy * rvy) / rr);
  const cpaM = Math.hypot(dx + rvx * tcpaSec, dy + rvy * tcpaSec);
  return {
    cpaNm: cpaM / 1852,
    tcpaMin: tcpaSec / 60,
    colliding: tcpaSec > 0 && tcpaSec < 12 * 60 && cpaM < 185.2,
  };
}

export function routeStats(points: LatLng[], sogKn: number) {
  let meters = 0;
  const legs: { from: LatLng; to: LatLng; nm: number; brg: number }[] = [];
  for (let i = 1; i < points.length; i++) {
    const nm = nmBetween(points[i - 1]!, points[i]!);
    meters += nm * 1852;
    legs.push({
      from: points[i - 1]!,
      to: points[i]!,
      nm,
      brg: bearingDeg(points[i - 1]!, points[i]!),
    });
  }
  const nm = meters / 1852;
  const hours = sogKn > 0.3 ? nm / sogKn : 0;
  return { nm, legs, etaMin: hours * 60 };
}

export function underKeelClearance(fairwayDepthM: number, draftM: number, seaAnomalyM: number) {
  return fairwayDepthM + seaAnomalyM - draftM;
}

/** Ray-cast point-in-polygon. Ring may be open or closed. */
export function pointInRing(pos: LatLng, ring: LatLng[]) {
  if (ring.length < 3) return false;
  let inside = false;
  for (let i = 0, j = ring.length - 1; i < ring.length; j = i++) {
    const yi = ring[i]!.lat;
    const xi = ring[i]!.lng;
    const yj = ring[j]!.lat;
    const xj = ring[j]!.lng;
    if (yi === yj) continue;
    const intersect =
      yi > pos.lat !== yj > pos.lat && pos.lng < ((xj - xi) * (pos.lat - yi)) / (yj - yi) + xi;
    if (intersect) inside = !inside;
  }
  return inside;
}

/** Parse "60.155 24.89" or "60.155,24.89" inside Finnish waters. */
export function parseLatLngQuery(q: string): LatLng | null {
  const m = q
    .replace(",", " ")
    .trim()
    .match(/^(-?\d+\.?\d*)\s+(-?\d+\.?\d*)$/);
  if (!m) return null;
  const lat = Number(m[1]);
  const lng = Number(m[2]);
  if (lat < 59 || lat > 71 || lng < 19 || lng > 32) return null;
  return { lat, lng };
}
