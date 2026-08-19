import { chromium } from '@playwright/test';

(async () => {
  console.log('🚀 Launching Chromium browser to test https://sakkoja.pages.dev ...');
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext();
  const page = await context.newPage();

  const consoleErrors = [];
  const consoleWarnings = [];
  const failedRequests = [];
  const successfulRequests = [];

  // Listen to browser console messages
  page.on('console', (msg) => {
    const type = msg.type();
    const text = msg.text();
    if (type === 'error' || text.includes('⛔') || text.includes('Error:') || text.includes('CORS')) {
      consoleErrors.push(`[${type.toUpperCase()}] ${text}`);
    } else if (type === 'warning' || text.includes('⚠️')) {
      consoleWarnings.push(`[WARN] ${text}`);
    }
  });

  // Listen to page errors / unhandled exceptions
  page.on('pageerror', (err) => {
    consoleErrors.push(`[UNHANDLED EXCEPTION] ${err.message}\n${err.stack}`);
  });

  // Listen to network requests & responses
  page.on('response', (response) => {
    const url = response.url();
    const status = response.status();
    if (status >= 400) {
      failedRequests.push(`[${status}] ${url}`);
    } else {
      successfulRequests.push(`[${status}] ${url}`);
    }
  });

  page.on('requestfailed', (request) => {
    const url = request.url();
    const failure = request.failure();
    failedRequests.push(`[FAILED] ${url} - Failure: ${failure ? failure.errorText : 'Unknown'}`);
  });

  console.log('🌐 Navigating to https://sakkoja.pages.dev ...');
  await page.goto('https://sakkoja.pages.dev', { waitUntil: 'domcontentloaded', timeout: 30000 });

  // Wait 8 seconds for Flutter web app initialization and initial data sync
  console.log('⏳ Waiting 8s for app initialization & network sync...');
  await page.waitForTimeout(8000);

  // Take screenshot of live app
  await page.screenshot({ path: 'e2e/live_verification_screenshot.png' });

  console.log('\n--- NETWORK REQUEST SUMMARY ---');
  console.log(`Total successful requests (200-399): ${successfulRequests.length}`);
  console.log(`Total failed requests (400+ or blocked): ${failedRequests.length}`);
  if (failedRequests.length > 0) {
    console.log('\n🔴 Failed Network Requests:');
    failedRequests.forEach((req) => console.log('  ' + req));
  } else {
    console.log('✅ ALL network requests succeeded (0 HTTP 4xx/5xx or CORS blocks)!');
  }

  console.log('\n--- BROWSER CONSOLE LOG SUMMARY ---');
  console.log(`Console Errors/Exceptions: ${consoleErrors.length}`);
  console.log(`Console Warnings: ${consoleWarnings.length}`);

  if (consoleErrors.length > 0) {
    console.log('\n🔴 Console Errors:');
    consoleErrors.forEach((err) => console.log('  ' + err));
  } else {
    console.log('✅ ZERO console errors detected!');
  }

  await browser.close();
  console.log('\n🏁 E2E Console & Network Verification Finished.');
  process.exit(consoleErrors.length > 0 ? 1 : 0);
})();
