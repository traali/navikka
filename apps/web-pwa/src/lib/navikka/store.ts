import { create } from "zustand";
import { persist } from "zustand/middleware";
import { AIS_SEED, HARBORS, MIN_SIZES, nearestFairwayDepth, type Harbor } from "./catalog.ts";
import {
  destination,
  formatDdm,
  haversineM,
  HELSINKI_SEA,
  type LatLng,
  underKeelClearance,
} from "./geo.ts";
import { COPY, type Lang } from "./i18n.ts";
import { copyText, newId, overSpeedLimit, speedLimitKmh } from "./rules.ts";

export type Tab = "map" | "fishing" | "weather" | "menu";
export type Theme = "night" | "solar" | "deep" | "aurora" | "red";
export type Sheet = "none" | "layers" | "sos" | "search" | "detail" | "voice";
export type SpeedUnit = "kn" | "kmh";
export type WindUnit = "ms" | "kn";
export type DepthUnit = "m" | "ft";

export type CatchEntry = {
  id: string;
  species: string;
  cm: number;
  at: string;
  pos: LatLng;
};

export type WeatherSnap = {
  tempC: number;
  windMs: number;
  gustMs: number;
  windDir: number;
  pressureHpa: number;
  humidity: number;
  visM: number;
  cloudPct: number;
  waveM: number;
  waveDir: number;
  wavePeriod: number;
  waterC: number;
  dewC: number;
  updated: string;
};

export type AisTarget = {
  mmsi: string;
  name: string;
  sogKn: number;
  cog: number;
  pos: LatLng;
  kind: "ferry" | "cargo" | "tanker" | "pilot" | "pleasure";
};

export type Selection =
  | { type: "harbor"; id: string }
  | { type: "ais"; mmsi: string }
  | { type: "fish"; id: string }
  | { type: "wp"; index: number };

type NavState = {
  tab: Tab;
  theme: Theme;
  lang: Lang;
  sheet: Sheet;
  query: string;
  follow: boolean;
  planning: boolean;
  navigating: boolean;
  roughSea: boolean;
  speedUnit: SpeedUnit;
  windUnit: WindUnit;
  depthUnit: DepthUnit;
  layers: {
    seamarks: boolean;
    ais: boolean;
    harbors: boolean;
    fishing: boolean;
    speedLimits: boolean;
    satellite: boolean;
  };
  vessel: { name: string; draftM: number; loaM: number; airDraftM: number; fuelL: number };
  pos: LatLng;
  sogKn: number;
  cog: number;
  gpsSource: "demo" | "device";
  gpsAccM: number;
  waypoints: LatLng[];
  catches: CatchEntry[];
  weather: WeatherSnap | null;
  weatherError: string | null;
  weatherAt: number | null;
  weatherPos: LatLng | null;
  weatherFetching: boolean;
  ais: AisTarget[];
  aisAt: number | null;
  selection: Selection | null;
  copied: boolean;
  setTab: (tab: Tab) => void;
  setTheme: (theme: Theme) => void;
  setLang: (lang: Lang) => void;
  setSheet: (sheet: Sheet) => void;
  setQuery: (q: string) => void;
  toggleLayer: (k: keyof NavState["layers"]) => void;
  toggleFollow: () => void;
  togglePlanning: () => void;
  toggleNav: () => void;
  toggleRough: () => void;
  setUnits: (p: Partial<Pick<NavState, "speedUnit" | "windUnit" | "depthUnit">>) => void;
  setVessel: (v: Partial<NavState["vessel"]>) => void;
  setPos: (pos: LatLng, sogKn?: number, cog?: number, source?: "demo" | "device", acc?: number) => void;
  addWaypoint: (p: LatLng) => void;
  removeWaypoint: (index: number) => void;
  clearRoute: () => void;
  addCatch: (species: string, cm: number) => void;
  setWeather: (w: WeatherSnap | null, err?: string | null) => void;
  setAis: (targets: AisTarget[]) => void;
  select: (s: Selection | null) => void;
  tickDemo: () => void;
  copyPos: () => Promise<void>;
};

const LS = "navikka-v1";

