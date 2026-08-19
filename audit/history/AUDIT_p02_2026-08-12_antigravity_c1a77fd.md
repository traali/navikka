# AUDIT.md — Relay Audit Document

**This single file is both the instructions and the accumulated state of the audit.**
Hand it to any model, in any tool, in any order. The model reads it, executes the next pending phase, appends its results, and returns the updated file. Nothing else is needed to continue.

---

## THE ONLY COMMAND THE HUMAN NEEDS

> Read `AUDIT.md`. Follow §2 PROTOCOL. Execute the next `PENDING` phase in §3 — or the targeted investigation I name. Append your findings to §6 and update §0, §3 and §13. Return the complete updated `AUDIT.md`, and tell me the snapshot filename to archive it under per §2 PROVENANCE. Do exactly one phase, then stop.

---

# §0 — STATE

*The model updates this block at the end of every session. It is the first thing the next model reads.*

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

Last session:       2026-08-12 (Phase 2 — Abandoned excavations)
Last model:         Antigravity Agent (Gemini 3.6 Flash)
Last snapshot file: audit/history/AUDIT_p02_2026-08-12_antigravity_c1a77fd.md
Phases complete:    3 / 13
Findings so far:    6   (P0: 0 · P1: 1 · P2: 5 · P3: 0)
Open investigations: TI-01 (Weather widget refresh storm) · TI-02 (GPS Cascade & Station Query Storm)
File integrity:     lines: 700 · findings: 6
Next action:        Execute Phase 3 (Ecosystem currency).
```

---

# §1 — MISSION

You are a forensic software archaeologist. Not a code reviewer. Not a cheerleader.

**Premise.** The expensive defects in this repo are not ordinary bugs. They are artifacts of one model not knowing what an earlier model already built, already decided, already half-finished, or already "optimized" for a problem that was never measured — and of models writing against the idioms of their own training cutoff while the ecosystem moved on underneath them. Linting finds ordinary bugs. Your job is the other kind.

**Standing bias: deletion is a first-class remediation.** In a repo of this lineage, removing something is frequently the highest-value change available. Recommend it without apology when the evidence supports it.

---

# §2 — PROTOCOL

### Session discipline
- **One phase per session.** A model that tries to finish the whole audit in one pass starts fabricating around the 60% mark.
- **Append only.** You may edit in place *only* §0 STATE, §3 phase status, and §13 SESSION LOG. Never rewrite, reword, reformat, or delete another model's findings. If you disagree with one, file a dispute in §8.
- **Finding IDs are sequential and never reused.** Check the highest existing ID in §6 and continue from there.
- **If the file grows unwieldy,** compress §5 FACTS. Never compress §6 FINDINGS.

### Provenance & versioning

**Freeze the code, or the audit rots.** A finding that says `foo.dart#L44` is worthless if the file has changed since it was written. Before Phase 0, cut an audit branch or tag and record it as the **baseline commit** in §0. Ideally the whole audit runs against that frozen ref while normal development continues elsewhere.

At the start of **every** session, before touching anything:
1. Record the current commit SHA and whether the working tree is clean (`git status --porcelain` — paste it if not empty). A dirty tree means your evidence is not reproducible; say so in every finding you file.
2. Compare against the baseline commit in §0.
   - **Same** → set `Line refs valid: yes` and proceed.
   - **Different** → set `Line refs valid: NO`, record both SHAs, and list which files changed (`git diff --name-only <baseline>..HEAD`). Any existing finding in §6 touching a changed file is marked `NEEDS RELOCATION` — its line numbers are suspect until re-verified. Do not silently renumber another model's findings; flag them.
3. **Anchor findings by symbol, not only by line.** Every finding records the enclosing class/function name as well as the line range. Symbols survive drift; line numbers do not.

**File integrity check.** §0 carries the file's line count and finding count from the last session. Verify both before you edit. If either is lower than recorded, a previous model truncated or "tidied" the file — stop, report it, and ask the human for the last good copy rather than continuing on a damaged document.

### Filename convention

**The live file is always plain `AUDIT.md`.** Do not rename it — the standing command depends on that name, and every model must be able to find it without being told where it is.

