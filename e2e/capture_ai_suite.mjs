import { chromium } from 'playwright';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const artifactDir = path.resolve('C:/Users/aoinonen/.gemini/antigravity/brain/ad11818c-64b0-43f6-b0cd-e150be672e79');

async function run() {
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({
    viewport: { width: 1280, height: 850 },
    deviceScaleFactor: 2,
  });
  const page = await context.newPage();

  console.log('Navigating to live app...');
  await page.goto('https://sakkoja.pages.dev/#/menu', { waitUntil: 'networkidle', timeout: 45000 });
  await page.waitForTimeout(4000);

  // 1. Menu Screen - Top & AI Settings
  await page.screenshot({ path: path.join(artifactDir, '01_live_menu_ai_settings.png') });
  console.log('Saved 01_live_menu_ai_settings.png');

  // Scroll down menu to see AI toggles
  await page.keyboard.press('PageDown');
  await page.waitForTimeout(1000);
  await page.screenshot({ path: path.join(artifactDir, '02_live_menu_ai_toggles.png') });
  console.log('Saved 02_live_menu_ai_toggles.png');

  // 2. Navigate to Vessel Settings
  await page.goto('https://sakkoja.pages.dev/#/vessel-settings', { waitUntil: 'networkidle', timeout: 45000 });
  await page.waitForTimeout(3000);
  await page.screenshot({ path: path.join(artifactDir, '03_live_vessel_engine_settings.png') });
  console.log('Saved 03_live_vessel_engine_settings.png');

  // 3. Navigate to Technical Copilot
  await page.goto('https://sakkoja.pages.dev/#/technical-copilot', { waitUntil: 'networkidle', timeout: 45000 });
  await page.waitForTimeout(3000);
  await page.screenshot({ path: path.join(artifactDir, '04_live_technical_marine_copilot.png') });
  console.log('Saved 04_live_technical_marine_copilot.png');

  // 4. Navigate to Map Screen to see Voice Copilot FAB
  await page.goto('https://sakkoja.pages.dev/#/', { waitUntil: 'networkidle', timeout: 45000 });
  await page.waitForTimeout(4000);
  await page.screenshot({ path: path.join(artifactDir, '05_live_map_voice_copilot.png') });
  console.log('Saved 05_live_map_voice_copilot.png');

  await browser.close();
  console.log('All screenshots captured successfully.');
}

run().catch(console.error);
