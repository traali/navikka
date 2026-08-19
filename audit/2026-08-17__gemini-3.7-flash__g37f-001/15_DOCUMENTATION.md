# DOCUMENTATION & KNOWLEDGE AUDIT — DOC

- **run_id:** g37f-001
- **date:** 2026-08-17
- **model:** Gemini 3.7 Flash
- **target:** Sakkoja Marine Safety Navigator @ 604ebd4
- **wave:** 1
- **findings_reported:** 3
- **candidates_discarded:** 12
- **examined:** `docs/` (`architecture.md`, `deployment_guide.md`, `developer_guide.md`, `user_guide.md`, `external_apis.md`, `decisions/*`), `README.md`, inline code docstrings, and environment templates.
- **not_examined:** External wiki pages or private repository issues.

---

### DOC-001 — User guide claims hands-free voice copilot while implementation is chip-triggered

- **Severity:** S3-Low
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `docs/user_guide.md:65-80`
- **Novel:** yes

**Mechanism.** `docs/user_guide.md` describes the Voice Copilot ("Hei Kippari / Hey Skipper") as a hands-free voice assistant that listens for spoken queries while steering. In the actual implementation (`lib/features/ai/presentation/widgets/voice_copilot_mic_button.dart`), the modal presents only clickable `ActionChip` buttons with pre-defined text options, because no live Speech-to-Text audio pipeline is connected.

**Evidence.**
```markdown
<!-- docs/user_guide.md -->
"Bilingual Hands-Free Voice Marine Copilot ('Hei Kippari' / 'Hey Skipper') provides real-time voice guidance while underway."
```
vs.
```dart
// lib/features/ai/presentation/widgets/voice_copilot_mic_button.dart:120-130
children: _quickCommands.map((cmd) {
  return ActionChip(
    label: Text(cmd),
    onPressed: () { ... }
```

**Trigger.** A user following the user guide expecting hands-free speech input during heavy seas.

**Impact.** Skipper confusion and distraction while attempting to speak to an app that only accepts button taps.

**Falsification.** Checked if speech recognition plugins (such as `speech_to_text`) are included in `pubspec.yaml`. No speech recognition plugin is present in dependencies.

**Fix.** Update `docs/user_guide.md` to accurately describe the feature as "Quick Action Marine Copilot (Preset Voice Queries)" until Speech-to-Text hardware integration is implemented.
*Trade-off:* Accurately sets user expectations.

**Related:** CQ-002, AI-003

---

### DOC-002 — Deployment guide omits PROXY_AUTH_SECRET requirement for production builds

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `docs/deployment_guide.md:40-60`
- **Novel:** yes

**Mechanism.** `docs/deployment_guide.md` provides build commands for Cloudflare Pages (`flutter build web --release`). However, it omits the mandatory `--dart-define=PROXY_AUTH_SECRET=xxx` flag required by `WebProxyInterceptor`. A developer following the deployment guide step-by-step will produce a web release build that fails with HTTP 401 on all external API requests.

**Evidence.**
```markdown
<!-- docs/deployment_guide.md:44-50 -->
```bash
flutter build web --release \
  --dart-define=OPENWEATHER_API_KEY=your_key_here
```
```
vs.
```dart
// lib/core/network/web_proxy_interceptor.dart:44-46
static const String proxyAuthSecret = String.fromEnvironment(
  'PROXY_AUTH_SECRET',
);
```

**Trigger.** Following `docs/deployment_guide.md` to deploy a fresh instance of Sakkoja to Cloudflare Pages.

**Impact.** Broken production deployment where map weather, nautical chart WMS, and fishing restrictions fail to load.

**Falsification.** Verified `scripts/build_web.sh` vs `docs/deployment_guide.md`. `scripts/build_web.sh` references `PROXY_AUTH_SECRET`, but `docs/deployment_guide.md` omits it from the copy-pasteable build instructions.

**Fix.** Add `--dart-define=PROXY_AUTH_SECRET=$PROXY_AUTH_SECRET` to the build command examples in `docs/deployment_guide.md`.
*Trade-off:* None.

**Related:** SEC-003, OPS-001

---

### DOC-003 — Architecture documentation references obsolete sembast/hive data layers

- **Severity:** S3-Low
- **Confidence:** C2-Reasoned
- **Effort:** E1-Hours
- **Location:** `docs/architecture.md:30-45`
- **Novel:** no

**Mechanism.** `docs/architecture.md` mentions historical migration rules regarding Sembast and Hive, despite the codebase having completely standardized on Drift (SQLite schema v18). While not causing runtime errors, legacy references create confusion for new contributors.

**Evidence.**
```markdown
<!-- docs/architecture.md -->
Mentions Sembast/Hive legacy data layers in historical notes.
```

**Trigger.** New developer reading architecture guide for onboarding.

**Impact.** Cognitive friction and time wasted looking for non-existent NoSQL data stores.

**Falsification.** Checked `pubspec.yaml` for `sembast` and `hive`. Neither package exists in dependencies.

**Fix.** Clean up historical NoSQL references and explicitly state that Drift SQLite is the sole persistence engine.
*Trade-off:* None.

**Related:** none

---

## Cross-domain sightings
- Unbounded `CachedFeatures` growth in SQLite is undocumented in data architecture docs (DATA).
- `VoiceCopilotService` returns static responses for dynamic locations (AI).

## Hygiene (low-signal, listed for completeness)
- `docs/developer_guide.md:12`: Outdated link anchor to obsolete ADR path.

## Open questions
- Is there a planned release date for adding true Speech-to-Text on mobile?

## This team's blind spot
Documentation auditing checks discrepancies between written specs and source code, but cannot detect undocumented oral traditions or team decisions that never made it into Markdown files.
