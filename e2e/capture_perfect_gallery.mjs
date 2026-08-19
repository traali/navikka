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
    viewport: { width: 430, height: 932 },
    permissions: ['geolocation'],
    geolocation: { latitude: 60.151, longitude: 24.968 }
  });

  const page = await context.newPage();
  console.log('Navigating to live https://sakkoja.pages.dev ...');
  await page.goto('https://sakkoja.pages.dev/', { waitUntil: 'domcontentloaded', timeout: 45000 });
  await page.waitForTimeout(8000);

  // 1. Map Cockpit (OLED Dark)
  console.log('1. Capturing Map Cockpit...');
  const f1 = path.join(SCREENSHOT_DIR, '01_live_map_cockpit.png');
  await page.screenshot({ path: f1 });
  saveScreenshot(f1, '01_live_map_cockpit.png');

  // 2. Open Valikko (Tab 4: x: 376, y: 890)
  console.log('2. Opening Valikko...');
  await page.mouse.click(376, 890);
  await page.waitForTimeout(2000);
  const f2 = path.join(SCREENSHOT_DIR, '02_live_valikko_top.png');
  await page.screenshot({ path: f2 });
  saveScreenshot(f2, '02_live_valikko_top.png');

  // 3. Scroll to Themes & Units in Valikko
  console.log('3. Scrolling to Themes & Units...');
  await page.mouse.wheel(0, 750);
  await page.waitForTimeout(1500);
  const f3 = path.join(SCREENSHOT_DIR, '03_live_valikko_units_and_themes.png');
  await page.screenshot({ path: f3 });
  saveScreenshot(f3, '03_live_valikko_units_and_themes.png');

  // 4. Switch Theme to Standard Dark (Navy Deep)
  console.log('4. Switching Theme to Standard Dark (Navy Deep)...');
  // Click on "Tumma" theme tile (near top middle of viewport when scrolled)
  await page.mouse.click(215, 300);
  await page.waitForTimeout(1000);
  // Return to Map (Tab 1: x: 53, y: 890)
  await page.mouse.click(53, 890);
  await page.waitForTimeout(2000);
  const f4 = path.join(SCREENSHOT_DIR, '04_live_theme_navy_deep.png');
  await page.screenshot({ path: f4 });
  saveScreenshot(f4, '04_live_theme_navy_deep.png');

  // 5. Switch Theme to High-Contrast Light (Daylight Sun)
  console.log('5. Switching Theme to High-Contrast Light (Daylight Sun)...');
  await page.mouse.click(376, 890); // Valikko
  await page.waitForTimeout(1500);
  await page.mouse.wheel(0, 750); // Scroll
  await page.waitForTimeout(1000);
  await page.mouse.click(215, 360); // "Vaalea" tile
  await page.waitForTimeout(1000);
  await page.mouse.click(53, 890); // Map
  await page.waitForTimeout(2000);
  const f5 = path.join(SCREENSHOT_DIR, '05_live_theme_daylight_sun.png');
  await page.screenshot({ path: f5 });
  saveScreenshot(f5, '05_live_theme_daylight_sun.png');

  // 6. Weather Screen (Tab 3: x: 268, y: 890) in Light Mode
  console.log('6. Opening Weather Screen in Light Mode...');
  await page.mouse.click(268, 890);
  await page.waitForTimeout(2500);
  const f6 = path.join(SCREENSHOT_DIR, '06_live_weather_daylight.png');
  await page.screenshot({ path: f6 });
  saveScreenshot(f6, '06_live_weather_daylight.png');

  // 7. Fishing Screen (Tab 2: x: 161, y: 890) in Light Mode
  console.log('7. Opening Fishing Screen in Light Mode...');
  await page.mouse.click(161, 890);
  await page.waitForTimeout(2500);
  const f7 = path.join(SCREENSHOT_DIR, '07_live_fishing_daylight.png');
  await page.screenshot({ path: f7 });
  saveScreenshot(f7, '07_live_fishing_daylight.png');

  // 8. Restore OLED Dark Theme (Night Captain)
  console.log('8. Restoring OLED Dark Theme (Night Captain)...');
  await page.mouse.click(376, 890); // Valikko
  await page.waitForTimeout(1500);
  await page.mouse.wheel(0, 750); // Scroll
  await page.waitForTimeout(1000);
  await page.mouse.click(215, 230); // "OLED Tumma" tile
  await page.waitForTimeout(1000);

  // 9. Weather Screen in OLED Dark
  console.log('9. Opening Weather Screen in OLED Dark...');
  await page.mouse.click(268, 890); // Weather
  await page.waitForTimeout(2500);
  const f8 = path.join(SCREENSHOT_DIR, '08_live_weather_oled_dark.png');
  await page.screenshot({ path: f8 });
  saveScreenshot(f8, '08_live_weather_oled_dark.png');

  // 10. Return to Map in OLED Dark
  console.log('10. Returning to Map in OLED Dark...');
  await page.mouse.click(53, 890); // Map
  await page.waitForTimeout(2000);
  const f9 = path.join(SCREENSHOT_DIR, '09_live_map_oled_final.png');
  await page.screenshot({ path: f9 });
  saveScreenshot(f9, '09_live_map_oled_final.png');

  console.log('Perfect live gallery capture complete!');
  await browser.close();
})();
