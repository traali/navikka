import type { ReactNode } from "react";
import {
  Anchor,
  Copy,
  Fuel,
  Phone,
  Radio,
  Trash2,
  Waves,
  Zap,
} from "lucide-react";
import { FISH_ZONES, HARBORS, MIN_SIZES } from "@/lib/navikka/catalog";
import { computeCpa, formatDdm, nmBetween, padCourse, parseLatLngQuery, routeStats } from "@/lib/navikka/geo";
import { COPY } from "@/lib/navikka/i18n";
import { catchLegal, fogStatus, maydayScript, shareText } from "@/lib/navikka/rules";
import { formatWeatherAge, isWeatherStale, weatherAgeMs } from "@/lib/navikka/fetch-policy";
import {
  fmtDepth,
  fmtSpeed,
  fmtWind,
  minSizeFor,
  nearestHarbor,
  ukcNow,
  useCopy,
  useNav,
} from "@/lib/navikka/store";

export function WeatherPanel() {
  const c = useCopy();
  const w = useNav((s) => s.weather);
  const err = useNav((s) => s.weatherError);
  const fetching = useNav((s) => s.weatherFetching);
  const lang = useNav((s) => s.lang);
  const windUnit = useNav((s) => s.windUnit);
  const depthUnit = useNav((s) => s.depthUnit);
  if (!w) {
    return (
      <div className="panel">
        <header className="panel-head">
          <h2>{c.weather}</h2>
        </header>
        <p className="muted">{err ?? c.fetchingWx}</p>
      </div>
    );
  }
  const fog = fogStatus(w);
  const age = weatherAgeMs(w.updated);
  const stale = isWeatherStale(age);
  return (
    <div className="panel">
      <header className="panel-head">
        <h2>{c.weather}</h2>
        <span className={`chip ${stale ? "warn" : ""}`} data-weather-age={Math.round(age / 1000)}>
          {formatWeatherAge(age, lang)}
        </span>
      </header>
      {stale && (
        <div className="banner yellow">
          <Waves size={16} />
          <span>{c.staleWx}</span>
        </div>
      )}
      <div className={`banner ${fog.level}`}>
        <Waves size={16} />
        <span>{lang === "fi" ? fog.fi : fog.en}</span>
      </div>
      <div className="stat-grid">
        <Stat label={c.wind} value={fmtWind(w.windMs, windUnit)} sub={padCourse(w.windDir)} />
        <Stat label={c.gust} value={fmtWind(w.gustMs, windUnit)} />
        <Stat label={c.waves} value={fmtDepth(w.waveM, depthUnit)} sub={`${c.period} ${w.wavePeriod.toFixed(0)} s`} />
        <Stat label={c.pressure} value={`${Math.round(w.pressureHpa)} hPa`} />
        <Stat label={c.water} value={`${w.waterC.toFixed(1)} °C`} />
        <Stat label={c.vis} value={w.visM >= 10000 ? "10+ km" : `${(w.visM / 1000).toFixed(1)} km`} />
      </div>
      <p className="muted tiny">
        {c.wxSource}
        {fetching ? ` · ${c.fetchingWx}` : err ? ` · ${err}` : ""}
      </p>
    </div>
  );
}

export function FishingPanel() {
  const c = useCopy();
  const lang = useNav((s) => s.lang);
  const catches = useNav((s) => s.catches);
  const addCatch = useNav((s) => s.addCatch);
  const toggleLayer = useNav((s) => s.toggleLayer);
  const fishingOn = useNav((s) => s.layers.fishing);
  return (
    <div className="panel">
      <header className="panel-head">
        <h2>{c.fishing}</h2>
        <button
          className={`chip-btn ${fishingOn ? "on" : ""}`}
          onClick={() => toggleLayer("fishing")}
          type="button"
        >
          {c.fishingZones}
        </button>
      </header>
      <ul className="zone-list">
        {FISH_ZONES.map((z) => (
          <li key={z.id}>
            <strong>{lang === "fi" ? z.name : z.nameEn}</strong>
            <span className="muted">{lang === "fi" ? z.rule : z.ruleEn}</span>
          </li>
        ))}
      </ul>
      <h3>{c.catchLog}</h3>
      <CatchForm onAdd={addCatch} />
      <ul className="catch-list">
        {catches.length === 0 ? (
          <li className="muted">{lang === "fi" ? "Ei merkittyjä saaliita." : "No logged catches."}</li>
        ) : (
          catches.map((x) => {
            const spec = minSizeFor(x.species);
            const under = !catchLegal(x.species, x.cm).legal;
            return (
              <li key={x.id} className={under ? "bad" : ""}>
                <strong>{lang === "fi" ? spec?.fi : spec?.en}</strong>
                <span>
                  {x.cm} cm · {under ? c.undersize : c.legal}
                </span>
              </li>
            );
          })
        )}
      </ul>
    </div>
  );
}

