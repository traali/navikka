# Sakkoja CORS Proxy Worker

A secure Cloudflare Worker that proxies requests to approved APIs, adding CORS headers for the Sakkoja web app.

## Security Features

- **Allowlist**: Only proxies to `avoinkara.mmm.fi` (MMM fishing restrictions)
- **Origin validation**: Only accepts requests from `sakkoja.pages.dev` and localhost
- **Method restriction**: Only GET and OPTIONS allowed

## Local Development

```bash
npm install
npm run dev
```

Worker runs at `http://localhost:8787`.

## Deployment

First time only:
```bash
npx wrangler login
```

Deploy:
```bash
npm run deploy
```

## Usage

```
GET https://sakkoja-cors-proxy.YOUR_SUBDOMAIN.workers.dev?url=http://avoinkara.mmm.fi/geoserver/wfs?...
```

## Adding New APIs

Edit `src/index.js` and add the hostname to `ALLOWED_TARGET_HOSTS`:

```javascript
const ALLOWED_TARGET_HOSTS = [
  'avoinkara.mmm.fi',
  'new-api.example.com',  // Add new hosts here
];
```
