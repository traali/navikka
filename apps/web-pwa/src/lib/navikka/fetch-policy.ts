import { haversineM, type LatLng } from "./geo.ts";

/** MET / FMI usable grid. ~5.5 km — NOT GPS precision. */
export const WEATHER_SNAP_DEG = 0.05;
export const WEATHER_TTL_MS = 10 * 60 * 1000;
export const WEATHER_STALE_MS = 15 * 60 * 1000;
export const AIS_TTL_FOLLOW_MS = 60 * 1000;
export const AIS_TTL_IDLE_MS = 180 * 1000;
export const GPS_MIN_MS = 500;
export const GPS_MIN_M = 15;
export const FOLLOW_PAN_MIN_M = 12;
export const POLL_CHECK_MS = 15_000;
export const DEMO_TICK_MS = 1000;
export const AIS_BBOX_DEG = 0.4;
/** Digitraffic `radius` is kilometres. 0.4° ≈ 44 km. */
export const AIS_RADIUS_KM = 45;
export const WEATHER_RETRY_MS = 60 * 1000;
export const AIS_RETRY_MS = 60 * 1000;

export const pollStats = {
  weather: 0,
  ais: 0,
  skippedWeather: 0,
  skippedAis: 0,
};

export function resetPollStats() {
  pollStats.weather = 0;
  pollStats.ais = 0;
  pollStats.skippedWeather = 0;
  pollStats.skippedAis = 0;
}

export function snapCoord(v: number, deg = WEATHER_SNAP_DEG) {
  return Math.round(v / deg) * deg;
}

export function snapPos(pos: LatLng, deg = WEATHER_SNAP_DEG): LatLng {
  return { lat: snapCoord(pos.lat, deg), lng: snapCoord(pos.lng, deg) };
}

export function weatherQuery(pos: LatLng) {
  const s = snapPos(pos);
  return { lat: s.lat.toFixed(2), lon: s.lng.toFixed(2), snapped: s };
}

export function aisQuery(pos: LatLng) {
  const latitude = pos.lat.toFixed(3);
  const longitude = pos.lng.toFixed(3);
  return {
    latitude,
    longitude,
    radius: String(AIS_RADIUS_KM),
    url: `https://meri.digitraffic.fi/api/ais/v1/locations?latitude=${latitude}&longitude=${longitude}&radius=${AIS_RADIUS_KM}`,
  };
}

/** First LIVE GPS sample must not inherit demo 6.2 kn / 112°. CriOS speed is often null — derive from movement. */
export function deviceFixKinematics(opts: {
  wasDemo: boolean;
  speedMs: number | null | undefined;
  headingDeg: number | null | undefined;
  prevSogKn: number;
  prevCog: number;
  movedM?: number;
  dtMs?: number;
}): { sogKn: number; cog: number } {
  const speedKnown = opts.speedMs != null && Number.isFinite(opts.speedMs);
  const headingKnown = opts.headingDeg != null && Number.isFinite(opts.headingDeg);
  const derivedKn =
    !speedKnown &&
    opts.movedM != null &&
    opts.dtMs != null &&
    opts.dtMs >= 400 &&
    opts.movedM >= 8
      ? (opts.movedM / (opts.dtMs / 1000)) * 1.94384
      : 0;
  const kn = speedKnown ? opts.speedMs! * 1.94384 : derivedKn;
  let sogKn: number;
  if (speedKnown || derivedKn > 0.4) sogKn = kn > 0.4 ? kn : 0;
  else if (opts.wasDemo) sogKn = 0;
  else sogKn = opts.prevSogKn;
  const cog = headingKnown
    ? ((opts.headingDeg! + 360) % 360)
    : opts.wasDemo
      ? 0
      : opts.prevCog;
  return { sogKn, cog };
}

export type RefreshDecision =
  | { fetch: true; reason: "first" | "ttl" | "moved"; snapped: LatLng }
  | { fetch: false; reason: "hidden" | "fresh" | "inflight" | "backoff"; snapped: LatLng };