function CatchForm({ onAdd }: { onAdd: (species: string, cm: number) => void }) {
  const c = useCopy();
  const lang = useNav((s) => s.lang);
  return (
    <form
      className="catch-form"
      onSubmit={(e) => {
        e.preventDefault();
        const fd = new FormData(e.currentTarget);
        const species = String(fd.get("species") || "kuha");
        const cm = Number(fd.get("cm") || 0);
        if (cm > 0) onAdd(species, cm);
        e.currentTarget.reset();
      }}
    >
      <label>
        {c.species}
        <select name="species" defaultValue="kuha">
          {MIN_SIZES.map((s) => (
            <option key={s.id} value={s.id}>
              {lang === "fi" ? s.fi : s.en}
              {s.cm ? ` ≥${s.cm} cm` : ""}
            </option>
          ))}
        </select>
      </label>
      <label>
        {c.length} (cm)
        <input name="cm" type="number" min={1} max={200} step={1} required />
      </label>
      <button className="btn primary" type="submit">
        {c.addCatch}
      </button>
    </form>
  );
}

export function MenuPanel() {
  const c = useCopy();
  const theme = useNav((s) => s.theme);
  const lang = useNav((s) => s.lang);
  const rough = useNav((s) => s.roughSea);
  const vessel = useNav((s) => s.vessel);
  const speedUnit = useNav((s) => s.speedUnit);
  const windUnit = useNav((s) => s.windUnit);
  const depthUnit = useNav((s) => s.depthUnit);
  const setTheme = useNav((s) => s.setTheme);
  const setLang = useNav((s) => s.setLang);
  const toggleRough = useNav((s) => s.toggleRough);
  const setUnits = useNav((s) => s.setUnits);
  const setVessel = useNav((s) => s.setVessel);
  const setSheet = useNav((s) => s.setSheet);
  const togglePlanning = useNav((s) => s.togglePlanning);

  const themes = [
    ["night", c.night],
    ["solar", c.solar],
    ["deep", c.deep],
    ["aurora", c.aurora],
    ["red", c.red],
  ] as const;

  return (
    <div className="panel">
      <header className="panel-head">
        <h2>{c.menu}</h2>
      </header>
      <section>
        <h3>{c.themes}</h3>
        <div className="seg">
          {themes.map(([id, label]) => (
            <button key={id} className={theme === id ? "on" : ""} type="button" onClick={() => setTheme(id)}>
              {label}
            </button>
          ))}
        </div>
      </section>
      <section>
        <h3>{c.units}</h3>
        <Row label={c.sog}>
          <div className="seg tiny">
            <button className={speedUnit === "kn" ? "on" : ""} type="button" onClick={() => setUnits({ speedUnit: "kn" })}>
              kn
            </button>
            <button className={speedUnit === "kmh" ? "on" : ""} type="button" onClick={() => setUnits({ speedUnit: "kmh" })}>
              km/h
            </button>
          </div>
        </Row>
        <Row label={c.wind}>
          <div className="seg tiny">
            <button className={windUnit === "ms" ? "on" : ""} type="button" onClick={() => setUnits({ windUnit: "ms" })}>
              m/s
            </button>
            <button className={windUnit === "kn" ? "on" : ""} type="button" onClick={() => setUnits({ windUnit: "kn" })}>
              kn
            </button>
          </div>
        </Row>
        <Row label={c.depth}>
          <div className="seg tiny">
            <button className={depthUnit === "m" ? "on" : ""} type="button" onClick={() => setUnits({ depthUnit: "m" })}>
              m
            </button>
            <button className={depthUnit === "ft" ? "on" : ""} type="button" onClick={() => setUnits({ depthUnit: "ft" })}>
              ft
            </button>
          </div>
        </Row>
      </section>
      <section>
        <h3>{c.language}</h3>
        <div className="seg">
          <button className={lang === "fi" ? "on" : ""} type="button" onClick={() => setLang("fi")}>
            Suomi
          </button>
          <button className={lang === "en" ? "on" : ""} type="button" onClick={() => setLang("en")}>
            English
          </button>
        </div>
      </section>
      <section>
        <Row label={c.roughSea}>
          <button className={`switch ${rough ? "on" : ""}`} type="button" onClick={toggleRough} aria-pressed={rough} />
        </Row>
      </section>
      <section>
        <h3>{c.vessel}</h3>
        <label className="field">
          {lang === "fi" ? "Nimi" : "Name"}
          <input value={vessel.name} onChange={(e) => setVessel({ name: e.target.value })} />
        </label>
        <div className="field-row">
          <label className="field">
            {c.draft}
            <input
              type="number"
              step="0.1"
              value={vessel.draftM}
              onChange={(e) => setVessel({ draftM: Number(e.target.value) })}
            />
          </label>
          <label className="field">
            {c.loa}
            <input
              type="number"
              step="0.1"
              value={vessel.loaM}
              onChange={(e) => setVessel({ loaM: Number(e.target.value) })}
            />
          </label>
          <label className="field">
            {c.airDraft}
            <input
              type="number"
              step="0.1"
              value={vessel.airDraftM}
              onChange={(e) => setVessel({ airDraftM: Number(e.target.value) })}
            />
          </label>
        </div>
      </section>
      <div className="stack-btns">
        <button className="btn" type="button" onClick={togglePlanning}>
          {c.route}
        </button>
        <button className="btn danger" type="button" onClick={() => setSheet("sos")}>
          {c.sos}
        </button>
      </div>
      <p className="muted tiny">{c.disclaimer}</p>
    </div>
  );
}

