# Sakkoja – Developer & Contributor Guide 🛠️

Welcome to the **Sakkoja** developer guide. This document contains everything you need to set up the development environment, understand our architectural standards, run tests, and contribute changes.

---

## 1. Prerequisites & Environment Setup

### Required SDKs
- **Flutter SDK**: `3.44.8` stable (pinned in `.fvmrc`)
- **Dart SDK**: `3.12.2` (bundled with Flutter 3.44.8)
- **Node.js**: `24.x` (for Playwright E2E tests)
- **Git**: 2.40+

### Clone & Bootstrap
```bash
# 1. Clone the repository
git clone https://github.com/traali/sakkoja.git
cd sakkoja

# 2. Install Flutter dependencies
flutter pub get

# 3. Setup automated pre-commit Git hooks (lefthook)
dart run lefthook install

# 4. Run build runner code generation
dart run build_runner build --delete-conflicting-outputs
```

---

## 2. Running Locally

### Web Development (Chrome)
```bash
flutter run -d chrome
```

### Desktop / Mobile
```bash
flutter run -d windows    # Windows Desktop
flutter run -d macos      # macOS Desktop
flutter run -d linux      # Linux Desktop
```

---

## 3. Architecture & Code Conventions

Sakkoja strictly follows **Feature-First Clean Architecture**:

```
lib/
├── core/                  # Shared utilities, DI container, SQLite database models, styles
└── features/              # Feature modules (Domain-driven)
    └── [feature_name]/
        ├── data/          # Drift Store, Dio data sources, JSON DTOs
        ├── domain/        # Entities, Use Cases, Repositories definitions
        └── presentation/  # Riverpod Providers, UI Components & Screens
```

### Mandatory Rules
1. **Riverpod State Management**:
   - Use code-generated `@riverpod` annotations (`Notifier` / `AsyncNotifier`).
   - Legacy `ChangeNotifier` and `StateProvider` are strictly forbidden.
2. **DTO Layer Isolation**:
   - DTO classes in `data/models/` must **NOT** import from `domain/entities/`.
   - Mapping between DTOs and domain entities happens strictly in repositories or store classes.
3. **Data Return Signatures**:
   - Always return `Future<Either<Failure, T>>` using `fpdart` to enforce explicit error propagation. Never leak uncaught exceptions into the UI layer.
4. **Drift SQLite Caching (v18)**:
   - All persistence uses Drift SQLite (`sqlite3_flutter_libs` on native, `sqlite3.wasm` on web).
   - Any database table change requires incrementing `schemaVersion` in `app_database.dart` and adding a test case to `test/core/db/app_database_migration_test.dart`.

---

## 4. Testing & Verification Protocol

Before submitting any Pull Request or committing changes, all checks must pass with zero errors:

```bash
# 1. Format code according to official standards
dart format .

# 2. Static Analysis (Zero warnings, Zero errors)
flutter analyze

# 3. Unit & Widget Tests
flutter test

# 4. Database Schema Migration Tests
flutter test test/core/db/app_database_migration_test.dart

# 5. Playwright E2E Browser Tests
cd e2e
npm install
npm test
```

---

## 5. Build & Deployment Protocol

### Local Web Production Build
The build script bundles dual JS/WASM skwasm rendering engines to Cloudflare Pages:
- **Windows (PowerShell)**: `.\scripts\build_web.ps1`
- **macOS / Linux (Bash)**: `./scripts/build_web.sh`

*Note: Requires `OPENWEATHER_API_KEY` environmental variable.*

### Release Workflow
1. The commit that bumps `version:` in `pubspec.yaml` **must** simultaneously update `CHANGELOG.md`.
2. Commit message format: `chore: release vX.Y.Z`.
3. Never skip automated static analysis or linter rules on a release commit.
