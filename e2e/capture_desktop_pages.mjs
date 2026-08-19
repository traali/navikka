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

  const context = await browser.newContext({
    viewport: { width: 1280, height: 800 },
    permissions: ['geolocation'],
    geolocation: { latitude: 60.151, longitude: 24.968 }
  });

  const page = await context.newPage();
  await page.goto('https://sakkoja.pages.dev/', { waitUntil: 'domcontentloaded', timeout: 45000 });
  await page.waitForTimeout(7000);

  // 1. Desktop Map
  const fMap = path.join(SCREENSHOT_DIR, '01_desktop_map_oled.png');
  await page.screenshot({ path: fMap });
  saveScreenshot(fMap, '01_desktop_map_oled.png');

  // 2. Open Valikko via Desktop Sidebar (x: 60, y: 200)
  await page.mouse.click(60, 200);
  await page.waitForTimeout(2000);
  const fMenu = path.join(SCREENSHOT_DIR, '02_desktop_menu_units.png');
  await page.screenshot({ path: fMenu });
  saveScreenshot(fMenu, '02_desktop_menu_units.png');

  // 3. Open Sää via Desktop Sidebar (x: 60, y: 145)
  await page.mouse.click(60, 145);
  await page.waitForTimeout(2500);
  const fWeather = path.join(SCREENSHOT_DIR, '03_desktop_weather.png');
  await page.screenshot({ path: fWeather });
  saveScreenshot(fWeather, '03_desktop_weather.png');

  // 4. Open Kalastus via Desktop Sidebar (x: 60, y: 90)
  await page.mouse.click(60, 90);
  await page.waitForTimeout(2500);
  const fFishing = path.join(SCREENSHOT_DIR, '04_desktop_fishing.png');
  await page.screenshot({ path: fFishing });
  saveScreenshot(fFishing, '04_desktop_fishing.png');

  await browser.close();
})();
