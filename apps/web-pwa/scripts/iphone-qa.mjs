import { chromium } from "playwright";
import { mkdir } from "node:fs/promises";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const shots = resolve(here, "../screenshots");
await mkdir(shots, { recursive: true });

const BASE = process.env.BASE_URL ?? "http://127.0.0.1:5173/";
const CHROME_IOS =
  "Mozilla/5.0 (iPhone; CPU iPhone OS 17_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/128.0.6613.98 Mobile/15E148 Safari/604.1";

const devices = [
  { id: "iphone-11", width: 375, height: 812, dpr: 2 },
  { id: "iphone-12", width: 390, height: 844, dpr: 3 },
];

const browser = await chromium.launch({ args: ["--no-sandbox"] });
const results = [];

for (const d of devices) {
  const context = await browser.newContext({
    viewport: { width: d.width, height: d.height },
    isMobile: true,
    hasTouch: true,
    deviceScaleFactor: d.dpr,
    userAgent: CHROME_IOS,
  });
  const page = await context.newPage();
  const errors = [];
  page.on("pageerror", (e) => errors.push("page:" + e.message));
  page.on("console", (m) => {
    if (m.type() === "error") errors.push("console:" + m.text());
  });
  await page.goto(BASE, { waitUntil: "networkidle", timeout: 30000 });
  await page.waitForTimeout(1800);
  await page.screenshot({ path: `${shots}/${d.id}-map.png`, fullPage: false });

  const overflow = await page.evaluate(
    () => document.documentElement.scrollWidth > document.documentElement.clientWidth + 1,
  );
  await page.getByRole("button", { name: "Sää" }).click();
  await page.waitForTimeout(500);
  await page.screenshot({ path: `${shots}/${d.id}-weather.png` });

  await page.getByRole("button", { name: "Valikko" }).click();
  await page.waitForTimeout(400);
  await page.screenshot({ path: `${shots}/${d.id}-menu.png` });

  await page.getByRole("button", { name: "Kartta" }).click();
  await page.waitForTimeout(250);
  await page.getByRole("button", { name: "HÄTÄ" }).click();
  await page.waitForTimeout(350);
  await page.screenshot({ path: `${shots}/${d.id}-sos.png` });

  const text = await page.locator("body").innerText();
  const tileCount = await page.locator(".leaflet-tile").count();
  const mapSize = await page.locator(".leaflet-container").boundingBox();
  const inputFont = await page
    .locator(".search-row input")
    .evaluate((el) => getComputedStyle(el).fontSize);
  results.push({
    ...d,
    overflow,
    errors,
    tileCount,
    mapSize,
    inputFont,
    textLen: text.length,
    hasNavikka: text.includes("Navikka"),
    hasSos: text.includes("112"),
  });
  await context.close();
}

console.log(JSON.stringify(results, null, 2));
await browser.close();
if (results.some((r) => r.overflow || r.errors.length || !r.hasNavikka || !r.mapSize)) {
  process.exit(1);
}
