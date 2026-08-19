# ADR 002: Modular On-Device Marine AI Suite

## Status
Accepted & Implemented in Production

## Context
Skippers navigating in rough weather need automated situational awareness (weather risk, route shelter, under-keel clearance, wave slamming, acoustic warnings) without relying on heavy cloud servers or continuous internet connection. Furthermore, users must have complete control to disable any AI capability.

## Decision
1. Implement a **Modular Marine AI Suite** where every feature has an independent persistent toggle (`AiSettingsProvider` & `AiFeatureSettings`).
2. Run AI reasoning **on-device**:
   - Web: Chrome Built-in AI (`window.ai.languageModel` / Gemini Nano) + deterministic `LocalMarineReasoner`.
   - Motion: W3C `DeviceMotionEvent` / `sensors_plus` IMU sensor fusion.
   - Acoustics: Web Audio API FFT harmonics and COLREG signal decoder.
   - Voice: Web Speech API parser in Finnish and English.
   - Engine: Offline workshop diagnostic guides and specs autoloader.

## Consequences
- Zero cloud latency for marine safety advisories.
- Operates completely offline during open sea voyages.
- Skippers can toggle individual capabilities according to their preferences.
