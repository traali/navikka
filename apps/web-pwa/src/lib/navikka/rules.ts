import { MIN_SIZES, SPEED_ZONES } from "./catalog.ts";
import { formatDdm, kmhToKn, pointInRing, type LatLng } from "./geo.ts";

export function fogStatus(w: {
  visM: number | null;
  tempC: number;
  dewC: number | null;
  humidity: number | null;
}) {
  const rh = w.humidity ?? 0;
  const spread = w.dewC == null ? Infinity : Math.abs(w.tempC - w.dewC);
  if (w.visM == null) {
    if (spread <= 1.2 && rh >= 90) {
      return {
        level: "yellow" as const,
        fi: "Utua / merisumuriski.",
        en: "Mist / sea-fog condensation risk.",
      };
    }
    return {
      level: "muted" as const,
      fi: "Näkyvyyttä ei mitattu.",
      en: "No visibility observation.",
    };
  }
  if (w.visM <= 500)
    return {
      level: "red" as const,
      fi: "Tiheä sumu — äänimerkit, kulkuvalot, hidasta.",
      en: "Dense fog — sound signals, nav lights, reduce speed.",
    };
  if (w.visM <= 1000)
    return {
      level: "orange" as const,
      fi: "Sumuvaroitus — tähystäjä, AIS/tutka.",
      en: "Fog warning — post lookout, watch AIS.",
    };
  if (w.visM <= 2500 || (spread <= 1.2 && rh >= 90))
    return {
      level: "yellow" as const,
      fi: "Utua / merisumuriski.",
      en: "Mist / sea-fog condensation risk.",
    };
  return { level: "green" as const, fi: "Näkyvyys hyvä.", en: "Visibility good." };
}

export function kindFromName(name: string): "ferry" | "cargo" | "tanker" | "pilot" | "pleasure" {
  const n = name.toUpperCase();
  if (n.includes("PILOT") || n.includes("LUOTSI")) return "pilot";
  if (n.includes("TANK")) return "tanker";
  if (
    n.includes("MEGASTAR") ||
    n.includes("SILJA") ||
    n.includes("VIKING") ||
    n.includes("SUOMENLINNA") ||
    n.includes("FERRY")
  )
    return "ferry";
  if (n.includes("CARGO") || n.includes("FINN") || n.includes("CONTAINER")) return "cargo";
  return "pleasure";
}

export type SpeedUnit = "kn" | "kmh";
export type WindUnit = "ms" | "kn";
export type DepthUnit = "m" | "ft";

export function fmtSpeed(kn: number, unit: SpeedUnit) {
  if (unit === "kmh") return `${(kn * 1.852).toFixed(1)} km/h`;
  return `${kn.toFixed(1)} kn`;
}

export function fmtWind(ms: number, unit: WindUnit) {
  if (unit === "kn") return `${(ms / 0.514444).toFixed(1)} kn`;
  return `${ms.toFixed(1)} m/s`;
}

export function fmtDepth(m: number, unit: DepthUnit) {
  if (unit === "ft") return `${(m * 3.28084).toFixed(1)} ft`;
  return `${m.toFixed(1)} m`;
}

export function speedLimitKmh(pos: LatLng) {
  for (const z of SPEED_ZONES) {
    if (pointInRing(pos, z.ring)) return z.limitKmh;
  }
  return null;
}

export function overSpeedLimit(pos: LatLng, sogKn: number) {
  const limit = speedLimitKmh(pos);
  if (limit == null) return null;
  return sogKn > kmhToKn(limit) + 0.2 ? limit : null;
}

export function catchLegal(species: string, cm: number) {
  const spec = MIN_SIZES.find((s) => s.id === species);
  if (!spec) return { known: false, legal: true, minCm: 0 };
  if (spec.cm <= 0) return { known: true, legal: true, minCm: 0 };
  return { known: true, legal: cm >= spec.cm, minCm: spec.cm };
}

export function maydayScript(opts: {
  name: string;
  pos: LatLng;
  draftM: number;
  fairway?: string | null;
  ukc?: number | null;
}) {
  const pos = `Position ${formatDdm(opts.pos)}`;
  const draft = `Draft ${opts.draftM.toFixed(1)} m`;
  if (!opts.fairway || opts.ukc == null) {
    return `MAYDAY MAYDAY MAYDAY. This is ${opts.name}. ${pos}. ${draft}. Off-fairway / avomeri.`;
  }
  return `MAYDAY MAYDAY MAYDAY. This is ${opts.name}. ${pos}. ${draft}. Fairway ${opts.fairway} UKC ${opts.ukc.toFixed(1)} m.`;
}

/** iOS 15.3 and older Chrome/WebKit lack crypto.randomUUID. */
export function newId() {
  const c = globalThis.crypto;
  if (c && typeof c.randomUUID === "function") return c.randomUUID();
  return `id-${Date.now().toString(36)}-${Math.random().toString(36).slice(2, 10)}`;
}

/**
 * Clipboard on iPhone Chrome is WebKit: Clipboard API is often blocked,
 * so fall back to a hidden textarea + execCommand.
 */
export async function copyText(text: string): Promise<boolean> {
  if (typeof navigator !== "undefined" && navigator.clipboard?.writeText) {
    try {
      await navigator.clipboard.writeText(text);
      return true;
    } catch {
      /* continue to execCommand fallback */
    }
  }
  if (typeof document === "undefined") return false;
  const ta = document.createElement("textarea");
  ta.value = text;
  ta.setAttribute("readonly", "");
  ta.setAttribute("aria-hidden", "true");
  ta.style.position = "fixed";
  ta.style.top = "0";
  ta.style.left = "0";
  ta.style.opacity = "0";
  document.body.appendChild(ta);
  ta.focus();
  ta.select();
  ta.setSelectionRange(0, text.length);
  try {
    return document.execCommand("copy");
  } catch {
    return false;
  } finally {
    ta.remove();
  }
}

/** iPhone Chrome: Share sheet is more reliable than clipboard for SOS. */
export async function shareText(title: string, text: string): Promise<boolean> {
  const nav = typeof navigator !== "undefined" ? navigator : undefined;
  const share = nav?.share?.bind(nav);
  if (typeof share === "function") {
    try {
      await share({ title, text });
      return true;
    } catch {
      /* cancelled or unsupported — fall through */
    }
  }
  return copyText(text);
}
