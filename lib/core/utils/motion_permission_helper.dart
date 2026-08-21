import 'package:sakkoja/core/utils/motion_permission_helper_stub.dart'
    if (dart.library.js_interop) 'package:sakkoja/core/utils/motion_permission_helper_web.dart'
    as impl;

/// Helper for requesting hardware accelerometer / gyroscope motion permissions on iOS WebKit.
class MotionPermissionHelper {
  /// Requests motion sensor permission on iOS WebKit (Safari / Chrome iOS).
  /// Safe to call on any platform; returns true on platforms where explicit permission is not required.
  static Future<bool> requestPermission() async {
    return impl.requestMotionPermissionPlatform();
  }
}
