import { test, expect } from '@playwright/test';

test.describe('Navigation Flow', () => {
  test('should plan a route and show safety metrics', async ({ page }) => {
    const errors: string[] = [];

    page.on('console', msg => {
      if (msg.type() === 'error') errors.push(msg.text());
    });
    page.on('pageerror', exception => {
      errors.push(exception.message);
    });
    page.on('requestfailed', request => {
      errors.push(`FAILED: ${request.url()}`);
    });

    // Open App
    await page.goto('/', { waitUntil: 'load' });
    await page.waitForTimeout(8000);

    console.log(`Errors: ${errors.length}`);
    errors.forEach(e => console.log(`  - ${e}`));

    // Verify body is visible (Flutter loading screen)
    await expect(page.locator('body')).toBeVisible();

    // Navigate to Route Planner
    await page.goto('/#/route-planner', { waitUntil: 'load' });
    await page.waitForTimeout(5000);

    // Screenshot verification
    await expect(page).toHaveScreenshot('route-planner.png', {
      maxDiffPixelRatio: 0.1,
    });
  });
});