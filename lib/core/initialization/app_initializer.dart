import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sakkoja/core/config/env.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/core/utils/svg_precache.dart';

/// Centralized service for application initialization logic.
class AppInitializer {
  static bool _isInitialized = false;

  /// Performs all necessary pre-run setup.
  static Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // 1. Framework & Platform Error Traps
      _setupErrorTraps();

      // 2. Load environment variables
      await dotenv.load(isOptional: true);

      // 3. Initialize Persistent Logging
      await Log.init();

      // 4. Precache SVG icons (web performance)
      // Run unawaited so it doesn't block app startup.
      // Icons will be ready before the user navigates to the map.
      unawaited(SvgPrecacheService.precacheAll());

      // 5. Log Version Info
      final packageInfo = await PackageInfo.fromPlatform();
      final versionStr =
          '🚀 Sakkoja v${packageInfo.version}+${packageInfo.buildNumber} '
          '[${Env.commitHash}] (Built: ${Env.buildTime})';
      Log.i('$versionStr initialized');

      _isInitialized = true;
      Log.i('AppInitializer: System components initialized successfully');
    } catch (e, stack) {
      Log.e('AppInitializer: Critical failure during initialization', e, stack);
      rethrow;
    }
  }

  static void _setupErrorTraps() {
    // Flutter Framework Error Trap
    FlutterError.onError = (details) {
      Log.e('Flutter Framework Error', details.exception, details.stack);
    };

    // Platform Error Trap
    PlatformDispatcher.instance.onError = (error, stack) {
      Log.e('Platform Error: $error', error, stack);
      return true;
    };
  }
}
