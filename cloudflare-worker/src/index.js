/**
 * Sakkoja CORS Proxy Worker
 *
 * Security features:
 * 1. Allowlist: Only proxies specific trusted APIs
 * 2. Origin validation: Only responds to requests from Sakkoja domains
 * 3. Method restriction: Only GET and OPTIONS allowed
 * 4. Content-Type validation: Prevents XSS via open proxy
 * 5. Secret injection: Injects API keys for restricted services
 */

// === SECURITY CONFIGURATION ===
const ALLOWED_TARGET_HOSTS = [
  'avoinkara.mmm.fi', // MMM fishing restrictions WFS
  'avoinkara-mmm.ruokavirasto-awsa.com', // MMM fishing restrictions WFS (Alternative)
  'opendata.fmi.fi', // FMI WFS
  'openwms.fmi.fi', // FMI WMS (Radar)
  'alerts.fmi.fi', // FMI Alerts (Atom feed)
  'julkinen.traficom.fi', // Traficom Nautical Charts (WMTS)
  'avoinapi.vaylapilvi.fi', // Vaylapilvi Fairways & Beacons
  'api.met.no', // MET Norway Ocean Forecast
  'api.openweathermap.org', // OpenWeather API
  'wms.fmi.fi', // FMI WMS (Alternative)
  'paikkatieto.ymparisto.fi', // SYKE ArcGIS / WMS
  'odata.ymparisto.fi', // SYKE Vesla OData API
  'rajapinnat.ymparisto.fi', // SYKE Vesla OData API (New)
  'geoserver2.ymparisto.fi', // SYKE Geoserver
  'avoinkara.mmm.fi', // MMM fishing restrictions WFS
  'meri.digitraffic.fi', // Digitraffic Marine AIS API
  'api.lipas.fi', // Lipas Finnish sports/harbor places API
];

const ALLOWED_ORIGINS = [
  'https://sakkoja.pages.dev',
  'https://sakkoja.pages.dev/',
  'http://localhost:8080',
  'http://localhost:5050',
  'http://localhost:5000',
  'http://127.0.0.1:8080',
  'http://127.0.0.1:5050',
  'http://127.0.0.1:5000',
];

const ALLOWED_CONTENT_TYPES = [
  'application/json',
  'application/xml',
  'text/xml',
  'image/png',
  'image/jpeg',
  'image/webp',
  'application/vnd.google-earth.kml+xml',
  'application/gml+xml',
  'application/octet-stream', // Some GML/XML APIs return this
];

// Regex for preview deployment subdomains (e.g., https://a0612339-foo.sakkoja.pages.dev)
const WILDCARD_ORIGIN_PATTERN = /^https:\/\/[a-z0-9-]+\.sakkoja\.pages\.dev$/;

const CORS_HEADERS = {
  'Access-Control-Allow-Methods': 'GET, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, X-App-Auth',
  'Access-Control-Max-Age': '86400',
};

// === HELPER FUNCTIONS ===
function isAllowedOrigin(origin) {
  // Check static allowlist first
  if (ALLOWED_ORIGINS.includes(origin)) {
    return true;
  }
  // Allow preview subdomains unconditionally as they are protected by CF Pages
  return WILDCARD_ORIGIN_PATTERN.test(origin);
}

function isAllowedTargetHost(url) {
  try {
    const parsed = new URL(url);
    if (parsed.protocol !== 'https:' && parsed.protocol !== 'http:') {
      return false;
    }
    return ALLOWED_TARGET_HOSTS.includes(parsed.hostname);
  } catch {
    return false;
  }
}

function errorResponse(message, status = 403, origin = '') {
  const headers = { 
    'Content-Type': 'application/json',
  };
  if (origin) {
    headers['Access-Control-Allow-Origin'] = origin;
  }
  return new Response(JSON.stringify({ error: message }), {
    status,
    headers,
  });
}

