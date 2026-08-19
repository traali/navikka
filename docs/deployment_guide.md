# Sakkoja – Self-Hosting & Deployment Guide 🌐🚀

This guide explains how to clone **Sakkoja**, configure your own environment, deploy the web application, and host the optional CORS proxy worker.

---

## 1. Architecture Overview

A complete self-hosted Sakkoja deployment consists of two lightweight components:

1. **Frontend Web App (PWA)**: Pure client-side Flutter Web application compiled with SQLite WebAssembly (`sqlite3.wasm`), running entirely in the user's browser.
2. **CORS Proxy Worker (Cloudflare Worker)**: Serverless proxy that relays WFS/REST queries to Finnish maritime APIs (e.g. MMM fishing restrictions) that lack browser CORS headers.

---

## 2. Forking & Cloning the Repository

```bash
# 1. Clone your fork
git clone https://github.com/YOUR_USERNAME/sakkoja.git
cd sakkoja

# 2. Install Flutter dependencies
flutter pub get

# 3. Generate Riverpod providers and Drift tables
dart run build_runner build --delete-conflicting-outputs
```

---

## 3. Frontend Deployment Options

### Option A: Cloudflare Pages (Recommended – Free & Fast)

Cloudflare Pages provides global edge CDN distribution with zero server maintenance.

#### 1. Setup GitHub Actions CI/CD (Automated)
Sakkoja includes an automated workflow in `.github/workflows/deploy.yml`.

1. Go to your GitHub repository **Settings $\to$ Secrets and variables $\to$ Actions**.
2. Add the following repository secrets:
   - `CLOUDFLARE_API_TOKEN`: Cloudflare API token with *Cloudflare Pages: Edit* permissions.
   - `CLOUDFLARE_ACCOUNT_ID`: Your Cloudflare account ID (found in Cloudflare dashboard URL).
   - `OPENWEATHER_API_KEY`: *(Optional)* API key from OpenWeather for secondary marine validation.
3. Any push to `main` will build and deploy to your Cloudflare Pages project (`sakkoja`).

#### 2. Manual Local Build & Wrangler Deploy
If you prefer building locally:

```bash
# On Windows (PowerShell):
.\scripts\build_web.ps1

# On macOS / Linux (Bash):
./scripts/build_web.sh

# Deploy build/web directory to Cloudflare Pages
npx wrangler pages deploy build/web --project-name=your-sakkoja-app
```

---

### Option B: Self-Hosted Nginx / Docker

To serve Sakkoja using Nginx or a lightweight Docker container:

#### Nginx Configuration (`nginx.conf`)
Ensure MIME types for WebAssembly and SPA routing are properly configured:

```nginx
server {
    listen 80;
    server_name navigator.yourdomain.com;
    root /usr/share/nginx/html;
    index index.html;

    # Gzip compression for GeoJSON and tile assets
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript application/wasm application/geo+json;

    # Proper WASM & JS MIME types
    types {
        application/wasm wasm;
        application/javascript js;
        application/json json;
        image/svg+xml svg;
    }

    # SPA Fallback
    location / {
        try_files $uri $uri/ /index.html;
    }

    # Cache static assets
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|wasm)$ {
        expires 30d;
        add_header Cache-Control "public, no-transform";
    }
}
```

#### Dockerfile
```dockerfile
# Step 1: Build Web App
FROM ghcr.io/cirruslabs/flutter:3.44.8 AS build
WORKDIR /app
COPY . .
RUN flutter pub get
RUN dart run build_runner build --delete-conflicting-outputs
RUN dart compile js -O4 web/drift_worker.dart -o web/drift_worker.js
RUN flutter build web --release

# Step 2: Serve with Nginx
FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

---

## 4. Deploying the CORS Proxy Worker (`cloudflare-worker/`)

Some Finnish open data providers (like MMM fishing restrictions) do not include CORS headers for browser requests. The included Cloudflare Worker handles CORS headers securely:

```bash
cd cloudflare-worker

# 1. Install worker dependencies
npm install

# 2. Login to your Cloudflare account
npx wrangler login

# 3. Configure your domain in src/index.js
# Edit ALLOWED_ORIGINS to add your deployment domain:
# const ALLOWED_ORIGINS = ['https://navigator.yourdomain.com', 'http://localhost'];

# 4. Deploy worker
npm run deploy
```

The worker will output a URL like `https://sakkoja-cors-proxy.yourname.workers.dev`.

---

## 5. Custom Domain & SSL Configuration

1. In your Cloudflare Pages dashboard (or DNS provider), navigate to **Custom Domains**.
2. Add your desired subdomain (e.g. `merikartta.yourdomain.com`).
3. Add a CNAME DNS record pointing to your Pages project (`your-project.pages.dev`).
4. SSL/TLS certificates will be provisioned automatically.

---

## 6. Verification Checklist

After deploying your own instance:
- [ ] Open your URL in Chrome / Safari.
- [ ] Verify map tiles load (both OpenStreetMap and Traficom nautical charts in Fishing Mode).
- [ ] Verify FMI weather radar and wind arrows display live observations.
- [ ] Test PWA installation: Open browser menu $\to$ **Install App / Add to Home Screen**.
- [ ] Disconnect internet and verify offline cached navigation remains responsive.
