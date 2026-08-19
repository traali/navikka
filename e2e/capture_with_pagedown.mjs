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

  // Focus list and press PageDown multiple times
  await page.mouse.click(215, 400);
  await page.keyboard.press('PageDown');
  await page.waitForTimeout(1000);

  const f1 = path.join(SCREENSHOT_DIR, '02_live_menu_pagedown_1.png');
  await page.screenshot({ path: f1 });
  saveScreenshot(f1, '02_live_menu_pagedown_1.png');

  await page.keyboard.press('PageDown');
  await page.waitForTimeout(1000);

  const f2 = path.join(SCREENSHOT_DIR, '03_live_menu_pagedown_2.png');
  await page.screenshot({ path: f2 });
  saveScreenshot(f2, '03_live_menu_pagedown_2.png');

  await browser.close();
})();
