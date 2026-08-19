import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/features/harbors/data/datasources/lipas_remote_data_source.dart';
import 'package:sakkoja/features/harbors/data/models/lipas_harbor_dto.dart';
import 'package:sakkoja/features/harbors/data/repositories/harbor_repository_impl.dart';
import 'package:sakkoja/features/harbors/domain/entities/harbor.dart';

class MockLipasRemoteDataSource extends Mock implements LipasRemoteDataSource {}

void main() {
  late HarborRepositoryImpl repository;
  late MockLipasRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockLipasRemoteDataSource();
    repository = HarborRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  test('getHarbors returns mapped list of Harbor entities', () async {
    const fakeDtos = [
      LipasHarborDto(
        sportsPlaceId: 101,
        name: 'Elisaari (UUVI)',
        typeCode: 5120,
        latitude: 59.9880,
        longitude: 23.9050,
        municipalityName: 'Inkoo',
        hasSauna: true,
        hasCampfire: true,
      ),
      LipasHarborDto(
        sportsPlaceId: 102,
        name: 'Suomenlinna Vierasvenesatama',
        typeCode: 5110,
        latitude: 60.1460,
        longitude: 24.9860,
        municipalityName: 'Helsinki',
        hasSauna: true,
      ),
    ];

    when(
      () => mockRemoteDataSource.fetchHarbors(),
    ).thenAnswer((_) async => fakeDtos);

    final result = await repository.getHarbors();

    expect(result.isRight(), isTrue);
    result.fold(
      (failure) => fail('Should not return failure'),
      (harbors) {
        expect(harbors.length, 2);
        expect(harbors[0].name, 'Elisaari (UUVI)');
        expect(harbors[0].type, HarborType.excursionDock);
        expect(harbors[0].hasSauna, isTrue);
        expect(harbors[0].hasCampfire, isTrue);

        expect(harbors[1].name, 'Suomenlinna Vierasvenesatama');
        expect(harbors[1].type, HarborType.guestHarbor);
      },
    );
  });
}
