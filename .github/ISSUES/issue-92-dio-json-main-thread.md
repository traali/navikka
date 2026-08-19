# Issue: Dio JSON Parsing Blocks Main Thread - compute() Becomes Useless

## Status: ❌ DENIED — Already Fixed in Codebase

## Priority: HIGH (original) → NOT AN ISSUE

## Triage Result (2026-05-11)
Investigated Dio client setup and transformer configuration. All core Dio
clients already use `BackgroundTransformer` via the custom `FlutterTransformer`:

- `lib/core/providers/core_providers.dart:45,124` — `dio.transformer = FlutterTransformer()`
- `lib/core/utils/dio_transformer.dart:5-6` — `class FlutterTransformer extends BackgroundTransformer`

JSON parsing already happens **off the main thread** for all Dio clients.

Additionally, the large fishing restrictions payload already forces
`ResponseType.plain` and uses `compute()` for background parsing:
- `lib/features/fishing/data/datasources/fishing_remote_data_source.dart:69-75`

## Original Claim
> Dio parses JSON responses on the main thread by default

## Actual Code
```
lib/core/providers/core_providers.dart:45,124
lib/core/utils/dio_transformer.dart:5-6
```
— `BackgroundTransformer` is active app-wide; JSON never blocks the main thread.

---
*Created: 2026-05-09*
*Triaged: 2026-05-11 — DENIED, no action required*