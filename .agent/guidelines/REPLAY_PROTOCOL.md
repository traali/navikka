# Protocol: Record & Replay (Deterministic Dependencies)

To ensure offline resilience and deterministic behavior, Sakkoja follows a strict **Record & Replay** pattern for all external network dependencies.

## 1. Principles
- **No Live Network in Dev/Test**: By default, the app should run against recorded fixtures.
- **Atomic Fixtures**: Each fixture represents a specific logical session (e.g., "Helsinki Startup", "Storm Warning Flow").
- **Hermeticity**: Replay mode must return the exact same bytes, headers, and status codes as the recording.

## 2. Infrastructure
### Dio Adapter (`ReplayInterceptor`)
We use a custom `Interceptor` for `Dio` that can operate in three modes:
1.  **Direct**: Standard live network (Default for Production).
2.  **Record**: Logs all requests and responses to `assets/fixtures/network/<session_id>/`.
3.  **Replay**: Overrides network calls by reading from the fixture directory based on the request hash (Method + URI + Body).

### Fixture Storage
Fixtures are stored as JSON files:
- **Index**: `assets/fixtures/network/<session_id>/index.json` (maps hashes to files).
- **Data**: `assets/fixtures/network/<session_id>/<hash>.json` (contains status, headers, and body).

## 3. Workflow
### Recording a Session
1. Set `APP_REPLAY_MODE=record` and `APP_SESSION_ID=fishing_verify`.
2. Run the app and perform the manual smoke test.
3. The `ReplayInterceptor` will populate `assets/fixtures/network/fishing_verify/`.
4. Commit the new fixtures.

### Replaying a Session
1. Set `APP_REPLAY_MODE=replay` and `APP_SESSION_ID=fishing_verify`.
2. The app will now be fully functional without an internet connection.
3. This mode is **MANDATORY** for manual smoke tests of complex data flows.

## 4. Maintenance
- **Review**: Fixtures should be reviewed for PII (Personally Identifiable Information) before committing.
- **Refresh**: Fixtures should be recaptured if the API schema changes significantly.
- **Deduplication**: Identical requests across sessions should ideally be linked or shared.

---

> **Implementation**: See `lib/core/network/dio_adapter_replay.dart` for the concrete interceptor logic.
