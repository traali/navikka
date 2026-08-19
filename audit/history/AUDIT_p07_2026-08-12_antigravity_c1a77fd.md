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

Last session:       2026-08-12 (Phase 7 — Unjustified machinery)
Last model:         Antigravity Agent (Gemini 3.6 Flash)
Last snapshot file: audit/history/AUDIT_p07_2026-08-12_antigravity_c1a77fd.md
Phases complete:    8 / 13
Findings so far:    16  (P0: 0 · P1: 4 · P2: 11 · P3: 1)
Open investigations: TI-01 (Weather widget refresh storm) · TI-02 (GPS Cascade & Station Query Storm)
File integrity:     lines: 1090 · findings: 16
Next action:        Execute Phase 8 (Performance, measured).
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
| 3 | Ecosystem currency | **yes** | **DONE** | Antigravity (Gemini 3.6) | 2026-08-12 |
| 4 | External APIs & proxy | **yes** | **DONE** | Antigravity (Gemini 3.6) | 2026-08-12 |
| 5 | Documentation drift | no | **DONE** | Antigravity (Gemini 3.6) | 2026-08-12 |
| 6 | Seam defects | no | **DONE** | Antigravity (Gemini 3.6) | 2026-08-12 |
| 7 | Unjustified machinery | no | **DONE** | Antigravity (Gemini 3.6) | 2026-08-12 |
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

### F-007 · P2 · VERIFIED · adoption-gap-hand-rolled-retry
File:        lib/features/weather/data/repositories/weather_repository_impl.dart #L120-L155
Symbol:      WeatherRepositoryImpl._retrySync
Commit:      c1a77fd (tree: DIRTY)
Link:        file://c:/dev2/gtp/sakkoja/lib/features/weather/data/repositories/weather_repository_impl.dart#L120-L155
Claim:       Hand-rolled retry/backoff logic in WeatherRepositoryImpl duplicates dio_smart_retry (RetryInterceptor) capability already configured in dioProvider.
Evidence:    core_providers.dart#L95-L104 configures RetryInterceptor with exponential backoff ([1s, 2s, 4s]), while WeatherRepositoryImpl hand-rolls custom Future.delayed retries.
Measurement: 35 lines of hand-rolled retry boilerplate that bypasses Dio's central error handling interceptor chain.
Repro:       Inspect WeatherRepositoryImpl._retrySync vs core_providers.dart#L95-L104.
Why it exists: Model B wrote custom retry loops in repository code before RetryInterceptor was added to dioProvider. INFERRED.
Cost of keeping: Duplicate retry loops multiplying request attempts up to 9x on network failure (3 repo retries x 3 Dio retries).
Remediation: Delegate retries entirely to RetryInterceptor in dioProvider and remove WeatherRepositoryImpl._retrySync.
Blast radius: lib/features/weather/data/repositories/weather_repository_impl.dart:L120-L155
Effort: S    Risk of fix: low    LOC removed: 35
Found by: Antigravity (Gemini 3.6) on 2026-08-12
Sources: https://pub.dev/packages/dio_smart_retry (2026-04-10)
Verification: —

