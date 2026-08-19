import { chromium } from 'playwright';
import path from 'path';

const artifactDir = path.resolve('C:/Users/aoinonen/.gemini/antigravity/brain/999832d7-b1cc-4a6c-9d21-5a065b269d88');

async function run() {
  console.log('Launching headless Chromium...');
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({
    viewport: { width: 1280, height: 800 },
    deviceScaleFactor: 2,
  });
  const page = await context.newPage();

  console.log('Navigating to Live Map...');
  await page.goto('https://sakkoja.pages.dev/#/', { waitUntil: 'domcontentloaded', timeout: 30000 });
  await page.waitForTimeout(6000);

  // 1. Live Map Initial Screen
  const mapPath = path.join(artifactDir, 'real_live_app_map.png');
  await page.screenshot({ path: mapPath });
  console.log('Saved:', mapPath);

  // 2. Navigate to Weather Screen
  console.log('Navigating to Weather Screen...');
  await page.goto('https://sakkoja.pages.dev/#/weather', { waitUntil: 'domcontentloaded', timeout: 30000 });
  await page.waitForTimeout(4000);

  const weatherPath = path.join(artifactDir, 'real_live_app_weather.png');
  await page.screenshot({ path: weatherPath });
  console.log('Saved:', weatherPath);

  // 3. Scroll down Weather Screen to show SYKE Algae & Water Quality
  await page.keyboard.press('PageDown');
  await page.waitForTimeout(1500);

  const weatherScrolledPath = path.join(artifactDir, 'real_live_app_weather_algae_card.png');
  await page.screenshot({ path: weatherScrolledPath });
  console.log('Saved:', weatherScrolledPath);

  // 4. Navigate to Menu Screen to show Map Layers & Settings
  console.log('Navigating to Menu Screen...');
  await page.goto('https://sakkoja.pages.dev/#/menu', { waitUntil: 'domcontentloaded', timeout: 30000 });
  await page.waitForTimeout(3000);

  const menuPath = path.join(artifactDir, 'real_live_app_menu.png');
  await page.screenshot({ path: menuPath });
  console.log('Saved:', menuPath);

  await browser.close();
  console.log('All real live app screenshots captured successfully!');
}

run().catch(console.error);
