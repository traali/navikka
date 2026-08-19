# MARINE SAFETY AI & SENSORS AUDIT — AI

- **run_id:** g37f-001
- **date:** 2026-08-17
- **model:** Gemini 3.7 Flash
- **target:** Sakkoja Marine Safety Navigator @ 604ebd4
- **wave:** 1
- **findings_reported:** 3
- **candidates_discarded:** 12
- **examined:** Chrome Built-in AI (`window.ai.languageModel` / Gemini Nano JS interop), Local Marine Reasoner (`lib/features/ai/domain/services/weather_ai_edge_service_web.dart`), IMU Wave Roughness & Slamming AI (`wave_impact_ai_service.dart`), Marine Technical Engine Copilot, Acoustic Foghorn/Engine Harmonics, and Voice Copilot services.
- **not_examined:** Hardware microphone audio DAC drivers on Android/iOS/Desktop.

---

### AI-001 — Chrome Built-in AI on Web leaks LanguageModelSession without explicit destroy

- **Severity:** S2-Medium
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/ai/domain/services/weather_ai_edge_service_web.dart:112-133`
- **Novel:** yes

**Mechanism.** In `WeatherAIEdgeService._queryChromeBuiltInAI`, every call to generate advice creates a new Gemini Nano session using `lmFactory.create().toDart` and executes `session.prompt(...)`. In the Chrome Built-in AI Prompt API specification, language model sessions allocate significant on-device GPU/RAM context buffers in browser memory. Because `session.destroy()` is never called, repeatedly panning or triggering weather advice in Chrome accumulates detached LLM sessions in browser memory, leading to browser tab memory exhaustion.

**Evidence.**
```dart
// lib/features/ai/domain/services/weather_ai_edge_service_web.dart:129-132
final session = await lmFactory.create().toDart;
final resultPromise = session.prompt(prompt.toJS);
final result = await resultPromise.toDart;
return result.toDart;
// session.destroy() is never called!
```

**Trigger.** Running Sakkoja on Chrome Canary/Dev with Built-in AI enabled across extended navigation sessions.

**Impact.** Steady growth in browser memory usage (100MB+ per session creation), leading to eventual Out-Of-Memory tab crashes during navigation.

**Falsification.** Checked JS interop extension types:
```dart
// lib/features/ai/domain/services/weather_ai_edge_service_web.dart:26-28
extension type JSLanguageModelSession(JSObject _) implements JSObject {
  external JSPromise<JSString> prompt(JSString promptText);
  // Missing external void destroy();
}
```
Verified `destroy()` is neither declared in the JS extension type nor invoked after prompting.

**Fix.** Add `external void destroy();` to `JSLanguageModelSession` and wrap `session.prompt()` in a `try/finally` block that calls `session.destroy()`, or reuse a single cached session across invocations.
*Trade-off:* Session reuse requires tracking session token limits.

**Related:** PERF-001

---

### AI-002 — Voice Copilot returns static hardcoded locations and depths regardless of GPS

- **Severity:** S1-High
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/ai/domain/services/voice_copilot_service.dart:94-160`
- **Novel:** yes

**Mechanism.** `VoiceCopilotService.parseSpeech` parses skipper voice queries via keyword matching and returns hardcoded response strings. Inquiries regarding fairway depth return a static `2.4 m` depth ("Seuraavan väyläosuuden nimellissyvyys on 2.4 m"), sheltered harbor inquiries return a static `Suomenlinnan vierassatama 2.1 NM koilliseen` ("Suomenlinna guest harbor 2.1 NM North-East"), and weather forecasts return a static `5.0 m/s SW`. If a skipper in the Vaasa archipelago or Lake Saimaa queries the voice assistant, the system provides dangerously false navigational guidance referencing Helsinki coordinates and static depths.

