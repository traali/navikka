import { chromium } from 'playwright';
import fs from 'fs';

(async () => {
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext();
  const page = await context.newPage();

  // We will intercept network requests to measure asset sizes
  const assetSizes = {};
  page.on('response', async (response) => {
    const url = response.url();
    if (url.includes('sakkoja.pages.dev')) {
      try {
        const buffer = await response.body();
        assetSizes[url] = buffer.length;
      } catch (e) {
        // body might not be available
      }
    }
  });

  const client = await page.context().newCDPSession(page);
  await client.send('Performance.enable');

  await page.goto('https://sakkoja.pages.dev', { waitUntil: 'networkidle' });

  // Wait a bit for flutter map to render
  await page.waitForTimeout(5000);

  // Get JS Heap memory usage
  const metrics = await client.send('Performance.getMetrics');
  const jsHeapUsedSize = metrics.metrics.find(m => m.name === 'JSHeapUsedSize').value;
  const jsHeapTotalSize = metrics.metrics.find(m => m.name === 'JSHeapTotalSize').value;

  // Get Web Vitals (FCP, LCP, CLS)
  const webVitals = await page.evaluate(() => {
    return new Promise((resolve) => {
      let lcp = 0, fcp = 0, cls = 0;
      
      const observer = new PerformanceObserver((list) => {
        for (const entry of list.getEntries()) {
          if (entry.entryType === 'largest-contentful-paint') lcp = entry.renderTime || entry.loadTime;
          if (entry.entryType === 'paint' && entry.name === 'first-contentful-paint') fcp = entry.startTime;
          if (entry.entryType === 'layout-shift' && !entry.hadRecentInput) cls += entry.value;
        }
      });
      observer.observe({ type: 'largest-contentful-paint', buffered: true });
      observer.observe({ type: 'paint', buffered: true });
      observer.observe({ type: 'layout-shift', buffered: true });

      setTimeout(() => {
        resolve({ fcp, lcp, cls });
      }, 2000);
    });
  });

  console.log(JSON.stringify({
    assetSizes,
    memory: {
      jsHeapUsedSize,
      jsHeapTotalSize
    },
    webVitals
  }, null, 2));

  await browser.close();
})();
