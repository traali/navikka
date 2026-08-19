import { chromium } from 'playwright';

const browser = await chromium.launch({
  headless: true,
});

try {
  const page = await browser.newPage();

  page.on('console', msg => console.log('CONSOLE:', msg.type(), msg.text()));
  page.on('pageerror', err => console.log('PAGE_ERROR:', err.message));

  await page.goto('https://sakkoja.pages.dev/', { waitUntil: 'networkidle', timeout: 30000 });
  console.log('--- Page loaded ---');

  await page.waitForTimeout(5000);
  console.log('--- Waited 5s ---');

  const html = await page.content();
  console.log('HTML length:', html.length);
  console.log('flutter-view present:', html.includes('flutter-view'));

  const title = await page.title();
  console.log('title:', title);

  console.log('--- Done ---');
} finally {
  await browser.close();
}
