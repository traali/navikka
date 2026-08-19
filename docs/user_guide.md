# Sakkoja – Skipper's User Guide 🚤🇫🇮

Welcome to **Sakkoja**, an intelligent marine safety navigator designed for Finnish waters and the Baltic Sea.

---

## 🚀 1. Quick Start (Web & Mobile PWA)

Sakkoja runs directly in modern web browsers with **100% offline capability**:

- **Live Web App**: [https://sakkoja.pages.dev](https://sakkoja.pages.dev)
- **Install as PWA (Home Screen App)**:
  - **iOS (Safari)**: Tap the Share button $\to$ tap **"Add to Home Screen"** (*Lisää Koti-valikkoon*).
  - **Android (Chrome)**: Tap the three dots menu $\to$ tap **"Install app"** or **"Add to Home screen"**.

Once installed, the app caches map tiles, weather data, and workshop manuals for full offline navigation at sea.

---

## 🗺️ 2. Chart Navigation & Cockpit HUD

### Map Controls & Modes
- **Standard Navigation**: OpenStreetMap vector charts with official speed limit zones, fairway markers, and depth contours.
- **Fishing Mode** (Fish icon on map): Switches to official Traficom nautical raster charts and overlays regional fishing restriction polygons.
- **Zoom & Follow**: Tap the GPS target button to lock camera centering onto your vessel's current position.
- **Rough Sea / Glove Mode (64px)**: Enables oversized 64x64dp touch targets for wet hands and heavy boat vibrations.

### Collision-Free HUD Layouts (Configurable in Menu)
1. **Classic HUD**: Traditional card dashboard showing speed, course, and active speed limit warnings.
2. **Ghost HUD**: Frameless floating minimal HUD maximizing chart visibility.
3. **Omni HUD**: Comprehensive sensory sidebar.
4. **Vortex UI**: Circular radar-like instrument dials.
5. **Horizon 3D**: 3D perspective cockpit with pitch & roll attitude indicators.

---

## 🎨 3. Boating Themes ("Ulkoasu")

Select themes in **Valikko (Menu Screen)** according to lighting conditions:
- **Night Captain (Default)**: Pure OLED black (`#000000`) with cyan neon contours to preserve night vision.
- **Solar Flare**: High-contrast amber/yellow designed for direct sunlight legibility.
- **Deep Sea Navy**: Metallic nautical navy styling for yacht bridges.
- **Boreal Aurora (Revontulet)**: Dark slate canvas with emerald aurora accents.
- **Red Watch**: Low-luminance red OLED mode compliant with **IMO/IEC 62288** bridge standards.

---

## 🤖 4. Modular Marine AI Suite

Every AI module can be toggled on/off independently in **Valikko**:

| Feature | How to Use | What it Does |
| :--- | :--- | :--- |
| **Sää- ja Tilannekuva AI** | Tap weather card in Weather Screen | Chrome Built-in AI / local reasoner delivers instant weather risk assessments without server lag. |
| **Reitti- ja Sääreititys AI** | Plan a route in Route Planner | Checks under-keel clearance, wave-sheltered fairway segments, and open sea safety indices. |
| **Monimalliennuste AI** | Visible in Weather Screen | Compares FMI, MET Norway, and OpenWeather forecasts, flagging significant wind/gust discrepancies ($\ge 3.5\text{ m/s}$). |
| **Aallokon Iskut & Kiihtyvyysanturi AI** | Floating HUD capsule on map | Uses phone/tablet IMU sensors to measure dynamic $G$-forces ($1.0\text{--}5.0\text{g}$), slam rate (hits/min), wave attack angle (Head/Beam seas), and outlier rogue waves. |
| **Tekninen Moottoriopas** | Menu $\to$ *Avaa Moottoriopas* (`/technical-copilot`) | Workshop guides and common fault diagnostic steps for Volvo Penta, Yanmar, Yamaha, Mercury, Torqeedo, Honda + custom manual notes. |
| **Käsivapaa Puheavustaja** | Tap the floating Mic FAB on map | Speak nautical commands in Finnish or English (e.g. *"Mikä on väyläsyvyys?"*, *"Etsi suojaisa satama"*, *"Merkitse reittipiste"*, *"Sääennuste"*). |
| **Älykäs Matkaloki** | Menu $\to$ *Automaattinen Matkaloki* | Generates voyage summaries with nautical miles, average speed, wind exposure, and fuel consumption calculation. |
| **Akustinen Sireenivahti** | Automatic background listening | Decodes foghorns according to COLREG Rules 35/34 and warns of acoustic engine belt slip or impeller failure. |

---

## ⚓ 5. Vessel Profiles & Clearance Warnings

Configure your boat in **Valikko $\to$ Aluksen Profiili**:
- **HIN / WIN / Runkonumero**: Official hull identification code.
- **Moottorimerkki & malli**: Auto-populates oil type, coolant capacity, and impeller part numbers.
- **Syväys (Draft) & Ilmakorkeus (Air Draft)**: The route planner automatically alerts if bridges or shallow fairways violate your safety margins.
- **Polttoainetyyppi**: Calculates estimated fuel burn rate per nautical mile.

---

## 🆘 6. Safety & Emergency Distress

- **Emergency Mayday / MRCC Modal**: Quick-action emergency button displays your exact WGS84 coordinates, MMSI, and one-tap emergency call to the Finnish Coast Guard (**MRCC Turku: 0294 1000** or **112**).
- **COLREGS Right-of-Way Helper**: Quick reference card for powerboat, sailing, and overtaking crossing rules.