export function decideWeatherFetch(opts: {
  now: number;
  pos: LatLng;
  lastAt: number | null;
  lastPos: LatLng | null;
  lastAttemptAt: number | null;
  hidden: boolean;
  inflight: boolean;
}): RefreshDecision {
  const snapped = snapPos(opts.pos);
  if (opts.hidden) return { fetch: false, reason: "hidden", snapped };
  if (opts.inflight) return { fetch: false, reason: "inflight", snapped };
  if (opts.lastAt == null) {
    if (opts.lastAttemptAt != null && opts.now - opts.lastAttemptAt < WEATHER_RETRY_MS) {
      return { fetch: false, reason: "backoff", snapped };
    }
    return { fetch: true, reason: "first", snapped };
  }
  const sameCell =
    opts.lastPos != null &&
    snapPos(opts.lastPos).lat === snapped.lat &&
    snapPos(opts.lastPos).lng === snapped.lng;
  if (!sameCell) return { fetch: true, reason: "moved", snapped };
  const age = opts.now - opts.lastAt;
  if (age < WEATHER_TTL_MS) return { fetch: false, reason: "fresh", snapped };
  if (opts.lastAttemptAt != null && opts.now - opts.lastAttemptAt < WEATHER_RETRY_MS) {
    return { fetch: false, reason: "backoff", snapped };
  }
  return { fetch: true, reason: "ttl", snapped };
}

export function decideAisFetch(opts: {
  now: number;
  lastAt: number | null;
  lastAttemptAt: number | null;
  hidden: boolean;
  inflight: boolean;
  active: boolean;
}): { fetch: boolean; reason: "first" | "ttl" | "hidden" | "fresh" | "inflight" | "backoff" } {
  if (opts.hidden) return { fetch: false, reason: "hidden" };
  if (opts.inflight) return { fetch: false, reason: "inflight" };
  if (opts.lastAt == null) {
    if (opts.lastAttemptAt != null && opts.now - opts.lastAttemptAt < AIS_RETRY_MS) {
      return { fetch: false, reason: "backoff" };
    }
    return { fetch: true, reason: "first" };
  }
  const ttl = opts.active ? AIS_TTL_FOLLOW_MS : AIS_TTL_IDLE_MS;
  if (opts.now - opts.lastAt < ttl) return { fetch: false, reason: "fresh" };
  if (opts.lastAttemptAt != null && opts.now - opts.lastAttemptAt < AIS_RETRY_MS) {
    return { fetch: false, reason: "backoff" };
  }
  return { fetch: true, reason: "ttl" };
}

export function decideGpsAccept(opts: {
  now: number;
  pos: LatLng;
  lastAt: number;
  lastPos: LatLng | null;
}): boolean {
  if (opts.lastPos == null) return true;
  const dt = opts.now - opts.lastAt;
  const dist = haversineM(opts.lastPos, opts.pos);
  return dt >= GPS_MIN_MS || dist >= GPS_MIN_M;
}

export function decideFollowPan(opts: {
  follow: boolean;
  followJustOn: boolean;
  from: LatLng;
  to: LatLng;
  sogKn: number;
}): { pan: boolean; animate: boolean } {
  if (!opts.follow) return { pan: false, animate: false };
  if (opts.followJustOn) return { pan: true, animate: opts.sogKn <= 2 };
  const dist = haversineM(opts.from, opts.to);
  if (dist < FOLLOW_PAN_MIN_M) return { pan: false, animate: false };
  return { pan: true, animate: opts.sogKn <= 2 };
}

export function weatherAgeMs(updated: string | number, now = Date.now()) {
  const t = typeof updated === "number" ? updated : Date.parse(updated);
  if (!Number.isFinite(t)) return Infinity;
  return Math.max(0, now - t);
}

export function formatWeatherAge(ms: number, lang: "fi" | "en") {
  if (ms < 45_000) return lang === "fi" ? "juuri" : "just now";
  const min = Math.max(1, Math.round(ms / 60_000));
  return lang === "fi" ? `${min} min sitten` : `${min} min ago`;
}

export function isWeatherStale(ms: number) {
  return ms >= WEATHER_STALE_MS;
}
