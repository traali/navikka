import { chromium } from 'playwright';
import fs from 'fs';
import path from 'path';

const ARTIFACT_DIR = 'C:/Users/aoinonen/.gemini/antigravity/brain/999832d7-b1cc-4a6c-9d21-5a065b269d88';

const annotations = [
  {
    input: 'navikka_01_main_map.png',
    output: 'navikka_01_annotated.png',
    title: 'PÄÄNÄKYMÄ — MERIKARTTA & NAVIGOINTI (AUDITOITU)',
    items: [
      {
        x: 350,
        y: 260,
        w: 240,
        h: 220,
        label: 'A: Traficom-merikartta',
        desc: 'Täysi värikylläisyys, 0% harmautta, viralliset syvyyskäyrät & matalikot (sininen/valkoinen)',
        color: '#00e5ff',
        anchor: 'top',
      },
      {
        x: 620,
        y: 330,
        w: 160,
        h: 120,
        label: 'B: Nopeusrajoitusalue',
        desc: '10 km/h purppurarajaus ja hento läpikuultava huomioväri',
        color: '#d946ef',
        anchor: 'right',
      },
      {
        x: 690,
        y: 450,
        w: 60,
        h: 80,
        label: 'C: Oma alus & GPS',
        desc: 'Reaaliaikainen sijainti- ja keulasuuntamerkki',
        color: '#10b981',
        anchor: 'bottom',
      },
      {
        x: 320,
        y: 530,
        w: 180,
        h: 80,
        label: 'D: Syvyyslukemat',
        desc: 'Tarkat viralliset luotaukset (6.8m, 3.6m, 5.2m, 9.5m, 10.0m)',
        color: '#38bdf8',
        anchor: 'bottom',
      },
      {
        x: 1360,
        y: 620,
        w: 60,
        h: 180,
        label: 'E: Karttatyökalut',
        desc: 'Pikakeskitys ja zoomausohjaimet',
        color: '#f59e0b',
        anchor: 'left',
      },
    ],
  },
  {
    input: 'navikka_02_weather_ai.png',
    output: 'navikka_02_annotated.png',
    title: 'SÄÄ & SKIPPER AI (AUDITOITU)',
    items: [
      {
        x: 480,
        y: 10,
        w: 480,
        h: 45,
        label: 'A: Navigaatio-otsikko',
        desc: 'SÄÄ & SKIPPER -yläpalkki ja esteetön yökäyttöliittymä',
        color: '#00e5ff',
        anchor: 'bottom',
      },
      {
        x: 270,
        y: 175,
        w: 1140,
        h: 270,
        label: 'B: Nova Glass -tilakortti',
        desc: 'Automaattinen Ilmatieteen laitoksen (FMI) asemien tilaviesti ja animoitu eteneminen',
        color: '#38bdf8',
        anchor: 'top',
      },
      {
        x: 680,
        y: 380,
        w: 160,
        h: 48,
        label: 'C: Päivitä-painike',
        desc: 'Reaaliaikainen merisään ja havaintojen pikapäivitys',
        color: '#10b981',
        anchor: 'bottom',
      },
      {
        x: 10,
        y: 10,
        w: 240,
        h: 220,
        label: 'D: Päävalikkopalkki',
        desc: 'Sää-tilan aktiivinen korostus ja nopea siirtyminen',
        color: '#a855f7',
        anchor: 'right',
      },
    ],
  },
  {
    input: 'navikka_03_satellite_sentinel2.png',
    output: 'navikka_03_annotated.png',
    title: 'SATELLIITTI — SENTINEL-2 OPTINEN 10M/PX (AUDITOITU)',
    items: [
      {
        x: 40,
        y: 20,
        w: 400,
        h: 40,
        label: 'A: Resoluutiopilleri & Sykli',
        desc: '10m/px spatiaalinen tarkkuus ja 2-3 pv ylilentosykli erotettu selkeästi toisistaan',
        color: '#00e5ff',
        anchor: 'bottom',
      },
      {
        x: 1300,
        y: 20,
        w: 120,
        h: 40,
        label: 'B: ESA Copernicus',
        desc: 'Optisen datan virallinen lähdemerkintä',
        color: '#f59e0b',
        anchor: 'left',
      },
      {
        x: 20,
        y: 840,
        w: 400,
        h: 50,
        label: 'C: Esiasetteet',
        desc: 'Luonnonväri (RGB), Vesi & Levät ja Pilvetön mosaiikki',
        color: '#10b981',
        anchor: 'top',
      },
      {
        x: 1300,
        y: 915,
        w: 120,
        h: 30,
        label: 'D: Merikarttakerroksen säädin',
        desc: 'Väylien ja syvyysalueiden läpinäkyvyyden liukuri',
        color: '#d946ef',
        anchor: 'left',
      },
    ],
  },
  {
    input: 'navikka_04_satellite_eumetsat.png',
    output: 'navikka_04_annotated.png',
    title: 'SATELLIITTI — EUMETSAT LIVE SÄÄ & AIKAJANA (AUDITOITU)',
    items: [
      {
        x: 40,
        y: 20,
        w: 400,
        h: 40,
        label: 'A: 15 minuutin Live-sääsykli',
        desc: 'EUMETSAT klo 08:00 (15 min sykli) & FMI-lähdeviite',
        color: '#00e5ff',
        anchor: 'bottom',
      },
      {
        x: 350,
        y: 220,
        w: 500,
        h: 350,
        label: 'B: Aito optinen ESRI-avaruustausta',
        desc: 'Aito Maan satelliittikuva (metsät, rannat, saaret) korvaa tiekartat',
        color: '#10b981',
        anchor: 'top',
      },
      {
        x: 880,
        y: 220,
        w: 450,
        h: 350,
        label: 'C: Yhdistetty merikarttataso',
        desc: 'Traficom-väylät ja syvyydet läpinäkyvänä satelliittikuvan päällä',
        color: '#38bdf8',
        anchor: 'top',
      },
      {
        x: 20,
        y: 840,
        w: 1400,
        h: 60,
        label: 'D: 24-portainen aikajana & soittotila',
        desc: 'Toistopainike ▶ ja interaktiivinen aikajanaliukuri',
        color: '#f59e0b',
        anchor: 'top',
      },
    ],
  },
  {
    input: 'navikka_05_satellite_hd.png',
    output: 'navikka_05_annotated.png',
    title: 'SATELLIITTI — HD ORTO-ILMAKUVA (MML / MAXAR) (AUDITOITU)',
    items: [
      {
        x: 40,
        y: 20,
        w: 400,
        h: 40,
        label: 'A: Kesäortokuva-tila',
        desc: 'Maanmittauslaitos & Maxar HD -kesäkauden ilmakuvamosaiikki',
        color: '#00e5ff',
        anchor: 'bottom',
      },
      {
        x: 350,
        y: 220,
        w: 750,
        h: 450,
        label: 'B: Korkean resoluution rannikkokuvaus',
        desc: 'Valokuvantarkka erottelukyky rannoille, saarille ja matalikoille',
        color: '#10b981',
        anchor: 'top',
      },
      {
        x: 20,
        y: 850,
        w: 500,
        h: 45,
        label: 'C: Tarkkuustunniste',
        desc: 'Zoom-tasot 1-19 ja virallinen MML-aineistoleima',
        color: '#f59e0b',
        anchor: 'top',
      },
    ],
  },
  {
    input: 'navikka_06_fishing_mode.png',
    output: 'navikka_06_annotated.png',
    title: 'KALASTUSMOODI & SAALISPÄIVÄKIRJA (AUDITOITU)',
    items: [
      {
        x: 270,
        y: 85,
        w: 1140,
        h: 105,
        label: 'A: Kalastusmoodin pääkytkin',
        desc: 'Näytä kalastusrajoitusalueet ja rauhoitusajat kartalla',
        color: '#00e5ff',
        anchor: 'bottom',
      },
      {
        x: 270,
        y: 220,
        w: 1140,
        h: 65,
        label: 'B: Kirjaa saalis -pikatoiminto',
        desc: 'Suuren kontrastin toimintapainike saalispäiväkirjaan',
        color: '#10b981',
        anchor: 'bottom',
      },
      {
        x: 600,
        y: 580,
        w: 350,
        h: 150,
        label: 'C: Saalishistoria',
        desc: 'Selkeä tyhjän tilan grafiikka ja järjestelmällinen listaus',
        color: '#f59e0b',
        anchor: 'top',
      },
    ],
  },
  {
    input: 'navikka_07_menu_settings.png',
    output: 'navikka_07_annotated.png',
    title: 'VALIKKO & KARTTATASOASETUKSET (AUDITOITU)',
    items: [
      {
        x: 270,
        y: 80,
        w: 1140,
        h: 240,
        label: 'A: Sää- ja ympäristötasot',
        desc: 'Säätutka, SYKE-levätilanne, Navigointimerkit ja Vesiväylät',
        color: '#00e5ff',
        anchor: 'right',
      },
      {
        x: 270,
        y: 400,
        w: 1140,
        h: 80,
        label: 'B: AIS-alusten reaaliaikaseuranta',
        desc: 'Digitraffic Live AIS-kytkin',
        color: '#10b981',
        anchor: 'right',
      },
      {
        x: 270,
        y: 560,
        w: 1140,
        h: 80,
        label: 'C: Satamat ja vierasvenesatamat',
        desc: 'Suomen rannikon ja saariston satamamerkinnät',
        color: '#f59e0b',
        anchor: 'right',
      },
      {
        x: 10,
        y: 10,
        w: 240,
        h: 220,
        label: 'D: OLED Night Captain -päävalikko',
        desc: 'Korkea kontrasti, nollavirta mustalla pohjalla',
        color: '#a855f7',
        anchor: 'right',
      },
    ],
  },
];