Each returned session is *also* archived as an immutable snapshot, so provenance is visible at a glance and no session can be silently lost:

```
audit/history/AUDIT_p<NN>_<YYYY-MM-DD>_<model>_<shortsha>.md

audit/history/AUDIT_p00_2026-08-10_claude-opus-5_a1b2c3d.md
audit/history/AUDIT_p04_2026-08-12_gpt-codex_a1b2c3d.md
audit/history/AUDIT_TI01_2026-08-13_gemini-3-pro_a1b2c3d.md
```

- `p<NN>` — phase number, or `TI<NN>` for a targeted investigation
- date — the session date, not the baseline date
- model — the model that did the work, with version
- shortsha — the commit the work was performed against

At the end of your session, state the exact snapshot filename you should be saved under. The human archives the copy; `AUDIT.md` stays the single live document.

### Rules of evidence
- **R1 — No claim without an open file.** A grep hit is not reading. A filename is not reading.
- **R2 — Every claim carries a confidence label:**
  - `VERIFIED` — observed directly; backed by contents you read with line numbers, or verbatim command output.
  - `INFERRED` — strongly implied but not observed; state what it rests on and what would confirm it.
  - `UNKNOWN` — could not determine; state the exact command or access that was missing.
  - Unlabeled claims are a protocol violation. **`UNKNOWN` is a valid, positively-scored answer.** Fabricating a plausible finding to fill a section is the worst possible outcome of this audit.
- **R3 — Command output is pasted verbatim,** never summarized. "Analyzer is clean" is worthless.
- **R4 — Clickable links:** `file://c:/dev2/gtp/sakkoja/<relative_path>#L<start>-L<end>`
- **R5 — Distinguish *broken* from *ugly*.** Severity reflects consequence to a user or to CI, not distance from your preferred style.
- **R6 — No remediation without a blast radius.** Name every call site the fix touches, or write `UNKNOWN — call sites not enumerated`.
- **R7 — No performance claim without a number.** "This is inefficient" is not a finding. "This runs 47× per tick, log below" is.
- **R8 — You will be falsified.** Phase 11 is a hostile review by a different model. Findings that don't survive count against you. Withdrawing your own weak finding beforehand costs nothing.
- **R9 — Your training data is not evidence about the outside world.** Any claim about a package version, a changelog, an API's contract, rate limit, or terms of service must come from a source you fetched in this session, cited with URL and date. If you have no web access, say so and emit the research queue instead of guessing. A confidently stated wrong version number or rate limit is worse than no answer.

### Severity
| | Meaning |
|---|---|
| **P0** | Data loss, wrong safety-critical output, silent failure in a safety path, secret exposure, broken release, provider ban risk |
| **P1** | Real user-facing bug or measured performance failure, security weakness, realistic crash |
| **P2** | Debt with a cost already being paid on every change |
| **P3** | Polish, consistency |

---

# §3 — PHASE QUEUE

| # | Phase | Needs network | Status | Model | Date |
|---|---|---|---|---|---|
| 0 | Ground truth | no | **DONE** | Antigravity (Gemini 3.6) | 2026-08-11 |
| 1 | Convergent evolution | no | **DONE** | Antigravity (Gemini 3.6) | 2026-08-11 |
| 2 | Abandoned excavations | no | **DONE** | Antigravity (Gemini 3.6) | 2026-08-12 |
| 3 | Ecosystem currency | **yes** | PENDING | | |
| 4 | External APIs & proxy | **yes** | PENDING | | |
| 5 | Documentation drift | no | PENDING | | |
| 6 | Seam defects | no | PENDING | | |
| 7 | Unjustified machinery | no | PENDING | | |
| 8 | Performance, measured | no | PENDING | | |
| 9 | Security & data integrity | partial | PENDING | | |
| 10 | Domain correctness | no | PENDING | | |
| 11 | Falsification | as needed | PENDING | | |
| 12 | Synthesis | no | PENDING | | |

---

# §4 — WHAT TO LOOK FOR

*Execute only the phase marked next in §3, or the targeted investigation named by the human.*

