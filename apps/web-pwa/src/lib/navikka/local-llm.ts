/** On-device skipper: Chrome Prompt API / Gemini Nano, else deterministic rules. */

export type LocalAsk = { ok: true; text: string; source: "nano" | "rules" };

type LanguageModelFactory = {
  availability?: () => Promise<string>;
  create: (opts?: Record<string, unknown>) => Promise<{
    prompt: (s: string) => Promise<string>;
    destroy?: () => void;
  }>;
};

function factory(): LanguageModelFactory | null {
  const w = globalThis as typeof globalThis & {
    LanguageModel?: LanguageModelFactory;
    ai?: { languageModel?: LanguageModelFactory };
  };
  return w.LanguageModel ?? w.ai?.languageModel ?? null;
}

function rulesAdvice(q: string, ctx: string, lang: "fi" | "en"): string {
  const ql = q.toLowerCase();
  const ukc = ctx.match(/UKC ([\d.]+)/);
  const wind = ctx.match(/Tuuli ([\d.]+)/);
  const wave = ctx.match(/aalto ([\d.]+)/);
  const sog = ctx.match(/SOG ([\d.]+)/);
  if (lang === "en") {
    if (ql.includes("mayday") || ql.includes("emergency")) {
      return "Distress: 112. MRCC Turku +358 294 1000. Helsinki VTS VHF 71. Read the MAYDAY card — this is not a radio.";
    }
    if (ql.includes("ukc") || ql.includes("depth") || ql.includes("keel")) {
      return ukc
        ? `UKC about ${ukc[1]} m on the nearest catalog fairway. Not an ENC sounding — slow down if you doubt.`
        : "Off-fairway / open water: no catalog depth. Do not guess UKC.";
    }
    return `On-device rules. ${wind ? `Wind ${wind[1]} m/s. ` : ""}${wave ? `Waves ${wave[1]} m. ` : ""}${sog ? `SOG ${sog[1]} kn. ` : ""}${ctx.includes("Avomeri") ? "Open water." : ""} Not official advice.`;
  }
  if (ql.includes("mayday") || ql.includes("hätä") || ql.includes("112")) {
    return "Hätä: 112. MRCC Turku 0294 1000. Helsinki VTS VHF 71. Lue MAYDAY-kortti — tämä ei ole radio.";
  }
  if (ql.includes("köl") || ql.includes("syvy") || ql.includes("ukc") || ql.includes("väyl")) {
    return ukc
      ? `Kölivara noin ${ukc[1]} m lähimmällä katalogiväylällä. Ei ENC-luotaus — hidasta jos epäilet.`
      : "Avomeri / ei väylää: ei katalogisyvyyttä. Älä arvaa kölivaraa.";
  }
  return `Paikallinen sääntömoottori. ${wind ? `Tuuli ${wind[1]} m/s. ` : ""}${wave ? `Aallot ${wave[1]} m. ` : ""}${sog ? `SOG ${sog[1]} kn. ` : ""}${ctx.includes("Avomeri") ? "Avomeri." : ""} Ei virallinen neuvo.`;
}

async function tryNano(q: string, ctx: string, lang: "fi" | "en"): Promise<string | null> {
  const lm = factory();
  if (!lm?.create) return null;
  try {
    if (typeof lm.availability === "function") {
      const a = await lm.availability();
      if (a && a !== "readily" && a !== "available") return null;
    }
    const system =
      lang === "en"
        ? "Finnish-coast skipper copilot. ≤80 words. Not an official chart. Mention UKC/MAYDAY only from context."
        : "Kippariapuri Suomen rannikolla. ≤80 sanaa. Ei virallinen merikartta. Kölivara/MAYDAY vain kontekstista.";
    const session = await lm.create({ systemPrompt: system, expectedInputs: [{ type: "text", languages: [lang] }] });
    const text = (await session.prompt(`Tilanne:\n${ctx.slice(0, 700)}\n\nKysymys: ${q}`)).trim();
    session.destroy?.();
    return text || null;
  } catch {
    return null;
  }
}

export async function askOnDevice(q: string, ctx: string, lang: "fi" | "en"): Promise<LocalAsk> {
  const nano = await tryNano(q.slice(0, 280), ctx, lang);
  if (nano) return { ok: true, text: nano, source: "nano" };
  return { ok: true, text: rulesAdvice(q, ctx, lang), source: "rules" };
}
