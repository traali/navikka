import { describe, it } from "node:test";
import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import { resolve } from "node:path";
import { AIS_SEED, aisMarkersForMap } from "./catalog.ts";

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
  });

  it("empty live AIS does not paint seed MEGASTAR (NEXUS H1)", () => {
    const src = readFileSync(resolve(import.meta.dirname, "../../components/navikka/map-view.tsx"), "utf8");
    assert.match(src, /aisMarkersForMap/);
    assert.equal(src.includes("targets.length ? targets : AIS_SEED"), false);
    assert.equal(aisMarkersForMap([], "live").length, 0);
    assert.equal(aisMarkersForMap([], "seed").length, AIS_SEED.length);
  });
});
