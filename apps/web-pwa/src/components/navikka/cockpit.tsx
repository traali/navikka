import { useEffect, useRef } from "react";
import {
  Compass,
  Crosshair,
  Layers,
  Map as MapIcon,
  Menu,
  Mic,
  Navigation,
  Phone,
  Sun,
  Waves,
} from "lucide-react";
import { fetchLiveAis } from "@/lib/navikka/ais";
import { padCourse } from "@/lib/navikka/geo";
import { MapView, type MapHandle } from "@/components/navikka/map-view";
import {
  DetailSheet,
  FishingPanel,
  LayersSheet,
  MenuPanel,
  RouteHud,
  SearchHits,
  SosSheet,
  VoiceSheet,
  WeatherPanel,
} from "@/components/navikka/panels";
import {
  fmtDepth,
  fmtSpeed,
  fmtWind,
  overLimit,
  ukcNow,
  useCopy,
  useNav,
} from "@/lib/navikka/store";
import { fetchWeather } from "@/lib/navikka/weather";

export function Cockpit() {
  const map = useRef<MapHandle | null>(null);
  const theme = useNav((s) => s.theme);
  const tab = useNav((s) => s.tab);
  const sheet = useNav((s) => s.sheet);
  const rough = useNav((s) => s.roughSea);
  const gpsSource = useNav((s) => s.gpsSource);

  useEffect(() => {
    document.documentElement.dataset.theme = theme;
  }, [theme]);

  useEffect(() => {
    const id = window.setInterval(() => useNav.getState().tickDemo(), 1000);
    return () => window.clearInterval(id);
  }, []);

  useEffect(() => {
    if (!navigator.geolocation) return;
    const watch = navigator.geolocation.watchPosition(
      (p) => {
        const sog = (p.coords.speed ?? 0) * 1.94384;
        const cog = p.coords.heading ?? useNav.getState().cog;
        useNav.getState().setPos(
          { lat: p.coords.latitude, lng: p.coords.longitude },
          sog > 0.4 ? sog : useNav.getState().sogKn,
          cog,
          "device",
          p.coords.accuracy,
        );
      },
      () => {
        /* keep demo track if user denies */
      },
      { enableHighAccuracy: true, maximumAge: 2000, timeout: 8000 },
    );
    return () => navigator.geolocation.clearWatch(watch);
  }, []);

  const navigating = useNav((s) => s.navigating);
  useEffect(() => {
    if (!navigating || typeof navigator === "undefined") return;
    const lockApi = navigator.wakeLock;
    if (!lockApi?.request) return;
    let sentinel: WakeLockSentinel | undefined;
    const request = async () => {
      try {
        sentinel = await lockApi.request("screen");
      } catch {
        /* iPhone Chrome: Wake Lock is flaky / needs visibility */
      }
    };
    void request();
    const onVis = () => {
      if (document.visibilityState === "visible") void request();
    };
    document.addEventListener("visibilitychange", onVis);
    return () => {
      document.removeEventListener("visibilitychange", onVis);
      void sentinel?.release();
    };
  }, [navigating]);

  useEffect(() => {
    let alive = true;
    const load = async () => {
      try {
        const w = await fetchWeather(useNav.getState().pos);
        if (alive) useNav.getState().setWeather(w);
      } catch {
        if (alive) useNav.getState().setWeather(null, "Säätä ei saatu.");
      }
      try {
        const ais = await fetchLiveAis();
        if (alive && ais.length) useNav.getState().setAis(ais);
      } catch {
        /* seeded AIS remains */
      }
    };
    void load();
    const t = window.setInterval(load, 120000);
    return () => {
      alive = false;
      window.clearInterval(t);
    };
  }, []);

  return (
    <div className={`cockpit ${rough ? "rough" : ""}`} data-tab={tab}>
      <MapView onReady={(h) => (map.current = h)} />
      <Hud onRecenter={() => map.current?.recenter()} gpsLive={gpsSource === "device"} />
      <SideFabs />
      {tab === "weather" && (
        <div className="overlay-panel">
          <WeatherPanel />
        </div>
      )}
      {tab === "fishing" && (
        <div className="overlay-panel">
          <FishingPanel />
        </div>
      )}
      {tab === "menu" && (
        <div className="overlay-panel">
          <MenuPanel />
        </div>
      )}
      {sheet === "layers" && <LayersSheet />}
      {sheet === "sos" && <SosSheet />}
      {sheet === "detail" && <DetailSheet />}
      {sheet === "voice" && <VoiceSheet />}
      <BottomNav />
    </div>
  );
}

