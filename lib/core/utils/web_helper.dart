import 'package:flutter/foundation.dart';
import 'package:sakkoja/core/utils/web_helper_stub.dart'
    if (dart.library.js_interop) 'package:sakkoja/core/utils/web_helper_web.dart'
    as impl;

/// Helper for web-specific functionality to avoid VM compilation errors.
class WebHelper {
  /// Returns true if the current hostname is a local environment.
  static bool isLocal() {
    if (!kIsWeb) return false;
    return impl.isWebLocal();
  }
}
