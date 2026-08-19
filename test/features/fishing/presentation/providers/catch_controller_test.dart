import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_catch.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_species.dart';
import 'package:sakkoja/features/fishing/domain/usecases/get_catches.dart';
import 'package:sakkoja/features/fishing/domain/usecases/record_catch.dart';
import 'package:sakkoja/features/fishing/presentation/providers/catch_controller_provider.dart';

class MockGetCatches extends Mock implements GetCatches {}

class MockRecordCatch extends Mock implements RecordCatch {}

void main() {
  late MockGetCatches mockGetCatches;
  late MockRecordCatch mockRecordCatch;

  setUpAll(() {
    registerFallbackValue(
      FishCatch(
        id: 'temp',
        species: FishSpecies.ahven,
        timestamp: DateTime.now(),
        location: const LatLng(0, 0),
      ),
    );
  });

  setUp(() {
    mockGetCatches = MockGetCatches();
    mockRecordCatch = MockRecordCatch();
  });

  final testCatch = FishCatch(
    id: 'id-1',
    species: FishSpecies.ahven,
    timestamp: DateTime(2023),
    location: const LatLng(60, 24),
  );

  group('CatchController', () {
    test('build fetches and returns initial catches', () async {
      when(() => mockGetCatches()).thenAnswer((_) async => Right([testCatch]));

      final container = ProviderContainer(
        overrides: [
          getCatchesProvider.overrideWithValue(mockGetCatches),
          recordCatchProvider.overrideWithValue(mockRecordCatch),
        ],
      );

      final state = await container.read(catchControllerProvider.future);

      expect(state, [testCatch]);
      verify(() => mockGetCatches()).called(1);
    });

    test('recordCatch adds new catch to the list', () async {
      when(() => mockGetCatches()).thenAnswer((_) async => const Right([]));
      when(
        () => mockRecordCatch(any()),
      ).thenAnswer((_) async => const Right(unit));

      final container = ProviderContainer(
        overrides: [
          getCatchesProvider.overrideWithValue(mockGetCatches),
          recordCatchProvider.overrideWithValue(mockRecordCatch),
        ],
      );

      // Initialize
      await container.read(catchControllerProvider.future);

      final controller = container.read(catchControllerProvider.notifier);

      await controller.recordCatch(
        species: FishSpecies.hauki,
        location: const LatLng(61, 25),
      );

      final state = container.read(catchControllerProvider).value;
      expect(state?.length, 1);
      expect(state?.first.species, FishSpecies.hauki);
      verify(() => mockRecordCatch(any())).called(1);
    });

    test('recordCatch passes weather parameters correctly', () async {
      when(() => mockGetCatches()).thenAnswer((_) async => const Right([]));
      when(
        () => mockRecordCatch(any()),
      ).thenAnswer((_) async => const Right(unit));

      final container = ProviderContainer(
        overrides: [
          getCatchesProvider.overrideWithValue(mockGetCatches),
          recordCatchProvider.overrideWithValue(mockRecordCatch),
        ],
      );

      await container.read(catchControllerProvider.future);
      final controller = container.read(catchControllerProvider.notifier);

      await controller.recordCatch(
        species: FishSpecies.kuha,
        location: const LatLng(60.1, 24.8),
        weatherTemp: 18.5,
        weatherWindSpeed: 4.2,
        weatherWindDir: 180,
        weatherDesc: 'Sunny',
        weatherIcon: '01d',
      );

      final state = container.read(catchControllerProvider).value;
      expect(state?.length, 1);
      expect(state?.first.species, FishSpecies.kuha);
      expect(state?.first.weatherTemp, 18.5);
      expect(state?.first.weatherWindSpeed, 4.2);
      expect(state?.first.weatherWindDir, 180);
      expect(state?.first.weatherDesc, 'Sunny');
      expect(state?.first.weatherIcon, '01d');

      final captured =
          verify(() => mockRecordCatch(captureAny())).captured.first
              as FishCatch;
      expect(captured.weatherTemp, 18.5);
      expect(captured.weatherWindSpeed, 4.2);
      expect(captured.weatherWindDir, 180);
      expect(captured.weatherDesc, 'Sunny');
      expect(captured.weatherIcon, '01d');
    });

    test('refresh reloads catches from use case', () async {
      when(() => mockGetCatches()).thenAnswer((_) async => const Right([]));

      final container = ProviderContainer(
        overrides: [
          getCatchesProvider.overrideWithValue(mockGetCatches),
          recordCatchProvider.overrideWithValue(mockRecordCatch),
        ],
      );

      await container.read(catchControllerProvider.future);

      // Update mock response
      when(() => mockGetCatches()).thenAnswer((_) async => Right([testCatch]));

      final controller = container.read(catchControllerProvider.notifier);
      await controller.refresh();

      final state = container.read(catchControllerProvider).value;
      expect(state, [testCatch]);
      verify(() => mockGetCatches()).called(2);
    });
  });
}
