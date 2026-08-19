import { test, expect } from '@playwright/test';

test.describe('Landing Page', () => {
  test('should load the map and essential UI elements', async ({ page }) => {
    const errors: string[] = [];

    page.on('console', msg => {
      if (msg.type() === 'error') {
        errors.push(msg.text());
        console.error(`[Browser Console Error]: ${msg.text()}`);
      }
    });
    page.on('pageerror', exception => {
      errors.push(exception.message);
      console.error(`[Browser Page Error]: ${exception}`);
    });
    page.on('requestfailed', request => {
      errors.push(`FAILED: ${request.url()} - ${request.failure()?.errorText}`);
    });

    await page.goto('/', { waitUntil: 'load' });
    await page.waitForTimeout(8000);

    console.log(`Collected ${errors.length} errors`);
    errors.forEach(e => console.log(`  - ${e}`));

    const html = await page.content();
    console.log(`Page has ${html.length} chars`);
    console.log(`Has flt-glass-pane: ${html.includes('flt-glass-pane')}`);
    console.log(`Has canvas: ${html.includes('<canvas')}`);

    await expect(page.locator('body')).toBeVisible();

    await expect(page).toHaveScreenshot('landing-page.png', {
      maxDiffPixelRatio: 0.1,
      fullPage: true,
    });
  });
});