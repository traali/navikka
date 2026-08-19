import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sakkoja/core/utils/logger.dart';

/// Precaches SVG asset strings into memory to avoid jank on first render.
///
/// On web, each `rootBundle.loadString` call triggers an HTTP request.
/// By preloading all icon strings during startup (when the user is waiting
/// anyway), we eliminate first-render latency when markers appear on the map.
///
/// The strings are cached by Flutter's asset bundle automatically, so
/// subsequent `loadString` calls return instantly from memory.
class SvgPrecacheService {
  static bool _isPrecached = false;

  /// All nautical SVG icon paths that may appear on the map.
  static const List<String> _iconPaths = [
    // IALA A markers
    'assets/icons/nautical/iala_a/cardinal_north.svg',
    'assets/icons/nautical/iala_a/cardinal_east.svg',
    'assets/icons/nautical/iala_a/cardinal_south.svg',
    'assets/icons/nautical/iala_a/cardinal_west.svg',
    'assets/icons/nautical/iala_a/port.svg',
    'assets/icons/nautical/iala_a/starboard.svg',
    'assets/icons/nautical/iala_a/safe_water.svg',
    'assets/icons/nautical/iala_a/isolated_danger.svg',
    'assets/icons/nautical/iala_a/special_mark.svg',
    // Official signs
    'assets/icons/nautical/official/warning_infrastructure.svg',
    'assets/icons/nautical/official/warning_general.svg',
    'assets/icons/nautical/official/warning_cable.svg',
    'assets/icons/nautical/official/prohibition_no_waves.svg',
    'assets/icons/nautical/official/prohibition_waterski.svg',
    'assets/icons/nautical/official/prohibition_overtaking.svg',
    'assets/icons/nautical/official/prohibition_motorboat.svg',
    'assets/icons/nautical/official/prohibition_docking.svg',
    'assets/icons/nautical/official/prohibition_jetski.svg',
    'assets/icons/nautical/official/prohibition_meeting.svg',
    'assets/icons/nautical/official/prohibition_anchoring.svg',
    'assets/icons/nautical/official/restriction_width.svg',
    'assets/icons/nautical/official/restriction_height.svg',
    'assets/icons/nautical/official/restriction_depth.svg',
    'assets/icons/nautical/official/limit_speed_generic.svg',
    'assets/icons/nautical/official/info_generic.svg',
    'assets/icons/nautical/official/info_phone.svg',
    'assets/icons/nautical/official/info_horn.svg',
    'assets/icons/nautical/official/info_parking.svg',
    // General nautical
    'assets/icons/nautical/lighthouse.svg',
    'assets/icons/nautical/port_mark.svg',
    'assets/icons/nautical/starboard_mark.svg',
    'assets/icons/nautical/wind_barb.svg',
    'assets/icons/nautical/speed_meter.svg',
    'assets/icons/nautical/warning_signal.svg',
    'assets/icons/nautical/storm_bolt.svg',
    'assets/icons/nautical/gps_reticle.svg',
    'assets/icons/nautical/menu_bars.svg',
  ];

  /// Precaches all SVG icon strings into the asset bundle cache.
  ///
  /// Call during app startup (after WidgetsFlutterBinding.ensureInitialized).
  /// On web, this preloads the SVG strings so they render instantly on first use.
  static Future<void> precacheAll() async {
    if (_isPrecached) return;
    if (kIsWeb) {
      _isPrecached = true;
      return;
    }

    final stopwatch = Stopwatch()..start();
    var success = 0;
    var failed = 0;

    await Future.wait(
      _iconPaths.map((path) async {
        try {
          // Loading the string caches it in the asset bundle.
          // Subsequent calls return from memory cache.
          await rootBundle.loadString(path);
          success++;
        } catch (e, s) {
          failed++;
          if (kDebugMode) {
            Log.w('SvgPrecache: Failed to precache $path', e, s);
          }
        }
      }),
    );

    stopwatch.stop();
    Log.i(
      'SvgPrecache: $success icons precached in ${stopwatch.elapsedMilliseconds}ms'
      '${failed > 0 ? ', $failed failed' : ''}',
    );
    _isPrecached = true;
  }
}
