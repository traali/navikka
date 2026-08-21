import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'package:sakkoja/core/utils/logger.dart';

/// Web implementation for requesting iOS Safari / Chrome DeviceMotionEvent permission.
Future<bool> requestMotionPermissionPlatform() async {
  try {
    final global = globalContext;
    if (global.has('DeviceMotionEvent')) {
      final dme = global.getProperty<JSObject?>('DeviceMotionEvent'.toJS);
      if (dme != null && dme.has('requestPermission')) {
        final reqFn = dme.getProperty<JSFunction?>('requestPermission'.toJS);
        if (reqFn != null) {
          final promise = reqFn.callAsFunction(dme) as JSPromise<JSString>?;
          if (promise != null) {
            final res = await promise.toDart;
            final isGranted = res.toDart == 'granted';
            Log.i(
              '[MotionPermission] DeviceMotionEvent permission result: $isGranted',
            );
            return isGranted;
          }
        }
      }
    }
    return true;
  } catch (e) {
    Log.w('[MotionPermission] DeviceMotionEvent permission error: $e');
    return false;
  }
}
