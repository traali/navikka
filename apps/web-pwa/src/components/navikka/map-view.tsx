import { useEffect, useRef } from "react";
import {
  aisMarkersForMap,
  FAIRWAYS,
  FISH_ZONES,
  HARBORS,
  SPEED_ZONES,
  type Harbor,
} from "@/lib/navikka/catalog";
import { decideFollowPan } from "@/lib/navikka/fetch-policy";
import { HELSINKI_SEA, type LatLng } from "@/lib/navikka/geo";
import { useNav, type AisTarget } from "@/lib/navikka/store";

export type MapHandle = {
  flyTo: (pos: LatLng, zoom?: number) => void;
  recenter: () => void;
};

type Props = {
  onReady?: (h: MapHandle) => void;
};

export function MapView({ onReady }: Props) {
  const hostRef = useRef<HTMLDivElement>(null);
  const mapRef = useRef<import("leaflet").Map | null>(null);
  const layersRef = useRef<Record<string, import("leaflet").Layer>>({});
  const onReadyRef = useRef(onReady);
  onReadyRef.current = onReady;

  useEffect(() => {
    const el = hostRef.current;
    if (!el) return;
    let cancelled = false;
    let map: import("leaflet").Map | undefined;
    const delayed: number[] = [];
    const resize = () => map?.invalidateSize({ animate: false });

    let Lmod: typeof import("leaflet") | null = null;
    (async () => {
      const L = await import("leaflet");
      Lmod = L;
      await import("leaflet/dist/leaflet.css");
      if (cancelled || !hostRef.current) return;

      const start = useNav.getState().pos ?? HELSINKI_SEA;
      map = L.map(hostRef.current, {
        zoomControl: false,
        attributionControl: true,
        minZoom: 8,
        maxZoom: 18,
        zoomSnap: 0.25,
        tapTolerance: 18,
        bounceAtZoomLimits: false,
      }).setView([start.lat, start.lng], 13.5);

      const land = L.tileLayer(
        "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png",
        {
          attribution: "&copy; OpenStreetMap &copy; CARTO",
          subdomains: "abcd",
          maxZoom: 20,
        },
      );
      const light = L.tileLayer(
        "https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png",
        {
          attribution: "&copy; OpenStreetMap &copy; CARTO",
          subdomains: "abcd",
          maxZoom: 20,
        },
      );
      const sat = L.tileLayer(
        "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}",
        { attribution: "Tiles &copy; Esri", maxZoom: 19 },
      );
      const nautical = L.tileLayer(
        "https://julkinen.traficom.fi/rasteripalvelu/wmts?service=WMTS&request=GetTile&version=1.0.0&layer=Traficom%3AMerikarttasarjat+public&style=default&format=image%2Fpng&TileMatrixSet=WGS84_Pseudo-Mercator&TileMatrix=WGS84_Pseudo-Mercator:{z}&TileRow={y}&TileCol={x}",
        { attribution: "Traficom merikartta", maxNativeZoom: 15, maxZoom: 18, opacity: 0.88 },
      );
      const seamark = L.tileLayer("https://tiles.openseamap.org/seamark/{z}/{x}/{y}.png", {
        attribution: "&copy; OpenSeaMap",
        maxZoom: 18,
        opacity: 0.95,
      });

      const theme = useNav.getState().theme;
      const satellite = useNav.getState().layers.satellite;
      const base = satellite ? sat : theme === "solar" ? light : land;
      base.addTo(map);
      if (!satellite && useNav.getState().layers.enc) nautical.addTo(map);
      if (useNav.getState().layers.seamarks) seamark.addTo(map);

      const fairways = L.layerGroup();
      for (const f of FAIRWAYS) {
        L.polyline(
          f.path.map((p) => [p.lat, p.lng] as [number, number]),
          { color: "#5ee7ff", weight: 2.5, opacity: 0.7, dashArray: "8 6" },
        )
          .bindTooltip(`${f.name}`, { sticky: true })
          .addTo(fairways);
      }
      fairways.addTo(map);

      const speed = L.layerGroup();
      for (const z of SPEED_ZONES) {
        L.polygon(
          z.ring.map((p) => [p.lat, p.lng] as [number, number]),
          {
            color: z.noWake ? "#06b6d4" : "#ef4444",
            weight: 1,
            fillOpacity: 0.18,
            fillColor: z.noWake ? "#06b6d4" : "#ef4444",
          },
        )
          .bindTooltip(z.noWake ? `Aallokko kielletty · ${z.limitKmh} km/h` : `${z.limitKmh} km/h`)
          .addTo(speed);
      }

      const fish = L.layerGroup();
      for (const z of FISH_ZONES) {
        L.polygon(
          z.ring.map((p) => [p.lat, p.lng] as [number, number]),
          { color: "#f59e0b", weight: 1, fillOpacity: 0.16, fillColor: "#f59e0b" },
        ).on("click", () => useNav.getState().select({ type: "fish", id: z.id }))
          .addTo(fish);
      }

      const harbors = L.layerGroup();
      for (const h of HARBORS) harbors.addLayer(harborMarker(L, h));

      const ais = L.layerGroup();
      const boat = L.marker([start.lat, start.lng], {
        icon: boatIcon(L, useNav.getState().cog),
        zIndexOffset: 1000,
        interactive: false,
      });
      if (useNav.getState().gpsSource === "device") boat.addTo(map);

      const route = L.polyline([], { color: "#00f2fe", weight: 3, opacity: 0.9 });
      const wps = L.layerGroup();
      route.addTo(map);
      wps.addTo(map);

      layersRef.current = { land, light, sat, nautical, seamark, fairways, speed, fish, harbors, ais, boat, route, wps };
      if (useNav.getState().layers.harbors) harbors.addTo(map);
      if (useNav.getState().layers.ais) ais.addTo(map);
      if (useNav.getState().layers.speedLimits) speed.addTo(map);
      if (useNav.getState().layers.fishing) fish.addTo(map);

      map.on("click", (e) => {
        const s = useNav.getState();
        if (s.planning) s.addWaypoint({ lat: e.latlng.lat, lng: e.latlng.lng });
      });
      map.on("dragstart", () => {
        if (useNav.getState().follow) useNav.getState().toggleFollow();
      });

      mapRef.current = map;
      requestAnimationFrame(() => {
        resize();
        requestAnimationFrame(resize);
      });
      if (cancelled || !hostRef.current) {
        map.remove();
        mapRef.current = null;
        return;
      }
      delayed.push(...[120, 400, 1000].map((ms) => window.setTimeout(resize, ms)));
      window.addEventListener("orientationchange", resize);
      window.visualViewport?.addEventListener("resize", resize);
      onReadyRef.current?.({
        flyTo: (pos, zoom = 14.5) => map?.flyTo([pos.lat, pos.lng], zoom, { duration: 0.6 }),
        recenter: () => {
          const s = useNav.getState();
          if (s.gpsSource !== "device") return;
          map?.flyTo([s.pos.lat, s.pos.lng], Math.max(map.getZoom(), 14), { duration: 0.5 });
        },
      });

      syncAis(L, ais, useNav.getState().ais, useNav.getState().aisSource);
      syncRoute(L, route, wps, useNav.getState().waypoints);
    })();

    const unsub = useNav.subscribe((s, prev) => {
      const Lwait = layersRef.current;
      const m = mapRef.current;
      const L = Lmod;
      if (!m || !Lwait.boat || !L) return;
      const boat = Lwait.boat as import("leaflet").Marker;
      if (s.gpsSource === "device") {
        if (!m.hasLayer(boat)) boat.addTo(m);
        if (s.pos !== prev.pos || s.cog !== prev.cog) {
          boat.setLatLng([s.pos.lat, s.pos.lng]);
          if (s.cog !== prev.cog) boat.setIcon(boatIcon(L, s.cog));
          const pan = decideFollowPan({
            follow: s.follow,
            followJustOn: s.follow && !prev.follow,
            from: prev.pos,
            to: s.pos,
            sogKn: s.sogKn,
          });
          if (pan.pan) m.panTo([s.pos.lat, s.pos.lng], { animate: pan.animate, duration: pan.animate ? 0.4 : 0 });
        }
      } else if (m.hasLayer(boat)) {
        m.removeLayer(boat);
      }
      if (s.lookSeq !== prev.lookSeq && s.lookAt) {
        m.flyTo([s.lookAt.lat, s.lookAt.lng], Math.max(m.getZoom(), 14), { duration: 0.55 });
      }
      if (s.layers !== prev.layers || s.theme !== prev.theme) {
        const baseWanted = s.layers.satellite ? Lwait.sat : s.theme === "solar" ? Lwait.light : Lwait.land;
        [Lwait.land, Lwait.light, Lwait.sat].forEach((ly) => {
          if (ly === baseWanted) {
            if (!m.hasLayer(ly)) ly.addTo(m);
          } else if (m.hasLayer(ly)) m.removeLayer(ly);
        });
        toggle(m, Lwait.nautical, !s.layers.satellite && s.layers.enc);
        toggle(m, Lwait.seamark, s.layers.seamarks);
        toggle(m, Lwait.harbors, s.layers.harbors);
        toggle(m, Lwait.ais, s.layers.ais);
        toggle(m, Lwait.speed, s.layers.speedLimits);
        toggle(m, Lwait.fish, s.layers.fishing);
      }
      if (s.ais !== prev.ais || s.aisSource !== prev.aisSource) {
        syncAis(L, Lwait.ais as import("leaflet").LayerGroup, s.ais, s.aisSource);
      }
      if (s.waypoints !== prev.waypoints) {
        syncRoute(L, Lwait.route as import("leaflet").Polyline, Lwait.wps as import("leaflet").LayerGroup, s.waypoints);
      }
    });

    return () => {
      cancelled = true;
      unsub();
      delayed.forEach((id) => window.clearTimeout(id));
      window.removeEventListener("orientationchange", resize);
      window.visualViewport?.removeEventListener("resize", resize);
      map?.remove();
      mapRef.current = null;
    };
  }, []);

  return <div ref={hostRef} className="nav-map" aria-label="Merikartta" />;
}

