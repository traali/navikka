import 'package:fpdart/fpdart.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/core/models/bbox.dart';
import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/core/utils/lru_cache.dart';
import 'package:sakkoja/features/fishing/data/datasources/fishing_local_data_source.dart';
import 'package:sakkoja/features/fishing/data/datasources/fishing_remote_data_source.dart';
import 'package:sakkoja/features/fishing/data/models/fishing_mappers.dart';
import 'package:sakkoja/features/fishing/domain/entities/catch_size.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_species.dart';
import 'package:sakkoja/features/fishing/domain/entities/fishing_restriction.dart';
import 'package:sakkoja/features/fishing/domain/entities/waterway_feature.dart';
import 'package:sakkoja/features/fishing/domain/repositories/fishing_repository.dart';

class FishingRepositoryImpl implements FishingRepository {
  FishingRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource, {
    int networkCacheCapacity = _defaultNetworkCacheCapacity,
  }) : assert(
         networkCacheCapacity > 0,
         'networkCacheCapacity must be positive',
       ),
       _restrictionQueries = LruCache(capacity: networkCacheCapacity),
       _waterwayQueries = LruCache(capacity: networkCacheCapacity);

  static const int _defaultNetworkCacheCapacity = 12;

  final FishingRemoteDataSource _remoteDataSource;
  final FishingLocalDataSource _localDataSource;

  // Exact BBox queries are bounded to avoid accumulating map-wide data in
  // memory. Entries include empty successful responses.
  final LruCache<String, List<FishingRestriction>> _restrictionQueries;
  final LruCache<String, List<WaterwayFeature>> _waterwayQueries;
  Future<List<FishingRestriction>>? _bundledRestrictions;

  void resetCache() {
    _restrictionQueries.clear();
    _waterwayQueries.clear();
  }

  @override
  Future<Either<Failure, List<CatchSize>>> getCatchSizes({
    required double lat,
    required double lon,
  }) async {
    return const Right([
      CatchSize(species: FishSpecies.kuha, minimumSizeCm: 42),
      CatchSize(species: FishSpecies.lohi, minimumSizeCm: 60),
      CatchSize(
        species: FishSpecies.taimen,
        minimumSizeCm: 60,
        region: 'Merialue',
      ),
      CatchSize(species: FishSpecies.hauki, minimumSizeCm: 0),
      CatchSize(species: FishSpecies.ahven, minimumSizeCm: 0),
    ]);
  }

  @override
  Future<Either<Failure, List<FishingRestriction>>> getFishingRestrictions({
    required double minLat,
    required double minLng,
    required double maxLat,
    required double maxLng,
    String? category,
    bool onlyActive = false,
  }) async {
    final bbox = _bbox(
      minLat: minLat,
      minLng: minLng,
      maxLat: maxLat,
      maxLng: maxLng,
    );
    final key = _queryKey('restrictions', bbox);

    final inMemory = _readQuery<FishingRestriction>(_restrictionQueries, key);
    if (inMemory != null) {
      return Right(_applyFilters(inMemory, bbox, category, onlyActive));
    }

    try {
      final persisted = await _localDataSource.getFishingRestrictions(
        bbox: bbox,
      );
      if (persisted != null) {
        final entities = persisted.map((dto) => dto.toEntity()).toList();
        _writeQuery<FishingRestriction>(_restrictionQueries, key, entities);
        return Right(_applyFilters(entities, bbox, category, onlyActive));
      }
    } catch (error, stackTrace) {
      Log.w(
        'FishingRepository: Scoped restriction cache read failed',
        error,
        stackTrace,
      );
    }

    try {
      final dtos = await _remoteDataSource.fetchFishingRestrictions(bbox: bbox);
      final entities = dtos.map((dto) => dto.toEntity()).toList();
      await _localDataSource.saveFishingRestrictions(bbox, dtos);
      _writeQuery<FishingRestriction>(_restrictionQueries, key, entities);
      return Right(_applyFilters(entities, bbox, category, onlyActive));
    } catch (error, stackTrace) {
      Log.e(
        'FishingRepository: Restriction fetch failed for $bbox',
        error,
        stackTrace,
      );
      final fallback = await _loadBundledRestrictions();
      final filteredFallback = _applyFilters(
        fallback,
        bbox,
        category,
        onlyActive,
      );
      if (filteredFallback.isNotEmpty) {
        Log.w(
          'FishingRepository: Serving bundled restriction fallback for $bbox',
        );
        return Right(filteredFallback);
      }
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<WaterwayFeature>>> getWaterwayFeatures({
    required double minLat,
    required double minLng,
    required double maxLat,
    required double maxLng,
  }) async {
    final bbox = _bbox(
      minLat: minLat,
      minLng: minLng,
      maxLat: maxLat,
      maxLng: maxLng,
    );
    final key = _queryKey('waterways', bbox);

    final inMemory = _readQuery<WaterwayFeature>(_waterwayQueries, key);
    if (inMemory != null) return Right(inMemory);

    try {
      final persisted = await _localDataSource.getWaterwayFeatures(bbox: bbox);
      if (persisted != null) {
        final entities = persisted.map((dto) => dto.toEntity()).toList();
        _writeQuery<WaterwayFeature>(_waterwayQueries, key, entities);
        return Right(entities);
      }
    } catch (error, stackTrace) {
      Log.w(
        'FishingRepository: Scoped waterway cache read failed',
        error,
        stackTrace,
      );
    }

    try {
      final dtos = await _remoteDataSource.fetchWaterwayFeatures(bbox: bbox);
      final entities = dtos.map((dto) => dto.toEntity()).toList();
      await _localDataSource.saveWaterwayFeatures(bbox, dtos);
      _writeQuery<WaterwayFeature>(_waterwayQueries, key, entities);
      return Right(entities);
    } catch (error, stackTrace) {
      Log.e(
        'FishingRepository: Waterway fetch failed for $bbox',
        error,
        stackTrace,
      );
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<void> saveFishingMode(bool isEnabled) =>
      _localDataSource.saveFishingMode(isEnabled);

  @override
  Future<bool> getFishingMode() => _localDataSource.getFishingMode();

  Future<List<FishingRestriction>> _loadBundledRestrictions() {
    return _bundledRestrictions ??= _localDataSource.loadFromAssets().then(
      (dtos) => dtos.map((dto) => dto.toEntity()).toList(),
    );
  }

  BBox _bbox({
    required double minLat,
    required double minLng,
    required double maxLat,
    required double maxLng,
  }) {
    return BBox(
      minLon: minLng,
      minLat: minLat,
      maxLon: maxLng,
      maxLat: maxLat,
    );
  }

  String _queryKey(String type, BBox bbox) =>
      '$type|${bbox.toWfsParam(precision: 6, forceLonLat: true)}';

  List<T>? _readQuery<T>(LruCache<String, List<T>> cache, String key) {
    return cache[key];
  }

  void _writeQuery<T>(
    LruCache<String, List<T>> cache,
    String key,
    List<T> value,
  ) {
    cache[key] = List.unmodifiable(value);
  }

  List<FishingRestriction> _applyFilters(
    List<FishingRestriction> items,
    BBox queryBox,
    String? category,
    bool onlyActive,
  ) {
    return items
        .where((restriction) {
          if (restriction.boundingBox != null &&
              !restriction.boundingBox!.overlaps(queryBox)) {
            return false;
          }
          if (category != null && restriction.category != category) {
            return false;
          }
          return !onlyActive || restriction.isCurrentlyActive;
        })
        .toList(growable: false);
  }
}
