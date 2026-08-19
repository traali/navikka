# Issue: Drift Web Worker Feature Not Available

## Status: ❌ DENIED — Expected Browser Fallback, Not a Bug

## Priority: LOW → NOT AN ISSUE

## Triage Result (2026-05-11)
This is a **graceful degradation warning**, not a missing implementation.
The app is correctly configured and falls back automatically when the browser
lacks support for nested dedicated workers inside shared workers.

**What is already in place:**
- `lib/core/db/app_database.dart:373-376` — `DriftWebOptions(sqlite3Wasm: ..., driftWorker: ...)` configured
- `web/_headers:1-4` — COOP/COEP headers set (`Cross-Origin-Opener-Policy: same-origin`, `Cross-Origin-Embedder-Policy: require-corp`)

**Why the warning appears:**
Some browser environments (including Playwright's test runner) cannot start a
DedicatedWorker inside a SharedWorker. Drift automatically falls back to
`WasmStorageImplementation.opfsLocks`, which is fully functional — just
slightly less optimal for multi-tab scenarios.

## Original Log Message
```
Using WasmStorageImplementation.opfsLocks due to missing browser features:
{MissingBrowserFeature.dedicatedWorkersInSharedWorkers}
```

This is a **Drift library log**, not an app error. App still works.

## Impact
- No functionality loss
- Minor performance difference in multi-tab browser scenarios only
- E2E tests pass: 2/2 (landing_page, navigation_flow)

---
*Created: 2026-05-09*
*Triaged: 2026-05-11 — DENIED, no action required*