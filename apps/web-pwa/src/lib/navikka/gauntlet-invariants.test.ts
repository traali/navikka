import { describe, it } from "node:test";
import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import { resolve } from "node:path";
import { aisMarkersForMap } from "./catalog.ts";

const root = resolve(import.meta.dirname, "../../../../../");
const compact = (s: string) => s.replace(/\s+/g, " ");

describe("gauntlet source contracts (companion + Pages)", () => {
  it("fishing polygons are added to the Leaflet group", () => {
    const src = readFileSync(resolve(import.meta.dirname, "../../components/navikka/map-view.tsx"), "utf8");
    assert.match(src, /\.addTo\(fish\)/);
  });

  it("cockpit uses deviceFixKinematics for LIVE GPS", () => {
    const src = readFileSync(resolve(import.meta.dirname, "../../components/navikka/cockpit.tsx"), "utf8");
    assert.match(src, /deviceFixKinematics/);
  });

  it("AIS fetch uses radius, not the national dump URL", () => {
    const src = readFileSync(resolve(import.meta.dirname, "./ais.ts"), "utf8");
    assert.match(src, /aisQuery\(/);
    assert.equal(src.includes("/locations\""), false);
  });

  it("seed AIS does not CPA-alarm", () => {
    const src = readFileSync(resolve(import.meta.dirname, "../../components/navikka/panels.tsx"), "utf8");
    assert.match(src, /aisSource === "live"/);
  });

  it("Pages redirects put /cockpit before the Flutter SPA catch-all", () => {
    const text = compact(readFileSync(resolve(root, "web/_redirects"), "utf8"));
    const cockpit = text.indexOf("/cockpit /cockpit/");
    const pwa = text.indexOf("/pwa /cockpit/");
    const catchAll = text.indexOf("/* /index.html");
    assert.ok(cockpit >= 0);
    assert.ok(pwa >= 0);
    assert.ok(catchAll > cockpit);
    assert.ok(catchAll > pwa);
    assert.ok(text.includes("/cockpit/* /cockpit/:splat"));
  });

  it("deploy builds --base=/cockpit/ and does not copy /pwa", () => {
    const deploy = readFileSync(resolve(root, ".github/workflows/deploy.yml"), "utf8");
    assert.match(deploy, /--base=\/cockpit\//);
    assert.equal(deploy.includes("--base=./"), false);
    assert.equal(deploy.includes("build/web/pwa"), false);
  });

  it("CI verify always runs companion npm test and typecheck", () => {
    const ci = readFileSync(resolve(root, ".github/workflows/ci.yml"), "utf8");
    assert.match(ci, /npm test/);
    assert.match(ci, /npm run typecheck/);
    assert.match(ci, /--base=\/cockpit\//);
    assert.equal(ci.includes("build/web/pwa"), false);
  });

  it("Pages deploy skips when Cloudflare token is unset", () => {
    const deploy = readFileSync(resolve(root, ".github/workflows/deploy.yml"), "utf8");
    assert.match(deploy, /if:\s*needs\.gate\.outputs\.should_deploy\s*==\s*'true'/);
    assert.match(deploy, /required:\s*false/);
    assert.match(deploy, /CLOUDFLARE_API_TOKEN/);
    assert.match(deploy, /Skipping Cloudflare Pages deploy/);
  });

  it("Flutter AIS queries Digitraffic with radius and 60s/180s TTL", () => {
    const ds = readFileSync(
      resolve(root, "lib/features/ais/data/datasources/digitraffic_ais_remote_data_source.dart"),
      "utf8",
    );
    assert.match(ds, /'radius':/);
    const prov = readFileSync(
      resolve(root, "lib/features/ais/presentation/providers/ais_targets_provider.dart"),
      "utf8",
    );
    assert.match(prov, /shouldFetchAis/);
    assert.match(prov, /UnderwayFetch\.aisPollCheck/);
    assert.equal(prov.includes("Timer.periodic(const Duration(seconds: 15)"), false);
    assert.equal(prov.includes("reasonMoved"), false);
  });

  it("Skipper banner and Sää card keep last insight on weather reload", () => {
    const banner = readFileSync(
      resolve(root, "lib/features/ai/presentation/widgets/skipper_insight_banner.dart"),
      "utf8",
    );
    const screen = readFileSync(
      resolve(root, "lib/features/weather/presentation/screens/weather_screen.dart"),
      "utf8",
    );
    assert.match(banner, /skipLoadingOnReload:\s*true/);
    assert.match(screen, /skipLoadingOnReload:\s*true/);
  });

  it("companion AIS requires lastAttemptAt backoff like weather", () => {
    const policy = readFileSync(resolve(import.meta.dirname, "./fetch-policy.ts"), "utf8");
    assert.match(policy, /AIS_RETRY_MS/);
    assert.match(policy, /export function decideAisFetch/);
    assert.equal(policy.includes("lastAttemptAt?:"), false);
    const cockpit = readFileSync(
      resolve(import.meta.dirname, "../../components/navikka/cockpit.tsx"),
      "utf8",
    );
    assert.match(cockpit, /lastAisAttemptAt/);
    assert.match(cockpit, /lastAttemptAt: lastAisAttemptAt/);
  });

  it("empty live AIS does not paint seed MEGASTAR (NEXUS H1)", () => {
    const src = readFileSync(resolve(import.meta.dirname, "../../components/navikka/map-view.tsx"), "utf8");
    assert.match(src, /aisMarkersForMap/);
    assert.equal(src.includes("targets.length ? targets : AIS_SEED"), false);
    assert.equal(aisMarkersForMap([], "live").length, 0);
    assert.equal(aisMarkersForMap([], "seed").length, 0);
  });

  it("HUD SOG and MAYDAY wait for LIVE GPS — Helsinki pin is not the boat", () => {
    const cockpit = readFileSync(resolve(import.meta.dirname, "../../components/navikka/cockpit.tsx"), "utf8");
    assert.match(cockpit, /gpsLive \? fmtSpeed\(sog/);
    assert.match(cockpit, /if \(!gpsLive\) return;/);
    const panels = readFileSync(resolve(import.meta.dirname, "../../components/navikka/panels.tsx"), "utf8");
    assert.match(panels, /GPS ei kiinnittynyt — älä lue Helsingin oletuspinniä hätänä/);
    assert.match(panels, /gpsLive \? formatDdm\(pos\) : "—"/);
    assert.match(panels, /gpsLive &&\s*aisSource === "live"/);
    assert.match(panels, /GPS ei kiinnittynyt — älä oleta Helsingin oletuspinniä veneeksi/);
    const map = readFileSync(resolve(import.meta.dirname, "../../components/navikka/map-view.tsx"), "utf8");
    assert.match(map, /if \(s\.gpsSource !== "device"\) return;/);
    const weather = readFileSync(resolve(import.meta.dirname, "./weather.ts"), "utf8");
    assert.match(weather, /missing temp\/wind/);
    assert.match(weather, /Number.isFinite\(d0\.fog_area_fraction\)/);
    assert.equal(weather.includes("visM: 14000,"), false);
    assert.equal(weather.includes("windMs * 1.4"), false);
    assert.match(weather, /dewC: Number.isFinite/);
    assert.match(panels, /gpsLive \? `\$\{nmBetween/);
  });

  it("persist merge refuses a stored boat position", () => {
    const src = readFileSync(resolve(import.meta.dirname, "./store.ts"), "utf8");
    assert.match(src, /pos:\s*current\.pos/);
    assert.match(src, /ais:\s*\[\]/);
  });

  it("search does not teleport own-ship to a harbor", () => {
    const src = readFileSync(resolve(import.meta.dirname, "../../components/navikka/panels.tsx"), "utf8");
    assert.match(src, /peek\(/);
    assert.equal(src.includes("pos: h.pos"), false);
  });

  it("companion basemap is not Esri Ocean (Helsinki z13 watermark)", () => {
    const src = readFileSync(resolve(import.meta.dirname, "../../components/navikka/map-view.tsx"), "utf8");
    assert.equal(src.includes("World_Ocean_Base"), false);
    assert.match(src, /basemaps\.cartocdn\.com/);
    assert.match(src, /julkinen\.traficom\.fi/);
    assert.match(src, /layers\.enc/);
    assert.equal(src.includes("ENC · Traficom"), false);
  });
});
