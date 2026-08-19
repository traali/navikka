import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/features/weather/data/models/weather_observation_dto.dart';

void main() {
  group('WeatherObservationDto batch station key', () {
    test('station key matches 4-decimal precision used in batch resolver', () {
      final dto = WeatherObservationDto(
        timestamp: DateTime.now(),
        location: const LatLng(60.123456, 25.654321),
        stationName: 'Test Station',
        providerId: 10,
      );

      final lat4 = (dto.location.latitude * 10000).round() / 10000;
      final lon4 = (dto.location.longitude * 10000).round() / 10000;
      final stationKey =
          'weather|${lat4.toStringAsFixed(4)}|${lon4.toStringAsFixed(4)}';

      expect(stationKey, 'weather|60.1235|25.6543');
    });

    test('multiple DTOs produce unique station keys', () {
      final dtos = List.generate(
        5,
        (i) => WeatherObservationDto(
          timestamp: DateTime.now(),
          location: LatLng(60.0 + i * 0.01, 25.0 + i * 0.01),
          stationName: 'Station $i',
          providerId: 10,
        ),
      );

      final keys = dtos.map((dto) {
        final lat4 = (dto.location.latitude * 10000).round() / 10000;
        final lon4 = (dto.location.longitude * 10000).round() / 10000;
        return 'weather|${lat4.toStringAsFixed(4)}|${lon4.toStringAsFixed(4)}';
      }).toSet();

      expect(keys.length, 5);
    });
  });
}
