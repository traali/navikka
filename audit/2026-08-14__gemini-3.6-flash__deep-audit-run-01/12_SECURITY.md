# SECURITY AUDIT — SEC

- **run_id:** deep-audit-run-01
- **date:** 2026-08-14
- **model:** gemini-3.6-flash
- **target:** Sakkoja (Marine Safety Navigator) @ `a8aa5a4`
- **wave:** 1
- **findings_reported:** 1
- **candidates_discarded:** 11
- **examined:** `cloudflare-worker/src/index.js`, `lib/core/network/`, `lib/features/ai/data/repositories/`, `lib/core/config/env.dart`
- **not_examined:** Backend server infrastructure (Cloudflare Pages edge runtime environment)

---

### SEC-001 — Plaintext Obfuscation Theater for OpenRouter AI API Keys

- **Severity:** S1-High
- **Confidence:** C1-Verified
- **Effort:** E2-Days
- **Location:** `lib/features/ai/data/repositories/skipper_settings_repository_impl.dart:39-41`
- **Novel:** yes

**Mechanism.** User OpenRouter API keys (`aiApiKey`) are processed using `SecretObfuscator.obfuscate()`, which applies an XOR operation with a static hardcoded byte (`0x5A`) followed by Base64 encoding. The result is written directly to the `skipper_settings` table in an unencrypted SQLite database. Anyone with access to the application data folder or an unencrypted backup can decode the key instantly.

**Evidence.**
```dart
// lib/core/utils/secret_obfuscator.dart:17-20
final bytes = utf8.encode(rawSecret);
final xorBytes = bytes.map((b) => b ^ _xorMask).toList(); // _xorMask = 0x5A
final base64Str = base64.encode(xorBytes);
return '$_prefix$base64Str';
```

**Trigger.** Storing an OpenRouter API key in Skipper Settings on a rooted device, shared desktop, or unencrypted backup.

**Impact.** Exposure of user paid API credentials to local malware or device backup extractions.

**Falsification.** Checked if `flutter_secure_storage` was utilized; confirmed key is written into SQLite `skipper_settings` table instead of OS keychain/keystore.

**Fix.** Migrate `aiApiKey` storage to `FlutterSecureStorage` (iOS Keychain / Android EncryptedSharedPreferences / Web Encrypted Store) and store only non-sensitive configuration in SQLite.

**Related:** DATA-001

---

## Cross-domain sightings
- `cloudflare-worker/src/index.js`: Worker strips upstream CORS headers before injecting proxy origin.

## Hygiene (low-signal, listed for completeness)
- `lib/core/config/env.dart`: `dotenv.get('OPENWEATHER_API_KEY', fallback: '')` returns empty string on missing key.

## Open questions
- Does Cloudflare Worker rate limiting prevent proxy abuse on public endpoints?

## This team's blind spot
Security auditing inspects code path mechanisms and credential handling, but cannot run live penetration tests against Cloudflare Edge infrastructure.
