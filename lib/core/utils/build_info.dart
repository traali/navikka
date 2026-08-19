import 'package:flutter/foundation.dart';
import 'package:sakkoja/core/utils/logger.dart';

/// Static container for build-time metadata injected via --dart-define.
class BuildInfo {
  static const String hash = String.fromEnvironment(
    'APP_VERSION_HASH',
    defaultValue: 'local',
  );
  static const String branch = String.fromEnvironment(
    'APP_VERSION_BRANCH',
    defaultValue: 'dev',
  );
  static const String buildTime = String.fromEnvironment(
    'APP_VERSION_BUILD_TIME',
    defaultValue: 'n/a',
  );
  static const String environment = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'local',
  );

  static const String version = String.fromEnvironment(
    'APP_VERSION',
    defaultValue: 'v0.0.0',
  );

  static String get versionLabel => 'v$version';

  static bool get isLocal => hash == 'local';

  static String get summary => '$branch @ $hash ($buildTime)';

  static void printToConsole() {
    if (kDebugMode || !kReleaseMode) {
      Log.i('🚀 Sakkoja App Started');
      Log.i('Build: $summary');
      Log.i('Env: $environment');
    }
  }
}
