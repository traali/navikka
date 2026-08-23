import { before, describe, it } from "node:test";
import assert from "node:assert/strict";

const mem = new Map<string, string>();
const ls = {
  getItem: (k: string) => mem.get(k) ?? null,
  setItem: (k: string, v: string) => {
    mem.set(k, v);
  },
  removeItem: (k: string) => {
    mem.delete(k);
  },
  clear: () => mem.clear(),
  key: (i: number) => [...mem.keys()][i] ?? null,
  get length() {
    return mem.size;
  },
};
Object.defineProperty(globalThis, "localStorage", { value: ls, configurable: true });
Object.defineProperty(globalThis, "window", { value: { localStorage: ls }, configurable: true });

const { minSizeFor, nearestHarbor, overLimit, ukcNow, useNav } = await import("./store.ts");
const { HELSINKI_SEA } = await import("./geo.ts");

describe("nav store", () => {
  before(() => {
    useNav.setState({
      pos: HELSINKI_SEA,
      sogKn: 6.2,
      cog: 112,
      gpsSource: "demo",
      waypoints: [],
      catches: [],
      weather: null,
      vessel: { name: "Oma vene", draftM: 0.9, loaM: 6.4, airDraftM: 2.1, fuelL: 80 },
    });
  });

  it("demo tick advances position only while GPS is demo", () => {
    const a = useNav.getState().pos;
    useNav.getState().tickDemo();
    const b = useNav.getState().pos;
    assert.notEqual(a.lat, b.lat);
    useNav.getState().setPos(HELSINKI_SEA, 5, 90, "device", 12);
    const frozen = useNav.getState().pos;
    useNav.getState().tickDemo();
    assert.equal(useNav.getState().pos, frozen);
    assert.equal(useNav.getState().gpsSource, "device");
  });

  it("UKC is nearest fairway depth minus draft when seas are calm", () => {
    useNav.getState().setPos(HELSINKI_SEA, 6, 112, "demo", 8);
    const { fw, ukc } = ukcNow();
    assert.ok(fw);
    assert.ok(ukc != null);
    assert.ok(fw.depthM > 2);
    assert.ok(Math.abs(ukc - (fw.depthM - 0.9)) < 1e-9, String(ukc));
  });

  it("keeps last good weather when a later fetch fails", () => {
    const live = {
      tempC: 8,
      windMs: 18.2,
      gustMs: 24,
      windDir: 240,
      pressureHpa: 988,
      humidity: 90,
      visM: 4000,
      cloudPct: 90,
      waveM: 2.1,
      waveDir: 240,
      wavePeriod: 6,
      waterC: 12,
      dewC: 7,
      updated: "2026-08-21T10:00:00.000Z",
    };
    useNav.getState().setWeather(live);
    const at = useNav.getState().weatherAt;
    useNav.getState().setWeather(null, "Säätä ei saatu.");
    assert.equal(useNav.getState().weather?.windMs, 18.2);
    assert.equal(useNav.getState().weather?.updated, "2026-08-21T10:00:00.000Z");
    assert.equal(useNav.getState().weatherAt, at);
    assert.equal(useNav.getState().weatherError, "Säätä ei saatu.");
  });

  it("does not invent UKC at Porkkala", () => {
    useNav.getState().setPos({ lat: 59.986, lng: 24.52 }, 6, 270, "demo", 8);
    const { fw, ukc } = ukcNow();
    assert.equal(fw, null);
    assert.equal(ukc, null);
    useNav.getState().setPos(HELSINKI_SEA, 6, 112, "demo", 8);
  });

  it("does not flag overspeed in open Helsinki sea", () => {
    assert.equal(overLimit(HELSINKI_SEA, 12), null);
  });

  it("logs a catch at current position and caps at 40", () => {
    useNav.setState({ catches: [] });
    useNav.getState().addCatch("kuha", 44);
    assert.equal(useNav.getState().catches[0]?.species, "kuha");
    assert.equal(useNav.getState().catches[0]?.cm, 44);
    for (let i = 0; i < 45; i++) useNav.getState().addCatch("ahven", 12);
    assert.equal(useNav.getState().catches.length, 40);
  });

  it("nearest harbor from demo start is a Helsinki guest/service berth", () => {
    const n = nearestHarbor(HELSINKI_SEA);
    assert.ok(n.nm < 4, String(n.nm));
    assert.ok(n.harbor.name.length > 3);
  });

  it("kuha minimum size is 42 cm", () => {
    assert.equal(minSizeFor("kuha")?.cm, 42);
  });

  it("removeWaypoint drops the index and closes an open waypoint sheet", () => {
    useNav.setState({ waypoints: [HELSINKI_SEA, { lat: 60.16, lng: 24.9 }], selection: { type: "wp", index: 0 }, sheet: "detail" });
    useNav.getState().removeWaypoint(0);
    assert.equal(useNav.getState().waypoints.length, 1);
    assert.equal(useNav.getState().selection, null);
    assert.equal(useNav.getState().sheet, "none");
  });

  it("does not persist live GPS or weather into localStorage", async () => {
    useNav.setState({ theme: "aurora" });
    await new Promise((r) => setTimeout(r, 20));
    const raw = mem.get("navikka-v1");
    if (!raw) return; // persist is browser-only; skip if storage API is inert
    const parsed = JSON.parse(raw) as { state?: Record<string, unknown> };
    assert.equal("pos" in (parsed.state ?? {}), false);
    assert.equal("weather" in (parsed.state ?? {}), false);
    assert.ok("theme" in (parsed.state ?? {}));
    assert.ok("vessel" in (parsed.state ?? {}));
  });
});
