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
import { fetchAisAround } from "@/lib/navikka/ais";
import {
  POLL_CHECK_MS,
  decideAisFetch,
  decideGpsAccept,
  decideWeatherFetch,
  deviceFixKinematics,
  formatWeatherAge,
  isWeatherStale,
  pollStats,
  weatherAgeMs,
} from "@/lib/navikka/fetch-policy";
import { bearingDeg, haversineM, padCourse } from "@/lib/navikka/geo";
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

if (typeof window !== "undefined") {
  (window as Window & { __navikkaPoll?: typeof pollStats }).__navikkaPoll = pollStats;
}

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
    if (import.meta.env.DEV) return;
    if (!("serviceWorker" in navigator)) return;
    void navigator.serviceWorker
      .register(`${import.meta.env.BASE_URL}navikka-sw.js`)
      .catch(() => undefined);
  }, []);

  useEffect(() => {
    if (!navigator.geolocation) return;
    let lastAt = 0;
    let lastPos: { lat: number; lng: number } | null = null;
    const watch = navigator.geolocation.watchPosition(
      (p) => {
        const pos = { lat: p.coords.latitude, lng: p.coords.longitude };
        const now = Date.now();
        if (!decideGpsAccept({ now, pos, lastAt, lastPos })) return;
        const moved = lastPos ? haversineM(lastPos, pos) : 0;
        const dt = lastAt ? now - lastAt : 0;
        let heading = p.coords.heading;
        if ((heading == null || !Number.isFinite(heading)) && lastPos && moved > 8) {
          heading = bearingDeg(lastPos, pos);
        }
        lastAt = now;
        lastPos = pos;
        const prev = useNav.getState();
        const k = deviceFixKinematics({
          wasDemo: prev.gpsSource !== "device",
          speedMs: p.coords.speed,
          headingDeg: heading,
          prevSogKn: prev.sogKn,
          prevCog: prev.cog,
          movedM: moved,
          dtMs: dt,
        });
        useNav.getState().setPos(pos, k.sogKn, k.cog, "device", p.coords.accuracy);
      },
      () => {
        /* stay at 0 kn until a fix */
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
    let weatherInflight = false;
    let aisInflight = false;
    let lastWeatherAttemptAt: number | null = null;
    let lastAisAttemptAt: number | null = null;

    const tick = async () => {
      const hidden = document.visibilityState !== "visible";
      const s = useNav.getState();
      const wx = decideWeatherFetch({
        now: Date.now(),
        pos: s.pos,
        lastAt: s.weatherAt,
        lastPos: s.weatherPos,
        lastAttemptAt: lastWeatherAttemptAt,
        hidden,
        inflight: weatherInflight,
      });
      const ais = decideAisFetch({
        now: Date.now(),
        lastAt: s.aisAt,
        lastAttemptAt: lastAisAttemptAt,
        hidden,
        inflight: aisInflight,
        active: s.follow || s.navigating,
      });
      if (!wx.fetch) pollStats.skippedWeather += 1;
      if (!ais.fetch) pollStats.skippedAis += 1;
      // Arm both inflight flags before any await so a visibility tick
      // cannot start a second AIS request while weather is in flight.
      if (wx.fetch && alive) {
        weatherInflight = true;
        lastWeatherAttemptAt = Date.now();
        pollStats.weather += 1;
        useNav.setState({ weatherFetching: true });
      }
      if (ais.fetch && alive) {
        aisInflight = true;
        lastAisAttemptAt = Date.now();
        pollStats.ais += 1;
      }
      if (wx.fetch && alive) {
        try {
          const w = await fetchWeather(wx.snapped);
          if (alive) useNav.getState().setWeather(w);
        } catch {
          if (alive) useNav.getState().setWeather(null, "Säätä ei saatu.");
        } finally {
          weatherInflight = false;
        }
      }
      if (ais.fetch && alive) {
        try {
          const targets = await fetchAisAround(s.pos);
          if (alive) useNav.getState().setAis(targets, "live");
        } catch {
          if (alive) useNav.getState().setAisError("AIS-virhe");
        } finally {
          aisInflight = false;
        }
      }
    };

    void tick();
    const id = window.setInterval(tick, POLL_CHECK_MS);
    const onVis = () => {
      if (document.visibilityState === "visible") void tick();
    };
    document.addEventListener("visibilitychange", onVis);
    return () => {
      alive = false;
      window.clearInterval(id);
      document.removeEventListener("visibilitychange", onVis);
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
  const lang = useNav((s) => s.lang);
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
  const { fw, ukc } = gpsLive ? ukcNow() : { fw: null, ukc: null };
  const limit = gpsLive ? overLimit(pos, sog) : null;
  const ukcAlarm = ukc != null && ukc < 0.5;
  const wxAge = weather ? weatherAgeMs(weather.updated) : Infinity;
  const wxStale = isWeatherStale(wxAge);

  return (
    <div className="hud">
      <div className="hud-top">
        <div className="brand">
          <Compass size={16} />
          <span>Navikka</span>
          <em>{c.tag}</em>
        </div>
        <span className={`gps-pill ${gpsLive ? "live" : ""}`}>{gpsLive ? c.live : c.waitingGps}</span>
      </div>
      <div className="telemetry">
        <div className={`tel ${limit ? "alarm" : ""}`}>
          <span>{c.sog}</span>
          <strong>{gpsLive ? fmtSpeed(sog, speedUnit) : "—"}</strong>
          {limit != null && <small>{limit} km/h</small>}
        </div>
        <div className="tel">
          <span>{c.cog}</span>
          <strong>{gpsLive ? padCourse(cog) : "—"}</strong>
        </div>
        <div className={`tel ${ukcAlarm ? "alarm" : ""}`}>
          <span>{c.ukc}</span>
          <strong>{ukc == null ? "—" : fmtDepth(Math.max(ukc, 0), depthUnit)}</strong>
          <small>{!gpsLive ? c.waitingGps : fw ? `${fw.depthM.toFixed(1)} m` : c.openWater}</small>
        </div>
        <div className={`tel ${wxStale ? "alarm" : ""}`}>
          <span>{c.wind}</span>
          <strong>{weather ? fmtWind(weather.windMs, windUnit) : "—"}</strong>
          {weather && (
            <small data-weather-age={Math.round(wxAge / 1000)}>{formatWeatherAge(wxAge, lang)}</small>
          )}
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
          onClick={() => {
            if (!gpsLive) return;
            useNav.setState({ follow: true });
            onRecenter();
          }}
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
