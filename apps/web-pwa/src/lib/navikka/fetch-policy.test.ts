import { describe, it } from "node:test";
import assert from "node:assert/strict";
import { HELSINKI_SEA } from "./geo.ts";
import {
  AIS_RADIUS_KM,
  AIS_RETRY_MS,
  AIS_TTL_FOLLOW_MS,
  aisQuery,
  decideAisFetch,
  decideFollowPan,
  decideGpsAccept,
  decideWeatherFetch,
  deviceFixKinematics,
  formatWeatherAge,
  isWeatherStale,
  snapPos,
  weatherQuery,
  WEATHER_RETRY_MS,
  WEATHER_SNAP_DEG,
  WEATHER_STALE_MS,
  WEATHER_TTL_MS,
} from "./fetch-policy.ts";

describe("weather snap — the 'fetched all the time while boating' bug", () => {
  it("snaps GPS noise into the same 0.05° MET cell", () => {
    const a = weatherQuery({ lat: 60.155, lng: 24.89 });
    const b = weatherQuery({ lat: 60.16, lng: 24.91 });
    const c = weatherQuery({ lat: 60.1542, lng: 24.887 });
    assert.equal(a.lat, b.lat);
    assert.equal(a.lon, b.lon);
    assert.equal(a.lat, c.lat);
    assert.equal(a.lon, c.lon);
    assert.match(a.lat, /^\d+\.\d{2}$/);
    assert.equal(WEATHER_SNAP_DEG, 0.05);
  });

  it("does not mint a new URL after 6 kn × 2 min (720 m)", () => {
    const start = HELSINKI_SEA;
    const after = { lat: start.lat + 720 / 111320, lng: start.lng };
    assert.deepEqual(snapPos(start), snapPos(after));
  });
});

describe("decideWeatherFetch", () => {
  const pos = HELSINKI_SEA;
  const snapped = snapPos(pos);

  it("fetches on first call", () => {
    const d = decideWeatherFetch({
      now: 1000,
      pos,
      lastAt: null,
      lastPos: null,
      lastAttemptAt: null,
      hidden: false,
      inflight: false,
    });
    assert.equal(d.fetch, true);
    if (d.fetch) assert.equal(d.reason, "first");
  });

  it("stays quiet inside the same cell for 10 min of GPS motion", () => {
    const d = decideWeatherFetch({
      now: 9 * 60 * 1000,
      pos: { lat: pos.lat + 0.002, lng: pos.lng + 0.002 },
      lastAt: 0,
      lastPos: snapped,
      lastAttemptAt: null,
      hidden: false,
      inflight: false,
    });
    assert.equal(d.fetch, false);
    if (!d.fetch) assert.equal(d.reason, "fresh");
  });

  it("refetches after TTL in the same cell", () => {
    const d = decideWeatherFetch({
      now: WEATHER_TTL_MS + 1,
      pos,
      lastAt: 0,
      lastPos: snapped,
      lastAttemptAt: null,
      hidden: false,
      inflight: false,
    });
    assert.equal(d.fetch, true);
    if (d.fetch) assert.equal(d.reason, "ttl");
  });

  it("refetches when the boat enters a new snap cell", () => {
    const d = decideWeatherFetch({
      now: 30_000,
      pos: { lat: pos.lat + 0.08, lng: pos.lng },
      lastAt: 0,
      lastPos: snapped,
      lastAttemptAt: 29_000,
      hidden: false,
      inflight: false,
    });
    assert.equal(d.fetch, true);
    if (d.fetch) assert.equal(d.reason, "moved");
  });

  it("moved cell fetches even when lastAttemptAt is 1s old (NEXUS M1)", () => {
    const d = decideWeatherFetch({
      now: 10_000,
      pos: { lat: pos.lat + 0.08, lng: pos.lng },
      lastAt: 0,
      lastPos: snapped,
      lastAttemptAt: 9_000,
      hidden: false,
      inflight: false,
    });
    assert.equal(d.fetch, true);
    if (d.fetch) assert.equal(d.reason, "moved");
  });

  it("backs off for 60s after a failed fetch attempt when lastAt is null", () => {
    const d1 = decideWeatherFetch({
      now: 10_000,
      pos,
      lastAt: null,
      lastPos: null,
      lastAttemptAt: 9_000,
      hidden: false,
      inflight: false,
    });
    assert.equal(d1.fetch, false);
    if (!d1.fetch) assert.equal(d1.reason, "backoff");

    const d2 = decideWeatherFetch({
      now: 70_000,
      pos,
      lastAt: null,
      lastPos: null,
      lastAttemptAt: 9_000,
      hidden: false,
      inflight: false,
    });
    assert.equal(d2.fetch, true);
    if (d2.fetch) assert.equal(d2.reason, "first");
  });

  it("same-cell TTL expiry backs off for 60s after a failed refresh", () => {
    const d = decideWeatherFetch({
      now: WEATHER_TTL_MS + 5_000,
      pos,
      lastAt: 0,
      lastPos: snapped,
      lastAttemptAt: WEATHER_TTL_MS + 4_000,
      hidden: false,
      inflight: false,
    });
    assert.equal(d.fetch, false);
    if (!d.fetch) assert.equal(d.reason, "backoff");
  });

  it("does not fetch in a background iPhone Chrome tab", () => {
    const d = decideWeatherFetch({
      now: WEATHER_TTL_MS * 2,
      pos,
      lastAt: 0,
      lastPos: snapped,
      lastAttemptAt: null,
      hidden: true,
      inflight: false,
    });
    assert.equal(d.fetch, false);
    if (!d.fetch) assert.equal(d.reason, "hidden");
  });

  it("does not overlap in-flight weather calls", () => {
    const d = decideWeatherFetch({
      now: WEATHER_TTL_MS * 2,
      pos,
      lastAt: 0,
      lastPos: snapped,
      lastAttemptAt: null,
      hidden: false,
      inflight: true,
    });
    assert.equal(d.fetch, false);
    if (!d.fetch) assert.equal(d.reason, "inflight");
  });
});