### F-008 · P1 · VERIFIED · api-proxy-cors-header-duplication
File:        cloudflare-worker/src/index.js #L202-L212
Symbol:      default.fetch
Commit:      c1a77fd (tree: DIRTY)
Link:        file://c:/dev2/gtp/sakkoja/cloudflare-worker/src/index.js#L202-L212
Claim:       Cloudflare CORS proxy worker copies all upstream response headers verbatim (headers: proxyResponse.headers) before setting Access-Control-Allow-Origin, causing duplicate CORS headers that browsers reject.
Evidence:    index.js#L202-L212: `const response = new Response(proxyResponse.body, { status: proxyResponse.status, statusText: proxyResponse.statusText, headers: proxyResponse.headers }); response.headers.set('Access-Control-Allow-Origin', origin);`
Measurement: Web client request failures when proxying requests to upstream servers returning native Access-Control-Allow-Origin headers.
Repro:       Fetch a target URL via proxy that returns Access-Control-Allow-Origin: * in a web browser.
Why it exists: Proxy worker did not filter out upstream Access-Control-* headers prior to appending proxy CORS headers. INFERRED.
Cost of keeping: Intermittent web client CORS blockages.
Remediation: Strip Access-Control-Allow-Origin, Access-Control-Allow-Methods, and Access-Control-Allow-Headers from proxyResponse.headers before instantiating client Response.
Blast radius: cloudflare-worker/src/index.js:L202-L212
Effort: S    Risk of fix: low    LOC removed: 2
Found by: Antigravity (Gemini 3.6) on 2026-08-12
Sources: n/a
Verification: —

### F-009 · P2 · VERIFIED · api-proxy-wildcard-origin-leak
File:        cloudflare-worker/src/index.js #L84-L92
Symbol:      errorResponse
Commit:      c1a77fd (tree: DIRTY)
Link:        file://c:/dev2/gtp/sakkoja/cloudflare-worker/src/index.js#L84-L92
Claim:       errorResponse helper defaults origin to '*' when omitted (e.g. on method validation failures at L131), exposing error response payloads to arbitrary origins.
Evidence:    `function errorResponse(message, status = 403, origin = '*')` used at L131: `return errorResponse('Method not allowed', 405);`.
Measurement: Open CORS header (*) returned on proxy error responses regardless of caller origin.
Repro:       Send an HTTP POST request with an unallowed Origin header to proxy worker.
Why it exists: Default wildcard parameter was left in error helper scaffolding. INFERRED.
Cost of keeping: Permissive CORS header leaks on proxy error responses.
Remediation: Change default origin parameter in errorResponse to empty string or sanitize origin before response creation.
Blast radius: cloudflare-worker/src/index.js:L84-L92
Effort: S    Risk of fix: low    LOC removed: 1
Found by: Antigravity (Gemini 3.6) on 2026-08-12
Sources: n/a
Verification: —

### F-010 · P2 · VERIFIED · doc-drift-obsolete-storage-engine
File:        PROJECT_DOCUMENTATION.md #L36
Symbol:      Storage Strategy Documentation
Commit:      c1a77fd (tree: DIRTY)
Link:        file://c:/dev2/gtp/sakkoja/PROJECT_DOCUMENTATION.md#L36
Claim:       PROJECT_DOCUMENTATION.md documents Sembast as the active local database engine and claims web persistence is blocked on sembast_web.
Evidence:    PROJECT_DOCUMENTATION.md L36 ("Local caching of vector data (Sembast)"), L43 ("sembast_io hangs on web"), L59 ("Replace Hive with Sembast"). In reality, Sembast was completely replaced by drift (SQLite via sqlite3 and drift_flutter WASM).
Measurement: 3 documented sections claiming obsolete Sembast storage strategy.
Repro:       Read PROJECT_DOCUMENTATION.md#L36-L59 vs pubspec.yaml and lib/core/database/app_database.dart.
Why it exists: PROJECT_DOCUMENTATION.md was last updated in Dec 2025 (2025-12-23) and was not updated during the Drift SQLite migration. INFERRED.
Cost of keeping: Confuses developers and AI agents reading legacy documentation context.
Remediation: Update PROJECT_DOCUMENTATION.md storage section to document Drift (SQLite).
Blast radius: PROJECT_DOCUMENTATION.md:L36-L60
Effort: S    Risk of fix: low    LOC removed: 0
Found by: Antigravity (Gemini 3.6) on 2026-08-12
Sources: n/a
Verification: —

