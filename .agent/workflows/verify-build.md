---
description: Comprehensive build verification workflow to catch issues early and avoid trial-and-error rebuilds.
---

# Proper Build Verification Workflow

To ensure a clean, boating-optimized build and catch issues as early as possible, follow this hierarchical sequence. 

> [!IMPORTANT]
> **Always run verification in this order.** Each step is more expensive than the last. Do not proceed to a later step if an earlier one fails.

## 0. Code Generation (Prerequisite)
Ensures all Riverpod/Freezed/Drift files exist so the analyzer doesn't throw false errors.

// turbo
```bash
dart run build_runner build --delete-conflicting-outputs
```

## 1. Static Analysis (Fastest)
Catches 90% of syntax, type, and lint errors. Includes formatting to ensure code style consistency.

// turbo
```bash
dart format --set-exit-if-changed .
dart analyze --fatal-infos
```

## 2. Logic Verification (Medium)
Validates business logic, state management (Riverpod), and data providers.

// turbo
```bash
flutter test --exclude-tags=golden
```

## 3. Platform Verification (Slowest)
Validates platform-specific compatibility. Web release is a great "canary" for compiler strictness. Note: Uses `>` to overwrite the log file, ensuring you only see the latest build errors.

// turbo
```bash
flutter build web --release -v > build_log.txt 2>&1
```

## 4. Android Runtime Verification (On-Demand)
Actually installs and boots the app on the emulator. Catches native crashes (JNI/Gradle) missed by static analysis.

> [!NOTE]
> **Prerequisite**: An Android Emulator must be running (emulator-5554). This step is slow (~1-2 mins). Run only before merging PRs.

// turbo
```bash
flutter test integration_test/app_test.dart -d android
```

---

## Logging & Auditing

### Build-Time Logging
If a build fails, inspect `build_log.txt`. Search for `Error:` or `Compiling... failed`.
Using `-v` (verbose) is critical for identifying why a release build might fail even if `dart analyze` passes (e.g., a package missing web support).

### Runtime Logging
For runtime issues, use the `Log` utility in code:
- `Log.d('Message')` for debug info.
- `Log.e('Error', error, stackTrace)` for failures.

In the dev console or while investigating task failures, check the most recent logs using the `Log.recentLogsNotifier`.
