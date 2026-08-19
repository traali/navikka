import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/features/weather/data/datasources/fmi_weather_data_source.dart';
import 'package:sakkoja/features/weather/data/datasources/met_norway_data_source.dart';
import 'package:sakkoja/features/weather/data/datasources/met_norway_ocean_source.dart';
import 'package:sakkoja/features/weather/data/datasources/openweather_data_source.dart';
import 'package:sakkoja/features/weather/data/datasources/syke_data_source.dart';
import 'package:sakkoja/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:sakkoja/features/weather/data/models/weather_forecast_dto.dart';
import 'package:sakkoja/features/weather/data/models/weather_observation_dto.dart';

class MockFmiDataSource extends Mock implements FmiWeatherDataSource {}

class MockMetNorwayDataSource extends Mock implements MetNorwayDataSource {}

class MockMetNorwayOceanSource extends Mock implements MetNorwayOceanSource {}

class MockOpenWeatherDataSource extends Mock implements OpenWeatherDataSource {}

class MockSykeDataSource extends Mock implements SykeDataSource {}

void main() {
  late MockFmiDataSource fmiMock;
  late MockMetNorwayDataSource metMock;
  late MockMetNorwayOceanSource metOceanMock;
  late MockOpenWeatherDataSource owMock;
  late MockSykeDataSource sykeMock;
  late WeatherRemoteDataSourceImpl dataSource;

  setUp(() {
    fmiMock = MockFmiDataSource();
    metMock = MockMetNorwayDataSource();
    metOceanMock = MockMetNorwayOceanSource();
    owMock = MockOpenWeatherDataSource();
    sykeMock = MockSykeDataSource();
    dataSource = WeatherRemoteDataSourceImpl(
      fmiMock,
      owMock,
      metMock,
      metOceanMock,
      sykeMock,
    );
  });

  const testLat = 60.0;
  const testLon = 25.0;
  final now = DateTime.now();

  group('WeatherRemoteDataSource Parallel Fetch', () {
    test(
      'fetchWeatherObservations should return combined list even if FMI fails',
      () async {
        // 1. Arrange
        // FMI Fails
        when(
          () => fmiMock.fetchWeatherObservations(
            any(),
            any(),
            requestId: any(named: 'requestId'),
          ),
        ).thenThrow(Exception('FMI Timeout'));

        // OpenWeather Succeeds
        final owDto = WeatherObservationDto(
          timestamp: now,
          location: const LatLng(testLat, testLon),
          providerId: 3,
          temperature: 15,
        );
        when(
          () => owMock.fetchCurrentWeather(any(), any()),
        ).thenAnswer((_) async => owDto);

        // MetNorway Succeeds (Forecast as Observation)
        final metDto = WeatherForecastDto(
          timestamp: now,
          location: const LatLng(testLat, testLon),
          temperature: 14,
          providerId: 5,
        );
        when(
          () => metMock.fetchLocationForecast(any(), any()),
        ).thenAnswer((_) async => [metDto]);

        // 2. Act
        final result = await dataSource.fetchWeatherObservations(
          testLat,
          testLon,
        );

        // 3. Assert
        expect(
          result.length,
          2,
          reason: 'Should return OpenWeather + MET Norway (mapped)',
        );

        // Verify OpenWeather (Provider 3)
        final owResult = result.firstWhere((e) => e.providerId == 3);
        expect(owResult.temperature, 15.0);

        // Verify MET Norway (Provider 5)
        final metResult = result.firstWhere((e) => e.providerId == 5);
        expect(metResult.temperature, 14.0);
      },
    );

    test('fetchWeatherObservations throws when every provider fails', () async {
      when(
        () => fmiMock.fetchWeatherObservations(
          any(),
          any(),
          requestId: any(named: 'requestId'),
        ),
      ).thenThrow(Exception('FMI unavailable'));
      when(
        () => owMock.fetchCurrentWeather(any(), any()),
      ).thenThrow(Exception('OpenWeather unavailable'));
      when(
        () => metMock.fetchLocationForecast(any(), any()),
      ).thenThrow(Exception('MET Norway unavailable'));

      await expectLater(
        dataSource.fetchWeatherObservations(testLat, testLon),
        throwsA(
          isA<AllWeatherProvidersFailedException>().having(
            (error) => error.providers,
            'providers',
            containsAll(['FMI', 'OpenWeather', 'MET Norway']),
          ),
        ),
      );
    });

    test(
      'fetchWeatherForecast should return combined list from all providers',
      () async {
        // 1. Arrange
        final fmiDto = WeatherForecastDto(
          timestamp: now,
          location: const LatLng(testLat, testLon),
          providerId: 10,
          temperature: 10,
        );
        when(
          () => fmiMock.fetchWeatherForecast(
            any(),
            any(),
            requestId: any(named: 'requestId'),
          ),
        ).thenAnswer((_) async => [fmiDto]);

        final owDto = WeatherForecastDto(
          timestamp: now,
          location: const LatLng(testLat, testLon),
          providerId: 3,
          temperature: 11,
        );
        when(
          () => owMock.fetchThreeHourForecast(any(), any()),
        ).thenAnswer((_) async => [owDto]);

        final metDto = WeatherForecastDto(
          timestamp: now,
          location: const LatLng(testLat, testLon),
          providerId: 5,
          temperature: 12,
        );
        when(
          () => metMock.fetchLocationForecast(any(), any()),
        ).thenAnswer((_) async => [metDto]);

        // 2. Act
        final result = await dataSource.fetchWeatherForecast(testLat, testLon);

        // 3. Assert
        expect(result.length, 3);
        expect(result.any((e) => e.providerId == 10), isTrue);
        expect(result.any((e) => e.providerId == 3), isTrue);
        expect(result.any((e) => e.providerId == 5), isTrue);
      },
    );
  });
}