export function LayersSheet() {
  const c = useCopy();
  const layers = useNav((s) => s.layers);
  const toggle = useNav((s) => s.toggleLayer);
  const close = () => useNav.getState().setSheet("none");
  const items = [
    ["harbors", c.harbors],
    ["ais", c.ais],
    ["seamarks", c.seamarks],
    ["speedLimits", c.speedLimits],
    ["fishing", c.fishingZones],
    ["satellite", c.satellite],
  ] as const;
  return (
    <Sheet title={c.layers} onClose={close}>
      {items.map(([k, label]) => (
        <Row key={k} label={label}>
          <button
            className={`switch ${layers[k] ? "on" : ""}`}
            type="button"
            onClick={() => toggle(k)}
            aria-pressed={layers[k]}
          />
        </Row>
      ))}
    </Sheet>
  );
}

export function SosSheet() {
  const c = useCopy();
  const pos = useNav((s) => s.pos);
  const vessel = useNav((s) => s.vessel);
  const copied = useNav((s) => s.copied);
  const copyPos = useNav((s) => s.copyPos);
  const { fw, ukc } = ukcNow();
  const close = () => useNav.getState().setSheet("none");
  const ddm = formatDdm(pos);
  const script = maydayScript({
    name: vessel.name,
    pos,
    draftM: vessel.draftM,
    fairway: fw?.name ?? null,
    ukc,
  });
  return (
    <Sheet title={c.sos} onClose={close} danger>
      <p className="mono pos-readout">{ddm}</p>
      <p className="muted tiny">
        {vessel.name} · {fw && ukc != null ? `${c.ukc} ${ukc.toFixed(1)} m · ${fw.name}` : c.openWater}
      </p>
      <div className="stack-btns">
        <a className="btn danger" href="tel:112">
          <Phone size={16} /> 112 {c.emergency}
        </a>
        <a className="btn" href="tel:02941000">
          <Radio size={16} /> {c.mrcc} 0294 1000
        </a>
        <button className="btn" type="button" onClick={() => void copyPos()}>
          <Copy size={16} /> {copied ? c.copied : c.copyPos}
        </button>
        <button
          className="btn"
          type="button"
          onClick={() => void shareText("Navikka MAYDAY", script)}
        >
          {c.sharePos}
        </button>
      </div>
      <pre className="mayday">{script}</pre>
    </Sheet>
  );
}

