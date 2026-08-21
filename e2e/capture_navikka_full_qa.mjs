import { chromium } from 'playwright';
import fs from 'fs';
import path from 'path';

const ARTIFACT_DIR = 'C:/Users/aoinonen/.gemini/antigravity/brain/999832d7-b1cc-4a6c-9d21-5a065b269d88';
const BASE_URL = 'https://navikka.pages.dev';

async function runQA() {
  console.log('🚀 Launching Chromium browser for Navikka QA inspection...');
  const browser = await chromium.launch({
    headless: true,
    args: [
      '--disable-web-security',
      '--allow-running-insecure-content',
      '--enable-features=NetworkService,NetworkServiceInProcess',
      '--no-sandbox',
    ],
  });

  const context = await browser.newContext({
    viewport: { width: 1440, height: 900 },
    userAgent:
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    geolocation: { latitude: 60.1533, longitude: 24.8911 },
    permissions: ['geolocation'],
  });

  const page = await context.newPage();

  async function snap(name, desc) {
    console.log(`📸 Capturing: ${name} (${desc})...`);
    const artifactPath = path.join(ARTIFACT_DIR, `${name}.png`);
    await page.screenshot({ path: artifactPath });
    console.log(`✅ Saved ${name}.png`);
  }

  try {
    // 1. Main Navigation Map
    console.log('🌐 Navigating to Main Navigation Map...');
    await page.goto(`${BASE_URL}/`, { waitUntil: 'networkidle', timeout: 35000 });
    await page.waitForTimeout(10000);
    await snap('navikka_01_main_map', 'Main Marine Navigation Map with Nautical Tiles and Telemetry');

    // 2. Weather & AI Safety Screen
    console.log('🌦️ Navigating to Weather Screen (/weather)...');
    await page.goto(`${BASE_URL}/#/weather`, { waitUntil: 'networkidle', timeout: 35000 });
    await page.waitForTimeout(5000);
    const refreshBtn = page.locator('text=Päivitä nyt'); if (await refreshBtn.isVisible()) { await refreshBtn.click(); await page.waitForTimeout(6000); } await snap('navikka_02_weather_ai', 'Weather Observations, Forecasts, and AI Safety Advisor');

    // 3. Satellite: Copernicus Sentinel-2
    console.log('🛰️ Navigating to Satellite Screen (/satellite)...');
    await page.goto(`${BASE_URL}/#/satellite`, { waitUntil: 'networkidle', timeout: 35000 });
    await page.waitForTimeout(5000);
    await snap('navikka_03_satellite_sentinel2', 'Copernicus Sentinel-2 Optical RGB Satellite Mode');

    // 4. Satellite: EUMETSAT Live Weather
    console.log('⛈️ Switching to EUMETSAT Live Weather Satellite mode...');
    const eumetsatTab = page.locator('text=EUMETSAT Sää');
    if (await eumetsatTab.isVisible()) {
      await eumetsatTab.click();
    } else {
      await page.mouse.click(200, 45);
    }
    await page.waitForTimeout(5000);
    await snap('navikka_04_satellite_eumetsat', 'EUMETSAT Live Weather Satellite with 15min Animation Loop');

    // 5. Satellite: HD Satelliitti Basemap
    console.log('🌍 Switching to HD Satelliitti Basemap mode...');
    const hdTab = page.locator('text=HD Satelliitti');
    if (await hdTab.isVisible()) {
      await hdTab.click();
    } else {
      await page.mouse.click(320, 45);
    }
    await page.waitForTimeout(5000);
    await snap('navikka_05_satellite_hd', 'HD Satelliitti High-Resolution Ortho-Basemap');

    // 6. Fishing Mode
    console.log('🎣 Navigating to Fishing Mode (/fishing)...');
    await page.goto(`${BASE_URL}/#/fishing`, { waitUntil: 'networkidle', timeout: 35000 });
    await page.waitForTimeout(4000);
    await snap('navikka_06_fishing_mode', 'Fishing Restriction Map and Regulations');

    // 7. Menu / Valikko
    console.log('⚙️ Navigating to Valikko (/menu)...');
    await page.goto(`${BASE_URL}/#/menu`, { waitUntil: 'networkidle', timeout: 35000 });
    await page.waitForTimeout(4000);
    await snap('navikka_07_menu_settings', 'Valikko & Settings Screen');

    console.log('🎉 All 7 QA screenshots captured successfully!');
  } catch (err) {
    console.error('❌ Error during QA capture:', err);
  } finally {
    await browser.close();
  }
}

runQA();


