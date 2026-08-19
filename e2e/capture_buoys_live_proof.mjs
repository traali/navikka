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

  console.log('Navigating to live https://sakkoja.pages.dev ...');
  await page.goto('https://sakkoja.pages.dev/', { waitUntil: 'domcontentloaded', timeout: 35000 });
  await page.waitForTimeout(7000); // Allow Flutter web to render tiles and buoys

  const screenshotPath = path.resolve('e2e/live_buoys_proof.png');
  await page.screenshot({ path: screenshotPath });
  console.log(`Live screenshot saved to ${screenshotPath}`);

  const artifactDir = 'C:\\Users\\aoinonen\\.gemini\\antigravity\\brain\\25c2db09-0c0b-4026-addf-77ab17a77251';
  if (fs.existsSync(artifactDir)) {
    const artifactPath = path.join(artifactDir, 'live_buoys_proof.png');
    fs.copyFileSync(screenshotPath, artifactPath);
    console.log(`Copied live proof screenshot to artifact dir: ${artifactPath}`);
  }

  await browser.close();
})();
