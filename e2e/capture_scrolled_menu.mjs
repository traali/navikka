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

  // Click Valikko tab
  await page.mouse.click(376, 890);
  await page.waitForTimeout(1500);

  // Drag up to scroll down to Teema & Mittayksiköt
  console.log('Dragging to scroll down...');
  await page.mouse.move(215, 700);
  await page.mouse.down();
  await page.mouse.move(215, 150, { steps: 15 });
  await page.mouse.up();
  await page.waitForTimeout(1500);

  const f1 = path.join(SCREENSHOT_DIR, '02_live_menu_themes_and_units_scrolled.png');
  await page.screenshot({ path: f1 });
  saveScreenshot(f1, '02_live_menu_themes_and_units_scrolled.png');

  // Drag further down to view more of Mittayksiköt
  console.log('Dragging further down...');
  await page.mouse.move(215, 700);
  await page.mouse.down();
  await page.mouse.move(215, 250, { steps: 15 });
  await page.mouse.up();
  await page.waitForTimeout(1500);

  const f2 = path.join(SCREENSHOT_DIR, '03_live_menu_unit_dropdowns.png');
  await page.screenshot({ path: f2 });
  saveScreenshot(f2, '03_live_menu_unit_dropdowns.png');

  await browser.close();
})();
