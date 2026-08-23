/* Companion offline shell + bounded tile cache. */
const SHELL = "navikka-shell-v2";
const TILES = "navikka-tiles-v2";
const TILE_MAX = 400;
const TILE_HOSTS = [
  "basemaps.cartocdn.com",
  "julkinen.traficom.fi",
  "tiles.openseamap.org",
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
  event.waitUntil(
    caches
      .keys()
      .then((keys) =>
        Promise.all(keys.filter((k) => k !== SHELL && k !== TILES).map((k) => caches.delete(k))),
      )
      .then(() => self.clients.claim()),
  );
});

async function putTile(cache, req, res) {
  await cache.put(req, res);
  const keys = await cache.keys();
  if (keys.length <= TILE_MAX) return;
  const drop = keys.length - TILE_MAX;
  await Promise.all(keys.slice(0, drop).map((k) => cache.delete(k)));
}

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
        const res = await fetch(req);
        if (res.ok) await putTile(cache, req, res.clone());
        return res;
      }),
    );
    return;
  }
  if (url.origin !== self.location.origin) return;
  const isDoc = req.mode === "navigate" || req.destination === "document";
  event.respondWith(
    fetch(req)
      .then((res) => {
        if (res.ok && req.mode !== "navigate") {
          const copy = res.clone();
          caches.open(SHELL).then((c) => c.put(req, copy));
        }
        return res;
      })
      .catch(async () => {
        const hit = await caches.match(req);
        if (hit) return hit;
        if (isDoc) return caches.match(new URL("index.html", self.registration.scope));
        return Response.error();
      }),
  );
});
