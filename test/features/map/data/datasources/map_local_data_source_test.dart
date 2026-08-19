import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/features/map/data/datasources/map_local_data_source.dart';
import 'package:sakkoja/features/map/data/models/last_location_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  final savedAt = DateTime.utc(2026, 7, 27, 12);

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('persists a timestamp and reads a location within 24 hours', () async {
    final prefs = await SharedPreferences.getInstance();
    final source = MapLocalDataSourceImpl(clock: () => savedAt);
    const location = LastLocationDto(latitude: 60.1, longitude: 24.9);

    await source.saveLastLocation(location);

    final payload =
        jsonDecode(prefs.getString('map_last_location')!)
            as Map<String, dynamic>;
    expect(payload['savedAt'], savedAt.toIso8601String());
    expect(await source.getLastLocation(), location);
  });

  test('treats legacy coordinates without a timestamp as stale', () async {
    SharedPreferences.setMockInitialValues({
      'map_last_location': jsonEncode({
        'latitude': 60.1,
        'longitude': 24.9,
      }),
    });
    final source = MapLocalDataSourceImpl(clock: () => savedAt);

    expect(await source.getLastLocation(), isNull);
  });

  test('expires a location at the 24-hour boundary', () async {
    SharedPreferences.setMockInitialValues({
      'map_last_location': jsonEncode({
        'latitude': 60.1,
        'longitude': 24.9,
        'savedAt': savedAt
            .subtract(const Duration(hours: 24))
            .toIso8601String(),
      }),
    });
    final source = MapLocalDataSourceImpl(clock: () => savedAt);

    expect(await source.getLastLocation(), isNull);
  });

  test(
    'does not treat a failed preference write as a successful save',
    () async {
      final prefs = MockSharedPreferences();
      when(
        () => prefs.setString('map_last_location', any()),
      ).thenAnswer((_) async => false);
      final source = MapLocalDataSourceImpl(clock: () => savedAt, prefs: prefs);

      await expectLater(
        source.saveLastLocation(
          const LastLocationDto(latitude: 60.1, longitude: 24.9),
        ),
        throwsA(isA<StateError>()),
      );
    },
  );
}
