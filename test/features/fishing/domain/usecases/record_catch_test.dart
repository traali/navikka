import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_catch.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_species.dart';
import 'package:sakkoja/features/fishing/domain/repositories/catch_repository.dart';
import 'package:sakkoja/features/fishing/domain/usecases/record_catch.dart';

class MockCatchRepository extends Mock implements CatchRepository {}

class FakeFishCatch extends Fake implements FishCatch {}

void main() {
  late RecordCatch useCase;
  late MockCatchRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeFishCatch());
  });

  setUp(() {
    mockRepository = MockCatchRepository();
    useCase = RecordCatch(mockRepository);
  });

  final tFishCatch = FishCatch(
    id: 'test-id',
    species: FishSpecies.ahven,
    timestamp: DateTime.fromMillisecondsSinceEpoch(1000),
    location: const LatLng(60, 24),
    weightGrams: 200,
    lengthCm: 25,
  );

  test(
    'should call repository.saveCatch and return Right(Unit) on success',
    () async {
      // Arrange
      when(
        () => mockRepository.saveCatch(any()),
      ).thenAnswer((_) async => const Right<Failure, Unit>(unit));

      // Act
      final result = await useCase(tFishCatch);

      // Assert
      expect(result, const Right<Failure, Unit>(unit));
      verify(() => mockRepository.saveCatch(tFishCatch)).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
