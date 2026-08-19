import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sakkoja/core/services/location_service.dart';

void main() {
  test('uses fresh high-accuracy settings for web navigation', () {
    final settings = LocationService.navigationSettings(isWeb: true);

    expect(settings, isA<WebSettings>());
    expect(settings.accuracy, LocationAccuracy.bestForNavigation);
    expect(settings.distanceFilter, 0);
    expect((settings as WebSettings).maximumAge, Duration.zero);
  });
}
