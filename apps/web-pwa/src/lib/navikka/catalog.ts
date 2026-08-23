import { type LatLng, HELSINKI_SEA, haversineM } from "./geo.ts";

export type Harbor = {
  id: string;
  name: string;
  nameEn: string;
  pos: LatLng;
  kind: "guest" | "service" | "excursion" | "ramp";
  depthM: number;
  vhf?: string;
  phone?: string;
  fuel: boolean;
  power: boolean;
  water: boolean;
  sauna: boolean;
  pumpout: boolean;
};

export const HARBORS: Harbor[] = [
  {
    id: "kauppatori",
    name: "Helsingin vierasvenesatama",
    nameEn: "Helsinki Market Square marina",
    pos: { lat: 60.1674, lng: 24.9538 },
    kind: "guest",
    depthM: 3.5,
    vhf: "71",
    phone: "09 310 37900",
    fuel: false,
    power: true,
    water: true,
    sauna: false,
    pumpout: true,
  },
  {
    id: "suomenlinna",
    name: "Suomenlinnan vierassatama",
    nameEn: "Suomenlinna guest harbor",
    pos: { lat: 60.1468, lng: 24.9896 },
    kind: "guest",
    depthM: 3.2,
    vhf: "71",
    fuel: false,
    power: true,
    water: true,
    sauna: true,
    pumpout: false,
  },
  {
    id: "lauttasaari",
    name: "Lauttasaaren venesatama",
    nameEn: "Lauttasaari marina",
    pos: { lat: 60.1586, lng: 24.8774 },
    kind: "service",
    depthM: 2.8,
    fuel: true,
    power: true,
    water: true,
    sauna: false,
    pumpout: true,
  },
  {
    id: "hss",
    name: "HSS / Liuskasaari",
    nameEn: "HSS Liuskasaari",
    pos: { lat: 60.1522, lng: 24.9195 },
    kind: "guest",
    depthM: 4.0,
    vhf: "68",
    fuel: false,
    power: true,
    water: true,
    sauna: true,
    pumpout: true,
  },
  {
    id: "haukilahti",
    name: "Haukilahden venesatama",
    nameEn: "Haukilahti marina",
    pos: { lat: 60.1558, lng: 24.775 },
    kind: "guest",
    depthM: 2.4,
    fuel: true,
    power: true,
    water: true,
    sauna: true,
    pumpout: true,
  },
  {
    id: "koivusaari",
    name: "Koivusaaren venesatama",
    nameEn: "Koivusaari marina",
    pos: { lat: 60.1642, lng: 24.8548 },
    kind: "service",
    depthM: 3.0,
    fuel: false,
    power: true,
    water: true,
    sauna: false,
    pumpout: true,
  },
  {
    id: "porkkala",
    name: "Porkkalan retkisatama",
    nameEn: "Porkkala excursion harbor",
    pos: { lat: 59.986, lng: 24.52 },
    kind: "excursion",
    depthM: 2.5,
    fuel: false,
    power: false,
    water: false,
    sauna: false,
    pumpout: false,
  },
  {
    id: "katajanokka",
    name: "Katajanokan laituri",
    nameEn: "Katajanokka quay",
    pos: { lat: 60.1669, lng: 24.9688 },
    kind: "service",
    depthM: 6.1,
    fuel: false,
    power: true,
    water: true,
    sauna: false,
    pumpout: false,
  },
  {
    id: "porslahti",
    name: "Porslahden veneluiska",
    nameEn: "Porslahti boat ramp",
    pos: { lat: 60.1768, lng: 25.052 },
    kind: "ramp",
    depthM: 1.4,
    fuel: false,
    power: false,
    water: false,
    sauna: false,
    pumpout: false,
  },
];

export type Fairway = {
  id: string;
  name: string;
  depthM: number;
  path: LatLng[];
};

export const FAIRWAYS: Fairway[] = [
  {
    id: "hel-9",
    name: "Helsinki 9,0 m",
    depthM: 9.0,
    path: [
      { lat: 60.12, lng: 24.96 },
      { lat: 60.14, lng: 24.97 },
      { lat: 60.155, lng: 24.96 },
      { lat: 60.167, lng: 24.958 },
    ],
  },
  {
    id: "lautta-4",
    name: "Lauttasaarensalmi 4,5 m",
    depthM: 4.5,
    path: [
      { lat: 60.152, lng: 24.86 },
      { lat: 60.156, lng: 24.875 },
      { lat: 60.161, lng: 24.892 },
    ],
  },
  {
    id: "local-24",
    name: "Sisäväylä 2,4 m",
    depthM: 2.4,
    path: [
      { lat: 60.148, lng: 24.88 },
      { lat: 60.152, lng: 24.9 },
      { lat: 60.155, lng: 24.915 },
    ],
  },
];

export type SpeedZone = {
  id: string;
  limitKmh: number;
  noWake: boolean;
  ring: LatLng[];
};

