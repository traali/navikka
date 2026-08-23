import { chromium } from "playwright";
import { mkdir } from "node:fs/promises";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const shotDir = join(here, "../screenshots");
await mkdir(shotDir, { recursive: true });
const BASE = process.env.BASE_URL ?? "http://127.0.0.1:5173/";

const CHROME_IOS =
  "Mozilla/5.0 (iPhone; CPU iPhone OS 17_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/128.0.6613.98 Mobile/15E148 Safari/604.1";

const browser = await chromium.launch({ args: ["--no-sandbox"] });
const context = await browser.newContext({
  viewport: { width: 390, height: 844 },
  isMobile: true,
  hasTouch: true,
  deviceScaleFactor: 3,
  userAgent: CHROME_IOS,
});
const page = await context.newPage();
const errors = [];
page.on("pageerror", (e) => errors.push("page:" + e.message));
page.on("console", (m) => {
  if (m.type() === "error") errors.push("console:" + m.text());
});

await page.goto(BASE, { waitUntil: "networkidle", timeout: 30000 });
await page.waitForTimeout(2500);

const afterLoad = await page.evaluate(() => window.__navikkaPoll ?? null);

await page.waitForTimeout(16000);
const afterBoat = await page.evaluate(() => {
  const poll = window.__navikkaPoll ?? null;
  const age = document.querySelector("[data-weather-age]");
  const wind = document.querySelector(".tel:nth-child(4)");
  return {
    poll,
    weatherAge: age?.getAttribute("data-weather-age") ?? null,
    weatherAgeText: age?.textContent ?? null,
    windText: wind?.innerText ?? null,
    sog: document.querySelector(".tel")?.innerText ?? null,
  };
});

await page.getByRole("button", { name: "Sää" }).click();
await page.waitForTimeout(600);
await page.screenshot({ path: join(shotDir, "underway-weather.png") });
const weatherPanel = await page.locator(".panel").innerText();

await page.getByRole("button", { name: "Kartta" }).click();
await page.waitForTimeout(300);
await page.screenshot({ path: join(shotDir, "underway-map.png") });

const overflow = await page.evaluate(
  () => document.documentElement.scrollWidth > document.documentElement.clientWidth + 1,
);

const verdict = {
  errors,
  overflow,
  afterLoad,
  afterBoat,
  weatherPanelHead: weatherPanel.slice(0, 280),
  perpetualFetch: /Haetaan merisäätä/i.test(weatherPanel) && !/min|juuri|just/i.test(weatherPanel),
  weatherFetchesAfter8s: afterBoat.poll?.weather ?? null,
  aisFetchesAfter8s: afterBoat.poll?.ais ?? null,
};

console.log(JSON.stringify(verdict, null, 2));
if (errors.length) process.exitCode = 1;
if (verdict.weatherFetchesAfter8s != null && verdict.weatherFetchesAfter8s > 1) process.exitCode = 1;
if (verdict.perpetualFetch) process.exitCode = 1;
await browser.close();
