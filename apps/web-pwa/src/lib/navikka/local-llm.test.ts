import { describe, it } from "node:test";
import assert from "node:assert/strict";
import { askOnDevice } from "./local-llm.ts";

describe("on-device skipper", () => {
  it("answers UKC from context with rules when Nano is absent", async () => {
    const r = await askOnDevice("mikä kölivara", "POS 60 N · UKC 1.4 · Tuuli 8.0 aalto 0.6", "fi");
    assert.equal(r.ok, true);
    assert.equal(r.source, "rules");
    assert.match(r.text, /1\.4/);
  });

  it("does not invent UKC on open water", async () => {
    const r = await askOnDevice("syvyys", "POS 59.9 · Avomeri · SOG 0.0", "fi");
    assert.match(r.text, /ei katalogisyvyyttä/i);
  });
});
