import { chromium } from 'playwright';
import fs from 'fs';
import path from 'path';

const ARTIFACT_DIR = 'C:/Users/aoinonen/.gemini/antigravity/brain/999832d7-b1cc-4a6c-9d21-5a065b269d88';
const BASE_URL = 'https://navikka.pages.dev';

async function runMobileQA() {
  console.log('📱 Launching Mobile Chromium browser emulation (iPhone 14 / Pixel standard)...');
  const browser = await chromium.launch({
    headless: true,
    args: [
      '--disable-web-security',
      '--allow-running-insecure-content',
      '--no-sandbox',
    ],
  });

  // Emulate modern mobile device: 393 x 852 (iPhone 14 / 15 Pro standard) with touch
  const context = await browser.newContext({
    viewport: { width: 393, height: 852 },
    deviceScaleFactor: 2,
    isMobile: true,
    hasTouch: true,
    userAgent:
      'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1',
    geolocation: { latitude: 60.1533, longitude: 24.8911 },
    permissions: ['geolocation'],
  });

  const page = await context.newPage();

  async function snap(name, desc) {
    console.log(`📸 Capturing Mobile: ${name} (${desc})...`);
    const artifactPath = path.join(ARTIFACT_DIR, `${name}.png`);
    await page.screenshot({ path: artifactPath });
    console.log(`✅ Saved ${name}.png`);
  }

  try {
    // 1. Mobile Main Navigation Map
    console.log('🌐 Navigating to Mobile Main Navigation Map...');
    await page.goto(`${BASE_URL}/`, { waitUntil: 'networkidle', timeout: 35000 });
    await page.waitForTimeout(10000);
    await snap('mobile_01_main_map', 'Mobile Main Marine Navigation Map with Bottom Bar and Cockpit');

    // 2. Mobile Weather Screen
    console.log('🌦️ Navigating to Mobile Weather Screen (/weather)...');
    await page.goto(`${BASE_URL}/#/weather`, { waitUntil: 'networkidle', timeout: 35000 });
    await page.waitForTimeout(6000);
    await snap('mobile_02_weather_ai', 'Mobile Weather Observations, Forecasts, and AI Advisor');

    // 3. Mobile Satellite: Sentinel-2
    console.log('🛰️ Navigating to Mobile Satellite Screen (/satellite)...');
    await page.goto(`${BASE_URL}/#/satellite`, { waitUntil: 'networkidle', timeout: 35000 });
    await page.waitForTimeout(6000);
    await snap('mobile_03_satellite_sentinel2', 'Mobile Copernicus Sentinel-2 Optical RGB Mode');

    // 4. Mobile Satellite: EUMETSAT Live Weather
    console.log('⛈️ Switching to Mobile EUMETSAT Live Weather Satellite mode...');
    const eumetsatTab = page.locator('text=EUMETSAT Sää');
    if (await eumetsatTab.isVisible()) {
      await eumetsatTab.click();
    } else {
      await page.mouse.click(180, 45);
    }
    await page.waitForTimeout(6000);
    await snap('mobile_04_satellite_eumetsat', 'Mobile EUMETSAT Live Weather Satellite with Scrubber');

    // 5. Mobile Satellite: HD Orto-ilmakuva
    console.log('🌍 Switching to Mobile HD Satelliitti Basemap mode...');
    const hdTab = page.locator('text=HD Satelliitti');
    if (await hdTab.isVisible()) {
      await hdTab.click();
    } else {
      await page.mouse.click(300, 45);
    }
    await page.waitForTimeout(6000);
    await snap('mobile_05_satellite_hd', 'Mobile HD Satelliitti Ortho-Basemap');

    // 6. Mobile Fishing Mode
    console.log('🎣 Navigating to Mobile Fishing Mode (/fishing)...');
    await page.goto(`${BASE_URL}/#/fishing`, { waitUntil: 'networkidle', timeout: 35000 });
    await page.waitForTimeout(5000);
    await snap('mobile_06_fishing_mode', 'Mobile Fishing Restriction Map and Regulations');

    // 7. Mobile Menu / Valikko
    console.log('⚙️ Navigating to Mobile Valikko (/menu)...');
    await page.goto(`${BASE_URL}/#/menu`, { waitUntil: 'networkidle', timeout: 35000 });
    await page.waitForTimeout(5000);
    await snap('mobile_07_menu_settings', 'Mobile Valikko & Settings Screen');

    console.log('🎉 All 7 Mobile QA screenshots captured successfully!');
  } catch (err) {
    console.error('❌ Error during mobile QA capture:', err);
  } finally {
    await browser.close();
  }
}

runMobileQA();
