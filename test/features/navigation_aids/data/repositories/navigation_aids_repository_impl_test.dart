import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sakkoja/features/navigation_aids/data/datasources/navigation_aids_local_data_source.dart';
import 'package:sakkoja/features/navigation_aids/data/datasources/navigation_aids_remote_data_source.dart';
import 'package:sakkoja/features/navigation_aids/data/models/fairway_area_dto.dart';
import 'package:sakkoja/features/navigation_aids/data/models/navigation_aid_dto.dart';
import 'package:sakkoja/features/navigation_aids/data/models/navigation_line_dto.dart';
import 'package:sakkoja/features/navigation_aids/data/repositories/navigation_aids_repository_impl.dart';

class MockNavigationAidsLocalDataSource extends Mock
    implements NavigationAidsLocalDataSource {}

class MockNavigationAidsRemoteDataSource extends Mock
    implements NavigationAidsRemoteDataSource {}

void main() {
  late MockNavigationAidsLocalDataSource local;
  late MockNavigationAidsRemoteDataSource remote;
  late NavigationAidsRepositoryImpl repository;

  const fairway = FairwayAreaDto(id: 'fairway', rings: []);
  const aid = NavigationAidDto(
    id: 'aid',
    type: NavigationAidTypeDto.safetyEquipment,
    position: LatLng(60, 24),
  );
  const line = NavigationLineDto(
    id: 'line',
    points: [LatLng(60, 24), LatLng(60.1, 24.1)],
  );

  setUp(() {
    local = MockNavigationAidsLocalDataSource();
    remote = MockNavigationAidsRemoteDataSource();
    repository = NavigationAidsRepositoryImpl(local, remote);
    when(() => local.saveFairwayAreas(any())).thenAnswer((_) async {});
    when(() => local.saveNavigationAids(any())).thenAnswer((_) async {});
    when(() => local.saveNavigationLines(any())).thenAnswer((_) async {});
  });

  void stubFreshCaches() {
    when(() => local.getFairwayAreas()).thenAnswer((_) async => [fairway]);
    when(() => local.getNavigationAids()).thenAnswer((_) async => [aid]);
    when(() => local.getNavigationLines()).thenAnswer((_) async => [line]);
  }

  void stubMissingCachesWithStaleFallback() {
    when(() => local.getFairwayAreas()).thenAnswer((_) async => null);
    when(() => local.getNavigationAids()).thenAnswer((_) async => null);
    when(() => local.getNavigationLines()).thenAnswer((_) async => null);
    when(
      () => local.getFairwayAreas(ignoreExpiry: true),
    ).thenAnswer((_) async => [fairway]);
    when(
      () => local.getNavigationAids(ignoreExpiry: true),
    ).thenAnswer((_) async => [aid]);
    when(
      () => local.getNavigationLines(ignoreExpiry: true),
    ).thenAnswer((_) async => [line]);
    when(
      () => local.loadFairwayAreasFromAssets(),
    ).thenAnswer((_) async => [fairway]);
    when(
      () => local.loadNavigationAidsFromAssets(),
    ).thenAnswer((_) async => [aid]);
    when(
      () => local.loadNavigationLinesFromAssets(),
    ).thenAnswer((_) async => [line]);
  }

  test('uses the local source TTL for already-fresh datasets', () async {
    stubFreshCaches();

    await repository.initialize();

    verify(() => local.getFairwayAreas()).called(1);
    verify(() => local.getNavigationAids()).called(1);
    verify(() => local.getNavigationLines()).called(1);
    verifyNever(() => local.getFairwayAreas(ignoreExpiry: true));
    verifyNever(() => remote.fetchFairwayAreas());
  });

  test('refreshes missing datasets from bundled assets', () async {
    stubMissingCachesWithStaleFallback();
    when(() => local.saveFairwayAreas(any())).thenAnswer((_) async {});
    when(() => local.saveNavigationLines(any())).thenAnswer((_) async {});
    when(() => local.saveNavigationAids(any())).thenAnswer((_) async {});

    await repository.initialize();

    final result = await repository.getNavigationLines();
    expect(result.isRight(), isTrue);
    expect(
      result.match((_) => 0, (lines) => lines.length),
      1,
    );
    verify(() => local.loadNavigationLinesFromAssets()).called(1);
  });

  test('shares concurrent initialization', () async {
    stubMissingCachesWithStaleFallback();
    when(() => local.saveFairwayAreas(any())).thenAnswer((_) async {});
    when(() => local.saveNavigationLines(any())).thenAnswer((_) async {});
    when(() => local.saveNavigationAids(any())).thenAnswer((_) async {});

    final first = repository.initialize();
    final second = repository.initialize();
    expect(identical(first, second), isTrue);

    await Future.wait([first, second]);

    verify(() => local.loadNavigationLinesFromAssets()).called(1);
  });
}
