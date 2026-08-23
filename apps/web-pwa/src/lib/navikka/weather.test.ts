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

  it("throws on HTTP 200 with empty timeseries instead of stamping calm wind as now", async () => {
    const orig = globalThis.fetch;
    globalThis.fetch = (async () =>
      ({
        ok: true,
        json: async () => ({ properties: { timeseries: [] } }),
      }) as Response) as typeof fetch;
    try {
      await assert.rejects(() => fetchWeather(HELSINKI_SEA), /empty|failed/i);
    } finally {
      globalThis.fetch = orig;
    }
  });

  it("does not invent 0.6 m waves when ocean forecast is missing", async () => {
    const orig = globalThis.fetch;
    globalThis.fetch = (async (input: RequestInfo | URL) => {
      const url = String(input);
      if (url.includes("oceanforecast")) {
        return { ok: false, status: 404, json: async () => ({}) } as Response;
      }
      return {
        ok: true,
        json: async () => ({
          properties: {
            timeseries: [
              {
                data: {
                  instant: {
                    details: {
                      air_temperature: 12,
                      wind_speed: 7.2,
                      wind_from_direction: 240,
                      air_pressure_at_sea_level: 1008,
                      relative_humidity: 80,
                      dew_point_temperature: 8,
                    },
                  },
                },
              },
            ],
          },
        }),
      } as Response;
    }) as typeof fetch;
    try {
      const w = await fetchWeather(HELSINKI_SEA);
      assert.equal(w.windMs, 7.2);
      assert.equal(w.waveM, null);
      assert.equal(w.waterC, null);
    } finally {
      globalThis.fetch = orig;
    }
  });
});
