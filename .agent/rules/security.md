# Security & Privacy Rules

## 1. Principles
- **Offline First & Zero Trust**: Assume the device is compromised. Validate all inputs, even from local DB.
- **Data Minimization**: Only store what is strictly necessary for the user's current task.

## 2. Data Persistence (Drift SQLite)
- **Sensitive Data**: Any user PII (Personally Identifiable Information) must be encrypted before storage.
- **No Plaintext Secrets**: API Keys must be injected via build-time environments (--dart-define) or secure storage, never hardcoded.

## 3. External Integrations
- **API Verification**: As per AGENTS.md, all external endpoints must be verified with fixtures.
- **CORS (Web)**: Use strict CORS proxies or Cloudflare Workers. Never disable browser security for production.

## 4. Code Obfuscation
- **Production Builds**: Must use --obfuscate --split-debug-info for release builds to hinder reverse engineering.
