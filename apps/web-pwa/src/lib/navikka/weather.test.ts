import { describe, it } from "node:test";
import assert from "node:assert/strict";
import { fogStatus } from "./rules.ts";
import { fetchWeather } from "./weather.ts";
import { HELSINKI_SEA } from "./geo.ts";

function snap(over: Partial<Parameters<typeof fogStatus>[0]>): Parameters<typeof fogStatus>[0] {
  return {
    tempC: 12,
    humidity: 70,
    visM: 14000,
    dewC: 6,
    ...over,
  };
}

describe("fogStatus COLREG 19/35", () => {
  it("≤500 m is dense fog (red)", () => {
    assert.equal(fogStatus(snap({ visM: 400 })).level, "red");
  });

  it("≤1000 m is fog warning (orange)", () => {
    assert.equal(fogStatus(snap({ visM: 800 })).level, "orange");
  });

  it("≤2500 m is mist (yellow)", () => {
    assert.equal(fogStatus(snap({ visM: 2000 })).level, "yellow");
  });

  it("flags sea-fog condensation when |T-Td|≤1.2 and RH≥90", () => {
    const f = fogStatus(snap({ visM: 14000, tempC: 11.0, dewC: 10.0, humidity: 92 }));
    assert.equal(f.level, "yellow");
  });

  it("good visibility stays green", () => {
    assert.equal(fogStatus(snap({})).level, "green");
  });
});

describe("fetchWeather failure must not look live", () => {
  it("throws on network loss instead of returning calm fallback stamped as now", async () => {
    const orig = globalThis.fetch;
    globalThis.fetch = (async () => {
      throw new Error("network down");
    }) as typeof fetch;
    try {
      await assert.rejects(() => fetchWeather(HELSINKI_SEA), /failed|network|down/i);
    } finally {
      globalThis.fetch = orig;
    }
  });
});