export function DetailSheet() {
  const sel = useNav((s) => s.selection);
  const lang = useNav((s) => s.lang);
  const close = () => useNav.getState().select(null);
  if (!sel) return null;
  if (sel.type === "harbor") {
    const h = HARBORS.find((x) => x.id === sel.id);
    if (!h) return null;
    const c = COPY[lang];
    return (
      <Sheet title={lang === "fi" ? h.name : h.nameEn} onClose={close}>
        <p className="muted">
          {h.kind} · {c.depth} {h.depthM.toFixed(1)} m
        </p>
        <div className="svc">
          {h.fuel && (
            <span>
              <Fuel size={14} /> {c.fuel}
            </span>
          )}
          {h.power && (
            <span>
              <Zap size={14} /> {c.power}
            </span>
          )}
          {h.water && (
            <span>
              <Waves size={14} /> {c.waterSvc}
            </span>
          )}
          {h.sauna && <span>{c.sauna}</span>}
          {h.pumpout && <span>{c.pumpout}</span>}
        </div>
        {h.vhf && (
          <p>
            {c.vhf} {h.vhf}
          </p>
        )}
        {h.phone && <a href={`tel:${h.phone.replace(/\s/g, "")}`}>{h.phone}</a>}
        <button
          className="btn primary"
          type="button"
          onClick={() => {
            useNav.getState().addWaypoint(h.pos);
            useNav.getState().select(null);
            useNav.setState({ planning: true, tab: "map" });
          }}
        >
          {c.route}
        </button>
      </Sheet>
    );
  }
  if (sel.type === "ais") {
    const t = useNav.getState().ais.find((x) => x.mmsi === sel.mmsi);
    if (!t) return null;
    const own = useNav.getState();
    const cpa = computeCpa(own.pos, own.cog, own.sogKn, t.pos, t.cog, t.sogKn);
    const c = COPY[lang];
    const danger = cpa.colliding || (cpa.tcpaMin > 0 && cpa.tcpaMin < 8 && cpa.cpaNm < 0.5);
    return (
      <Sheet title={t.name} onClose={close} danger={danger}>
        <div className="stat-grid">
          <Stat label="MMSI" value={t.mmsi} />
          <Stat label={c.sog} value={`${t.sogKn.toFixed(1)} kn`} />
          <Stat label={c.cog} value={padCourse(t.cog)} />
          <Stat label={c.cpa} value={`${cpa.cpaNm.toFixed(2)} NM`} />
          <Stat
            label={c.tcpa}
            value={Number.isFinite(cpa.tcpaMin) ? `${cpa.tcpaMin.toFixed(1)} min` : "—"}
          />
        </div>
        {danger && <p className="banner red">{lang === "fi" ? "Lähestymisvaara" : "Closing risk"}</p>}
      </Sheet>
    );
  }
  if (sel.type === "fish") {
    const z = FISH_ZONES.find((x) => x.id === sel.id);
    if (!z) return null;
    return (
      <Sheet title={lang === "fi" ? z.name : z.nameEn} onClose={close}>
        <p>{lang === "fi" ? z.rule : z.ruleEn}</p>
      </Sheet>
    );
  }
  return null;
}

export function RouteHud() {
  const c = useCopy();
  const wps = useNav((s) => s.waypoints);
  const sog = useNav((s) => s.sogKn);
  const planning = useNav((s) => s.planning);
  const navigating = useNav((s) => s.navigating);
  const speedUnit = useNav((s) => s.speedUnit);
  if (!planning && wps.length === 0) return null;
  const stats = routeStats(wps, sog);
  return (
    <div className="route-hud">
      <p className="tiny">{c.addWp}</p>
      {wps.length > 0 && (
        <p className="mono">
          {c.total} {stats.nm.toFixed(2)} NM · {c.eta} {stats.etaMin > 0 ? `${Math.round(stats.etaMin)} min` : "—"} ·{" "}
          {fmtSpeed(sog, speedUnit)}
        </p>
      )}
      <div className="row-btns">
        <button className="btn ghost" type="button" onClick={() => useNav.getState().clearRoute()}>
          <Trash2 size={14} /> {c.clearRoute}
        </button>
        {wps.length >= 2 && (
          <button className="btn primary" type="button" onClick={() => useNav.getState().toggleNav()}>
            {navigating ? c.stopNav : c.startNav}
          </button>
        )}
      </div>
    </div>
  );
}

