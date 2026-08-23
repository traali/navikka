import { describe, it } from "node:test";
import assert from "node:assert/strict";
import { COPY } from "./i18n.ts";
import { HARBORS, MIN_SIZES, nearestFairwayDepth, SPEED_ZONES } from "./catalog.ts";
import { HELSINKI_SEA } from "./geo.ts";
import { kindFromName } from "./rules.ts";

describe("catalog", () => {
  it("has Helsinki harbors with required services fields", () => {
    assert.ok(HARBORS.length >= 8);
    for (const h of HARBORS) {
      assert.ok(h.name.length > 2);
      assert.ok(h.depthM > 0);
      assert.equal(typeof h.fuel, "boolean");
    }
  });

  it("nearest fairway to demo start is a local Helsinki channel with published depth", () => {
    const fw = nearestFairwayDepth(HELSINKI_SEA);
    assert.ok(fw);
    assert.ok(fw.depthM >= 2.4);
    assert.ok(["local-24", "lautta-4", "hel-9"].includes(fw.id), fw.id);
  });

  it("recognizes hel-9 fairway at segment midpoint between distant vertices", () => {
    // Leg 1 is 60.12, 24.96 -> 60.14, 24.97 (2.3 km). Midpoint is >1.1 km from vertices.
    const mid = { lat: 60.13, lng: 24.965 };
    const fw = nearestFairwayDepth(mid);
    assert.ok(fw);
    assert.equal(fw.id, "hel-9");
    assert.equal(fw.depthM, 9.0);
  });

  it("does not invent a Helsinki fairway at Porkkala", () => {
    assert.equal(nearestFairwayDepth({ lat: 59.986, lng: 24.52 }), null);
  });

  it("kuha / meritaimen / lohi keep statutory minima", () => {
    assert.equal(MIN_SIZES.find((s) => s.id === "kuha")?.cm, 42);
    assert.equal(MIN_SIZES.find((s) => s.id === "taimen")?.cm, 60);
    assert.equal(MIN_SIZES.find((s) => s.id === "lohi")?.cm, 60);
    assert.equal(MIN_SIZES.find((s) => s.id === "loh"), undefined);
  });

  it("speed zones include a no-wake box", () => {
    assert.ok(SPEED_ZONES.some((z) => z.noWake && z.limitKmh === 5));
  });
});

describe("i18n", () => {
  it("FI and EN copy expose the same keys", () => {
    assert.deepEqual(Object.keys(COPY.fi).sort(), Object.keys(COPY.en).sort());
  });
});

describe("AIS kindFromName", () => {
  it("classifies Finnish traffic names", () => {
    assert.equal(kindFromName("SUOMENLINNA II"), "ferry");
    assert.equal(kindFromName("MEGASTAR"), "ferry");
    assert.equal(kindFromName("SILJA SYMPHONY"), "ferry");
    assert.equal(kindFromName("HELSINKI PILOT"), "pilot");
    assert.equal(kindFromName("LUOTSI 1"), "pilot");
    assert.equal(kindFromName("TANKER BALTIC"), "tanker");
    assert.equal(kindFromName("FINNPULP"), "cargo");
    assert.equal(kindFromName("S/Y AURORA"), "pleasure");
  });
});
