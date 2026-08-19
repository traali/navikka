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
    viewport: { width: 430, height: 932 },
    permissions: ['geolocation'],
    geolocation: { latitude: 60.151, longitude: 24.968 }
  });

  const page = await context.newPage();
  await page.goto('https://sakkoja.pages.dev/', { waitUntil: 'domcontentloaded', timeout: 45000 });
  await page.waitForTimeout(7000);

  // 1. OLED Dark
  const f1 = path.join(SCREENSHOT_DIR, '01_theme_night_captain_oled.png');
  await page.screenshot({ path: f1 });
  saveScreenshot(f1, '01_theme_night_captain_oled.png');

  // Go to Valikko
  await page.mouse.click(376, 897);
  await page.waitForTimeout(1500);
  await page.mouse.move(215, 400);
  await page.mouse.wheel(0, 1100);
  await page.waitForTimeout(1500);

  // 2. Select Päivänpaiste (Daylight Sun) - 2nd theme tile (~y: 355)
  console.log('Selecting Päivänpaiste (Daylight Sun)...');
  await page.mouse.click(215, 355);
  await page.waitForTimeout(1000);
  await page.mouse.click(53, 897); // Map
  await page.waitForTimeout(2000);
  const f2 = path.join(SCREENSHOT_DIR, '02_theme_daylight_sun.png');
  await page.screenshot({ path: f2 });
  saveScreenshot(f2, '02_theme_daylight_sun.png');

  // 3. Select Syvä meri (Deep Sea) - 3rd theme tile (~y: 425)
  console.log('Selecting Syvä meri (Deep Sea)...');
  await page.mouse.click(376, 897); // Valikko
  await page.waitForTimeout(1000);
  await page.mouse.click(215, 425);
  await page.waitForTimeout(1000);
  await page.mouse.click(53, 897); // Map
  await page.waitForTimeout(2000);
  const f3 = path.join(SCREENSHOT_DIR, '03_theme_deep_sea_navy.png');
  await page.screenshot({ path: f3 });
  saveScreenshot(f3, '03_theme_deep_sea_navy.png');

  // 4. Select Revontulet (Aurora Boreal) - 4th theme tile (~y: 500)
  console.log('Selecting Revontulet (Aurora Boreal)...');
  await page.mouse.click(376, 897); // Valikko
  await page.waitForTimeout(1000);
  await page.mouse.click(215, 500);
  await page.waitForTimeout(1000);
  await page.mouse.click(53, 897); // Map
  await page.waitForTimeout(2000);
  const f4 = path.join(SCREENSHOT_DIR, '04_theme_aurora_boreal.png');
  await page.screenshot({ path: f4 });
  saveScreenshot(f4, '04_theme_aurora_boreal.png');

  // 5. Select Punainen yövahti (Red Night Watch) - 5th theme tile (~y: 575)
  console.log('Selecting Punainen yövahti (Red Night Watch)...');
  await page.mouse.click(376, 897); // Valikko
  await page.waitForTimeout(1000);
  await page.mouse.click(215, 575);
  await page.waitForTimeout(1000);
  await page.mouse.click(53, 897); // Map
  await page.waitForTimeout(2000);
  const f5 = path.join(SCREENSHOT_DIR, '05_theme_red_night_watch.png');
  await page.screenshot({ path: f5 });
  saveScreenshot(f5, '05_theme_red_night_watch.png');

  // Restore OLED Dark
  await page.mouse.click(376, 897); // Valikko
  await page.waitForTimeout(1000);
  await page.mouse.click(215, 275); // 1st tile (OLED)
  await page.waitForTimeout(1000);
  await page.mouse.click(53, 897); // Map
  await page.waitForTimeout(1500);

  console.log('All 5 themes captured successfully!');
  await browser.close();
})();
