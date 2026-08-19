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

  console.log('Navigating to live https://sakkoja.pages.dev ...');
  await page.goto('https://sakkoja.pages.dev/', { waitUntil: 'domcontentloaded', timeout: 45000 });
  await page.waitForTimeout(8000);

  // 1. OLED Dark (Night Captain) Map View
  console.log('1. Capturing OLED Dark (Night Captain)...');
  const f1 = path.join(SCREENSHOT_DIR, '01_theme_oled_dark.png');
  await page.screenshot({ path: f1 });
  saveScreenshot(f1, '01_theme_oled_dark.png');

  // 2. Open Menu, scroll to Themes & Units
  console.log('2. Navigating to Menu & scrolling to Themes & Units...');
  await page.mouse.click(1050, 770); // Click Menu tab
  await page.waitForTimeout(1500);
  // Scroll down
  await page.mouse.wheel(0, 500);
  await page.waitForTimeout(1500);
  const f2 = path.join(SCREENSHOT_DIR, '02_menu_themes_and_units.png');
  await page.screenshot({ path: f2 });
  saveScreenshot(f2, '02_menu_themes_and_units.png');

  // 3. Switch to Standard Dark Theme (Navy Deep)
  console.log('3. Selecting Standard Dark (Navy Deep)...');
  // Click on "Tumma (Navy Deep)" tile
  await page.mouse.click(640, 240);
  await page.waitForTimeout(1500);
  await page.mouse.click(230, 770); // Back to Map
  await page.waitForTimeout(2000);
  const f3 = path.join(SCREENSHOT_DIR, '03_theme_navy_deep_dark.png');
  await page.screenshot({ path: f3 });
  saveScreenshot(f3, '03_theme_navy_deep_dark.png');

  // 4. Switch to High-Contrast Light Theme (Daylight Sun)
  console.log('4. Selecting High-Contrast Light (Daylight Sun)...');
  await page.mouse.click(1050, 770); // Menu tab
  await page.waitForTimeout(1500);
  await page.mouse.click(640, 310); // Daylight Sun option
  await page.waitForTimeout(1500);
  await page.mouse.click(230, 770); // Back to Map
  await page.waitForTimeout(2000);
  const f4 = path.join(SCREENSHOT_DIR, '04_theme_daylight_sun_light.png');
  await page.screenshot({ path: f4 });
  saveScreenshot(f4, '04_theme_daylight_sun_light.png');

  // 5. Weather Screen in Daylight Sun
  console.log('5. Capturing Weather Screen in Daylight Sun...');
  await page.mouse.click(500, 770); // Weather tab
  await page.waitForTimeout(2500);
  const f5 = path.join(SCREENSHOT_DIR, '05_weather_daylight_sun.png');
  await page.screenshot({ path: f5 });
  saveScreenshot(f5, '05_weather_daylight_sun.png');

  // 6. Restore OLED Dark Theme and capture Weather Screen
  console.log('6. Restoring OLED Dark & Capturing Weather Screen...');
  await page.mouse.click(1050, 770); // Menu tab
  await page.waitForTimeout(1500);
  await page.mouse.click(640, 160); // OLED Dark option
  await page.waitForTimeout(1500);
  await page.mouse.click(500, 770); // Weather tab
  await page.waitForTimeout(2000);
  const f6 = path.join(SCREENSHOT_DIR, '06_weather_oled_dark.png');
  await page.screenshot({ path: f6 });
  saveScreenshot(f6, '06_weather_oled_dark.png');

  // 7. Fishing Screen
  console.log('7. Capturing Fishing Screen...');
  await page.mouse.click(780, 770); // Fishing tab
  await page.waitForTimeout(2500);
  const f7 = path.join(SCREENSHOT_DIR, '07_fishing_screen.png');
  await page.screenshot({ path: f7 });
  saveScreenshot(f7, '07_fishing_screen.png');

  console.log('Detailed gallery capture complete!');
  await browser.close();
})();
