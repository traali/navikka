import { describe, it } from "node:test";
import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import {
  CHROME_IOS_UA,
  classifyIphoneViewport,
  IPHONE_11,
  IPHONE_12,
  IOS_NO_ZOOM_INPUT_PX,
  isChromeOniOS,
  isIosWebKit,
  MIN_TOUCH_PX,
  SAFARI_IOS_UA,
} from "./iphone.ts";

const here = dirname(fileURLToPath(import.meta.url));
const css = readFileSync(join(here, "../../styles.css"), "utf8");

describe("iPhone 11 / 12 + Chrome (WebKit)", () => {
  it("treats CriOS as iOS WebKit, not Chromium", () => {
    assert.equal(isIosWebKit(CHROME_IOS_UA), true);
    assert.equal(isChromeOniOS(CHROME_IOS_UA), true);
    assert.equal(isChromeOniOS(SAFARI_IOS_UA), false);
    assert.equal(isIosWebKit(SAFARI_IOS_UA), true);
    assert.equal(isChromeOniOS("Mozilla/5.0 (Linux; Android 14) Chrome/128.0.0.0"), false);
  });

  it("classifies Friday field-test viewports", () => {
    assert.equal(classifyIphoneViewport(375, 812, 2), "iphone-11");
    assert.equal(classifyIphoneViewport(390, 844, 3), "iphone-12");
    assert.equal(IPHONE_11.cssWidth, 375);
    assert.equal(IPHONE_12.cssWidth, 390);
    assert.equal(IPHONE_12.cssHeight, 844);
    assert.ok(IPHONE_11.dpr < IPHONE_12.dpr);
  });

  it("locks iOS input zoom with 16px fields and 44px targets", () => {
    assert.equal(IOS_NO_ZOOM_INPUT_PX, 16);
    assert.equal(MIN_TOUCH_PX, 44);
    assert.match(css, /font-size:\s*16px/);
    assert.match(css, /height:\s*44px/);
    assert.match(css, /min-height:\s*44px/);
    assert.match(css, /grid-template-columns:\s*1fr 44px 44px 44px/);
  });

  it("uses dvh + webkit fill + safe-area so notch/home-indicator do not cover HUD", () => {
    assert.match(css, /100dvh/);
    assert.match(css, /-webkit-fill-available/);
    assert.match(css, /env\(safe-area-inset-top\)/);
    assert.match(css, /env\(safe-area-inset-bottom\)/);
    assert.match(css, /-webkit-text-size-adjust:\s*100%/);
    assert.match(css, /touch-action:\s*manipulation/);
    const start = css.indexOf(".cockpit {");
    const block = css.slice(start, css.indexOf("}", start));
    assert.ok(
      block.lastIndexOf("100dvh") > block.lastIndexOf("-webkit-fill-available"),
      "100dvh must be last so CriOS URL bar does not undo it",
    );
  });

  it("menu and catch inputs are 16px (iOS focus-zoom)", () => {
    assert.match(css, /\.field input[\s\S]{0,180}font-size:\s*16px/);
  });

  it("keeps iPhone 11 (375px) HUD from overflowing", () => {
    assert.match(css, /max-width:\s*389px/);
  });
});
