import { describe, it } from "node:test";
import assert from "node:assert/strict";
import {
  bearingDeg,
  computeCpa,
  destination,
  formatDdm,
  haversineM,
  HELSINKI_SEA,
  kmhToKn,
  knToMs,
  nmBetween,
  padCourse,
  parseLatLngQuery,
  pointInRing,
  routeStats,
  underKeelClearance,
} from "./geo.ts";

describe("geo", () => {
  it("haversine is ~0 for the same point", () => {
    assert.equal(haversineM(HELSINKI_SEA, HELSINKI_SEA), 0);
  });

  it("Kauppatori to Suomenlinna is about 1.5–2.0 NM", () => {
    const nm = nmBetween({ lat: 60.1674, lng: 24.9538 }, { lat: 60.1468, lng: 24.9896 });
    assert.ok(nm > 1.4 && nm < 2.1, String(nm));
  });

  it("bearing east of origin is near 90°", () => {
    const dest = destination(HELSINKI_SEA, 90, 1000);
    const brg = bearingDeg(HELSINKI_SEA, dest);
    assert.ok(Math.abs(brg - 90) < 2, String(brg));
  });

  it("formats DDM with N/E hemispheres", () => {
    const s = formatDdm({ lat: 60.155, lng: 24.89 });
    assert.match(s, /60°/);
    assert.match(s, /N/);
    assert.match(s, /E/);
  });

  it("pads course 0–359 into three digits", () => {
    assert.equal(padCourse(7), "007°");
    assert.equal(padCourse(359.6), "000°");
    assert.equal(padCourse(-10), "350°");
  });

  it("unit conversions stay invertible", () => {
    assert.ok(Math.abs(knToMs(1) - 0.514444) < 1e-9);
    assert.ok(Math.abs(kmhToKn(1.852) - 1) < 1e-9);
  });

  it("UKC is depth + anomaly − draft", () => {
    assert.equal(underKeelClearance(2.4, 0.9, 0), 1.5);
    assert.ok(Math.abs(underKeelClearance(2.4, 0.9, -0.2) - 1.3) < 1e-9);
  });

  it("route stats sum NM and ETA", () => {
    const a = HELSINKI_SEA;
    const b = destination(a, 90, 1852);
    const s = routeStats([a, b], 10);
    assert.ok(Math.abs(s.nm - 1) < 0.02, String(s.nm));
    assert.ok(Math.abs(s.etaMin - 6) < 0.2, String(s.etaMin));
    assert.equal(s.legs.length, 1);
  });

  it("CPA flags a head-on closing within 1 cable", () => {
    const own = HELSINKI_SEA;
    const tgt = destination(own, 0, 400);
    const cpa = computeCpa(own, 0, 8, tgt, 180, 8);
    assert.ok(cpa.tcpaMin > 0);
    assert.ok(cpa.cpaNm < 0.15, String(cpa.cpaNm));
    assert.equal(cpa.colliding, true);
  });

  it("CPA of parallel same-speed tracks is not colliding", () => {
    const own = HELSINKI_SEA;
    const tgt = destination(own, 90, 800);
    const cpa = computeCpa(own, 0, 6, tgt, 0, 6);
    assert.equal(cpa.colliding, false);
  });

  it("point-in-ring detects the Kauppatori 5 km/h box", () => {
    const ring = [
      { lat: 60.1658, lng: 24.948 },
      { lat: 60.1694, lng: 24.948 },
      { lat: 60.1694, lng: 24.961 },
      { lat: 60.1658, lng: 24.961 },
    ];
    assert.equal(pointInRing({ lat: 60.1676, lng: 24.954 }, ring), true);
    assert.equal(pointInRing(HELSINKI_SEA, ring), false);
    assert.equal(pointInRing(HELSINKI_SEA, ring.slice(0, 2)), false);
  });

  it("parses decimal coordinates inside Finnish waters only", () => {
    assert.deepEqual(parseLatLngQuery("60.155 24.89"), { lat: 60.155, lng: 24.89 });
    assert.deepEqual(parseLatLngQuery("60.155,24.89"), { lat: 60.155, lng: 24.89 });
    assert.equal(parseLatLngQuery("0 0"), null);
    assert.equal(parseLatLngQuery("helsinki"), null);
  });
});
