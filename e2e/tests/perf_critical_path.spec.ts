import { test, expect } from '@playwright/test';
import * as fs from 'fs';
import * as path from 'path';

test.describe('Sakkoja Critical Path & CDP Performance Suite', () => {
  test('verify HTML headers, Flutter view boot, and CDP performance metrics', async ({
    page,
    context,
    baseURL,
  }) => {
    const targetUrl = baseURL || 'https://sakkoja.pages.dev';
    console.log(`[E2E Perf] Testing target URL: ${targetUrl}`);

    // 1. Verify live HTML response contains NO forced skwasm override
    const response = await page.goto(targetUrl, { waitUntil: 'domcontentloaded' });
    expect(response).not.toBeNull();
    
    const htmlContent = await page.content();
    expect(htmlContent).not.toContain("window.flutterWebRenderer = 'skwasm'");
    console.log('✓ Pass 0.1: HTML does not force skwasm renderer');

    // 2. Verify response headers do NOT contain restrictive COEP require-corp
    const headers = response?.headers() || {};
    const coepHeader = headers['cross-origin-embedder-policy'];
    expect(coepHeader).not.toBe('require-corp');
    console.log('✓ Pass 0.2: Headers do not enforce COEP require-corp');

    // 3. Connect CDP Session for Chrome Performance Metrics
    let cdpSession;
    try {
      cdpSession = await context.newCDPSession(page);
      await cdpSession.send('Performance.enable');
      console.log('✓ Pass: CDP Performance enabled');
    } catch (e) {
      console.log('⚠️ CDP Session unavailable in non-Chromium context:', e);
    }

    // 4. Wait for Flutter view initialization
    const flutterView = page.locator('flutter-view');
    await expect(flutterView).toBeVisible({ timeout: 15000 });
    console.log('✓ Pass 2.1: Flutter view rendered within 15s');

    // 5. Allow map canvas to stabilize and simulate panning over Helsinki
    await page.waitForTimeout(3000);
    const boundingBox = await flutterView.boundingBox();
    if (boundingBox) {
      const centerX = boundingBox.x + boundingBox.width / 2;
      const centerY = boundingBox.y + boundingBox.height / 2;

      // Simulate smooth map drag pan
      await page.mouse.move(centerX, centerY);
      await page.mouse.down();
      await page.mouse.move(centerX - 150, centerY - 100, { steps: 10 });
      await page.mouse.up();
    }
    await page.waitForTimeout(2000);

    // 6. Capture E2E proof screenshot
    const screenshotPath = path.join(__dirname, '../test-results/perf_critical_path.png');
    await page.screenshot({ path: screenshotPath });
    console.log(`✓ Pass: Screenshot captured at ${screenshotPath}`);

    // 7. Export CDP Performance Metrics to JSON
    if (cdpSession) {
      const metricsResponse = await cdpSession.send('Performance.getMetrics');
      const metricsMap: Record<String, number> = {};
      for (const m of metricsResponse.metrics) {
        metricsMap[m.name] = m.value;
      }

      const perfReport = {
        timestamp: new Date().toISOString(),
        targetUrl,
        metrics: {
          JSHeapUsedSizeMB: Math.round(((metricsMap['JSHeapUsedSize'] || 0) / (1024 * 1024)) * 100) / 100,
          JSHeapTotalSizeMB: Math.round(((metricsMap['JSHeapTotalSize'] || 0) / (1024 * 1024)) * 100) / 100,
          TaskDurationSec: Math.round((metricsMap['TaskDuration'] || 0) * 100) / 100,
          ScriptDurationSec: Math.round((metricsMap['ScriptDuration'] || 0) * 100) / 100,
          LayoutDurationSec: Math.round((metricsMap['LayoutDuration'] || 0) * 100) / 100,
          RecalcStyleDurationSec: Math.round((metricsMap['RecalcStyleDuration'] || 0) * 100) / 100,
        },
        passCriteria: {
          noSkwasmHtml: !htmlContent.includes("window.flutterWebRenderer = 'skwasm'"),
          noCoepRequireCorp: coepHeader !== 'require-corp',
          flutterViewBootUnder15s: true,
        },
      };

      const reportPath = path.join(__dirname, '../perf_report.json');
      fs.writeFileSync(reportPath, JSON.stringify(perfReport, null, 2));
      console.log(`✓ Pass: CDP Performance Report written to ${reportPath}`);
      console.log('Metrics Summary:', JSON.stringify(perfReport.metrics, null, 2));
    }
  });
});
