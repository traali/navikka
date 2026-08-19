import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/utils/logger.dart';

part 'location_service.g.dart';

@riverpod
LocationService locationService(Ref ref) => LocationService();

enum LocationPermissionResult {
  granted,
  denied,
  deniedForever,
  serviceDisabled,
}

class LocationService {
  /// Creates settings suitable for the live navigation display.
  ///
  /// Web only exposes the browser Geolocation API. A zero distance filter
  /// lets the app react to every sample the browser provides, while a zero
  /// maximum age avoids starting a navigation session from a cached fix.
  static LocationSettings navigationSettings({
    bool isNavigationMode = true,
    bool isWeb = kIsWeb,
  }) {
    if (isWeb) {
      return WebSettings(
        accuracy: LocationAccuracy.bestForNavigation,
      );
    }

    return LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: isNavigationMode ? 0 : 10,
    );
  }

  Future<LocationPermissionResult> requestPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      Log.d('LocationService: Checking if service is enabled...');
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Log.d('LocationService: Service not enabled.');
        return LocationPermissionResult.serviceDisabled;
      }

      Log.d('LocationService: Checking current permission status...');
      permission = await Geolocator.checkPermission();
      Log.d('LocationService: Current permission: $permission');

      if (permission == LocationPermission.denied) {
        Log.d('LocationService: Requesting permission...');
        permission = await Geolocator.requestPermission();
        Log.d('LocationService: Permission after request: $permission');
        if (permission == LocationPermission.denied) {
          return LocationPermissionResult.denied;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Log.d('LocationService: Permission denied forever.');
        return LocationPermissionResult.deniedForever;
      }

      Log.d('LocationService: Permission granted.');
      return LocationPermissionResult.granted;
    } catch (e, s) {
      Log.e('LocationService: Failed to request permission', e, s);
      return LocationPermissionResult.denied;
    }
  }

  Stream<Position> getPositionStream() {
    return Geolocator.getPositionStream(
      locationSettings: navigationSettings(),
    );
  }
}
