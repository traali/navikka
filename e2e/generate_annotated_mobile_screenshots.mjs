import { chromium } from 'playwright';
import fs from 'fs';
import path from 'path';

const ARTIFACT_DIR = 'C:/Users/aoinonen/.gemini/antigravity/brain/999832d7-b1cc-4a6c-9d21-5a065b269d88';

const mobileAnnotations = [
  {
    input: 'mobile_01_main_map.png',
    output: 'mobile_01_annotated.png',
    title: 'MOBIILI PÄÄNÄKYMÄ — KÄYTETTÄVYYSANALYYSI',
    items: [
      {
        x: 10,
        y: 630,
        w: 125,
        h: 60,
        label: '⚠️ PÄÄLLEKKÄISYYS: Nopeus & Aaltoanturi',
        desc: '1.0g 0/min -anturipilleri peittää alleen 0.0 km/h nopeuslukeman tekstin.',
        color: '#ef4444',
        anchor: 'top',
      },
      {
        x: 320,
        y: 65,
        w: 65,
        h: 600,
        label: '⚠️ TILANKÄYTTÖ: Oikea pystydokki',
        desc: '7 painiketta vievät ~70% näytön korkeudesta peittäen rannikkoväyliä puhelimessa.',
        color: '#f59e0b',
        anchor: 'left',
      },
      {
        x: 270,
        y: 660,
        w: 110,
        h: 65,
        label: '⚠️ PÄÄLLEKKÄISYYS: Kompassi & Mikrofoni',
        desc: '000° suuntalukema ja ääniohjauksen mikrofonipainike osuvat liian lähelle toisiaan.',
        color: '#ef4444',
        anchor: 'top',
      },
      {
        x: 10,
        y: 775,
        w: 373,
        h: 60,
        label: '✓ ERINOMAINEN: Alanavigaatiopalkki',
        desc: 'Korkeus ja kosketusalueet optimaaliset peukalokäyttöön.',
        color: '#10b981',
        anchor: 'top',
      },
    ],
  },
  {
    input: 'mobile_02_weather_ai.png',
    output: 'mobile_02_annotated.png',
    title: 'MOBIILI SÄÄ & SKIPPER — KÄYTETTÄVYYSANALYYSI',
    items: [
      {
        x: 20,
        y: 120,
        w: 353,
        h: 240,
        label: '✓ ERINOMAINEN: Skipper AI Bento -kortti',
        desc: 'Teksti rivittyy luontevasti ja mahtuu yhdellä silmäyksellä näytölle.',
        color: '#10b981',
        anchor: 'bottom',
      },
      {
        x: 20,
        y: 380,
        w: 353,
        h: 260,
        label: '✓ SELKEÄ: FMI-synkronointikortti',
        desc: 'Kosketusalue Päivitä nyt -painikkeelle on sormiystävällinen.',
        color: '#00e5ff',
        anchor: 'bottom',
      },
    ],
  },
  {
    input: 'mobile_03_satellite_sentinel2.png',
    output: 'mobile_03_annotated.png',
    title: 'MOBIILI SATELLIITTI SENTINEL-2 — KÄYTETTÄVYYSANALYYSI',
    items: [
      {
        x: 15,
        y: 15,
        w: 363,
        h: 48,
        label: '⚠️ YLIVUOTO: Moodivalitsinpillerit',
        desc: 'HD Satelliitti -pilleri leikkautuu oikeasta reunasta kapeilla puhelimilla.',
        color: '#ef4444',
        anchor: 'bottom',
      },
      {
        x: 20,
        y: 65,
        w: 353,
        h: 30,
        label: '⚠️ TÖRMÄYS: Resoluutioteksti & Lähde',
        desc: '10m/px ja ESA Copernicus -tekstit osuvat päällekkäin ilman rivitystä.',
        color: '#ef4444',
        anchor: 'bottom',
      },
      {
        x: 15,
        y: 670,
        w: 363,
        h: 105,
        label: '⚠️ YLIVUOTO: Esiasetteiden rivi',
        desc: 'Pilvetön mosaiikki -painike leikkautuu oikeasta laidasta.',
        color: '#f59e0b',
        anchor: 'top',
      },
    ],
  },
  {
    input: 'mobile_04_satellite_eumetsat.png',
    output: 'mobile_04_annotated.png',
    title: 'MOBIILI EUMETSAT LIVE SÄÄ — KÄYTETTÄVYYSANALYYSI',
    items: [
      {
        x: 15,
        y: 65,
        w: 363,
        h: 30,
        label: '⚠️ TÖRMÄYS: Aikaleima ja Lähdeteksti',
        desc: '(15 min sykli) ja FMI / EUMETSAT -tekstit törmäävät toisiinsa.',
        color: '#ef4444',
        anchor: 'bottom',
      },
      {
        x: 15,
        y: 660,
        w: 363,
        h: 115,
        label: '✓ HYVÄ: Aikajanaliukuri & Toistopainike',
        desc: 'Aikajana mahtuu ja kellonaikaleima 08:15 pysyy selkeästi näkyvissä.',
        color: '#10b981',
        anchor: 'top',
      },
    ],
  },
  {
    input: 'mobile_06_fishing_mode.png',
    output: 'mobile_06_annotated.png',
    title: 'MOBIILI KALASTUSMOODI — KÄYTETTÄVYYSANALYYSI',
    items: [
      {
        x: 20,
        y: 80,
        w: 353,
        h: 90,
        label: '✓ ERINOMAINEN: Kytkinkortti',
        desc: 'Kytkin mahtuu puhelimen leveyteen ja on helposti peukalolla käytettävissä.',
        color: '#10b981',
        anchor: 'bottom',
      },
      {
        x: 20,
        y: 200,
        w: 353,
        h: 60,
        label: '✓ ERINOMAINEN: Kirjaa saalis -toiminto',
        desc: 'Täysleveä CTA-painike isolla kosketuspinnalla.',
        color: '#00e5ff',
        anchor: 'bottom',
      },
    ],
  },
  {
    input: 'mobile_07_menu_settings.png',
    output: 'mobile_07_annotated.png',
    title: 'MOBIILI VALIKKO — KÄYTETTÄVYYSANALYYSI',
    items: [
      {
        x: 20,
        y: 100,
        w: 353,
        h: 550,
        label: '✓ ERINOMAINEN: Karttatasojen lista',
        desc: 'Tekstit, selitteet ja kytkimet asettuvat täydellisesti ilman leikkautumista.',
        color: '#10b981',
        anchor: 'bottom',
      },
    ],
  },
];

