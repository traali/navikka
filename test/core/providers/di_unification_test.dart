import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/core/db/app_database.dart';
import 'package:sakkoja/core/providers/core_providers.dart';
import 'package:sakkoja/features/weather/data/weather_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  test('DI Graph - WeatherRepository resolves correctly', () {
    final mockPrefs = MockSharedPreferences();
    when(mockPrefs.getKeys).thenReturn({});

    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(mockPrefs),
        appDatabaseProvider.overrideWithValue(
          AppDatabase(NativeDatabase.memory()),
        ),
      ],
    );

    // Cleanup
    addTearDown(container.dispose);

    // Act: Read the repository
    final repo = container.read(weatherRepositoryProvider);

    // Assert: It should resolve without error
    expect(repo, isNotNull);
  });
}
