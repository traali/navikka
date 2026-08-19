import { chromium } from 'playwright';
import fs from 'fs';

(async () => {
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({
    viewport: { width: 1280, height: 720 },
    permissions: ['geolocation']
  });
  const page = await context.newPage();

  // Log everything
  page.on('console', msg => console.log('CONSOLE:', msg.text()));
  page.on('pageerror', err => console.log('ERROR:', err.message));

  console.log('--- 1. Testing Route Planner ---');
  await page.goto('https://sakkoja.pages.dev/#/route-planner', { waitUntil: 'load' });
  await page.waitForTimeout(8000); // Give Flutter some time to render and fetch data
  
  await page.screenshot({ path: 'route-planner-initial.png' });

  // Waypoint addition at map center
  const width = 1280;
  const height = 720;
  await page.mouse.click(width / 2, height / 2);
  await page.waitForTimeout(1000);
  
  // Add a second waypoint slightly offset
  await page.mouse.click(width / 2 + 100, height / 2 + 100);
  await page.waitForTimeout(2000);
  await page.screenshot({ path: 'route-planner-waypoints.png' });

  // Try to click "Save Route" (we will just take screenshots of the state for now, assuming it's visually there)
  
  console.log('--- 2. Testing Weather Alerts & Insights ---');
  await page.goto('https://sakkoja.pages.dev/#/weather', { waitUntil: 'load' });
  await page.waitForTimeout(8000);
  await page.screenshot({ path: 'weather-initial.png' });
  
  // Try to click around where alerts might be
  await page.mouse.click(width - 50, 50); // Top right corner might have alert badge?
  await page.waitForTimeout(2000);
  await page.screenshot({ path: 'weather-alert.png' });

  console.log('--- 3. Testing Fishing Mode ---');
  await page.goto('https://sakkoja.pages.dev/#/fishing', { waitUntil: 'load' });
  await page.waitForTimeout(8000);
  await page.screenshot({ path: 'fishing-initial.png' });
  
  // Try to interact with toggles (usually top or bottom sheets)
  await page.mouse.click(width / 2, 50); // Maybe top bar
  await page.waitForTimeout(1000);
  await page.mouse.click(width / 2, height - 50); // Maybe bottom sheet
  await page.waitForTimeout(2000);
  await page.screenshot({ path: 'fishing-toggles.png' });

  await browser.close();
  console.log('Done.');
})();
