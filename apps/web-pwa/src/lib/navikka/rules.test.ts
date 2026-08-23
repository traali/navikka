import { describe, it } from "node:test";
import assert from "node:assert/strict";
import { HELSINKI_SEA } from "./geo.ts";
import {
  catchLegal,
  copyText,
  fmtDepth,
  fmtSpeed,
  fmtWind,
  maydayScript,
  newId,
  overSpeedLimit,
  shareText,
  speedLimitKmh,
} from "./rules.ts";

describe("units", () => {
  it("formats SOG, wind and depth", () => {
    assert.equal(fmtSpeed(10, "kn"), "10.0 kn");
    assert.equal(fmtSpeed(10, "kmh"), "18.5 km/h");
    assert.equal(fmtWind(5, "ms"), "5.0 m/s");
    assert.match(fmtWind(5.14444, "kn"), /^10\.0 kn$/);
    assert.equal(fmtDepth(2, "m"), "2.0 m");
    assert.equal(fmtDepth(1, "ft"), "3.3 ft");
  });
});

describe("speed limits", () => {
  it("returns 5 km/h inside Kauppatori no-wake box", () => {
    assert.equal(speedLimitKmh({ lat: 60.1676, lng: 24.954 }), 5);
  });

  it("returns 15 km/h in Lauttasaari box", () => {
    assert.equal(speedLimitKmh({ lat: 60.158, lng: 24.877 }), 15);
  });

  it("is unrestricted at Helsinki sea demo start", () => {
    assert.equal(speedLimitKmh(HELSINKI_SEA), null);
    assert.equal(overSpeedLimit(HELSINKI_SEA, 20), null);
  });

  it("flags overspeed only when SOG exceeds the zone", () => {
    const pos = { lat: 60.1676, lng: 24.954 };
    assert.equal(overSpeedLimit(pos, 1), null);
    assert.equal(overSpeedLimit(pos, 8), 5);
  });
});

describe("catch sizes", () => {
  it("kuha is undersize below 42 cm", () => {
    assert.deepEqual(catchLegal("kuha", 41), { known: true, legal: false, minCm: 42 });
    assert.deepEqual(catchLegal("kuha", 42), { known: true, legal: true, minCm: 42 });
  });

  it("ahven has no statutory minimum in this table", () => {
    assert.equal(catchLegal("ahven", 8).legal, true);
  });

  it("lohi is undersize below 60 cm", () => {
    assert.deepEqual(catchLegal("lohi", 45), { known: true, legal: false, minCm: 60 });
    assert.deepEqual(catchLegal("lohi", 60), { known: true, legal: true, minCm: 60 });
  });

  it("unknown species stay permissive", () => {
    assert.equal(catchLegal("silakka", 10).known, false);
    assert.equal(catchLegal("silakka", 10).legal, true);
  });
});

describe("MAYDAY + ids", () => {
  it("builds a VHF MAYDAY readout with DDM and UKC", () => {
    const text = maydayScript({
      name: "Oma vene",
      pos: { lat: 60.155, lng: 24.89 },
      draftM: 0.9,
      fairway: "Sisäväylä 2,4 m",
      ukc: 1.5,
    });
    assert.match(text, /^MAYDAY MAYDAY MAYDAY/);
    assert.match(text, /Oma vene/);
    assert.match(text, /UKC 1\.5 m/);
    assert.match(text, /Draft 0\.9 m/);
  });

  it("MAYDAY omits a guessed Helsinki fairway when off-channel", () => {
    const text = maydayScript({
      name: "Oma vene",
      pos: { lat: 59.986, lng: 24.52 },
      draftM: 0.9,
      fairway: null,
      ukc: null,
    });
    assert.match(text, /avomeri/i);
    assert.doesNotMatch(text, /Sisäväylä|Lauttasaari|Helsinki 9/);
    assert.doesNotMatch(text, /UKC/);
  });

  it("newId works without crypto.randomUUID (iOS 15.3 Chrome)", () => {
    const orig = globalThis.crypto;
    Object.defineProperty(globalThis, "crypto", { value: {}, configurable: true });
    const id = newId();
    assert.match(id, /^id-/);
    Object.defineProperty(globalThis, "crypto", { value: orig, configurable: true });
  });
});

describe("clipboard fallback", () => {
  it("uses execCommand when Clipboard API is blocked", async () => {
    const calls: string[] = [];
    const ta = {
      value: "",
      style: {} as CSSStyleDeclaration,
      setAttribute() {},
      focus() {},
      select() {
        calls.push("select");
      },
      setSelectionRange() {},
      remove() {
        calls.push("remove");
      },
    };
    const doc = {
      createElement: () => ta,
      body: { appendChild() {} },
      execCommand: (cmd: string) => {
        calls.push(cmd);
        return cmd === "copy";
      },
    };
    Object.defineProperty(globalThis, "navigator", {
      value: {
        clipboard: {
          writeText: async () => {
            throw new Error("NotAllowedError");
          },
        },
      },
      configurable: true,
    });
    Object.defineProperty(globalThis, "document", { value: doc, configurable: true });
    const ok = await copyText("60°N");
    assert.equal(ok, true);
    assert.ok(calls.includes("copy"));
    assert.ok(calls.includes("remove"));
  });
});

describe("iPhone Chrome share sheet", () => {
  it("prefers navigator.share (CriOS) and falls back to copy", async () => {
    const shares: string[] = [];
    Object.defineProperty(globalThis, "navigator", {
      value: {
        share: async ({ text }: { text: string }) => {
          shares.push(text);
        },
      },
      configurable: true,
    });
    const ok = await shareText("Navikka MAYDAY", "MAYDAY MAYDAY MAYDAY");
    assert.equal(ok, true);
    assert.deepEqual(shares, ["MAYDAY MAYDAY MAYDAY"]);
  });
});