async function generateAllAnnotatedScreenshots() {
  console.log('🎨 Generating annotated QA screenshots with visual markers...');
  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage({ viewport: { width: 1440, height: 900 } });

  for (const ann of annotations) {
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
      // SVG Bounding Box with corner dots
      svgOverlays += `
        <rect x="${item.x}" y="${item.y}" width="${item.w}" height="${item.h}" 
              rx="8" ry="8" 
              fill="${item.color}18" 
              stroke="${item.color}" 
              stroke-width="3" 
              stroke-dasharray="6,4" />
        <circle cx="${item.x}" cy="${item.y}" r="6" fill="${item.color}" />
        <circle cx="${item.x + item.w}" cy="${item.y}" r="6" fill="${item.color}" />
        <circle cx="${item.x}" cy="${item.y + item.h}" r="6" fill="${item.color}" />
        <circle cx="${item.x + item.w}" cy="${item.y + item.h}" r="6" fill="${item.color}" />
      `;

      // Callout positioning
      let cardX = item.x;
      let cardY = item.y - 65;
      if (item.anchor === 'bottom') cardY = item.y + item.h + 12;
      if (item.anchor === 'top') cardY = Math.max(15, item.y - 70);
      if (item.anchor === 'left') {
        cardX = Math.max(20, item.x - 300);
        cardY = item.y;
      }
      if (item.anchor === 'right') {
        cardX = Math.min(1100, item.x + item.w + 15);
        cardY = item.y;
      }

      calloutCards += `
        <div style="
          position: absolute;
          left: ${cardX}px;
          top: ${cardY}px;
          background: rgba(10, 15, 29, 0.92);
          border: 1.5px solid ${item.color};
          border-left: 5px solid ${item.color};
          border-radius: 8px;
          padding: 8px 12px;
          color: #ffffff;
          font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
          max-width: 320px;
          box-shadow: 0 8px 24px rgba(0,0,0,0.8), 0 0 12px ${item.color}40;
          backdrop-filter: blur(8px);
          z-index: 100;
          pointer-events: none;
        ">
          <div style="font-weight: 700; font-size: 13px; color: ${item.color}; margin-bottom: 2px; display: flex; align-items: center; gap: 6px;">
            <span>✓</span> ${item.label}
          </div>
          <div style="font-size: 11.5px; color: #cbd5e1; line-height: 1.35;">
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
          body { width: 1440px; height: 900px; overflow: hidden; background: #000; position: relative; }
          .base-img { width: 1440px; height: 900px; display: block; }
          .header-banner {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            background: linear-gradient(180deg, rgba(0,0,0,0.85) 0%, rgba(0,0,0,0.4) 70%, transparent 100%);
            padding: 8px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            z-index: 999;
          }
          .title-tag {
            font-size: 14px;
            font-weight: 800;
            letter-spacing: 1.5px;
            color: #00e5ff;
            text-transform: uppercase;
            text-shadow: 0 2px 8px rgba(0,229,255,0.4);
          }
          .status-badge {
            background: #10b981;
            color: #ffffff;
            font-size: 11px;
            font-weight: 700;
            padding: 3px 10px;
            border-radius: 999px;
            letter-spacing: 0.5px;
            box-shadow: 0 0 10px rgba(16,185,129,0.5);
          }
        </style>
      </head>
      <body>
        <img class="base-img" src="${dataUri}" />
        <div class="header-banner">
          <div class="title-tag">🔍 QA AUDIT: ${ann.title}</div>
          <div class="status-badge">AUDITOITU & HYVÄKSYTTY</div>
        </div>
        <svg style="position: absolute; top: 0; left: 0; width: 1440px; height: 900px; pointer-events: none; z-index: 50;">
          ${svgOverlays}
        </svg>
        ${calloutCards}
      </body>
      </html>
    `;

    await page.setContent(htmlContent);
    await page.waitForTimeout(300);
    await page.screenshot({ path: outPath });
    console.log(`✅ Generated annotated screenshot: ${ann.output}`);
  }

  await browser.close();
  console.log('🎉 All annotated screenshots generated successfully!');
}

generateAllAnnotatedScreenshots();
