import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/utils/logger.dart';

part 'logging_provider.g.dart';

@riverpod
class LogLevel extends _$LogLevel {
  @override
  Level build() {
    // Default to debug in debug mode, info in release
    const initialLevel = kDebugMode ? Level.debug : Level.info;
    Log.setLevel(initialLevel);
    return initialLevel;
  }

  void toggle() {
    state = (state == Level.debug) ? Level.info : Level.debug;
    Log.setLevel(state);
  }
}
