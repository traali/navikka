import { test, expect } from '@playwright/test';

const ROUTES = [
  '/',
  '/#/fishing',
  '/#/weather',
  '/#/menu',
  '/#/route-planner',
  '/#/skipper-settings',
  '/#/offline-regions',
  '/#/routes',
  '/#/vessel-settings',
  '/#/insight-history',
];

const VIEWPORTS = [
  { name: 'Mobile', width: 390, height: 844 },
  { name: 'Tablet', width: 768, height: 1024 },
  { name: 'Desktop', width: 1440, height: 900 },
];

test.describe('Sakkoja UI Shell Navigation and Responsive Audit', () => {
  for (const vp of VIEWPORTS) {
    test.describe(`Viewport: ${vp.name}`, () => {
      test.use({ viewport: { width: vp.width, height: vp.height } });

      for (const route of ROUTES) {
        test(`Deep-link navigation to ${route}`, async ({ page }) => {
          const logs: string[] = [];
          page.on('console', msg => logs.push(`[${msg.type()}] ${msg.text()}`));
          
          const response = await page.goto(route, { waitUntil: 'domcontentloaded' });
          expect(response?.status()).toBeLessThan(400);

          // Wait a bit to see if Flutter loads successfully and any errors are logged
          await page.waitForTimeout(3000);

          // If flutter app is rendering, there should be a canvas or flutter-view element
          const flutterView = await page.$('flutter-view');
          if (flutterView) {
            console.log(`${route} at ${vp.name}: Loaded Flutter view successfully`);
          } else {
            console.log(`${route} at ${vp.name}: Flutter view not found`);
          }

          if (logs.length > 0) {
            console.log(`Logs for ${route} at ${vp.name}:\n`, logs.join('\n'));
          }
        });
      }
    });
  }
});
