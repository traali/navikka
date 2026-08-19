import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/models/bbox.dart';
import 'package:sakkoja/features/fishing/data/datasources/fishing_local_data_source.dart';
import 'package:sakkoja/features/fishing/data/datasources/fishing_remote_data_source.dart';
import 'package:sakkoja/features/fishing/data/models/fishing_restriction_dto.dart';
import 'package:sakkoja/features/fishing/data/models/waterway_feature_dto.dart';
import 'package:sakkoja/features/fishing/data/repositories/fishing_repository_impl.dart';

class FakeFishingRemoteDataSource implements FishingRemoteDataSource {
  List<FishingRestrictionDto> restrictions = const [];
  List<WaterwayFeatureDto> waterways = const [];
  Object? restrictionError;
  Object? waterwayError;
  int restrictionCalls = 0;
  int waterwayCalls = 0;

  @override
  Future<List<FishingRestrictionDto>> fetchFishingRestrictions({
    BBox? bbox,
  }) async {
    restrictionCalls++;
    if (restrictionError != null) throw restrictionError!;
    return restrictions;
  }

  @override
  Future<List<WaterwayFeatureDto>> fetchWaterwayFeatures({BBox? bbox}) async {
    waterwayCalls++;
    if (waterwayError != null) throw waterwayError!;
    return waterways;
  }
}

class FakeFishingLocalDataSource implements FishingLocalDataSource {
  FakeFishingLocalDataSource({this.persistQueries = true});

  final bool persistQueries;
  final Map<String, List<FishingRestrictionDto>> restrictions = {};
  final Map<String, List<WaterwayFeatureDto>> waterways = {};
  List<FishingRestrictionDto> bundledRestrictions = const [];
  final List<BBox> savedRestrictionBboxes = [];

  String _key(BBox bbox) => bbox.toWfsParam(precision: 6, forceLonLat: true);

  @override
  Future<List<FishingRestrictionDto>?> getFishingRestrictions({
    required BBox bbox,
    bool ignoreExpiry = false,
  }) async => restrictions[_key(bbox)];

  @override
  Future<void> saveFishingRestrictions(
    BBox bbox,
    List<FishingRestrictionDto> values,
  ) async {
    savedRestrictionBboxes.add(bbox);
    if (persistQueries) restrictions[_key(bbox)] = values;
  }

  @override
  Future<List<WaterwayFeatureDto>?> getWaterwayFeatures({
    required BBox bbox,
    bool ignoreExpiry = false,
  }) async => waterways[_key(bbox)];

  @override
  Future<void> saveWaterwayFeatures(
    BBox bbox,
    List<WaterwayFeatureDto> values,
  ) async {
    if (persistQueries) waterways[_key(bbox)] = values;
  }

  @override
  Future<List<FishingRestrictionDto>> loadFromAssets() async =>
      bundledRestrictions;

  @override
  Future<bool> getFishingMode() async => false;

  @override
  Future<void> saveFishingMode(bool isEnabled) async {}
}

FishingRestrictionDto restriction(String id, double latitude) {
  return FishingRestrictionDto(
    id: id,
    title: id,
    rings: [
      [
        LatLng(latitude, 24),
        LatLng(latitude + 0.01, 24),
        LatLng(latitude, 24.01),
      ],
    ],
  );
}

void main() {
  const queryA = (minLat: 60.0, minLng: 24.0, maxLat: 60.2, maxLng: 24.2);
  const queryB = (minLat: 61.0, minLng: 25.0, maxLat: 61.2, maxLng: 25.2);

  test('persists remote restrictions under the requested BBox', () async {
    final remote = FakeFishingRemoteDataSource()
      ..restrictions = [restriction('remote', 60.05)];
    final local = FakeFishingLocalDataSource();
    final repository = FishingRepositoryImpl(remote, local);

    final result = await repository.getFishingRestrictions(
      minLat: queryA.minLat,
      minLng: queryA.minLng,
      maxLat: queryA.maxLat,
      maxLng: queryA.maxLng,
    );

    expect(result.fold((_) => false, (_) => true), isTrue);
    expect(result.getOrElse((_) => []).single.id, 'remote');
    expect(local.savedRestrictionBboxes, hasLength(1));
    expect(local.savedRestrictionBboxes.single.minLat, queryA.minLat);
  });

  test(
    'evicts old exact BBox entries instead of merging a map-wide cache',
    () async {
      final remote = FakeFishingRemoteDataSource()
        ..restrictions = [restriction('remote', 60.05)];
      final repository = FishingRepositoryImpl(
        remote,
        FakeFishingLocalDataSource(persistQueries: false),
        networkCacheCapacity: 1,
      );

      Future<void> fetch(
        ({double minLat, double minLng, double maxLat, double maxLng}) query,
      ) async {
        await repository.getFishingRestrictions(
          minLat: query.minLat,
          minLng: query.minLng,
          maxLat: query.maxLat,
          maxLng: query.maxLng,
        );
      }

      await fetch(queryA);
      await fetch(queryB);
      await fetch(queryA);

      expect(remote.restrictionCalls, 3);
    },
  );

  test(
    'uses bundled restrictions only as an explicit remote-failure fallback',
    () async {
      final remote = FakeFishingRemoteDataSource()
        ..restrictionError = StateError('offline');
      final local = FakeFishingLocalDataSource()
        ..bundledRestrictions = [restriction('bundled', 60.05)];
      final repository = FishingRepositoryImpl(remote, local);

      final result = await repository.getFishingRestrictions(
        minLat: queryA.minLat,
        minLng: queryA.minLng,
        maxLat: queryA.maxLat,
        maxLng: queryA.maxLng,
      );

      expect(result.getOrElse((_) => []).single.id, 'bundled');
      expect(remote.restrictionCalls, 1);
    },
  );

  test(
    'surfaces remote restriction failures when no fallback covers the BBox',
    () async {
      final remote = FakeFishingRemoteDataSource()
        ..restrictionError = StateError('offline');
      final repository = FishingRepositoryImpl(
        remote,
        FakeFishingLocalDataSource(),
      );

      final result = await repository.getFishingRestrictions(
        minLat: queryA.minLat,
        minLng: queryA.minLng,
        maxLat: queryA.maxLat,
        maxLng: queryA.maxLng,
      );

      expect(result.fold((_) => true, (_) => false), isTrue);
    },
  );

  test(
    'surfaces waterway remote failures instead of returning a stale global row',
    () async {
      final remote = FakeFishingRemoteDataSource()
        ..waterwayError = StateError('offline');
      final repository = FishingRepositoryImpl(
        remote,
        FakeFishingLocalDataSource(),
      );

      final result = await repository.getWaterwayFeatures(
        minLat: queryA.minLat,
        minLng: queryA.minLng,
        maxLat: queryA.maxLat,
        maxLng: queryA.maxLng,
      );

      expect(result.fold((_) => true, (_) => false), isTrue);
    },
  );

  test(
    'restriction cache ids are versioned, scoped, and six-decimal precise',
    () {
      const first = BBox(minLon: 24, minLat: 60, maxLon: 24.1, maxLat: 60.1);
      const second = BBox(
        minLon: 24.000001,
        minLat: 60,
        maxLon: 24.1,
        maxLat: 60.1,
      );

      expect(
        FishingLocalDataSourceImpl.restrictionCacheId(first),
        startsWith('fishing_restrictions_v2_60.000000_24.000000'),
      );
      expect(
        FishingLocalDataSourceImpl.restrictionCacheId(first),
        isNot(FishingLocalDataSourceImpl.restrictionCacheId(second)),
      );
    },
  );
}