export function VoiceSheet() {
  const c = useCopy();
  const lang = useNav((s) => s.lang);
  const w = useNav((s) => s.weather);
  const { fw, ukc } = ukcNow();
  const near = nearestHarbor(useNav.getState().pos);
  const close = () => useNav.getState().setSheet("none");
  const replies = [
    lang === "fi"
      ? fw && ukc != null
        ? `Syvyys: ${fw.name}, kölivara ${ukc.toFixed(1)} m.`
        : "Syvyys: avomeri, ei julkaistua väylää."
      : fw && ukc != null
        ? `Depth: ${fw.name}, UKC ${ukc.toFixed(1)} m.`
        : "Depth: open water, no published fairway.",
    lang === "fi"
      ? `Lähin satama: ${near.harbor.name}, ${near.nm.toFixed(1)} NM.`
      : `Nearest harbor: ${near.harbor.nameEn}, ${near.nm.toFixed(1)} NM.`,
    w
      ? lang === "fi"
        ? `Tuuli ${fmtWind(w.windMs, "ms")}, aallot ${w.waveM.toFixed(1)} m.`
        : `Wind ${fmtWind(w.windMs, "ms")}, waves ${w.waveM.toFixed(1)} m.`
      : c.offline,
  ];
  return (
    <Sheet title={c.skipper} onClose={close}>
      <p className="muted">{c.voiceHint}</p>
      <ul className="voice-list">
        {replies.map((r) => (
          <li key={r}>{r}</li>
        ))}
      </ul>
    </Sheet>
  );
}

export function SearchHits() {
  const q = useNav((s) => s.query).trim().toLowerCase();
  const lang = useNav((s) => s.lang);
  if (q.length < 2) return null;
  const coord = parseLatLngQuery(q);
  const hits = HARBORS.filter(
    (h) => h.name.toLowerCase().includes(q) || h.nameEn.toLowerCase().includes(q),
  ).slice(0, 6);
  return (
    <div className="search-hits">
      {coord && (
        <button
          type="button"
          onClick={() => {
            useNav.getState().setPos(coord);
            useNav.getState().setQuery("");
            useNav.setState({ follow: true, sheet: "none" });
          }}
        >
          GPS {formatDdm(coord)}
        </button>
      )}
      {hits.map((h) => (
        <button
          key={h.id}
          type="button"
          onClick={() => {
            useNav.getState().select({ type: "harbor", id: h.id });
            useNav.getState().setQuery("");
            useNav.setState({ pos: h.pos, follow: true });
          }}
        >
          <Anchor size={14} /> {lang === "fi" ? h.name : h.nameEn}
          <span>{nmBetween(useNav.getState().pos, h.pos).toFixed(1)} NM</span>
        </button>
      ))}
    </div>
  );
}

function Sheet({
  title,
  onClose,
  children,
  danger,
}: {
  title: string;
  onClose: () => void;
  children: ReactNode;
  danger?: boolean;
}) {
  return (
    <div className={`sheet ${danger ? "danger" : ""}`} role="dialog" aria-label={title}>
      <div className="sheet-grab" />
      <header className="sheet-head">
        <h2>{title}</h2>
        <button type="button" className="icon-btn" onClick={onClose} aria-label="Sulje">
          ×
        </button>
      </header>
      <div className="sheet-body">{children}</div>
    </div>
  );
}

function Stat({ label, value, sub }: { label: string; value: string; sub?: string }) {
  return (
    <div className="stat">
      <span className="lbl">{label}</span>
      <strong>{value}</strong>
      {sub && <span className="muted tiny">{sub}</span>}
    </div>
  );
}

function Row({ label, children }: { label: string; children: ReactNode }) {
  return (
    <div className="row">
      <span>{label}</span>
      {children}
    </div>
  );
}