**Evidence.**
```dart
// lib/features/ai/domain/services/voice_copilot_service.dart:100-107 (Depth)
if (lower.contains('syvyys') || lower.contains('vettä') || lower.contains('depth')) {
  return VoiceCommandResult(
    rawTranscript: transcript,
    intent: VoiceCommandIntent.depthInquiry,
    responseMessage: isEn
        ? 'Depth check: Planned fairway minimum depth is 2.4 m. Under-keel clearance is safe.'
        : 'Syvyystarkistus: Seuraavan väyläosuuden nimellissyvyys on 2.4 m. Kölivara on turvallinen.',
    isFinnish: !isEn,
  );
}

// lib/features/ai/domain/services/voice_copilot_service.dart:136-143 (Harbor)
if (lower.contains('satama') || lower.contains('harbor')) {
  return VoiceCommandResult(
    rawTranscript: transcript,
    intent: VoiceCommandIntent.shelteredHarborInquiry,
    responseMessage: isEn
        ? 'Sheltered harbor found: Suomenlinna guest harbor is 2.1 NM North-East with wind shelter from West.'
        : 'Lähin suojaisa satama: Suomenlinnan vierassatama 2.1 NM koilliseen. Hyvä suoja länsituulelta.',
    isFinnish: !isEn,
  );
}
```

**Trigger.** Asking the Voice Copilot about depth, weather, or nearby harbors while boating anywhere outside Suomenlinna / Helsinki.

**Impact.** Extreme maritime safety hazard if a skipper relies on the reported 2.4m fairway depth or false harbor coordinates in shallow or unfamiliar waters.

**Falsification.** Checked `VoiceCopilotService.parseSpeech`. It takes only `String transcript` as input and has no access to `LocationService`, `NavigationService`, or `PointWeatherController`. The outputs are pure static strings.

**Fix.** Inject `NavigationContext`, current GPS `LatLng`, active fairway depth, and live `WeatherData` into `VoiceCopilotService` to dynamically calculate real distance to the closest harbor, actual fairway depth, and live wind observations.
*Trade-off:* Requires converting `parseSpeech` to an instance method or passing dynamic context.

**Related:** DOC-001, UX-002

---

### AI-003 — AcousticMarineAIService is an unconnected prototype orphan

- **Severity:** S3-Low
- **Confidence:** C1-Verified
- **Effort:** E1-Hours
- **Location:** `lib/features/ai/domain/services/acoustic_marine_ai_service.dart:57-167`
- **Novel:** yes

**Mechanism.** `AcousticMarineAIService` implements COLREG Rule 35 foghorn sound pattern decoding and engine harmonic acoustic anomaly detection. However, `startListening()` and `stopListening()` only toggle a local boolean `_isListening = true/false` without opening any microphone stream or audio buffer listener. Furthermore, the class is not registered in any Riverpod provider or accessed by any presentation widget in the entire application.

**Evidence.**
```dart
// lib/features/ai/domain/services/acoustic_marine_ai_service.dart:71-81
void startListening() {
  _isListening = true;
  Log.i('[AcousticAI] Started acoustic listening for foghorns and engine harmonics.');
}
void stopListening() {
  _isListening = false;
  Log.i('[AcousticAI] Stopped acoustic listening.');
}
```
Grepped `AcousticMarineAIService` across `lib/`: found only in its own definition file.

**Trigger.** Reviewing codebase architecture or enabling "Acoustic AI" in settings.

**Impact.** Toggling "Acoustic AI" in `AiSettingsNotifier` does nothing at runtime; dead code exists in production binaries.

**Falsification.** Checked `lib/features/ai/presentation/` for any usage of `AcousticMarineAIService`. None exists.

**Fix.** Connect `AcousticMarineAIService` to a live audio recording package (e.g. `record` or Web Audio API) or deprecate and move the prototype into experimental research packages.
*Trade-off:* Audio recording requires microphone OS permissions.

**Related:** TEST-002, DOC-001

---

## Cross-domain sightings
- Unthrottled 100 Hz accelerometer sensor emission causes UI thread contention (PERF).
- Voice Copilot FAB touch target is 40dp instead of 64dp (UX).

## Hygiene (low-signal, listed for completeness)
- `lib/features/ai/domain/services/weather_ai_edge_service.dart:36`: Unused constructor parameter `getModelPath` ignored in web implementation.

## Open questions
- Will Gemini Nano on Chrome support streaming text response tokens in future browser updates?

## This team's blind spot
Marine AI auditing evaluates model prompts, sensor calculations, and intent logic, but cannot verify whether physical boat hull geometry amplifies false positive $G$-force slams on catamaran vs monohull designs.