async function generateMobileAnnotations() {
  console.log('🎨 Generating annotated Mobile QA screenshots with visual markers...');
  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage({ viewport: { width: 393, height: 852 } });

  for (const ann of mobileAnnotations) {
    const imgPath = path.join(ARTIFACT_DIR, ann.input);
    const outPath = path.join(ARTIFACT_DIR, ann.output);
    if (!fs.existsSync(imgPath)) {
      console.warn(`⚠️ Source image not found: ${imgPath}`);
      continue;
    }

    const imgBase64 = fs.readFileSync(imgPath).toString('base64');
    const dataUri = `data:image/png;base64,${imgBase64}`;

    let svgOverlays = '';
    let calloutCards = '';

    ann.items.forEach((item, idx) => {
      // SVG Bounding Box
      svgOverlays += `
        <rect x="${item.x}" y="${item.y}" width="${item.w}" height="${item.h}" 
              rx="6" ry="6" 
              fill="${item.color}22" 
              stroke="${item.color}" 
              stroke-width="2.5" 
              stroke-dasharray="5,3" />
        <circle cx="${item.x}" cy="${item.y}" r="4.5" fill="${item.color}" />
        <circle cx="${item.x + item.w}" cy="${item.y}" r="4.5" fill="${item.color}" />
        <circle cx="${item.x}" cy="${item.y + item.h}" r="4.5" fill="${item.color}" />
        <circle cx="${item.x + item.w}" cy="${item.y + item.h}" r="4.5" fill="${item.color}" />
      `;

      let cardX = Math.max(10, Math.min(200, item.x));
      let cardY = item.y - 60;
      if (item.anchor === 'bottom') cardY = item.y + item.h + 8;
      if (item.anchor === 'top') cardY = Math.max(10, item.y - 65);
      if (item.anchor === 'left') {
        cardX = 10;
        cardY = item.y + 20;
      }

      calloutCards += `
        <div style="
          position: absolute;
          left: ${cardX}px;
          top: ${cardY}px;
          background: rgba(10, 15, 29, 0.95);
          border: 1.5px solid ${item.color};
          border-left: 4px solid ${item.color};
          border-radius: 6px;
          padding: 6px 10px;
          color: #ffffff;
          font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
          max-width: 280px;
          box-shadow: 0 6px 20px rgba(0,0,0,0.85);
          backdrop-filter: blur(8px);
          z-index: 100;
          pointer-events: none;
        ">
          <div style="font-weight: 700; font-size: 11px; color: ${item.color}; margin-bottom: 2px;">
            ${item.label}
          </div>
          <div style="font-size: 10px; color: #cbd5e1; line-height: 1.3;">
            ${item.desc}
          </div>
        </div>
      `;
    });

    const htmlContent = `
      <!DOCTYPE html>
      <html>
      <head>
        <style>
          * { box-sizing: border-box; margin: 0; padding: 0; }
          body { width: 393px; height: 852px; overflow: hidden; background: #000; position: relative; }
          .base-img { width: 393px; height: 852px; display: block; }
          .header-banner {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            background: linear-gradient(180deg, rgba(0,0,0,0.9) 0%, rgba(0,0,0,0.4) 80%, transparent 100%);
            padding: 6px 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            z-index: 999;
          }
          .title-tag {
            font-size: 10.5px;
            font-weight: 800;
            letter-spacing: 0.8px;
            color: #00e5ff;
            text-transform: uppercase;
          }
          .status-badge {
            background: #3b82f6;
            color: #ffffff;
            font-size: 9px;
            font-weight: 700;
            padding: 2px 7px;
            border-radius: 999px;
          }
        </style>
      </head>
      <body>
        <img class="base-img" src="${dataUri}" />
        <div class="header-banner">
          <div class="title-tag">📱 MOBIILIANALYYSI: ${ann.title}</div>
          <div class="status-badge">KÄYTETTÄVYYS</div>
        </div>
        <svg style="position: absolute; top: 0; left: 0; width: 393px; height: 852px; pointer-events: none; z-index: 50;">
          ${svgOverlays}
        </svg>
        ${calloutCards}
      </body>
      </html>
    `;

    await page.setContent(htmlContent);
    await page.waitForTimeout(300);
    await page.screenshot({ path: outPath });
    console.log(`✅ Generated annotated mobile screenshot: ${ann.output}`);
  }

  await browser.close();
  console.log('🎉 All mobile annotated screenshots generated successfully!');
}

generateMobileAnnotations();
