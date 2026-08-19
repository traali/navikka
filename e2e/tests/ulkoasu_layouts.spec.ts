import { test, expect } from '@playwright/test';
import path from 'path';

const ARTIFACT_DIR = 'C:/Users/aoinonen/.gemini/antigravity/brain/89e3fa77-ae46-4d38-bb8d-899796a5f59c';

const LAYOUTS = [
  { id: 'ghost', name: 'Ghost (Minimalistinen)', filename: 'ulkoasu_ghost.png' },
  { id: 'classic', name: 'Classic (Lasi)', filename: 'ulkoasu_classic.png' },
  { id: 'commandBar', name: 'Command Bar (Yhtenäinen)', filename: 'ulkoasu_command_bar.png' },
  { id: 'horizon3D', name: 'Horizon 3D (Horisonttikapteeni)', filename: 'ulkoasu_horizon_3d.png' },
  { id: 'omni', name: 'Omni (Tehokäyttäjä)', filename: 'ulkoasu_omni.png' },
];

test.describe('Sakkoja Ulkoasu (Appearance & UI Layout) Verification', () => {
  test.setTimeout(60000);

  for (const layout of LAYOUTS) {
    test(`Verify layout: ${layout.name}`, async ({ page }) => {
      await page.addInitScript((layoutId) => {
        window.localStorage.setItem('flutter.ui_layout_style', layoutId);
        window.localStorage.setItem('ui_layout_style', layoutId);
      }, layout.id);

      const response = await page.goto('https://sakkoja.pages.dev', { waitUntil: 'domcontentloaded' });
      expect(response?.status()).toBeLessThan(400);

      // Wait 3.5s for map tiles and Flutter HUD widgets to render
      await page.waitForTimeout(3500);

      // Verify Flutter view element is present
      const flutterView = await page.$('flutter-view');
      const canvas = await page.$('canvas');
      expect(flutterView || canvas).not.toBeNull();

      // Capture screenshot for this layout
      const outputPath = path.join(ARTIFACT_DIR, layout.filename);
      await page.screenshot({ path: outputPath, fullPage: false });
      console.log(`Captured screenshot for ${layout.name} -> ${outputPath}`);
    });
  }
});