### F-011 · P2 · VERIFIED · doc-drift-deployment-status
File:        PROJECT_DOCUMENTATION.md #L20
Symbol:      Deployment Status Documentation
Commit:      c1a77fd (tree: DIRTY)
Link:        file://c:/dev2/gtp/sakkoja/PROJECT_DOCUMENTATION.md#L20
Claim:       PROJECT_DOCUMENTATION.md claims Web deployment is "Not yet deployed; relies on local dev proxy for API CORS" and lists Web as "Alpha / Local Development only".
Evidence:    Sakkoja is live on Cloudflare Pages (https://sakkoja.pages.dev) with automated CI deployment scripts (scripts/build_web.ps1) and Cloudflare Worker proxy (https://sakkoja-proxy.workers.dev). Both README.md#L4 and AGENTS.md#L31 confirm production live status.
Measurement: 2 documentation sections incorrectly stating web is undeployed local dev only.
Repro:       Compare PROJECT_DOCUMENTATION.md#L20,L44 vs README.md#L4.
Why it exists: PROJECT_DOCUMENTATION.md predates Cloudflare Pages CI pipeline setup. INFERRED.
Cost of keeping: Incorrect deployment status in documentation.
Remediation: Update PROJECT_DOCUMENTATION.md web deployment section to reflect Cloudflare Pages live production status.
Blast radius: PROJECT_DOCUMENTATION.md:L20-L45
Effort: S    Risk of fix: low    LOC removed: 0
Found by: Antigravity (Gemini 3.6) on 2026-08-12
Sources: n/a
Verification: —

### F-012 · P3 · VERIFIED · doc-drift-directory-structure
File:        ARCHITECTURE.md #L13
Symbol:      Directory Structure Diagram
Commit:      c1a77fd (tree: DIRTY)
Link:        file://c:/dev2/gtp/sakkoja/ARCHITECTURE.md#L13
Claim:       ARCHITECTURE.md directory tree lists core/db/ for Drift database definitions.
Evidence:    In reality, the database is located at lib/core/database/app_database.dart, not core/db/.
Measurement: 1 path mismatch in ARCHITECTURE.md directory tree diagram.
Repro:       Compare ARCHITECTURE.md#L13 tree with actual lib/core/ folder topology (lib/core/database).
Why it exists: Database folder was renamed from db to database during clean architecture alignment. INFERRED.
Cost of keeping: Minor confusion when following architecture directory diagrams.
Remediation: Update ARCHITECTURE.md#L13 from core/db/ to core/database/.
Blast radius: ARCHITECTURE.md:L13
Effort: S    Risk of fix: low    LOC removed: 0
Found by: Antigravity (Gemini 3.6) on 2026-08-12
Sources: n/a
Verification: —

### F-013 · P1 · VERIFIED · seam-lifecycle-duplicated-listeners
File:        lib/features/ais/presentation/providers/ais_targets_provider.dart #L22-L33
Symbol:      AisTargetsNotifier.build, PointWeatherSyncController.build
Commit:      c1a77fd (tree: DIRTY)
Link:        file://c:/dev2/gtp/sakkoja/lib/features/ais/presentation/providers/ais_targets_provider.dart#L22-L33
Claim:       Placing ref.listen inside provider build() methods registers duplicate callbacks on every provider re-build/invalidation without disposing prior listeners.
Evidence:    AisTargetsNotifier.build calls ref.listen(significantMapCameraPositionProvider) at L22 and PointWeatherSyncController.build calls ref.listen(...) 3 times at L79, L88, L104. In Riverpod, ref.listen within build() persists for the provider's lifetime. If build() re-runs on invalidation, duplicate listeners accumulate and fire multiple parallel requests for the same event.
Measurement: Accumulation of N duplicate listeners per provider invalidation cycle.
Repro:       Trigger ref.invalidate(aisTargetsNotifierProvider) and observe camera position change callback executing N times.
Why it exists: Model B treated ref.listen inside Riverpod build() as a one-time widget-like listener without considering provider rebuild lifecycles. INFERRED.
Cost of keeping: Exponentially multiplying listener triggers and redundant API/DB calls during vessel navigation.
Remediation: Use ref.listen inside widget lifecycle methods (WidgetRef.listen) or convert dependency observation to reactive ref.watch in state getters.
Blast radius: lib/features/ais/presentation/providers/ais_targets_provider.dart:L22-L33, lib/features/weather/presentation/controllers/point_weather_sync_controller.dart:L79-L110
Effort: M    Risk of fix: medium    LOC removed: 15
Found by: Antigravity (Gemini 3.6) on 2026-08-12
Sources: n/a
Verification: —

### F-014 · P1 · VERIFIED · seam-error-swallowing-empty-list
File:        lib/features/navigation_aids/presentation/providers/navigation_aids_providers.dart #L44-L64
Symbol:      HybridFairwayAreas.build, HybridNavigationAids.build
Commit:      c1a77fd (tree: DIRTY)
Link:        file://c:/dev2/gtp/sakkoja/lib/features/navigation_aids/presentation/providers/navigation_aids_providers.dart#L44-L64
Claim:       Navigation aid providers swallow repository Failure results with result.fold((f) => [], (data) => data), returning empty lists [] that make downstream UI render no safety markers with zero error UI.
Evidence:    HybridFairwayAreas (L44-L47) and HybridNavigationAids (L61-L64) return [] when getFairwayAreas() or getNavigationAids() returns Left(Failure). Riverpod wraps this in AsyncValue.data([]) instead of AsyncValue.error(), preventing the UI from knowing data loading failed.
Measurement: Complete masking of SQLite database errors and network failures in safety-critical navigation aid layers.
Repro:       Simulate a database read failure in navigationAidsRepositoryProvider.getNavigationAids() and observe UI rendering empty map layer instead of error state.
Why it exists: Model B used defensive fallback return [] to avoid UI crashes, breaking clean architecture error propagation contracts. INFERRED.
Cost of keeping: Skippers navigate without buoys/beacons thinking no aids exist in the area when DB/API actually failed.
Remediation: Throw or rethrow exception / return AsyncValue.error so Riverpod surfaces error state to UI error handlers.
Blast radius: lib/features/navigation_aids/presentation/providers/navigation_aids_providers.dart:L44-L64
Effort: S    Risk of fix: low    LOC removed: 6
Found by: Antigravity (Gemini 3.6) on 2026-08-12
Sources: n/a
Verification: —

### F-015 · P2 · VERIFIED · machinery-stubbed-interceptor
File:        lib/core/network/replay_interceptor.dart #L32-L95
Symbol:      ReplayInterceptor
Commit:      c1a77fd (tree: DIRTY)
Link:        file://c:/dev2/gtp/sakkoja/lib/core/network/replay_interceptor.dart#L32-L95
Claim:       ReplayInterceptor is a 96-line stubbed prototype interceptor registered into production dioProvider that only prints log messages without loading or saving actual fixtures.
Evidence:    L36-37 ("For this prototype, we log the recording to console"), L59-61 ("For now, we continue to allow dev to see it failing if missing"). It provides no functional mocking capability while adding 96 lines of dead code and duplicate secret-scrubbing logic (_sanitizeUrl). Registered in core_providers.dart#L106.
Measurement: 96 LOC of unused interceptor overhead executed on every HTTP request pass.
Repro:       Inspect ReplayInterceptor.onRequest and ReplayInterceptor.onResponse.
Why it exists: Model B started writing a record/replay network mock for unit testing but left the prototype unfinished in production Dio interceptor chain. INFERRED.
Cost of keeping: Unnecessary request processing overhead and confusion over test fixture infrastructure.
Remediation: Remove ReplayInterceptor from core_providers.dart and delete replay_interceptor.dart.
Blast radius: lib/core/providers/core_providers.dart:L106, lib/core/network/replay_interceptor.dart
Effort: S    Risk of fix: low    LOC removed: 96
Found by: Antigravity (Gemini 3.6) on 2026-08-12
Sources: n/a
Verification: —

### F-016 · P2 · VERIFIED · machinery-over-engineered-persistence
File:        lib/core/network/rate_limit_interceptor.dart #L16-L72
Symbol:      RateLimitInterceptor._loadHistory, RateLimitInterceptor._schedulePersist
Commit:      c1a77fd (tree: DIRTY)
Link:        file://c:/dev2/gtp/sakkoja/lib/core/network/rate_limit_interceptor.dart#L16-L72
Claim:       RateLimitInterceptor over-engineers rate limiting by serializing transient 10-second request timestamp lists into SharedPreferences disk storage across application restarts.
Evidence:    L28-72 load, parse, serialize (toIso8601String), and save string lists to disk (_storageKeyPrefix + domain) using periodic timers (_persistTimer) and async save locks (_saveLockMap). Rate limiting for transient API calls (e.g. 10 requests per 10 seconds) does not require disk persistence across app restarts.
Measurement: 57 LOC of unnecessary disk persistence, JSON string serialization, and timer management for transient in-memory rate limiting.
Repro:       Inspect RateLimitInterceptor._loadHistory and RateLimitInterceptor._schedulePersist.
Why it exists: Model B attempted to prevent rate-limit bypass across quick app restarts, over-designing an in-memory queue with disk persistence. INFERRED.
Cost of keeping: Unnecessary disk I/O, SharedPreferences write churn, and code complexity.
Remediation: Remove disk persistence (_loadHistory, _schedulePersist, prefs, _saveLockMap) and keep request timestamps purely in memory.
Blast radius: lib/core/network/rate_limit_interceptor.dart:L16-L72
Effort: S    Risk of fix: low    LOC removed: 57
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
| `replay_interceptor.dart` | `lib/core/network/replay_interceptor.dart` | 96 | **Safe to delete** | Stubbed prototype interceptor in production Dio chain. (F-015) |

---

# §10 — UPGRADE & ADOPTION LEDGER *(Phase 3 output)*

**A. Version delta**

| Package | Ours (Lock) | Latest | Behind by | Breaking? | Advisory? | Verdict | Source + Date |
|---|---|---|---|---|---|---|---|
| `flutter_map` | `8.3.0` | `8.3.1` | 1 patch release | No | None | **Upgrade** (Polygon & Marker performance gains) | [pub.dev/packages/flutter_map/changelog](https://pub.dev/packages/flutter_map/changelog) (2026-06-30) |
| `dio` | `5.9.2` | `5.10.0` | 1 minor release | No | None | **Upgrade** (Interceptor stall fixes & memory opt) | [pub.dev/packages/dio/changelog](https://pub.dev/packages/dio/changelog) (2026-06-15) |
| `drift` | `2.33.0` | `2.33.0` | 0 releases | No | None | **Stay put** | [pub.dev/packages/drift/changelog](https://pub.dev/packages/drift/changelog) (2026-07-10) |
| `flutter_riverpod` | `3.3.1` | `3.3.1` | 0 releases | No | None | **Stay put** | [pub.dev/packages/flutter_riverpod/changelog](https://pub.dev/packages/flutter_riverpod/changelog) (2026-07-20) |
| `fpdart` | `1.2.0` | `1.2.0` | 0 releases | No | None | **Stay put** | [pub.dev/packages/fpdart/changelog](https://pub.dev/packages/fpdart/changelog) (2026-05-15) |

**B. Adoption gap — capability we already have and don't use** *(no version change; cheapest wins in the audit)*

| Capability | Available since | Where we hand-roll it | LOC removable | Behavioural difference | Source |
|---|---|---|---|---|---|
| `dio_smart_retry` exponential backoff | `dio_smart_retry 7.0.1` | [`weather_repository_impl.dart#L120-L155`](file:///c:/dev2/gtp/sakkoja/lib/features/weather/data/repositories/weather_repository_impl.dart#L120-L155) | 35 LOC | Dio interceptor handles retries uniformly without unhandled Future retries in repo layers. (F-007) | [pub.dev/packages/dio_smart_retry](https://pub.dev/packages/dio_smart_retry) (2026-04-10) |
| Native `flutter_map` Tile Cancellation | `flutter_map 8.2.0` | [`drift_tile_provider.dart#L140-L175`](file:///c:/dev2/gtp/sakkoja/lib/features/map/presentation/widgets/drift_tile_provider.dart#L140-L175) | 35 LOC | Native `TileLayer` cancels tile requests automatically on fast map pan without manual map tracking wrappers. | [pub.dev/packages/flutter_map/changelog](https://pub.dev/packages/flutter_map/changelog) (2025-07-11) |

**C. Upgrade to get**

| Package | Target | What we gain (concrete) | Migration cost | Value ÷ cost | Source |
|---|---|---|---|---|---|
| `flutter_map` | `8.3.1` | Caching projections in `MarkerLayer` & polygon hole rendering performance for restriction polygons | Low (`flutter pub upgrade flutter_map`) | **High** | [pub.dev/packages/flutter_map/changelog](https://pub.dev/packages/flutter_map/changelog) (2026-06-30) |
| `dio` | `5.10.0` | Fixes `QueuedInterceptor` stalling on cancelled requests and `ErrorInterceptorHandler.reject()` continuation | Low (`flutter pub upgrade dio`) | **High** | [pub.dev/packages/dio/changelog](https://pub.dev/packages/dio/changelog) (2026-06-15) |

**D. Deprecated in our code** — None identified in core SDK calls.

**E. Skip list** — `drift`: `2.33.0` stable is up-to-date. WASM experimental library (`package:drift/wasm.dart`) is not yet semver stable; stay on SQLite native/DriftWorker setup.

---

# §11 — API INVENTORY & UTILIZATION *(Phase 4 output)*

| Service Provider | Base URL / Endpoint | Protocol / Format | Auth / Key | Live Status | Rate Limit (Client vs Server) | Client DTO & Consumer | Notes & Vulnerabilities |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **FMI Weather WFS** | `https://opendata.fmi.fi/wfs` | WFS 2.0 (GML/XML) | Public / None | **200 OK** | Client: 200/5min<br>Server: None | `FmiWeatherDto`<br>[`fmi_weather_data_source.dart`](file:///c:/dev2/gtp/sakkoja/lib/features/weather/data/datasources/fmi_weather_data_source.dart#L15) | Verified live. Parses `timevaluepair` for marine weather stations. |
| **SYKE Vesla OData** | `https://rajapinnat.ymparisto.fi/api/vesla/2.0/odata` | OData v2.0 (JSON) | Public / None | **200 OK** | Client: 50/min<br>Server: 100-node limit | `WaterQualityDto`<br>[`syke_data_source.dart`](file:///c:/dev2/gtp/sakkoja/lib/features/weather/data/datasources/syke_data_source.dart#L78) | Verified live via `$metadata` and `Naytteenotto`. Filter uses `VedenlTulos` OR conditions. |
| **SYKE Citizen Obs** | `https://rajapinnat.ymparisto.fi/api/kansalaishavainnot/1.0` | Open311 (JSON) | Public / None | **200 OK** | Client: 50/min<br>Server: None | `AlgaeReportDto`<br>[`syke_data_source.dart`](file:///c:/dev2/gtp/sakkoja/lib/features/weather/data/datasources/syke_data_source.dart#L238) | Verified live with `service_code=hisp_algaebloom_service_code_202201051826208`. Handles Open311 extended attributes. |
| **MET Norway Weather** | `https://api.met.no/weatherapi/locationforecast/2.0/compact` | GeoJSON | Required User-Agent | **200 OK** | Client: 60/min<br>Server: Strict TOS | `MetNorwayDto`<br>[`met_norway_data_source.dart`](file:///c:/dev2/gtp/sakkoja/lib/features/weather/data/datasources/met_norway_data_source.dart#L12) | Verified live. Requires identifying User-Agent (`Sakkoja/1.1`). Fallback for FMI. |
| **OpenWeather API** | `https://api.openweathermap.org/data/2.5` | JSON | API Key (Env/Worker) | **200 OK** | Client: 55/60s<br>Server: 60/min free | `OpenWeatherDto`<br>[`openweather_data_source.dart`](file:///c:/dev2/gtp/sakkoja/lib/features/weather/data/datasources/openweather_data_source.dart#L14) | Verified live. Key injected by Cloudflare Worker for web build. |
| **Traficom / Väylävirasto** | `https://julkinen.vayla.fi/inspire/wfs` | WFS 2.0 (GML/XML) | Public / None | **200 OK** | Client: 100/min<br>Server: None | `NavAidDto`<br>[`vayla_remote_data_source.dart`](file:///c:/dev2/gtp/sakkoja/lib/features/navigation_aids/data/datasources/vayla_remote_data_source.dart#L20) | Fairways, navigation aids & speed limit features. |
| **Cloudflare CORS Proxy** | `https://sakkoja-proxy.workers.dev` | HTTP Proxy | `X-App-Auth` (Optional) | **200 OK** | Worker Edge | Proxy Worker<br>[`cloudflare-worker/src/index.js`](file:///c:/dev2/gtp/sakkoja/cloudflare-worker/src/index.js#L95) | CORS header duplication bug found (F-008 P1) and error origin leak (F-009 P2). |

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
| 2026-08-12 | Antigravity (Gemini 3.6) | Phase 3 | c1a77fd | DIRTY | 1 | AUDIT_p03_2026-08-12_antigravity_c1a77fd.md | Phase 3 Ecosystem Currency complete: live pub.dev research recorded, F-007 (P2) filed, §10 ledger fully populated (flutter_map 8.3.1 & dio 5.10.0 upgrade recommendations). Ready for Phase 4. |
| 2026-08-12 | Antigravity (Gemini 3.6) | Phase 4 | c1a77fd | DIRTY | 2 | AUDIT_p04_2026-08-12_antigravity_c1a77fd.md | Phase 4 External APIs & Proxy complete: all 6 external endpoints verified live, 2 findings filed (F-008 P1 CORS header duplication, F-009 P2 error origin leak), §11 API inventory populated. Ready for Phase 5. |
| 2026-08-12 | Antigravity (Gemini 3.6) | Phase 5 | c1a77fd | DIRTY | 3 | AUDIT_p05_2026-08-12_antigravity_c1a77fd.md | Phase 5 Documentation Drift complete: 3 findings filed (F-010 P2 obsolete Sembast doc, F-011 P2 undeployed web doc drift, F-012 P3 directory path mismatch). Ready for Phase 6. |
| 2026-08-12 | Antigravity (Gemini 3.6) | Phase 6 | c1a77fd | DIRTY | 2 | AUDIT_p06_2026-08-12_antigravity_c1a77fd.md | Phase 6 Seam Defects complete: 2 findings filed (F-013 P1 duplicated ref.listen in build(), F-014 P1 error swallowing with empty lists in nav aids). Ready for Phase 7. |
| 2026-08-12 | Antigravity (Gemini 3.6) | Phase 7 | c1a77fd | DIRTY | 2 | AUDIT_p07_2026-08-12_antigravity_c1a77fd.md | Phase 7 Unjustified Machinery complete: 2 findings filed (F-015 P2 stubbed ReplayInterceptor, F-016 P2 RateLimitInterceptor SharedPreferences persistence). Ready for Phase 8. |

---

# §14 — FINAL REPORT *(Phase 12 output)*

*empty*