export const useNav = create<NavState>()(
  persist(
    (set, get) => ({
      tab: "map",
      theme: "night",
      lang: "fi",
      sheet: "none",
      query: "",
      follow: true,
      planning: false,
      navigating: false,
      roughSea: false,
      speedUnit: "kn",
      windUnit: "ms",
      depthUnit: "m",
      layers: {
        seamarks: true,
        ais: true,
        harbors: true,
        fishing: false,
        speedLimits: true,
        satellite: false,
      },
      vessel: { name: "Oma vene", draftM: 0.9, loaM: 6.4, airDraftM: 2.1, fuelL: 80 },
      pos: HELSINKI_SEA,
      sogKn: 6.2,
      cog: 112,
      gpsSource: "demo",
      gpsAccM: 8,
      waypoints: [],
      catches: [],
      weather: null,
      weatherError: null,
      weatherAt: null,
      weatherPos: null,
      weatherFetching: false,
      ais: AIS_SEED,
      aisAt: null,
      selection: null,
      copied: false,
      setTab: (tab) => set({ tab, sheet: "none" }),
      setTheme: (theme) => set({ theme }),
      setLang: (lang) => set({ lang }),
      setSheet: (sheet) => set({ sheet }),
      setQuery: (query) => set({ query, sheet: query ? "search" : get().sheet === "search" ? "none" : get().sheet }),
      toggleLayer: (k) => set({ layers: { ...get().layers, [k]: !get().layers[k] } }),
      toggleFollow: () => set({ follow: !get().follow }),
      togglePlanning: () => set({ planning: !get().planning, tab: "map" }),
      toggleNav: () => set({ navigating: !get().navigating, follow: true, tab: "map" }),
      toggleRough: () => set({ roughSea: !get().roughSea }),
      setUnits: (p) => set(p),
      setVessel: (v) => set({ vessel: { ...get().vessel, ...v } }),
      setPos: (pos, sogKn, cog, source, acc) =>
        set({
          pos,
          sogKn: sogKn ?? get().sogKn,
          cog: cog ?? get().cog,
          gpsSource: source ?? get().gpsSource,
          gpsAccM: acc ?? get().gpsAccM,
        }),
      addWaypoint: (p) => set({ waypoints: [...get().waypoints, p] }),
      removeWaypoint: (index) => {
        const waypoints = get().waypoints.filter((_, i) => i !== index);
        const sel = get().selection;
        const drop = sel?.type === "wp";
        set({ waypoints, selection: drop ? null : sel, sheet: drop ? "none" : get().sheet });
      },
      clearRoute: () => set({ waypoints: [], navigating: false, planning: false }),
      addCatch: (species, cm) =>
        set({
          catches: [
            {
              id: newId(),
              species,
              cm,
              at: new Date().toISOString(),
              pos: get().pos,
            },
            ...get().catches,
          ].slice(0, 40),
        }),
      setWeather: (weather, weatherError = null) => {
        if (weather) {
          set({
            weather,
            weatherError: null,
            weatherAt: Date.now(),
            weatherPos: get().pos,
            weatherFetching: false,
          });
          return;
        }
        set({ weatherError: weatherError ?? get().weatherError, weatherFetching: false });
      },
      setAis: (ais) =>
        set({
          ais: ais.length ? ais : get().ais,
          aisAt: ais.length ? Date.now() : get().aisAt,
        }),
      select: (selection) => set({ selection, sheet: selection ? "detail" : "none" }),
      tickDemo: () => {
        const s = get();
        if (s.gpsSource !== "demo") return;
        const next = destination(s.pos, s.cog, knToMeters(s.sogKn, 1));
        const wander = s.cog + (Math.random() - 0.5) * 4;
        set({ pos: next, cog: (wander + 360) % 360, sogKn: 5.4 + Math.random() * 1.6 });
      },
      copyPos: async () => {
        const text = formatDdm(get().pos);
        const ok = await copyText(text);
        if (!ok) return;
        set({ copied: true });
        setTimeout(() => set({ copied: false }), 1600);
      },
    }),
    {
      name: LS,
      partialize: (s) => ({
        theme: s.theme,
        lang: s.lang,
        roughSea: s.roughSea,
        speedUnit: s.speedUnit,
        windUnit: s.windUnit,
        depthUnit: s.depthUnit,
        layers: s.layers,
        vessel: s.vessel,
        waypoints: s.waypoints,
        catches: s.catches,
      }),
    },
  ),
);

function knToMeters(kn: number, seconds: number) {
  return kn * 0.514444 * seconds;
}

export function t() {
  return COPY[useNav.getState().lang];
}

export function useCopy() {
  const lang = useNav((s) => s.lang);
  return COPY[lang];
}

export function currentHarbor(): Harbor | undefined {
  const id = useNav.getState().selection;
  if (id?.type !== "harbor") return undefined;
  return HARBORS.find((h) => h.id === id.id);
}

export { fmtDepth, fmtSpeed, fmtWind } from "./rules.ts";

export function ukcNow() {
  const s = useNav.getState();
  const fw = nearestFairwayDepth(s.pos);
  if (!fw) return { fw: null, ukc: null };
  const sea = (s.weather?.waveM ?? 0) * -0.05;
  return { fw, ukc: underKeelClearance(fw.depthM, s.vessel.draftM, sea) };
}

export function speedZoneLimitKmh(pos: LatLng) {
  return speedLimitKmh(pos);
}

export function overLimit(pos: LatLng, sogKn: number) {
  return overSpeedLimit(pos, sogKn);
}

export function minSizeFor(species: string) {
  return MIN_SIZES.find((s) => s.id === species);
}

export function nearestHarbor(pos: LatLng) {
  let best = HARBORS[0]!;
  let d = Infinity;
  for (const h of HARBORS) {
    const m = haversineM(pos, h.pos);
    if (m < d) {
      d = m;
      best = h;
    }
  }
  return { harbor: best, nm: d / 1852 };
}
