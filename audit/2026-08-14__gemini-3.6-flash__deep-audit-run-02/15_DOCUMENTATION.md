# DOCUMENTATION & KNOWLEDGE AUDIT — DOC

- **run_id:** deep-audit-run-02
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `c4492cc`
- **wave:** 1
- **findings_reported:** 1
- **candidates_discarded:** 11
- **examined:** `README.md`, `AGENTS.md`, `PROJECT_DOCUMENTATION.md`, `ARCHITECTURE.md`, `AUDIT.md`, `llms.txt`
- **not_examined:** External wiki or private design constitution documents

---

### DOC-001 — Historical Sembast Storage Documentation Residue

- **Severity:** S3-Low
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `PROJECT_DOCUMENTATION.md:36`
- **Novel:** no

**Mechanism.** `PROJECT_DOCUMENTATION.md` includes text describing Sembast key-value storage as the primary local data engine. Although a deprecation warning header was added at line 3, the body text contradicts `AGENTS.md` and `ARCHITECTURE.md`, which state that local storage was 100% migrated to Drift (SQLite).

**Evidence.**
```markdown
> [!WARNING]
> HISTORICAL / DEPRECATED DOCUMENTATION ARTIFACT
> This document reflects the legacy v1.1.0 architecture (Dec 2025) which utilized Sembast key-value storage...
```

**Trigger.** A new developer or LLM reading `PROJECT_DOCUMENTATION.md` without noticing the warning header.

**Impact.** Minor developer confusion regarding active storage engine dependencies.

**Falsification.** Checked codebase imports; confirmed 0 Sembast packages exist in `pubspec.yaml`.

**Fix.** Remove outdated section or replace `PROJECT_DOCUMENTATION.md` with an updated architecture overview pointing to `ARCHITECTURE.md`.

**Related:** DATA-001

---

## Cross-domain sightings
- `ARCHITECTURE.md`: Database directory path correctly specified as `lib/core/db/`.

## Hygiene (low-signal, listed for completeness)
- `llms.txt`: Summary reflects Flutter 3.44.8 baseline.

## Open questions
- Is there a separate API specification document for Cloudflare proxy parameters?

## This team's blind spot
Documentation auditing detects contradictions between docs and code, but cannot evaluate whether oral knowledge exists among team members.