// === MAIN HANDLER ===
export default {
  async fetch(request, env) {
    const origin = request.headers.get('Origin') || '';
    const url = new URL(request.url);

    // Get target URL from query parameter
    let targetUrl = url.searchParams.get('url');

    // Handle /config endpoint for remote configuration
    if (url.pathname === '/config') {
      if (!isAllowedOrigin(origin)) {
        return errorResponse('Access denied', 403, origin);
      }
      try {
        const config = await import('./config/keywords.json');
        return new Response(JSON.stringify(config.default || config), {
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': origin,
            'Cache-Control': 'public, max-age=3600', // 1 hour cache
          },
        });
      } catch (err) {
        return errorResponse('Config not found', 404, origin);
      }
    }

    // Handle preflight OPTIONS request
    if (request.method === 'OPTIONS') {
      if (!isAllowedOrigin(origin)) {
        return errorResponse('Access denied', 403, origin);
      }
      return new Response(null, {
        headers: {
          ...CORS_HEADERS,
          'Access-Control-Allow-Origin': origin,
        },
      });
    }

    // Only allow GET requests
    if (request.method !== 'GET') {
      return errorResponse('Method not allowed', 405, origin);
    }

    // Validate origin
    if (!isAllowedOrigin(origin)) {
      return errorResponse('Access denied', 403, origin);
    }

    // Validate App Secret (if configured)
    const appAuth = request.headers.get('X-App-Auth');
    if (env.PROXY_AUTH_SECRET && appAuth !== env.PROXY_AUTH_SECRET) {
      return errorResponse('Unauthorized proxy access', 401, origin);
    }

    // Validate target URL exists
    if (!targetUrl) {
      return errorResponse('Missing "url" query parameter', 400, origin);
    }

    // Validate target host is in allowlist
    if (!isAllowedTargetHost(targetUrl)) {
      return errorResponse('Invalid target host', 400, origin);
    }

    // Forward client query parameters to target URL (e.g., service=WMS&request=GetMap... from flutter_map)
    // Client parameters are processed first, explicitly blocking client tampering of 'appid' / 'api_key'
    try {
      const targetUri = new URL(targetUrl);
      for (const [key, value] of url.searchParams.entries()) {
        if (key !== 'url' && key !== 'appid' && key !== 'apiKey' && key !== 'api_key') {
          targetUri.searchParams.set(key, value);
        }
      }

      // === SECRET INJECTION ===
      // If target is OpenWeather, inject the API key from environment (protected from client overwrite)
      if (targetUri.hostname === 'api.openweathermap.org' && env.OPENWEATHER_API_KEY) {
        targetUri.searchParams.set('appid', env.OPENWEATHER_API_KEY);
      }
      targetUrl = targetUri.toString();
    } catch (e) {
      return errorResponse('Invalid target URL', 400, origin);
    }

      const headers = {
        'User-Agent': 'Sakkoja-CORS-Proxy/1.1 (https://github.com/traali/sakkoja; admin@sakkoja.pages.dev)',
      };

      // MET Norway requires a specific User-Agent format for their TOS
      if (targetUri.hostname === 'api.met.no') {
        headers['User-Agent'] = 'Sakkoja/1.1 (https://github.com/traali/sakkoja; admin@sakkoja.pages.dev)';
      }

      const proxyResponse = await fetch(targetUrl, {
        method: 'GET',
        headers: headers,
      });

      // Validate Content-Type
      const contentType = proxyResponse.headers.get('Content-Type') || '';
      const isAllowedType = ALLOWED_CONTENT_TYPES.some(type => contentType.toLowerCase().includes(type.toLowerCase()));
      
      if (!isAllowedType && proxyResponse.status === 200) {
        console.warn(`Blocked invalid content-type: ${contentType} from ${targetUrl}`);
        return errorResponse('Content type not allowed', 415, origin);
      }

      // Create new response with cleaned CORS headers
      const responseHeaders = new Headers(proxyResponse.headers);
      responseHeaders.delete('Access-Control-Allow-Origin');
      responseHeaders.delete('Access-Control-Allow-Credentials');
      responseHeaders.delete('Access-Control-Allow-Methods');
      responseHeaders.delete('Access-Control-Allow-Headers');

      const response = new Response(proxyResponse.body, {
        status: proxyResponse.status,
        statusText: proxyResponse.statusText,
        headers: responseHeaders,
      });

      // Add CORS headers
      response.headers.set('Access-Control-Allow-Origin', origin);
      response.headers.append('Vary', 'Origin');

      return response;
    } catch (error) {
      console.error('Proxy error:', error.message);
      return errorResponse('Service unavailable', 502, origin);
    }
  },
};
