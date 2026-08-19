import { chromium } from 'playwright';
import path from 'path';
import fs from 'fs';

(async () => {
  const browser = await chromium.launch({
    headless: true,
    args: ['--enable-unsafe-swiftshader', '--use-gl=angle', '--no-sandbox']
  });
  const context = await browser.newContext({
    viewport: { width: 1280, height: 720 },
    permissions: ['geolocation'],
    geolocation: { latitude: 60.151, longitude: 24.968 }
  });
  const page = await context.newPage();

  page.on('console', msg => console.log('CONSOLE:', msg.type(), msg.text()));
  page.on('pageerror', err => console.log('PAGE_ERROR:', err.message));

  console.log('Navigating to sakkoja.pages.dev...');
  await page.goto('https://sakkoja.pages.dev/', { waitUntil: 'domcontentloaded', timeout: 30000 });
  await page.waitForTimeout(6000);

  // Click the '+' zoom button 4 times to zoom into level 16
  const zoomIn = page.locator('button:has-text("+"), [aria-label="Zoom In"], .flutter-view button').first();
  for (let i = 0; i < 4; i++) {
    await page.keyboard.press('Equal'); // '+' key in flutter_map
    await page.waitForTimeout(500);
  }
  await page.waitForTimeout(4000);

  const screenshotPath = path.resolve('e2e/buoys_zoomed_in.png');
  await page.screenshot({ path: screenshotPath });
  console.log(`Screenshot saved to ${screenshotPath}`);

  const artifactDir = 'C:\\Users\\aoinonen\\.gemini\\antigravity\\brain\\25c2db09-0c0b-4026-addf-77ab17a77251';
  if (fs.existsSync(artifactDir)) {
    const artifactPath = path.join(artifactDir, 'buoys_zoomed_in.png');
    fs.copyFileSync(screenshotPath, artifactPath);
  }

  await browser.close();
})();
