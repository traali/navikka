# ADR 001: Drift SQLite Storage & Schema v18

## Status
Accepted & Implemented in Production

## Context
Marine navigation requires offline caching of map tiles, weather observations, fishing regulations, user waypoints, tracks, and vessel specs.

## Decision
1. Standardize on **Drift (SQLite)** via `sqlite3_flutter_libs` on mobile/desktop and `sqlite3.wasm` on web.
2. Maintain strict database migrations with automated migration testing (`app_database_migration_test.dart`).
3. Current schema version is `v18` with added vessel identification (HIN/WIN), engine specifications, and fuel type.

## Consequences
- 100% offline capability across mobile, desktop, and web (PWA).
- Type-safe compile-time queries via DAOs.
