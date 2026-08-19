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
    geolocation: { latitude: 60.151, longitude: 24.968 } // Right next to Särkkä buoys
  });
  const page = await context.newPage();

  console.log('Navigating to sakkoja.pages.dev...');
  await page.goto('https://sakkoja.pages.dev/', { waitUntil: 'domcontentloaded', timeout: 30000 });
  await page.waitForTimeout(6000); // Allow Flutter web to render map tiles and buoys

  const screenshotPath = path.resolve('e2e/buoys_visible.png');
  await page.screenshot({ path: screenshotPath });
  console.log(`Screenshot saved to ${screenshotPath}`);

  const artifactDir = 'C:\\Users\\aoinonen\\.gemini\\antigravity\\brain\\25c2db09-0c0b-4026-addf-77ab17a77251';
  if (fs.existsSync(artifactDir)) {
    const artifactPath = path.join(artifactDir, 'buoys_visible.png');
    fs.copyFileSync(screenshotPath, artifactPath);
    console.log(`Copied screenshot to artifact directory: ${artifactPath}`);
  }

  await browser.close();
})();
