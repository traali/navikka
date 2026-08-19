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
  console.log('Navigating to live https://sakkoja.pages.dev ...');
  await page.goto('https://sakkoja.pages.dev/', { waitUntil: 'domcontentloaded', timeout: 45000 });
  await page.waitForTimeout(8000);

  // 1. Live Map with AI Insight Capsule
  console.log('1. Capturing Live Map with AI insight...');
  const f1 = path.join(SCREENSHOT_DIR, '01_live_map_local_ai.png');
  await page.screenshot({ path: f1 });
  saveScreenshot(f1, '01_live_map_local_ai.png');

  // 2. Open Weather Screen (Tab 3: x: 268, y: 897)
  console.log('2. Opening Weather Screen for Local AI Skipper card...');
  await page.mouse.click(268, 897);
  await page.waitForTimeout(3000);

  const f2 = path.join(SCREENSHOT_DIR, '02_live_weather_local_skipper_ai.png');
  await page.screenshot({ path: f2 });
  saveScreenshot(f2, '02_live_weather_local_skipper_ai.png');

  console.log('Local Web AI screenshots captured successfully!');
  await browser.close();
})();
