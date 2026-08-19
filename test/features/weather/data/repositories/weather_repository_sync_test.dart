import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:sakkoja/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:sakkoja/features/weather/data/repositories/weather_repository_impl.dart';

class _MockLocalDataSource extends Mock implements WeatherLocalDataSource {}

class _MockRemoteDataSource extends Mock implements WeatherRemoteDataSource {}

void main() {
  late _MockLocalDataSource local;
  late _MockRemoteDataSource remote;
  late WeatherRepositoryImpl repository;

  setUp(() {
    local = _MockLocalDataSource();
    remote = _MockRemoteDataSource();
    repository = WeatherRepositoryImpl(remote, local);
  });

  group('WeatherRepositoryImpl sync methods', () {
    test('propagates remote failures to the sync controller', () async {
      when(
        () => remote.fetchActiveAlerts(),
      ).thenThrow(StateError('FMI unavailable'));

      await expectLater(repository.syncActiveAlerts(), throwsStateError);
      verifyNever(() => local.cacheAlerts(any()));
    });

    test('accepts an empty successful response', () async {
      when(() => remote.fetchActiveAlerts()).thenAnswer((_) async => []);
      when(() => local.cacheAlerts(any())).thenAnswer((_) async {});

      await repository.syncActiveAlerts();

      verify(() => local.cacheAlerts([])).called(1);
    });

    test('propagates cache failures after a successful fetch', () async {
      when(() => remote.fetchActiveAlerts()).thenAnswer((_) async => []);
      when(
        () => local.cacheAlerts(any()),
      ).thenThrow(StateError('cache unavailable'));

      await expectLater(repository.syncActiveAlerts(), throwsStateError);
    });
  });
}