function toggle(map: import("leaflet").Map, layer: import("leaflet").Layer, on: boolean) {
  if (!layer) return;
  if (on && !map.hasLayer(layer)) layer.addTo(map);
  if (!on && map.hasLayer(layer)) map.removeLayer(layer);
}

function boatIcon(L: typeof import("leaflet"), cog: number) {
  return L.divIcon({
    className: "boat-icon",
    iconSize: [28, 28],
    iconAnchor: [14, 14],
    html: `<div style="transform:rotate(${cog}deg)" class="boat-glyph"></div>`,
  });
}

function harborMarker(L: typeof import("leaflet"), h: Harbor) {
  const icon = L.divIcon({
    className: "harbor-icon",
    iconSize: [18, 18],
    iconAnchor: [9, 9],
    html: `<span class="harbor-dot ${h.kind}"></span>`,
  });
  return L.marker([h.pos.lat, h.pos.lng], { icon }).on("click", () =>
    useNav.getState().select({ type: "harbor", id: h.id }),
  );
}

function aisIcon(L: typeof import("leaflet"), t: AisTarget) {
  return L.divIcon({
    className: "ais-icon",
    iconSize: [16, 16],
    iconAnchor: [8, 8],
    html: `<div class="ais-glyph ${t.kind}" style="transform:rotate(${t.cog}deg)"></div>`,
  });
}

function syncAis(
  L: typeof import("leaflet"),
  group: import("leaflet").LayerGroup,
  targets: AisTarget[],
  source: "seed" | "live",
) {
  group.clearLayers();
  const list = aisMarkersForMap(targets, source);
  for (const t of list) {
    L.marker([t.pos.lat, t.pos.lng], { icon: aisIcon(L, t) }).on("click", () =>
      useNav.getState().select({ type: "ais", mmsi: t.mmsi }),
    ).addTo(group);
  }
}

function syncRoute(
  L: typeof import("leaflet"),
  line: import("leaflet").Polyline,
  group: import("leaflet").LayerGroup,
  wps: LatLng[],
) {
  line.setLatLngs(wps.map((p) => [p.lat, p.lng] as [number, number]));
  group.clearLayers();
  wps.forEach((p, i) => {
    L.circleMarker([p.lat, p.lng], {
      radius: 7,
      color: "#00f2fe",
      fillColor: "#050505",
      fillOpacity: 1,
      weight: 2,
    })
      .bindTooltip(String(i + 1))
      .on("click", () => useNav.getState().select({ type: "wp", index: i }))
      .addTo(group);
  });
}
