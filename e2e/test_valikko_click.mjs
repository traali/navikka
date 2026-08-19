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

  // Click GPS prompt first to dismiss if visible
  await page.mouse.click(200, 740);
  await page.waitForTimeout(1000);

  // Click Valikko tab (x: 376, y: 897)
  await page.mouse.click(376, 897);
  await page.waitForTimeout(2000);

  const f1 = path.join(ARTIFACT_DIR, 'valikko_clicked.png');
  await page.screenshot({ path: f1 });
  console.log(`Saved valikko_clicked to ${f1}`);

  await browser.close();
})();
