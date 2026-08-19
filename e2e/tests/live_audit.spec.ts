import { test, expect } from '@playwright/test';

test.describe('Live Browser Audit for Sakkoja', () => {
  test('should navigate routes and capture logs', async ({ page }) => {
    const errors: string[] = [];
    const consoleLogs: string[] = [];
    const networkLatencies: { url: string; durationMs: number }[] = [];

    page.on('console', msg => {
      consoleLogs.push(`[${msg.type()}] ${msg.text()}`);
    });
    
    page.on('pageerror', exception => {
      errors.push(exception.message);
    });

    page.on('requestfinished', request => {
      const timing = request.timing();
      if (timing && timing.responseEnd) {
        networkLatencies.push({
          url: request.url(),
          durationMs: timing.responseEnd - timing.requestStart
        });
      }
    });

    page.on('requestfailed', request => {
      errors.push(`FAILED: ${request.url()} - ${request.failure()?.errorText}`);
    });

    const routes = ['/', '/#/fishing', '/#/weather', '/#/menu', '/#/route-planner'];

    for (const route of routes) {
      console.log(`Navigating to ${route}...`);
      await page.goto(route, { waitUntil: 'load' });
      await page.waitForTimeout(3000); // Give Flutter some time to render and fetch data
    }

    console.log('\n=== AUDIT RESULTS ===\n');
    
    console.log(`\n--- Console Logs (${consoleLogs.length}) ---`);
    consoleLogs.forEach(log => console.log(log));
    
    console.log(`\n--- Uncaught Exceptions / Errors (${errors.length}) ---`);
    errors.forEach(err => console.log(err));

    console.log(`\n--- Network Requests (${networkLatencies.length}) ---`);
    // Output a few slowest requests
    const slowest = networkLatencies.sort((a, b) => b.durationMs - a.durationMs).slice(0, 10);
    console.log('Top 10 Slowest Requests:');
    slowest.forEach(req => console.log(`${req.durationMs.toFixed(2)}ms - ${req.url}`));

  });
});
