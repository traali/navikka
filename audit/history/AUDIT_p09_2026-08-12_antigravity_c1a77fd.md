# AUDIT.md — Relay Audit Document Snapshot (Phase 9)

Snapshot File: audit/history/AUDIT_p09_2026-08-12_antigravity_c1a77fd.md
Date: 2026-08-12
Model: Antigravity Agent (Gemini 3.6 Flash)
Commit: c1a77fd7d9e33ab3e46ed9956ca7f16b81b9bd9a (tree DIRTY)

---

# §0 — STATE

```
Repository:         Sakkoja (Marine Safety Navigator)
Root:               c:/dev2/gtp/sakkoja
Stack:              Flutter 3.44.8 · Dart 3.12.2 · Riverpod 3.3.1 · Drift 2.30.1 · flutter_map 8.3
External APIs:      FMI (WFS/OData), SYKE (Water quality/Algae), OpenWeather, MET Norway, Traficom
CORS proxy:         Cloudflare Worker (cloudflare-worker/)
History:            Built incrementally over many months by MULTIPLE different AI models
                    and sessions. No single human ever held the whole design in their head.

Audit started:      2026-08-10
Audit branch/tag:   main (frozen baseline for audit session)
Baseline commit:    a902786a14d00ea72cf4cd7bff962c1fedbbcd13
Current commit:     c1a77fd7d9e33ab3e46ed9956ca7f16b81b9bd9a
Working tree:       DIRTY (.agent/rules/*, AGENTS.md, llms.txt, AUDIT.md)
Line refs valid:    yes

Last session:       2026-08-12 (Phase 9 — Security & data integrity)
Last model:         Antigravity Agent (Gemini 3.6 Flash)
Last snapshot file: audit/history/AUDIT_p09_2026-08-12_antigravity_c1a77fd.md
Phases complete:    10 / 13
Findings so far:    20  (P0: 0 · P1: 6 · P2: 13 · P3: 1)
Open investigations: TI-01 (Weather widget refresh storm) · TI-02 (GPS Cascade & Station Query Storm)
File integrity:     lines: 1230 · findings: 20
Next action:        Execute Phase 10 (Domain correctness).
```

---

# §6 — NEW FINDINGS IN PHASE 9

### F-019 · P1 · VERIFIED · sec-cleartext-api-key-sqlite-storage
File:        lib/core/db/app_database.dart #L268-L271, lib/features/ai/data/repositories/skipper_settings_repository_impl.dart #L52
Symbol:      SkipperSettingsTable.aiApiKey, SkipperSettingsRepositoryImpl.updateSettings
Commit:      c1a77fd (tree: DIRTY)
Link:        file://c:/dev2/gtp/sakkoja/lib/features/ai/data/repositories/skipper_settings_repository_impl.dart#L52
Claim:       User AI API keys for Virtual Skipper (OpenAI/Anthropic/Gemini) are persisted as plain unencrypted text columns (ai_api_key) in unencrypted SQLite database storage instead of hardware-backed secure storage.
Evidence:    app_database.dart#L270 adds aiApiKey text column to skipper_settings_table and skipper_settings_repository_impl.dart#L52 writes aiApiKey: Value(settings.aiApiKey) directly to SQLite. Anyone with local database or device backup access can extract raw API keys.
Measurement: 1 plain text private API key column stored in unencrypted SQLite file (app_drift_db.sqlite).
Repro:       Open SQLite database file app_drift_db.sqlite with DB Browser and view skipper_settings_table.ai_api_key.
Why it exists: Model B grouped AI configuration fields into the existing skipper_settings_table without implementing secure storage isolation for secret tokens. INFERRED.
Cost of keeping: Plaintext secret exposure risk on compromised devices or unencrypted DB backups.
Remediation: Migrate aiApiKey storage to flutter_secure_storage or OS Keyring/Keystore, removing the plaintext column from SQLite database schema.
Blast radius: lib/core/db/app_database.dart:L268-L272, lib/features/ai/data/repositories/skipper_settings_repository_impl.dart:L52
Effort: M    Risk of fix: low    LOC removed: 0
Found by: Antigravity (Gemini 3.6) on 2026-08-12
Sources: n/a
Verification: —

### F-020 · P2 · VERIFIED · sec-unhandled-dotenv-key-crash
File:        lib/core/config/env.dart #L4, lib/core/constants/openweather_constants.dart #L24-L27
Symbol:      Env.openWeatherKey
Commit:      c1a77fd (tree: DIRTY)
Link:        file://c:/dev2/gtp/sakkoja/lib/core/config/env.dart#L4
Claim:       Env.openWeatherKey calls dotenv.get('OPENWEATHER_API_KEY') without fallback or empty check, throwing an unhandled StateError crash on application launch if .env is missing or missing the key.
Evidence:    env.dart#L4: static String get openWeatherKey => dotenv.get('OPENWEATHER_API_KEY');. Unlike other environment variables in env.dart (which provide safe defaults via fallback), openWeatherKey throws StateError when .env is unpopulated.
Measurement: Application startup crash on environments without an explicit .env file.
Repro:       Run flutter run without a .env file and observe launch crash when OpenWeather provider initializes.
Why it exists: Env.openWeatherKey was implemented assuming .env is always present on dev/prod environments. INFERRED.
Cost of keeping: Unhandled launch crash when running in fresh environments or CI pipelines.
Remediation: Use dotenv.get('OPENWEATHER_API_KEY', fallback: '') and allow downstream proxy or fallback providers (FMI / MET Norway) to handle empty keys gracefully.
Blast radius: lib/core/config/env.dart:L4
Effort: S    Risk of fix: low    LOC removed: 0
Found by: Antigravity (Gemini 3.6) on 2026-08-12
Sources: n/a
Verification: —