describe("decideAisFetch", () => {
  it("uses 60 s underway and stays quiet before that", () => {
    const fresh = decideAisFetch({
      now: AIS_TTL_FOLLOW_MS - 1,
      lastAt: 0,
      lastAttemptAt: null,
      hidden: false,
      inflight: false,
      active: true,
    });
    const due = decideAisFetch({
      now: AIS_TTL_FOLLOW_MS,
      lastAt: 0,
      lastAttemptAt: null,
      hidden: false,
      inflight: false,
      active: true,
    });
    assert.equal(fresh.fetch, false);
    assert.equal(due.fetch, true);
  });

  it("idles to 3 min when not following", () => {
    const d = decideAisFetch({
      now: 120_000,
      lastAt: 0,
      lastAttemptAt: null,
      hidden: false,
      inflight: false,
      active: false,
    });
    assert.equal(d.fetch, false);
  });

  it("failed first AIS backs off 60 s instead of 15 s storm", () => {
    const d1 = decideAisFetch({
      now: 10_000,
      lastAt: null,
      lastAttemptAt: 9_000,
      hidden: false,
      inflight: false,
      active: true,
    });
    assert.equal(d1.fetch, false);
    if (!d1.fetch) assert.equal(d1.reason, "backoff");

    const d2 = decideAisFetch({
      now: 70_000,
      lastAt: null,
      lastAttemptAt: 9_000,
      hidden: false,
      inflight: false,
      active: true,
    });
    assert.equal(d2.fetch, true);
    if (d2.fetch) assert.equal(d2.reason, "first");
  });

  it("TTL retry backs off 60 s after a failed refresh", () => {
    const d = decideAisFetch({
      now: AIS_TTL_FOLLOW_MS + 5_000,
      lastAt: 0,
      lastAttemptAt: AIS_TTL_FOLLOW_MS + 4_000,
      hidden: false,
      inflight: false,
      active: true,
    });
    assert.equal(d.fetch, false);
    if (!d.fetch) assert.equal(d.reason, "backoff");
  });
});