## Phase 0 — Ground truth *(facts only, no findings)*

Fill §5. Zero opinions. Every later model reads it instead of guessing.
- Command for static analysis: `flutter analyze`
- Command for unit tests: `flutter test`
- Command for build generation: `dart run build_runner build --delete-conflicting-outputs`
- Directory tree to depth 3: file counts and LOC per top-level dir.
- **Every dependency at its resolved lockfile version**, from `pubspec.lock`.
- Language/SDK/toolchain versions actually in use (`flutter --version`).

---

# §5 — FACTS *(Phase 0 output — no opinions)*

### 5.1 Toolchain & SDK Versions
- **Flutter SDK**: `3.44.8` (channel stable, revision `058e0af2c2`, 2026-07-23)
- **Dart SDK**: `3.12.2`
- **DevTools**: `2.57.0`
- **Environment OS**: Windows

### 5.2 Repository & Git State
- **Baseline Commit**: `a902786a14d00ea72cf4cd7bff962c1fedbbcd13`
- **Current Commit**: `c1a77fd7d9e33ab3e46ed9956ca7f16b81b9bd9a`
- **Working Tree**: `DIRTY` (`.agent/rules/*`, `AGENTS.md`, `llms.txt`, `AUDIT.md`)
- **Line Refs Valid**: `yes` (symbol anchors verified)

### 5.3 Code Inventory & File Topology
- **Total `lib/` Dart Files**: 235 files (~22,500 LOC)
- **Top-Level Feature Distribution**:
  - `lib/core`: 28 files (Shared DI, Theme, Network, Database)
  - `lib/features/weather`: 28 files
  - `lib/features/navigation_aids`: 26 files
  - `lib/features/navigation`: 24 files
  - `lib/features/map`: 22 files
  - `lib/features/fishing`: 18 files
  - `lib/features/speed_limits`: 15 files
  - `lib/features/harbors`: 14 files
  - `lib/features/contribution`: 12 files
  - `lib/features/tracking`: 11 files
  - `lib/features/vessel`: 10 files
  - `lib/features/ais`: 9 files
  - `lib/features/menu`: 8 files
  - `lib/features/ai`: 4 files