function Hud({ onRecenter, gpsLive }: { onRecenter: () => void; gpsLive: boolean }) {
  const c = useCopy();
  const sog = useNav((s) => s.sogKn);
  const cog = useNav((s) => s.cog);
  const pos = useNav((s) => s.pos);
  const speedUnit = useNav((s) => s.speedUnit);
  const depthUnit = useNav((s) => s.depthUnit);
  const windUnit = useNav((s) => s.windUnit);
  const weather = useNav((s) => s.weather);
  const query = useNav((s) => s.query);
  const setQuery = useNav((s) => s.setQuery);
  const setSheet = useNav((s) => s.setSheet);
  const follow = useNav((s) => s.follow);
  const { fw, ukc } = ukcNow();
  const limit = overLimit(pos, sog);
  const ukcAlarm = ukc < 0.5;

  return (
    <div className="hud">
      <div className="hud-top">
        <div className="brand">
          <Compass size={16} />
          <span>Navikka</span>
          <em>{c.tag}</em>
        </div>
        <span className={`gps-pill ${gpsLive ? "live" : ""}`}>{gpsLive ? c.live : c.demo}</span>
      </div>
      <div className="telemetry">
        <div className={`tel ${limit ? "alarm" : ""}`}>
          <span>{c.sog}</span>
          <strong>{fmtSpeed(sog, speedUnit)}</strong>
          {limit != null && <small>{limit} km/h</small>}
        </div>
        <div className="tel">
          <span>{c.cog}</span>
          <strong>{padCourse(cog)}</strong>
        </div>
        <div className={`tel ${ukcAlarm ? "alarm" : ""}`}>
          <span>{c.ukc}</span>
          <strong>{fmtDepth(Math.max(ukc, 0), depthUnit)}</strong>
          <small>{fw.depthM.toFixed(1)} m</small>
        </div>
        <div className="tel">
          <span>{c.wind}</span>
          <strong>{weather ? fmtWind(weather.windMs, windUnit) : "—"}</strong>
          {weather && <small>{padCourse(weather.windDir)}</small>}
        </div>
      </div>
      <div className="search-row">
        <input
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder={c.search}
          aria-label={c.search}
        />
        <button className="fab" type="button" onClick={() => setSheet("layers")} aria-label={c.layers}>
          <Layers size={18} />
        </button>
        <button
          className={`fab ${follow ? "on" : ""}`}
          type="button"
          onClick={onRecenter}
          aria-label={c.locate}
        >
          <Crosshair size={18} />
        </button>
        <button className="fab sos" type="button" onClick={() => setSheet("sos")} aria-label={c.sos}>
          <Phone size={18} />
        </button>
      </div>
      <SearchHits />
      <RouteHud />
    </div>
  );
}

function SideFabs() {
  const c = useCopy();
  const setSheet = useNav((s) => s.setSheet);
  return (
    <div className="side-fabs">
      <button className="fab" type="button" onClick={() => setSheet("voice")} aria-label={c.skipper}>
        <Mic size={18} />
      </button>
      <button
        className="fab"
        type="button"
        onClick={() => useNav.getState().togglePlanning()}
        aria-label={c.route}
      >
        <Navigation size={18} />
      </button>
    </div>
  );
}

function BottomNav() {
  const c = useCopy();
  const tab = useNav((s) => s.tab);
  const setTab = useNav((s) => s.setTab);
  const items = [
    { id: "map" as const, label: c.map, icon: MapIcon },
    { id: "fishing" as const, label: c.fishing, icon: Waves },
    { id: "weather" as const, label: c.weather, icon: Sun },
    { id: "menu" as const, label: c.menu, icon: Menu },
  ];
  return (
    <nav className="bottom-nav" aria-label="Päävalikko">
      {items.map((it) => {
        const Icon = it.icon;
        return (
          <button
            key={it.id}
            type="button"
            className={tab === it.id ? "on" : ""}
            onClick={() => setTab(it.id)}
          >
            <Icon size={20} />
            {it.label}
          </button>
        );
      })}
    </nav>
  );
}