export const SPEED_ZONES: SpeedZone[] = [
  {
    id: "kauppatori-5",
    limitKmh: 5,
    noWake: true,
    ring: [
      { lat: 60.1658, lng: 24.948 },
      { lat: 60.1694, lng: 24.948 },
      { lat: 60.1694, lng: 24.961 },
      { lat: 60.1658, lng: 24.961 },
    ],
  },
  {
    id: "lautta-15",
    limitKmh: 15,
    noWake: false,
    ring: [
      { lat: 60.154, lng: 24.868 },
      { lat: 60.162, lng: 24.868 },
      { lat: 60.162, lng: 24.886 },
      { lat: 60.154, lng: 24.886 },
    ],
  },
];

export type FishZone = {
  id: string;
  name: string;
  nameEn: string;
  rule: string;
  ruleEn: string;
  ring: LatLng[];
};

export const FISH_ZONES: FishZone[] = [
  {
    id: "vanhakaupunki",
    name: "Vanhankaupunginlahti",
    nameEn: "Vanhankaupunginlahti reserve",
    rule: "Kalastus kielletty luonnonsuojelualueella ympäri vuoden.",
    ruleEn: "Fishing prohibited year-round in the nature reserve.",
    ring: [
      { lat: 60.198, lng: 24.98 },
      { lat: 60.21, lng: 24.98 },
      { lat: 60.21, lng: 25.02 },
      { lat: 60.198, lng: 25.02 },
    ],
  },
  {
    id: "kallahti",
    name: "Kallahdenniemi",
    nameEn: "Kallahti peninsula",
    rule: "Verkkokalastus kielletty 1.4.–31.7. kutuaikana.",
    ruleEn: "Net fishing prohibited 1 Apr–31 Jul during spawning.",
    ring: [
      { lat: 60.168, lng: 25.118 },
      { lat: 60.178, lng: 25.118 },
      { lat: 60.178, lng: 25.138 },
      { lat: 60.168, lng: 25.138 },
    ],
  },
];

export const MIN_SIZES: { id: string; fi: string; en: string; cm: number }[] = [
  { id: "kuha", fi: "Kuha", en: "Zander", cm: 42 },
  { id: "ahven", fi: "Ahven", en: "Perch", cm: 0 },
  { id: "hauki", fi: "Hauki", en: "Pike", cm: 0 },
  { id: "taimen", fi: "Meritaimen", en: "Sea trout", cm: 60 },
  { id: "loh", fi: "Lohi", en: "Salmon", cm: 60 },
  { id: "siika", fi: "Siika", en: "Whitefish", cm: 0 },
];

export type AisSeed = {
  mmsi: string;
  name: string;
  sogKn: number;
  cog: number;
  pos: LatLng;
  kind: "ferry" | "cargo" | "tanker" | "pilot" | "pleasure";
};

export const AIS_SEED: AisSeed[] = [
  {
    mmsi: "230994000",
    name: "SUOMENLINNA II",
    sogKn: 9.2,
    cog: 128,
    pos: { lat: 60.161, lng: 24.96 },
    kind: "ferry",
  },
  {
    mmsi: "276813000",
    name: "MEGASTAR",
    sogKn: 18.4,
    cog: 196,
    pos: { lat: 60.112, lng: 24.92 },
    kind: "ferry",
  },
  {
    mmsi: "230361000",
    name: "SILJA SYMPHONY",
    sogKn: 16.1,
    cog: 210,
    pos: { lat: 60.08, lng: 24.88 },
    kind: "ferry",
  },
  {
    mmsi: "230123890",
    name: "FINNPULP",
    sogKn: 12.0,
    cog: 88,
    pos: { lat: 60.13, lng: 25.08 },
    kind: "cargo",
  },
  {
    mmsi: "230661000",
    name: "HELSINKI PILOT",
    sogKn: 14.5,
    cog: 310,
    pos: { lat: 60.142, lng: 25.02 },
    kind: "pilot",
  },
  {
    mmsi: "230991110",
    name: "S/Y AURORA",
    sogKn: 5.4,
    cog: 42,
    pos: { lat: 60.149, lng: 24.91 },
    kind: "pleasure",
  },
];

export const SEARCH_INDEX = [
  ...HARBORS.map((h) => ({
    id: h.id,
    kind: "harbor" as const,
    label: h.name,
    labelEn: h.nameEn,
    pos: h.pos,
  })),
  {
    id: "sveaborg",
    kind: "place" as const,
    label: "Suomenlinna",
    labelEn: "Suomenlinna",
    pos: { lat: 60.145, lng: 24.987 },
  },
  {
    id: "home",
    kind: "place" as const,
    label: "Kaivopuisto",
    labelEn: "Kaivopuisto",
    pos: HELSINKI_SEA,
  },
  {
    id: "porkkala",
    kind: "place" as const,
    label: "Porkkala",
    labelEn: "Porkkala",
    pos: { lat: 59.986, lng: 24.52 },
  },
];

/** Skipper is "on" a published channel within ~0.5 NM of a polyline vertex. Beyond: open water. */
export const FAIRWAY_MAX_M = 1000;

export function nearestFairwayDepth(pos: LatLng) {
  let best = FAIRWAYS[0]!;
  let bestD = Infinity;
  for (const f of FAIRWAYS) {
    for (const p of f.path) {
      const d = haversineM(pos, p);
      if (d < bestD) {
        bestD = d;
        best = f;
      }
    }
  }
  if (bestD > FAIRWAY_MAX_M) return null;
  return best;
}
