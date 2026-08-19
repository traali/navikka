import { chromium } from 'playwright';
import path from 'path';
import fs from 'fs';

const ARTIFACT_DIR = 'C:\\Users\\aoinonen\\.gemini\\antigravity\\brain\\ad11818c-64b0-43f6-b0cd-e150be672e79';
const SCREENSHOT_DIR = path.resolve('e2e/screenshots');

if (!fs.existsSync(SCREENSHOT_DIR)) {
  fs.mkdirSync(SCREENSHOT_DIR, { recursive: true });
}

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
    geolocation: { latitude: 60.151, longitude: 24.968 } // Kaivopuisto / Harmaja, Helsinki
  });

  const page = await context.newPage();

  console.log('Navigating to live https://sakkoja.pages.dev ...');
  await page.goto('https://sakkoja.pages.dev/', { waitUntil: 'domcontentloaded', timeout: 45000 });
  
  // Wait for Flutter web rendering engine
  await page.waitForTimeout(8000);

  // 1. Cruising Mode (OLED Dark)
  console.log('Capturing Cruising Mode (OLED Dark)...');
  const fileCruising = path.join(SCREENSHOT_DIR, '01_cruising_mode_oled_dark.png');
  await page.screenshot({ path: fileCruising });
  saveScreenshot(fileCruising, '01_cruising_mode_oled_dark.png');

  // 2. Switch to Harbor Mode via Top Pill
  console.log('Switching to Harbor Mode...');
  // Tap around top pill area (or key actions)
  // Let's click on the pill selector for Harbor mode or evaluate in Flutter
  await page.mouse.click(640, 60);
  await page.waitForTimeout(1000);
  const fileHarbor = path.join(SCREENSHOT_DIR, '02_harbor_mode.png');
  await page.screenshot({ path: fileHarbor });
  saveScreenshot(fileHarbor, '02_harbor_mode.png');

  // 3. Open Menu / Settings to capture Unit Preferences & Themes
  console.log('Opening Valikko / Menu Screen...');
  // Tap bottom nav bar Menu icon (rightmost tab: ~960, 770 in 1280x800)
  await page.mouse.click(1050, 770);
  await page.waitForTimeout(2000);
  const fileMenu = path.join(SCREENSHOT_DIR, '05_menu_unit_preferences.png');
  await page.screenshot({ path: fileMenu });
  saveScreenshot(fileMenu, '05_menu_unit_preferences.png');

  // 4. Switch Theme to Light Mode (Daylight Sun)
  console.log('Switching Theme to Daylight Sun...');
  // Tap on Daylight Sun theme option
  await page.mouse.click(640, 200);
  await page.waitForTimeout(1500);
  // Tap back to Map tab (leftmost tab: ~230, 770)
  await page.mouse.click(230, 770);
  await page.waitForTimeout(2000);
  const fileLight = path.join(SCREENSHOT_DIR, '07_theme_high_contrast_light.png');
  await page.screenshot({ path: fileLight });
  saveScreenshot(fileLight, '07_theme_high_contrast_light.png');

  // 5. Switch to Weather Screen
  console.log('Navigating to Weather Screen...');
  // Weather tab is 2nd tab (~500, 770)
  await page.mouse.click(500, 770);
  await page.waitForTimeout(2500);
  const fileWeather = path.join(SCREENSHOT_DIR, '08_weather_marine_screen.png');
  await page.screenshot({ path: fileWeather });
  saveScreenshot(fileWeather, '08_weather_marine_screen.png');

  // 6. Switch back to OLED Dark Night Captain
  console.log('Restoring OLED Dark Night Captain Theme...');
  await page.mouse.click(1050, 770); // Menu tab
  await page.waitForTimeout(1500);
  await page.mouse.click(640, 140); // OLED Dark option
  await page.waitForTimeout(1000);
  await page.mouse.click(230, 770); // Map tab
  await page.waitForTimeout(2000);

  const fileFinal = path.join(SCREENSHOT_DIR, '09_virtual_skipper_explainable_hud.png');
  await page.screenshot({ path: fileFinal });
  saveScreenshot(fileFinal, '09_virtual_skipper_explainable_hud.png');

  console.log('All screenshots captured successfully!');
  await browser.close();
})();
