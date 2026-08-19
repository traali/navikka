import { chromium } from 'playwright';
import path from 'path';
import fs from 'fs';

const ARTIFACT_DIR = 'C:\\Users\\aoinonen\\.gemini\\antigravity\\brain\\ad11818c-64b0-43f6-b0cd-e150be672e79';
const SCREENSHOT_DIR = path.resolve('e2e/screenshots');

function saveScreenshot(sourcePath, filename) {
  if (fs.existsSync(ARTIFACT_DIR)) {
    const targetPath = path.join(ARTIFACT_DIR, filename);
    fs.copyFileSync(sourcePath, targetPath);
    console.log(`Saved screenshot to artifact: ${targetPath}`);
  }
}

(async () => {
  const browser = await chromium.launch({
    headless: true,
    args: ['--enable-unsafe-swiftshader', '--use-gl=angle', '--no-sandbox']
  });

  const routes = [
    { url: 'https://sakkoja.pages.dev/', name: '01_live_map_cockpit.png', wait: 8000 },
    { url: 'https://sakkoja.pages.dev/menu', name: '02_live_menu_units_themes.png', wait: 4000 },
    { url: 'https://sakkoja.pages.dev/weather', name: '03_live_weather_marine.png', wait: 5000 },
    { url: 'https://sakkoja.pages.dev/fishing', name: '04_live_fishing_bathymetry.png', wait: 4000 },
    { url: 'https://sakkoja.pages.dev/route-planner', name: '05_live_route_planner.png', wait: 4000 },
    { url: 'https://sakkoja.pages.dev/vessel-settings', name: '06_live_vessel_settings.png', wait: 4000 },
  ];

  // 1. Mobile Viewport (430 x 932)
  console.log('--- CAPTURING MOBILE PLOTTER VIEWS ---');
  const contextMobile = await browser.newContext({
    viewport: { width: 430, height: 932 },
    permissions: ['geolocation'],
    geolocation: { latitude: 60.151, longitude: 24.968 }
  });

  for (const r of routes) {
    const page = await contextMobile.newPage();
    console.log(`Navigating to ${r.url} (mobile)...`);
    await page.goto(r.url, { waitUntil: 'domcontentloaded', timeout: 45000 });
    await page.waitForTimeout(r.wait);
    const fname = `mobile_${r.name}`;
    const fpath = path.join(SCREENSHOT_DIR, fname);
    await page.screenshot({ path: fpath });
    saveScreenshot(fpath, fname);
    await page.close();
  }

  // 2. Desktop Viewport (1280 x 800)
  console.log('--- CAPTURING DESKTOP VIEWS ---');
  const contextDesktop = await browser.newContext({
    viewport: { width: 1280, height: 800 },
    permissions: ['geolocation'],
    geolocation: { latitude: 60.151, longitude: 24.968 }
  });

  for (const r of routes) {
    const page = await contextDesktop.newPage();
    console.log(`Navigating to ${r.url} (desktop)...`);
    await page.goto(r.url, { waitUntil: 'domcontentloaded', timeout: 45000 });
    await page.waitForTimeout(r.wait);
    const fname = `desktop_${r.name}`;
    const fpath = path.join(SCREENSHOT_DIR, fname);
    await page.screenshot({ path: fpath });
    saveScreenshot(fpath, fname);
    await page.close();
  }

  console.log('All direct route screenshots captured successfully!');
  await browser.close();
})();