describe("GPS / follow pan", () => {
  it("drops GPS samples inside 500 ms and 15 m", () => {
    const origin = HELSINKI_SEA;
    const near = { lat: origin.lat + 5 / 111320, lng: origin.lng };
    assert.equal(
      decideGpsAccept({ now: 200, pos: near, lastAt: 0, lastPos: origin }),
      false,
    );
    assert.equal(
      decideGpsAccept({ now: 600, pos: near, lastAt: 0, lastPos: origin }),
      true,
    );
  });

  it("accepts a 20 m jump immediately (speed-over-ground spike)", () => {
    const origin = HELSINKI_SEA;
    const jump = { lat: origin.lat + 20 / 111320, lng: origin.lng };
    assert.equal(
      decideGpsAccept({ now: 100, pos: jump, lastAt: 0, lastPos: origin }),
      true,
    );
  });

  it("pans follow only after ~12 m and kills animation when underway", () => {
    const from = HELSINKI_SEA;
    const near = { lat: from.lat + 5 / 111320, lng: from.lng };
    const far = { lat: from.lat + 30 / 111320, lng: from.lng };
    const skip = decideFollowPan({ follow: true, followJustOn: false, from, to: near, sogKn: 6 });
    const pan = decideFollowPan({ follow: true, followJustOn: false, from, to: far, sogKn: 6 });
    const start = decideFollowPan({ follow: true, followJustOn: true, from, to: near, sogKn: 0.5 });
    assert.equal(skip.pan, false);
    assert.equal(pan.pan, true);
    assert.equal(pan.animate, false);
    assert.equal(start.pan, true);
    assert.equal(start.animate, true);
  });
});

describe("weather age copy", () => {
  it("labels fresh / minutes / stale", () => {
    assert.equal(formatWeatherAge(10_000, "fi"), "juuri");
    assert.match(formatWeatherAge(4 * 60_000, "fi"), /4 min/);
    assert.equal(isWeatherStale(WEATHER_STALE_MS), true);
    assert.equal(isWeatherStale(60_000), false);
  });
});

describe("AIS query is not a national dump", () => {
  it("includes latitude, longitude and radius km", () => {
    const q = aisQuery(HELSINKI_SEA);
    assert.match(q.url, /latitude=60\.155/);
    assert.match(q.url, /longitude=24\.890/);
    assert.match(q.url, /radius=45/);
    assert.equal(AIS_RADIUS_KM, 45);
    assert.equal(WEATHER_RETRY_MS, 60_000);
  });
});

describe("device GPS kinematics", () => {
  it("does not inherit demo 6.2 kn when CriOS speed is null", () => {
    const k = deviceFixKinematics({
      wasDemo: true,
      speedMs: null,
      headingDeg: null,
      prevSogKn: 6.2,
      prevCog: 112,
    });
    assert.equal(k.sogKn, 0);
    assert.equal(k.cog, 0);
  });

  it("zeros SOG when GPS reports 0 at the dock after going LIVE", () => {
    const k = deviceFixKinematics({
      wasDemo: false,
      speedMs: 0,
      headingDeg: 40,
      prevSogKn: 6.2,
      prevCog: 112,
    });
    assert.equal(k.sogKn, 0);
    assert.equal(k.cog, 40);
  });

  it("derives SOG from movement when CriOS speed stays null after LIVE", () => {
    const k = deviceFixKinematics({
      wasDemo: false,
      speedMs: null,
      headingDeg: null,
      prevSogKn: 0,
      prevCog: 0,
      movedM: 25,
      dtMs: 2000,
    });
    assert.ok(k.sogKn > 20 && k.sogKn < 30, String(k.sogKn));
  });

  it("derives SOG when CriOS reports speed 0 while the boat is moving", () => {
    const k = deviceFixKinematics({
      wasDemo: false,
      speedMs: 0,
      headingDeg: null,
      prevSogKn: 0,
      prevCog: 0,
      movedM: 25,
      dtMs: 2000,
    });
    assert.ok(k.sogKn > 20 && k.sogKn < 30, String(k.sogKn));
  });

  it("keeps last GPS SOG when speed is null while already LIVE", () => {
    const k = deviceFixKinematics({
      wasDemo: false,
      speedMs: null,
      headingDeg: null,
      prevSogKn: 5.1,
      prevCog: 88,
    });
    assert.equal(k.sogKn, 5.1);
    assert.equal(k.cog, 88);
  });
});
