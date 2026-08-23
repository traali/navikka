/* Companion offline shell + tile cache. Same-origin + Carto/Traficom/OpenSeaMap. */
const SHELL = "navikka-shell-v1";
const TILES = "navikka-tiles-v1";
const TILE_HOSTS = [
  "basemaps.cartocdn.com",
  "julkinen.traficom.fi",
  "tiles.openseamap.org",
  "server.arcgisonline.com",
];

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(SHELL).then((c) => {
      const scope = self.registration.scope;
      return c.addAll([scope, new URL("index.html", scope).href]).catch(() => undefined);
    }),
  );
  self.skipWaiting();
});

self.addEventListener("activate", (event) => {
  event.waitUntil(self.clients.claim());
});

self.addEventListener("fetch", (event) => {
  const req = event.request;
  if (req.method !== "GET") return;
  let url;
  try {
    url = new URL(req.url);
  } catch {
    return;
  }
  const tile = TILE_HOSTS.some((h) => url.hostname.endsWith(h));
  if (tile) {
    event.respondWith(
      caches.open(TILES).then(async (cache) => {
        const hit = await cache.match(req);
        if (hit) return hit;
        try {
          const res = await fetch(req);
          if (res.ok) await cache.put(req, res.clone());
          return res;
        } catch (e) {
          if (hit) return hit;
          throw e;
        }
      }),
    );
    return;
  }
  if (url.origin !== self.location.origin) return;
  event.respondWith(
    fetch(req)
      .then((res) => {
        if (res.ok && req.mode !== "navigate") {
          const copy = res.clone();
          caches.open(SHELL).then((c) => c.put(req, copy));
        }
        return res;
      })
      .catch(() =>
        caches.match(req).then((h) => h || caches.match(new URL("index.html", self.registration.scope))),
      ),
  );
});
