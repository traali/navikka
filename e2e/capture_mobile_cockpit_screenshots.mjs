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

  // Mobile Viewport (iPhone 14 / Marine Plotter 430 x 932)
  const contextMobile = await browser.newContext({
    viewport: { width: 430, height: 932 },
    permissions: ['geolocation'],
    geolocation: { latitude: 60.151, longitude: 24.968 }
  });

  const page = await contextMobile.newPage();

  console.log('Navigating to live https://sakkoja.pages.dev in Mobile Plotter resolution...');
  await page.goto('https://sakkoja.pages.dev/', { waitUntil: 'domcontentloaded', timeout: 45000 });
  await page.waitForTimeout(8000);

  // 1. Mobile Cockpit Cruising Mode (OLED Dark)
  const fileMobileCruising = path.join(SCREENSHOT_DIR, '01_mobile_cockpit_cruising_oled.png');
  await page.screenshot({ path: fileMobileCruising });
  saveScreenshot(fileMobileCruising, '01_mobile_cockpit_cruising_oled.png');

  // 2. Open Menu / Unit preferences in Mobile
  await page.mouse.click(370, 900); // Bottom Nav Menu tab
  await page.waitForTimeout(2000);
  const fileMobileMenu = path.join(SCREENSHOT_DIR, '02_mobile_menu_unit_preferences.png');
  await page.screenshot({ path: fileMobileMenu });
  saveScreenshot(fileMobileMenu, '02_mobile_menu_unit_preferences.png');

  // 3. Switch to Light Mode (Daylight Sun)
  await page.mouse.click(215, 230); // Daylight Sun tile
  await page.waitForTimeout(1500);
  await page.mouse.click(50, 900); // Map tab
  await page.waitForTimeout(2000);
  const fileMobileLight = path.join(SCREENSHOT_DIR, '03_mobile_theme_daylight_sun.png');
  await page.screenshot({ path: fileMobileLight });
  saveScreenshot(fileMobileLight, '03_mobile_theme_daylight_sun.png');

  // 4. Switch to Weather Screen
  await page.mouse.click(160, 900); // Weather tab
  await page.waitForTimeout(2500);
  const fileMobileWeather = path.join(SCREENSHOT_DIR, '04_mobile_weather_screen.png');
  await page.screenshot({ path: fileMobileWeather });
  saveScreenshot(fileMobileWeather, '04_mobile_weather_screen.png');

  // 5. Switch to Fishing Mode
  await page.mouse.click(270, 900); // Fishing tab
  await page.waitForTimeout(2500);
  const fileMobileFishing = path.join(SCREENSHOT_DIR, '05_mobile_fishing_mode.png');
  await page.screenshot({ path: fileMobileFishing });
  saveScreenshot(fileMobileFishing, '05_mobile_fishing_mode.png');

  console.log('Mobile screenshots captured successfully!');
  await browser.close();
})();
