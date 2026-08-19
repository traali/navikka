import { chromium } from 'playwright';
import path from 'path';
import fs from 'fs';

const ARTIFACT_DIR = 'C:\\Users\\aoinonen\\.gemini\\antigravity\\brain\\ad11818c-64b0-43f6-b0cd-e150be672e79';

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

  // Click Valikko tab
  await page.mouse.click(376, 897);
  await page.waitForTimeout(1500);

  // Position mouse in list area and scroll
  await page.mouse.move(215, 400);
  await page.mouse.wheel(0, 1100);
  await page.waitForTimeout(1500);

  const f1 = path.join(ARTIFACT_DIR, '02_live_menu_themes_and_units.png');
  await page.screenshot({ path: f1 });
  console.log(`Saved screenshot to ${f1}`);

  // Scroll down slightly more for unit dropdowns
  await page.mouse.wheel(0, 600);
  await page.waitForTimeout(1500);

  const f2 = path.join(ARTIFACT_DIR, '03_live_menu_unit_preferences.png');
  await page.screenshot({ path: f2 });
  console.log(`Saved screenshot to ${f2}`);

  // Click on "Tumma" (Navy Deep theme) tile
  await page.mouse.click(215, 230);
  await page.waitForTimeout(1000);
  // Back to Map tab
  await page.mouse.click(53, 897);
  await page.waitForTimeout(2000);

  const f3 = path.join(ARTIFACT_DIR, '04_live_theme_navy_deep.png');
  await page.screenshot({ path: f3 });
  console.log(`Saved screenshot to ${f3}`);

  // Go to Valikko -> Click "Vaalea" (Daylight Sun theme)
  await page.mouse.click(376, 897);
  await page.waitForTimeout(1500);
  await page.mouse.move(215, 400);
  await page.mouse.wheel(0, 600);
  await page.waitForTimeout(1000);
  await page.mouse.click(215, 300); // Daylight Sun
  await page.waitForTimeout(1000);
  await page.mouse.click(53, 897); // Map
  await page.waitForTimeout(2000);

  const f4 = path.join(ARTIFACT_DIR, '05_live_theme_daylight_sun.png');
  await page.screenshot({ path: f4 });
  console.log(`Saved screenshot to ${f4}`);

  // Restore OLED Dark
  await page.mouse.click(376, 897);
  await page.waitForTimeout(1500);
  await page.mouse.move(215, 400);
  await page.mouse.wheel(0, 600);
  await page.waitForTimeout(1000);
  await page.mouse.click(215, 160); // OLED Dark
  await page.waitForTimeout(1000);
  await page.mouse.click(53, 897); // Map
  await page.waitForTimeout(2000);

  const f5 = path.join(ARTIFACT_DIR, '06_live_theme_oled_dark_cockpit.png');
  await page.screenshot({ path: f5 });
  console.log(`Saved screenshot to ${f5}`);

  await browser.close();
})();