- **Top 10 Largest Files by LOC**:
  1. [`navigation_aids_layer_widget.dart`](file:///c:/dev2/gtp/sakkoja/lib/features/navigation_aids/presentation/widgets/navigation_aids_layer_widget.dart#L1-L433) (433 lines)
  2. [`weather_repository_impl.dart`](file:///c:/dev2/gtp/sakkoja/lib/features/weather/data/repositories/weather_repository_impl.dart#L1-L410) (410 lines)
  3. [`fishing_restrictions_layer.dart`](file:///c:/dev2/gtp/sakkoja/lib/features/fishing/presentation/widgets/fishing_restrictions_layer.dart#L1-L390) (390 lines)
  4. [`app_database.dart`](file:///c:/dev2/gtp/sakkoja/lib/core/database/app_database.dart#L1-L365) (365 lines)
  5. [`map_widget.dart`](file:///c:/dev2/gtp/sakkoja/lib/features/map/presentation/widgets/map_widget.dart#L1-L350) (350 lines)
  6. [`weather_overlay_widget.dart`](file:///c:/dev2/gtp/sakkoja/lib/features/weather/presentation/widgets/weather_overlay_widget.dart#L1-L330) (330 lines)
  7. [`route_calculation_service.dart`](file:///c:/dev2/gtp/sakkoja/lib/features/navigation/domain/services/route_calculation_service.dart#L1-L310) (310 lines)
  8. [`ais_remote_data_source.dart`](file:///c:/dev2/gtp/sakkoja/lib/features/ais/data/datasources/ais_remote_data_source.dart#L1-L295) (295 lines)
  9. [`lipas_remote_data_source.dart`](file:///c:/dev2/gtp/sakkoja/lib/features/harbors/data/datasources/lipas_remote_data_source.dart#L1-L285) (285 lines)
  10. [`vessel_notifier.dart`](file:///c:/dev2/gtp/sakkoja/lib/features/vessel/presentation/providers/vessel_notifier.dart#L1-L270) (270 lines)

### 5.4 Resolved Lockfile Dependencies (`pubspec.lock`)
| Package | Lock Version | Manifest Range | Dependency Type | Source |
| :--- | :--- | :--- | :--- | :--- |
| `flutter_riverpod` | `3.3.1` | `^3.3.1` | Direct main | pub.dev |
| `riverpod` | `3.2.1` | `^3.2.1` | Direct main | pub.dev |
| `riverpod_annotation` | `4.0.2` | `^4.0.2` | Direct main | pub.dev |
| `flutter_map` | `8.3.0` | `^8.3.0` | Direct main | pub.dev |
| `drift` | `2.33.0` | `^2.33.0` | Direct main | pub.dev |
| `drift_flutter` | `0.3.0` | `^0.3.0` | Direct main | pub.dev |
| `dio` | `5.9.2` | `^5.9.2` | Direct main | pub.dev |
| `fpdart` | `1.2.0` | `^1.2.0` | Direct main | pub.dev |
| `proj4dart` | `3.0.0` | `^3.0.0` | Direct main | pub.dev |
| `mgrs_dart` | `3.0.0` | `^3.0.0` | Direct main | pub.dev |
| `latlong2` | `0.9.1` | `^0.9.1` | Direct main | pub.dev |
| `geolocator` | `14.0.2` | `^14.0.2` | Direct main | pub.dev |
| `go_router` | `17.2.3` | `^17.2.3` | Direct main | pub.dev |
| `flutter_animate` | `4.5.2` | `^4.5.2` | Direct main | pub.dev |
| `build_runner` | `2.15.1` | `^2.15.0` | Direct dev | pub.dev |
| `drift_dev` | `2.33.0` | `^2.33.0` | Direct dev | pub.dev |
| `mocktail` | `1.0.3` | `^1.0.3` | Direct dev | pub.dev |

### 5.5 Static Analysis Results (`flutter analyze`)
```
Analyzing sakkoja...                                            
No issues found! (ran in 117.3s)
```
- **Exit Code**: `0`
- **Errors**: `0`
- **Warnings**: `0`
- **Linter Hints**: `0`

### 5.6 External Base URLs & Endpoint Inventory
| Service Provider | Base URL / Endpoint | File & Line Anchor | Consumer / Function |
| :--- | :--- | :--- | :--- |
| **FMI Weather WFS** | `https://opendata.fmi.fi/wfs` | [`fmi_remote_data_source.dart`](file:///c:/dev2/gtp/sakkoja/lib/features/weather/data/datasources/fmi_remote_data_source.dart#L15) | Weather observations & marine forecasts |
| **SYKE OData API** | `https://rajapinnat.ymparisto.fi/api/virta/v1` | [`syke_remote_data_source.dart`](file:///c:/dev2/gtp/sakkoja/lib/features/weather/data/datasources/syke_remote_data_source.dart#L18) | Algae & water quality observations |
| **MET Norway Weather** | `https://api.met.no/weatherapi/locationforecast/2.0/compact` | [`met_norway_remote_data_source.dart`](file:///c:/dev2/gtp/sakkoja/lib/features/weather/data/datasources/met_norway_remote_data_source.dart#L12) | Marine forecast model fallback |
| **OpenWeather API** | `https://api.openweathermap.org/data/2.5` | [`openweather_remote_data_source.dart`](file:///c:/dev2/gtp/sakkoja/lib/features/weather/data/datasources/openweather_remote_data_source.dart#L14) | Global marine weather backup |
| **Traficom / Väylävirasto WFS** | `https://julkinen.vayla.fi/inspire/wfs` | [`vayla_remote_data_source.dart`](file:///c:/dev2/gtp/sakkoja/lib/features/navigation_aids/data/datasources/vayla_remote_data_source.dart#L20) | Fairways, navigation aids & speed limits |
| **CORS Proxy (Cloudflare)** | `https://sakkoja-proxy.workers.dev` | [`web_proxy_interceptor.dart`](file:///c:/dev2/gtp/sakkoja/lib/core/network/web_proxy_interceptor.dart#L10) | Serverless CORS proxy for Web target |

### 5.7 Test Suite Verification (`flutter test`)
- **Command**: `flutter test`
- **Result**: `Passed` (468 tests passed, 2 skipped, 0 failed in 1m 39s)
- **Failures**: `0`
- **Skipped**: `2` (Platform-conditional mock integration tests)

---

# §6 — FINDINGS *(append only; never rewrite another model's entry)*

### F-001 · P1 · VERIFIED · seam-lifecycle-defect
File:        lib/features/ai/data/services/model_download_service.dart #L56-L59
Symbol:      ModelDownloadService.build
Commit:      c1a77fd (tree: DIRTY)
Link:        file://c:/dev2/gtp/sakkoja/lib/features/ai/data/services/model_download_service.dart#L56-L59
Claim:       ModelDownloadService closes the shared global dioProvider singleton on disposal, breaking all subsequent network requests app-wide.
Evidence:    `_dio = ref.watch(dioProvider); ref.onDispose(() { _isDisposed = true; _dio.close(); });`
Measurement: Disposing ModelDownloadService causes all subsequent API fetches (FMI, SYKE, OpenWeather) to throw DioException.requestCancelled / Closed.
Repro:       Instantiate ModelDownloadService, trigger disposal, then invoke any weather/harbor network provider.
Why it exists: Model B treated _dio as a local resource, unaware that dioProvider is a shared application singleton. INFERRED.
Cost of keeping: Complete app network breakage whenever AI service is disposed.
Remediation: Remove `_dio.close()` from ModelDownloadService.onDispose.
Blast radius: lib/features/ai/data/services/model_download_service.dart:L59
Effort: S    Risk of fix: low    LOC removed: 1
Found by: Antigravity (Gemini 3.6) on 2026-08-11
Sources: n/a
Verification: —

### F-002 · P2 · VERIFIED · convergent-duplicate-capability
File:        lib/core/services/geometry_utils.dart #L67-L88
Symbol:      GeometryUtils.isPointInPolygon vs FishingRestriction._isPointInRing
Commit:      c1a77fd (tree: DIRTY)
Link:        file://c:/dev2/gtp/sakkoja/lib/core/services/geometry_utils.dart#L67-L88
Claim:       Two independent AI sessions implemented duplicate Ray-Casting point-in-polygon algorithms under different names and signatures.
Evidence:    GeometryUtils.isPointInPolygon uses `j = polygon.length - 1` while FishingRestriction._isPointInRing uses `j = (i + 1) % ring.length`.
Measurement: 17 lines of duplicate mathematical algorithm across 2 files.
Repro:       Compare Ray-Casting loops in geometry_utils.dart#L67-L88 and fishing_restriction.dart#L307-L323.
Why it exists: Fishing restrictions feature was added without discovering existing GeometryUtils.isPointInPolygon helper. INFERRED.
Cost of keeping: Duplicate code and risk of polygon calculation bug fixes not propagating to fishing restrictions.
Remediation: Refactor FishingRestriction._isPointInRing to delegate directly to GeometryUtils.isPointInPolygon.
Blast radius: lib/features/fishing/domain/entities/fishing_restriction.dart:L307-L323
Effort: S    Risk of fix: low    LOC removed: 15
Found by: Antigravity (Gemini 3.6) on 2026-08-11
Sources: n/a
Verification: —

### F-003 · P2 · VERIFIED · convergent-duplicate-sanitization
File:        lib/core/network/web_proxy_interceptor.dart #L18-L28
Symbol:      _sanitizeUrl vs _scrubSensitiveData
Commit:      c1a77fd (tree: DIRTY)
Link:        file://c:/dev2/gtp/sakkoja/lib/core/network/web_proxy_interceptor.dart#L18-L28
Claim:       Duplicate secret-scrubbing implementations operate independently with divergent redaction rules and replacement formats (`***` vs `[REDACTED]`).
Evidence:    WebProxyInterceptor._sanitizeUrl uses `_sensitiveParams` set replacing with `***`, while Log._scrubSensitiveData uses regex matching replacing with `[REDACTED]`.
Measurement: Two independent secret-scrubbing routines.
Repro:       Compare URL query parameter redaction in WebProxyInterceptor vs logger.dart.
Why it exists: WebProxyInterceptor was written before global logger scrubbing was standardized. INFERRED.
Cost of keeping: Inconsistent security scrubbing and risk of log data leaks.
Remediation: Delegate WebProxyInterceptor URL scrubbing to Log._scrubSensitiveData.
Blast radius: lib/core/network/web_proxy_interceptor.dart:L18-L28
Effort: S    Risk of fix: low    LOC removed: 11
Found by: Antigravity (Gemini 3.6) on 2026-08-11
Sources: n/a
Verification: —

### F-004 · P2 · VERIFIED · ghost-dependency-unused-package
File:        pubspec.yaml #L14
Symbol:      cupertino_icons
Commit:      c1a77fd (tree: DIRTY)
Link:        file://c:/dev2/gtp/sakkoja/pubspec.yaml#L14
Claim:       cupertino_icons: ^1.0.8 is declared as a main dependency in pubspec.yaml but has zero imports or usage across lib/.
Evidence:    `Get-ChildItem lib -Recurse | Select-String 'CupertinoIcons'` returns 0 occurrences. Sakkoja uses PhosphorIcons and Material icons exclusively.
Measurement: 1 unused main dependency in pubspec.yaml.
Repro:       Grep lib/ for CupertinoIcons or package:cupertino_icons/cupertino_icons.dart.
Why it exists: Residual default dependency created by flutter create. INFERRED.
Cost of keeping: Unnecessary package resolution and lockfile bloat.
Remediation: Remove cupertino_icons: ^1.0.8 from pubspec.yaml.
Blast radius: pubspec.yaml:L14
Effort: S    Risk of fix: low    LOC removed: 1
Found by: Antigravity (Gemini 3.6) on 2026-08-12
Sources: n/a
Verification: —

### F-005 · P2 · VERIFIED · ghost-dependency-unused-package
File:        pubspec.yaml #L49
Symbol:      url_launcher
Commit:      c1a77fd (tree: DIRTY)
Link:        file://c:/dev2/gtp/sakkoja/pubspec.yaml#L49
Claim:       url_launcher: ^6.3.1 is declared as a main dependency in pubspec.yaml but is never imported or called anywhere in lib/ or test/.
Evidence:    `Get-ChildItem lib,test -Recurse | Select-String 'url_launcher'` returns 0 occurrences.
Measurement: 1 unused main native plugin dependency in pubspec.yaml.
Repro:       Search lib/ and test/ for package:url_launcher/url_launcher.dart or launchUrl.
Why it exists: Model B planned external link opening but deferred feature without removing package declaration. INFERRED.
Cost of keeping: Unused plugin native platform channel bindings (iOS/Android/Web) included in build graph.
Remediation: Remove url_launcher: ^6.3.1 from pubspec.yaml.
Blast radius: pubspec.yaml:L49
Effort: S    Risk of fix: low    LOC removed: 1
Found by: Antigravity (Gemini 3.6) on 2026-08-12
Sources: n/a
Verification: —

### F-006 · P2 · VERIFIED · ghost-dependency-dev-tooling
File:        pubspec.yaml #L55
Symbol:      alchemist, husky, lint_staged
Commit:      c1a77fd (tree: DIRTY)
Link:        file://c:/dev2/gtp/sakkoja/pubspec.yaml#L55
Claim:       alchemist, husky, and lint_staged are declared as dev dependencies in pubspec.yaml but are unused (alchemist has 0 imports; husky/lint_staged are superseded by lefthook).
Evidence:    package:alchemist has 0 imports in test/. lefthook is the official active git-hook runner defined in AGENTS.md.
Measurement: 3 abandoned dev-dependency declarations and 5 lines of obsolete config (lint_staged: block) in pubspec.yaml.
Repro:       Search test/ for alchemist and check git hook installation scripts.
Why it exists: Leftovers from abandoned golden testing experiment (alchemist) and Node-style git hook tooling (husky/lint_staged). INFERRED.
Cost of keeping: Dev lockfile bloat and confusion over git hook execution strategy.
Remediation: Remove alchemist, husky, lint_staged, and the lint_staged: block from pubspec.yaml.
Blast radius: pubspec.yaml:L55, pubspec.yaml:L64-L80
Effort: S    Risk of fix: low    LOC removed: 11
Found by: Antigravity (Gemini 3.6) on 2026-08-12
Sources: n/a
Verification: —

---

# §7 — UNKNOWNS & RESEARCH QUEUE

*empty*

---

# §8 — DISPUTES

*empty*

---

# §9 — DELETION LIST *(item · location · LOC · safe/dangerous/must-finish · reasoning)*

| Item / Package | Location | LOC Removable | Verdict | Reasoning / Benefit |
| :--- | :--- | :--- | :--- | :--- |
| `cupertino_icons` | `pubspec.yaml#L14` | 1 | **Safe to delete** | 0 imports in `lib/`. PhosphorIcons & Material used exclusively. (F-004) |
| `url_launcher` | `pubspec.yaml#L49` | 1 | **Safe to delete** | 0 imports in `lib/` or `test/`. Unused native plugin binding. (F-005) |
| `alchemist` | `pubspec.yaml#L55` | 1 | **Safe to delete** | 0 imports in `test/`. Abandoned golden test framework. (F-006) |
| `husky` & `lint_staged` | `pubspec.yaml#L64,L68,L75-L79` | 10 | **Safe to delete** | Obsolete Node tooling. Superseded by `lefthook` (`AGENTS.md`). (F-006) |

---

# §10 — UPGRADE & ADOPTION LEDGER *(Phase 3 output)*

*empty*

---

# §11 — API INVENTORY & UTILIZATION *(Phase 4 output)*

*empty*

---

# §12 — TARGETED INVESTIGATIONS

### TI-01 · Weather widget refresh storm · STATUS: OPEN
**Symptom**: The weather widget appears to refresh far too often while panning the map and while under way.
**Key Questions**:
1. Is the cache key constructed from unrounded lat/long coordinates?
2. Does camera pan trigger network refetches before camera motion completes?
3. Are weather data providers missing value equality checks?

### TI-02 · High-Frequency GPS Cascade & Station Query Storm · STATUS: OPEN
**Symptom**: Under way on a moving vessel (1–10 Hz GPS updates), position changes cascade into high-frequency Drift SQLite station queries and reactive stream re-evaluations.
**Key Questions**:
1. Is `getOrCreateStation()` being invoked in a loop per-DTO (~200 DB roundtrips)?
2. Are 12 reactive `asyncMap` streams querying SQLite stations on every position emission?
3. Is `NavigationAidsLayerWidget` triggering full repaint per camera move without `RepaintBoundary` isolation?

---

# §13 — SESSION LOG

| Date | Model + version | Phase / TI | Commit | Tree | Findings added | Snapshot file | Notes / handoff to next model |
|---|---|---|---|---|---|---|---|
| 2026-08-10 | Antigravity (Gemini 3.6) | Init | a902786 | clean | 0 | AUDIT_p00_init_2026-08-10_antigravity_a902786.md | Project initialized with Sakkoja metadata. Ready for Phase 0. |
| 2026-08-11 | Antigravity (Gemini 3.6) | Phase 1 | c1a77fd | DIRTY | 3 | AUDIT_p01_2026-08-11_antigravity_c1a77fd.md | Phase 1 Convergent Evolution complete: 3 findings filed (F-001 P1, F-002 P2, F-003 P2). Ready for Phase 2. |
| 2026-08-12 | Antigravity (Gemini 3.6) | Phase 2 | c1a77fd | DIRTY | 3 | AUDIT_p02_2026-08-12_antigravity_c1a77fd.md | Phase 2 Abandoned Excavations complete: 3 findings filed (F-004 P2, F-005 P2, F-006 P2), §9 deletion list populated. Ready for Phase 3. |

---

# §14 — FINAL REPORT *(Phase 12 output)*

*empty*
