import { chromium, devices } from 'playwright';
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
  const iPhone = devices['iPhone 14 Pro Max'];
  const browser = await chromium.launch({
    headless: true,
    args: ['--enable-unsafe-swiftshader', '--use-gl=angle', '--no-sandbox']
  });

  const context = await browser.newContext({
    ...iPhone,
    permissions: ['geolocation'],
    geolocation: { latitude: 60.151, longitude: 24.968 }
  });

  const page = await context.newPage();
  await page.goto('https://sakkoja.pages.dev/', { waitUntil: 'domcontentloaded', timeout: 45000 });
  await page.waitForTimeout(7000);

  // Tap Valikko
  await page.tap('text=Valikko').catch(async () => {
    await page.touchscreen.tap(376, 890);
  });
  await page.waitForTimeout(2000);

  // Swipe up on touch screen to scroll down
  console.log('Swiping up to scroll menu...');
  await page.mouse.move(215, 750);
  await page.mouse.down();
  await page.mouse.move(215, 100, { steps: 20 });
  await page.mouse.up();
  await page.waitForTimeout(1500);

  const f1 = path.join(SCREENSHOT_DIR, '01_touch_menu_scrolled.png');
  await page.screenshot({ path: f1 });
  saveScreenshot(f1, '01_touch_menu_scrolled.png');

  // Swipe up more
  await page.mouse.move(215, 750);
  await page.mouse.down();
  await page.mouse.move(215, 100, { steps: 20 });
  await page.mouse.up();
  await page.waitForTimeout(1500);

  const f2 = path.join(SCREENSHOT_DIR, '02_touch_menu_units.png');
  await page.screenshot({ path: f2 });
  saveScreenshot(f2, '02_touch_menu_units.png');

  await browser.close();
})();
